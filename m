From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH v3 2/2] commit: add --ignore-submodules[=<when>] parameter
Date: Mon, 14 Apr 2014 22:18:34 +0200
Message-ID: <534C429A.6080508@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com> <533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com> <5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de>	<CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com>	<5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com>	<533B2036.3050506@web.de> <533B36AA.3090600@gmail.com>	<533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com>	<534180BC.308@web.de> <53431CB8.2050600@gmail.com>	<53432EA5.5060102@gmail.com> <53444368.9050607@web.de>	<5349BC2C.9030509@gmail.com> <xmqqd2gjpxvy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 22:18:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZnL6-00051D-Ib
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 22:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbaDNUSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 16:18:39 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:49616 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbaDNUSh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 16:18:37 -0400
Received: by mail-ee0-f43.google.com with SMTP id e53so6997065eek.2
        for <git@vger.kernel.org>; Mon, 14 Apr 2014 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ac+6n4UFY4v/erYAtncLP1zs89Su/jE8yeFGNFj+aYk=;
        b=Sb6t30cRbsdHoRjMdKGv6tpw2ciEA08MigG1QZ43e/WqSJ3APiY8/WnoTPjoQATyab
         COzgcMjEj7BsIRcdbjS/enC08lyECcQqBsgfDpDud5QmwKfL9KDbA9zoI7vljl8V4Fr1
         hpMsA89sTdhQe6upoOtRJiyr4jVgqqnluLE1I1cmQOknDNl+tPmnChHrTb6XtsqaeJuN
         uhHRYygY1Nat7aZ1MItcO9Ti8BIdsqI107hFYQPqllz3OaWoVLsk7PZLu9C9MoYakZi7
         9DiPfeqA4Mks9EoYJgDJypUAQ846puaXnubW97JvvdCnkMsnp+B9hxFJwiehJ4JWQBxJ
         oBDw==
X-Received: by 10.15.43.77 with SMTP id w53mr54044929eev.10.1397506716270;
        Mon, 14 Apr 2014 13:18:36 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id w12sm43621411eez.36.2014.04.14.13.18.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Apr 2014 13:18:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqqd2gjpxvy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246259>

On 14. 4. 2014 20:30, Junio C Hamano wrote:
> Ronald Weiss <weiss.ronald@gmail.com> writes:
> 
>> On 8. 4. 2014 20:43, Jens Lehmann wrote:
>>>> Useful <when> values for commit are 'all' (default) or 'none'. The others
>>>> ('dirty' and 'untracked') have same effect as 'none', as commit is only
>>>> interested in whether the submodule's HEAD differs from what is commited
>>>> in the superproject.
>>>
>>> Unless it outputs a status message, then 'dirty' and 'untracked' do
>>> influence what is shown there. Apart from that (and maybe tests for
>>> these two cases ;-) this is looking good to me.
>>
>> OK, I updated the patch for commit to take that into account. Also, I
>> rebased both patches onto current master. Sending them in a moment.
>>
>> If you don't have any more complaints, can I add "Acked-by: <you>" and
>> resend the patches to Junio?
> 
> It is not "When I see no more complaints, I'll resend with your
> Ack".  An Ack is a positive thing, not lack of discovery of further
> issues.

I'm really sorry if the tone of my message sounded harsh to you, it
wasn't meant like that at all.

> Rather, it is more like "I'll wait for your Acks and then I'll
> resend with your Ack", or "If they look good, reply with Ack and let
> the maintainer pick them up".

OK.
