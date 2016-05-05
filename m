From: "Philip Oakley" <philipoakley@iee.org>
Subject: /* compiler workaround */ - what was the issue?
Date: Thu, 5 May 2016 21:48:40 +0100
Organization: OPDS
Message-ID: <17E04501C9474282B87758C7998A1F5B@PhilipOakley>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Duy" <pclouds@gmail.com>
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 22:48:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayQCY-0007xL-15
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 22:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757007AbcEEUso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2016 16:48:44 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:57714 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756390AbcEEUsn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 16:48:43 -0400
Received: from PhilipOakley ([92.22.17.174])
	by smtp.talktalk.net with SMTP
	id yQCOaUnptfqzwyQCOavw1U; Thu, 05 May 2016 21:48:40 +0100
X-Originating-IP: [92.22.17.174]
X-Spam: 0
X-OAuthority: v=2.2 cv=RpmHF2uK c=1 sm=1 tr=0 a=65owrDdjWijhyMsEc5+gDw==:117
 a=65owrDdjWijhyMsEc5+gDw==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=pGLkceISAAAA:8 a=Q--Iwn271U0PCAvLysQA:9 a=Bn2pgwyD2vrAyMmN8A2t:22
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfK5+j8jf+c3C6Rp2vEnwXsYznPABlIl3pIOVHBUXx4FAIX7h9rsaZYsBAH25k8LEd7C/BKcbtjt86Q72UWgutXOUQnnZSxQ3uwdLGMnD1m3Fvhgq/hGM
 xatYRbovIB0+pxDGlPmhidX56uOSD289e57exZPvHkrD6ezMFVcko+YNwYdy0xyKzno7t/pulLD2CQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293678>

Duy,

In=20
https://github.com/git-for-windows/git/commit/b3c96fb158f05152336f16707=
6f5d81d23c3a5e5
(split-index: strip pathname of on-disk replaced entries, 13 Jun 2014)=20
Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>  you have

read-cache.c#L1790 (in that commit, now ~L1873)

    int saved_namelen =3D saved_namelen; /* compiler workaround */

Which then becomes an MSVC compile warning C4700: uninitialized local=20
variable.

I'm wondering what was the compiler workaround being referred to? i.e. =
why=20
does it need that tweak? There's no mention of the reason in the commit=
=20
message.

There are a few other occurences of this same initialisation issue, so =
I was=20
wondering if it's still neded? Or should I just get MSVC to ignore it, =
which=20
may hide other issues..

--
Philip
