From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Sun, 20 Mar 2011 08:48:29 +0100
Message-ID: <vpqlj0ajkqa.fsf@bauges.imag.fr>
References: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com>
	<AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
	<AANLkTinxyp=PbvzRkyyxXin5aOFm1NP4Be6U2Dv0aD6d@mail.gmail.com>
	<7vsjujq8kf.fsf@alter.siamese.dyndns.org>
	<AANLkTinPCeg3NU2bRvk8rwWSWnu4b0PHwya9+PWAc3DB@mail.gmail.com>
	<AANLkTinFFnm7-TKcbTdbzJHx4i4L8rdi4xogr3R7=7s1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: ryenus =?utf-8?Q?=E2=97=87?= <ryenus@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 08:51:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1DQS-0002pE-A7
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 08:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498Ab1CTHvn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 03:51:43 -0400
Received: from imag.imag.fr ([129.88.30.1]:37133 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab1CTHvm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2011 03:51:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p2K7mTuZ028356
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 20 Mar 2011 08:48:30 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q1DNF-0000a0-RI; Sun, 20 Mar 2011 08:48:29 +0100
In-Reply-To: <AANLkTinFFnm7-TKcbTdbzJHx4i4L8rdi4xogr3R7=7s1@mail.gmail.com>
	("ryenus =?utf-8?Q?=E2=97=87=22's?= message of "Sun, 20 Mar 2011 08:35:51
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 20 Mar 2011 08:48:30 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169489>

ryenus =E2=97=87 <ryenus@gmail.com> writes:

> oops, corrected the script with the test strings in upper cases
>
> #!/bin/sh
> echo $(uname -s)
> case $(uname -s) in
> *MINGW*|*CYGWIN*)
         ^
This "|" means "or" in a case statement...

>   echo "detected MinGW/Cygwin"
>   ;;
> *MINGW*)

=2E..so I can see no way to reach this point: if the string matches
*MINGW*, it also matches *MINGW*|*CYGWIN*.

>   echo "detected MinGW"
>   ;;
> *CYGWIN*)
>   echo "detected Cygwin"
>   ;;
> esac

But you've just showed that $(uname -s) of Cygwin did contain upper-cas=
e
CYGWIN, which I think was the point to verify :-).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
