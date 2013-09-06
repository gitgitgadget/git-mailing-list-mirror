From: "Uli Heller" <uli.heller@daemons-point.com>
Subject: Re: [PATCH] git-svn: Fix termination issues for remote svn  
     connections
Date: Fri, 6 Sep 2013 15:18:32 +0200 (CEST)
Message-ID: <f2fe486a6ca0bf40be4489bfe888d517.squirrel@83.236.132.106>
References: <6970c0cab40c60195c8f042a3b930a0a.squirrel@83.236.132.106>
    <xmqqli3bhzop.fsf@gitster.dls.corp.google.com>
    <A46AD76E-56FA-4555-8811-6141284300DD@gmail.com>
    <07b9b270090d6b42515c5dc3dfb8ab4f.squirrel@83.236.132.106>
    <9D2EC674-887A-479B-B8FB-3EFEAC391435@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Eric Wong" <normalperson@yhbt.net>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 15:18:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHvvy-0000vm-GH
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 15:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752Ab3IFNSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 09:18:42 -0400
Received: from daemons-point.com ([213.133.97.207]:59841 "EHLO
	daemons-point.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab3IFNSl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 09:18:41 -0400
Received: from port-83-236-132-106.static.qsc.de ([83.236.132.106] helo=qscmail.daemons-point.com)
	by daemons-point.com with esmtp (Exim 4.76)
	(envelope-from <uli.heller@daemons-point.com>)
	id 1VHvvq-0001r4-Sz; Fri, 06 Sep 2013 15:18:39 +0200
Received: from [127.0.0.1] (helo=83.236.132.106)
	by qscmail.daemons-point.com with esmtp (Exim 4.60)
	(envelope-from <uli.heller@daemons-point.com>)
	id 1VHvvk-00063e-4E; Fri, 06 Sep 2013 15:18:32 +0200
Received: from 155.250.255.144
        (SquirrelMail authenticated user uli)
        by 83.236.132.106 with HTTP;
        Fri, 6 Sep 2013 15:18:32 +0200 (CEST)
In-Reply-To: <9D2EC674-887A-479B-B8FB-3EFEAC391435@gmail.com>
User-Agent: SquirrelMail/1.4.17
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234046>

On Fri, September 6, 2013 2:44 pm, Kyle J. McKay wrote:
> On Sep 6, 2013, at 05:06, Uli Heller wrote:
>>> I'm using Git built from master (57e4c1783).  I see the same behavior
>>> both with and without the SVN/Ra.pm patch (and using both bulk
>>> updates
>>> and skelta mode).  Does the problem not happen on a git svn clone?  I
>>> can force serf back to version 1.2.1 and try that version just to
>>> see,
>>> but I would like to have an example of a known failing git svn
>>> command
>>> for testing purposes.  Thanks.
>>
>> I think this command should produce the error:
>>
>>  git svn clone --stdlayout https://github.com/uli-heller/uli-javawrapper
>>
>> You can use any other svn repo as well, you only have to specify an
>> HTTPS
>> url.
>
> Yes, that does it.  Interesting that cloning from
> "https://github.com/uli-heller/uli-javawrapper
> " core dumps while cloning from
> "http://github.com/uli-heller/uli-javawrapper
> " does not even though the latter redirects to
> "https://github.com/uli-heller/uli-javawrapper
> ".
>
> In any case, I can now reproduce the problem (serf 1.3.1 still breaks
> since it does not yet contain the fix and it is the most recent serf
> release available).
>
> And the Git/SVN/Ra.pm fix does eliminate the problem for me (both with
> bulk updates and with skelta updates -- the crash occurs with either).

Great. So I don't have to run any more tests ;)

What shall I do next? Add some inline comments to the patch?

---
Best regards, Uli.
