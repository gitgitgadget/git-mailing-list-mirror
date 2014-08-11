From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v8 0/8] Rewrite `git_config()` using config-set API
Date: Mon, 11 Aug 2014 10:59:13 +0100
Message-ID: <53E893F1.9080408@ramsay1.demon.co.uk>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>	<vpqy4v1vdui.fsf@anie.imag.fr>	<xmqq8un0ktqu.fsf@gitster.dls.corp.google.com>	<vpq61i4nld7.fsf@anie.imag.fr>	<xmqqoavwjb3i.fsf@gitster.dls.corp.google.com>	<53E4D986.6040708@gmail.com> <53E4DF6D.8070904@ramsay1.demon.co.uk> <xmqqppg88d8x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 11:59:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGmNu-0004hL-RB
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 11:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbaHKJ7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 05:59:19 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:45289 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750787AbaHKJ7S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 05:59:18 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 900731280AF;
	Mon, 11 Aug 2014 10:59:06 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 4F749128089;
	Mon, 11 Aug 2014 10:59:06 +0100 (BST)
Received: from [192.168.254.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Mon, 11 Aug 2014 10:59:05 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqppg88d8x.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255121>

On 10/08/14 18:29, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> On 08/08/14 15:07, Tanay Abhra wrote:
>> ...
>>> (cc to Ramsay)
>>>
>>> The discussion in both threads (v8 and v9), boils down to this,
>>> is the `key_value_info` struct really required to be declared public or should be
>>> just an implementation detail. I will give you the context,
>>
>> No, this is not the issue for me. The patch which introduces the
>> struct in cache.h does not make use of that struct in any interface.
>> It *is* an implementation detail of some code in config.c only.
>>
>> I do not know how that structure will be used in future patches. ;-)
> 
> It is debatable if it is a good API that tells the users "In the
> data I return to you, there is a structure hanging there with these
> two fields. Feel free to peek into it if you need what is recorded
> in them".

There is no debate in my mind. ;-)

In this future patch, the movement of the structure out of config.c would
be plain for everyone to see, and (hopefully) debate the merits of such
an 'interface'. Along with checking that it is properly documented. (which
patch should the documentation be in?) Where should it be documented?
 
>              But the contract between the the endgame "API" and its
> callers can include such a direct access, and then you can say that
> it is a part of the API, not just an implementation detail.

Sure. It's just a question of timing and allowing reviewers to see the
actual change in one patch.

> I think you and Tanay are both right (and I am wrong ;-).

;-)

I don't have *very* strong feelings about this, which is why I didn't
respond to the earlier replies by Tanay and Matthieu, but since I was
cc-ed on this thread ... (It seemed to me that my comments had been
misunderstood).

So yes, I think this "API" is ugly and could be improved upon, but I
don't care sufficiently to make any further comment. :-D

ATB,
Ramsay Jones
