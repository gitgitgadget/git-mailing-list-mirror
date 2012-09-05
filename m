From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Wed, 5 Sep 2012 11:59:37 +0200
Message-ID: <00a601cd8b4d$2986dfa0$7c949ee0$@schmitz-digital.de>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de> <7vr4qqzsbe.fsf@alter.siamese.dyndns.org> <002201cd86ce$285841b0$7908c510$@schmitz-digital.de> <7vfw74s3oy.fsf@alter.siamese.dyndns.org> <003d01cd8827$34e90180$9ebb0480$@schmitz-digital.de> <7vpq64f935.fsf@alter.siamese.dyndns.org> <000d01cd89b6$d5ba6c30$812f4490$@schmitz-digital.de> <7v1uijexor.fsf@alter.siamese.dyndns.org> <003601cd8a0f$6a792840$3f6b78c0$@schmitz-digital.de> <7vzk55bu8s.fsf@alter.siamese.dyndns.org> <002801cd8ac2$10937480$31ba5d80$@schmitz-digital.de> <7vwr09abim.fsf@alter.siamese.dyndns.org> <7vobllaami.fsf@alter.siamese.dyndns.org> <002c01cd8ae6$f23d7ec0$d6b87c40$@schmitz-digital.de> <7v627t8l2d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Johannes Sixt'" <j6t@kdbg.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 12:04:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9CTU-0004lj-6R
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 12:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758632Ab2IEKEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 06:04:07 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:50043 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758427Ab2IEJ7u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 05:59:50 -0400
Received: from DualCore (dsdf-4db50426.pool.mediaWays.net [77.181.4.38])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MURRH-1Szbm12cip-00QiQa; Wed, 05 Sep 2012 11:59:43 +0200
In-Reply-To: <7v627t8l2d.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIhsC26HFNXVNf5LMacgAbi0X2P9gIuBdH5AgQ1j9EAzDU6SAHd2fuOAzRbc6QCZvCE2AIPCL7WANNwrfABx6z0HgKAOAv2AfSTz54DIBk6ngIrMzuOAHeWZHSV+GvN4A==
Content-Language: de
X-Provags-ID: V02:K0:Bg27MuzRqMyDHLuVzHl4CE9EASbSqJ3yjujJQ5Cx72I
 FhBwmCw3IYp+7Za8L+1QHB8hgIoPEz3MnI/K/PbUhjGIkVOHEw
 A3lCeAuqJxZinBIkTFDTQ2z8PRufCKFnfJnBIxwnzCcnVwnu3A
 pW0A7MyIi4Agwxji19wQLYLNep+4q+RQzkNPDVEvCRUkAbO3cD
 /KuqlhIExHNKP78ecSs/jEuGvbs++PfVEU9PfjCthLVn9b/61U
 M0sYbeioSCZ8te+vFP2IhT2fs/rj1oLl87RaApD3aDX4Zt7qw7
 zi08W3CTbPXHxvYVMSSNbcDfh6v4OZrAoBy5omMlE8F7RJyCJP
 I4a7cfiUyaCqZ/tfUJRUKdSU93YQI8EjH5wYAsCorLn803IxhY
 yNG0Qn7+sQI2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204807>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Wednesday, September 05, 2012 12:45 AM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; 'Johannes Sixt'
> Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> From: Junio C Hamano [mailto:gitster@pobox.com]
> >> Sent: Tuesday, September 04, 2012 8:47 PM
> >> To: Joachim Schmitz
> >> Cc: git@vger.kernel.org; 'Johannes Sixt'
> >> Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
> >>
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >> >
> >> >>> Only with the observation of "clone", I cannot tell if your timer is
> >> >>> working.  You can try repacking the test repository you created by
> >> >>> your earlier "git clone" with "git repack -a -d -f" and see what
> >> >>> happens.
> >> >>
> >> >> It does update the counter too.
> >> >
> >> > Yeah, that was not a very good way to diagnose it.
> >> >
> >> > You see the progress from pack-objects (which is the underlying
> >> > machinery "git repack" uses) only because it knows how many objects
> >> > it is going to pack, and it updates the progress meter for every
> >> > per-cent progress it makes, without any help from the timer
> >> > interrupt.
> >>
> >> I think the "Counting objects: $number" phase is purely driven by
> >> the timer, as there is no way to say "we are done X per-cent so
> >> far".
> >>
> >> Doesn't your repack show "Counting objects: " with a number once,
> >> pause forever and then show "Counting objects: $number, done."?
> >
> > Yes, only once, when it is done
> > $ ./git repack -a -d -f
> > warning: no threads support, ignoring --threads
> > Counting objects: 140302, done.
> > Compressing objects:   1% (1385/138407)
> 
> So this strongly suggests that (1) your "poor-man's" is not a real
> substitute for recurring itimer, and (2) users could live with the
> progress.c code without any itimer firing.

OK

> Perhaps a no-op macro would work equally well?

Like the following:

diff --git a/git-compat-util.h b/git-compat-util.h
index 18089f0..55b9421 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h@@ -163,6 +163,10 @@
 #define probe_utf8_pathname_composition(a,b)
 #endif

+#ifdef NO_SETITIMER
+#define setitimer(w,v,o) /* NOP */
+#endif
+
 #ifdef MKDIR_WO_TRAILING_SLASH
 #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
 extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);

Does work for me and does not seem to make any difference, not in those test cases at least

Does the inability to re-arm the timer depend on SA_RESTART, possibly?
If so we may instead want 
#if SA_RSTART == 0  && defined(NO_SETITIMER)

Bye, Jojo
