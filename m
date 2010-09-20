From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Reduced privileges install
Date: Mon, 20 Sep 2010 16:40:23 +0200
Message-ID: <vpqzkvcwka0.fsf@bauges.imag.fr>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com>
	<86k4mhfcj1.fsf@red.stonehenge.com>
	<6BE502C9-5507-452D-A5D5-D0C69C05F126@kellerfarm.com>
	<677DFF75-2DBB-4772-802B-4402E4024307@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Keller <andrew@kellerfarm.com>,
	Git List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Sep 20 16:40:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxhXq-0003gp-T0
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 16:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567Ab0ITOkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 10:40:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33998 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756476Ab0ITOka (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 10:40:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o8KERWZL021826
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Sep 2010 16:27:32 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OxhXb-0002xD-KK; Mon, 20 Sep 2010 16:40:23 +0200
In-Reply-To: <677DFF75-2DBB-4772-802B-4402E4024307@sb.org> (Kevin Ballard's message of "Sun\, 19 Sep 2010 23\:51\:54 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 20 Sep 2010 16:27:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8KERWZL021826
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1285597654.94101@M/L6s7PrzChD4ynu/tHgnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156627>

Andrew Keller <andrew@kellerfarm.com> writes:

> make -C perl prefix='/usr/users/students/ak4390/.local' DESTDIR='' install
> make[1]: Entering directory `/usr/users/students/ak4390/Downloads/git-1.7.2.3/perl'
> make[2]: Entering directory `/usr/users/students/ak4390/Downloads/git-1.7.2.3/perl'
> Warning: You do not have permissions to install into /usr/perl5/site_perl/5.6.1/sun4-solaris-64int at /usr/perl5/5.6.1/lib/ExtUtils/Install.pm line 85.

The DESTDIR='' is suspicious. It seems the prefix is not passed
properly in recursive "make" invocations, and perl tries to install
things in the default directory.

Kevin Ballard <kevin@sb.org> writes:

> Andrew Keller <andrew@kellerfarm.com> writes:
>> $ ./configure --prefix=/usr/users/students/ak4390/.local
>> $ make
>> $ make install
>
> I admit, I'm not well-versed on the build system, but my impression
> was that specifying --prefix in ./configure was indeed supposed to
> propagate to a subsequent make and make install.

It does. I installed Git successfully without ever being root on
several machines.

In my case, it was GNU/Linux machines, so something may go wrong
because of a non-gnu system. Did you try compiling with gmake instead
of make?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
