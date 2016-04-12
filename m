From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 0 bot for Git
Date: Tue, 12 Apr 2016 22:29:06 +0200
Message-ID: <vpqoa9ea7vx.fsf@anie.imag.fr>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<vpq60vnl28b.fsf@anie.imag.fr>
	<CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: lkp@intel.com, Greg KH <gregkh@linuxfoundation.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 22:29:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq4wE-0003Mq-P6
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 22:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbcDLU30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 16:29:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54851 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932823AbcDLU3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 16:29:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u3CKT3T6005228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 12 Apr 2016 22:29:03 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3CKT625030114;
	Tue, 12 Apr 2016 22:29:06 +0200
In-Reply-To: <CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
	(Stefan Beller's message of "Tue, 12 Apr 2016 07:52:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 12 Apr 2016 22:29:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3CKT3T6005228
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461097745.4238@ePfHItrTZsQR3TsBoMTKwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291292>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Apr 12, 2016 at 12:23 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Hi Greg,
>>>
>>> Thanks for your talk at the Git Merge 2016!
>>> The Git community uses the same workflow as the kernel. So we may be
>>> interested in the 0 bot which could compile and test each patch on the list.
>>
>> In the case of Git, we already have Travis-CI that can do rather
>> thorough testing automatically (run the complete testsuite on a clean
>> machine for several configurations). You get the benefit from it only if
>> you use GitHub pull-requests today.
>
> But who uses that? (Not a lot of old-timers here, that's for sure)

Not many people clearly. I sometimes do, but SubmitGit as it is today
doesn't (yet?) beat "git send-email" for me. In a perfect world where I
could just ask SubmitGit "please wait for Travis to complete, if it
passes then send to the list, otherwise email me", I would use it more.

But my point wasn't to say "we already have everything we need", but
rather "we already have part of the solution, so an ideal complete
solution could integrate with it".

>> It would be interesting to have a
>> bot watch the list, apply patches and push to a travis-enabled fork of
>> git.git on GitHub to get the same benefit when posting emails directly
>> to the list.
>
> That is better (and probably more work) than what I had in mind.
> IIUC the 0 bot can grab a patch from a mailing list and apply it to a
> base (either the real base as encoded in the patch or a best guess)
> and then run "make".

I don't know how 0 bot solves this, but the obvious issue with this
approach is to allow dealing with someone sending a patch like

+++ Makefile
--- Makefile
+all:
+	rm -fr $(HOME); sudo rm -fr /

to the list. One thing that Travis gives us for free is isolation:
malicious code in the build cannot break the bot, only the build itself.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
