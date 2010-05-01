From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Sat, 01 May 2010 16:25:12 -0700
Message-ID: <7vk4rn2oiv.fsf@alter.siamese.dyndns.org>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <4BD7032D.9050508@drmicha.warpmail.net>
 <4BDC744E.4050006@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 02 01:25:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8M3y-0008Kd-SP
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 01:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455Ab0EAXZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 19:25:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab0EAXZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 19:25:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DAF9AFD03;
	Sat,  1 May 2010 19:25:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GIPOD7ubC71/fOmrBgQRRGKlyC8=; b=S9gCHH
	ShcR8TJeDhDx3+6K+J9A/xbg2UfXBcwM7+xNE/Z+ppgZMeClBUiveyRj6dlCaQJu
	raOz5+JBsd656YmyXlT3ZS7CzHGmMu4tAusl0W5ocAIntIG7xt8X2lb1nt+0PamL
	AGwOFRc0KpHMVOhBXByP4gCyhd5eMoMi/H4cI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QsQXKaFDY4ITSrEl6zSg3U7lt8CdyRwP
	ufOfFCondWM1iIG2kO9Z5uu/axSyK/+PMQFbSkevW6aztZ7IrN1Yc6xJNwTJ2pCF
	qjTXVgjZgWDnY694enxpBbcZ8vgWW1xz7/xTFy1cDCO+T9g3XorB4Wbv0lubdHYq
	hex1HyQT5/k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12B17AFD02;
	Sat,  1 May 2010 19:25:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08D41AFCFB; Sat,  1 May
 2010 19:25:13 -0400 (EDT)
In-Reply-To: <4BDC744E.4050006@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Sat\, 01 May 2010 20\:34\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CDBB1850-5578-11DF-B1F1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146122>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Michael J Gruber venit, vidit, dixit 27.04.2010 17:30:
>> Gary V. Vaughan venit, vidit, dixit 27.04.2010 15:57:
>>> Here are the portability patches we needed at TWW to enable git-1.7.1
>>> to compile and run on all of the wide range of Unix machines we
>>> support.  These patches apply to the git-1.7.1 release,  and address
>>> all of the feedback from the previous three times I posted them to
>>> this list, including fixing the massive testsuite failures I was
>>> experiencing and taking into account that the ss_family fixes and
>>> partial GMT_CMP_TEST fixes that have been pushed since my last post of
>>> this patch queue.
>> 
>> General remark: None of your patches have a s-o-b line. If you want to
>> have your patches in git you are required to sign-off on them (commit
>> -s) in order to certify that you can submit them under the license terms
>> of the project.
>> 
>> Your diff -> test_cmp are certainly something we want to have in any
>> case. The code changes look ugly, honestly, making the code much less
>> readable, but it seems to be the only way to make those older platforms
>> and compilers happy. (Erik pointed out some good ways to reduce the
>> uglyness somewhat.)
>> 
>> I can't test your target platform, but I would test the impact of the
>> code and test changes on mine. Do you have your series somewhere to pull
>> from?
>
> OK, unsurprsingly, tests still pass on Linux (Fedora 12 x86_64).
> If anyone wants to try, the series can be found at
>
> git://repo.or.cz/git/mjg.git
>
> in branch
>
> gvv/platform-compatibility
>
> applied cleanly on current master.

Thanks.  

Like everybody else, I like the s/diff/test_cmp/ one in general.  On
platforms without "diff -u", test_cmp may want to use "diff -c" instead
for readability, but that can be fixed/enhanced independently.

I agree with your general remark and also noticed that the titles are way
suboptimal.

* user-cppflags.patch

  Makefile: pass CPPFLAGS through to fllow customization

* const-expr.patch

  Rewrite dynamic structure initializations to runtime assignment

* pthread.patch

  Makefile: -lpthread may still be necessary when libc has only pthread stubs

* Without this patch at least IBM VisualAge C 5.0 (I have 5.0.2) on AIX 5.1 fails to compile git.

  enums: omit trailing comma for portability

* diff-export.patch

  Do not use "diff" found on PATH while building and installing

I think the change to git-merge-one-file.sh in this patch is wrong, by the
way.

* diff-test_cmp.patch

  tests: use "test_cmp", not "diff", when verifying the result

The patch to t9400 has indent-with-spaces, by the way.

* diff-defaults.patch

  test_cmp: do not use "diff -u" on platforms that lack one

It may be better to use "diff -c" on most of them, though.

* host-SunOS56.patch

  Makefile: SunOS 5.6 portability fix

* host-IRIX.patch

  git-compat-util.h: Irix 6.5 defines 'sgi' but not '__sgi'.

* host-HPUX10.patch

This would be better as two patches

  Makefile: HP-UX 10.20 lacks pread()
  git-compat-util.h: some platforms with mmap() lack MAP_FAILED definition

* host-HPUX11.patch

  Makefile: HPUX does not have nanosecond timestamp in struct stat

* host-OSF1.patch

  Makefile: Tru64 portability fix

* no-hstrerror.patch

I think this should come before "Makefile: SunOS 5.6 portability fix"
(split the change to Makefile from this one and move it to the other
patch).  Then this patch does not talk about SunOS specific issues.

  Makefile: some platforms do not have hstrerror anywhere

* no-inet_ntop.patch

It might make sense to squash this patch into the previous one (and again
do this before HPUX patches to Makefile) that deals with three functions
that are traditionally related to libresolv (hstrerror, inet_ntop/pton).

  Make NO_{HSTRERROR,INET_NTOP,INET_PTON} configured independently

* no-socklen_t.patch

Do this before the platform dependent bits, i.e. move the hunks that
changes "ifeq ($(uname_S,XXX)" block from this patch to host-XXX patch,
and do the remainder of this patch before any of the platform ones.

  Some platforms lack socklen_t type

* no-inline.patch

Do this before ... (ditto) ...

  Allow disabling "inline"
