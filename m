From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Fix a signal handler
Date: Wed, 24 Feb 2010 11:51:42 +0100
Message-ID: <4B8504BE.90503@op5.se>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de> <4B72E81B.3020900@web.de> <20100210173348.GA5091@coredump.intra.peff.net> <4B76A985.9070809@web.de> <20100214064745.GC20630@coredump.intra.peff.net> <7vsk94qfuy.fsf@alter.siamese.dyndns.org> <4B7D6B7A.1090004@web.de> <7veikib96d.fsf@alter.siamese.dyndns.org> <4B82744B.4060805@web.de> <7v1vgdgm02.fsf@alter.siamese.dyndns.org> <4B839811.6040109@web.de> <7vmxyzfwt7.fsf@alter.siamese.dyndns.org> <4B8501A0.3060805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 11:51:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkEqO-00022o-EB
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 11:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756621Ab0BXKvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 05:51:48 -0500
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:34690 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756585Ab0BXKvr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 05:51:47 -0500
Received: from source ([209.85.220.213]) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS4UEwdTYtlLGmOL/zgK6AP8BmaLVSm20@postini.com; Wed, 24 Feb 2010 02:51:46 PST
Received: by mail-fx0-f213.google.com with SMTP id 5so5049439fxm.29
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 02:51:45 -0800 (PST)
Received: by 10.87.56.7 with SMTP id i7mr14161511fgk.25.1267008704330;
        Wed, 24 Feb 2010 02:51:44 -0800 (PST)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d6sm13942800fga.19.2010.02.24.02.51.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 02:51:43 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Thunderbird/3.0.1 ThunderGit/0.1a
In-Reply-To: <4B8501A0.3060805@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140926>

On 02/24/2010 11:38 AM, Markus Elfring wrote:
>> Name one platform you tried to port git to and had trouble with because
>> the platform did not initialize variables in bss segment to zero, or
>> perhaps on that platfor NULL had a bitpattern different from all zero, and
>> after you initialized them explicitly to zero or NULL, you managed to make
>> everything work perfectly.
>>
>> Name one platform you actually got a segfault in the early-output codepath
>> on it, because a function pointer on that platform is not of an atomic
>> type, and the assignment from show_early_output to show done in
>> limit_list() picked up a pointer half-written by the signal handler, and
>> we ended up calling a garbage address, and you managed to make everything
>> work perfectly with your fix.
> 
> Thanks for your feedback.
> 
> Which is the name for this specific software environment where the "unexpected"
> behaviour was observed?
> 

There isn't one. He was asking you to provide a bugreport for a system where
this behaviour was observed to prove that your fix isn't pedantic. Returning
the question does not help.

> Does the mentioned improvement justify the integration of my intermediate update
> suggestion that works without a "static" flag so far into your source code
> repository?
> 

Wait and find out. I consider it useless codechurn since it's not fixing any
real-world problem, but it's not intrusive enough for me to care much either
way, so as long as it doesn't break anything I don't care either way. That's
the big problem, really. You're asking a lot of people to spend a lot of time
on something that we, over and over, have told you we're not interested in
unless you can prove you're solving a real problem.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
