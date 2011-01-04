From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/3] Fixes bug: git-diff: class methods are not detected in hunk headers for Pascal
Date: Tue, 4 Jan 2011 18:13:44 +0100
Message-ID: <201101041813.45053.trast@student.ethz.ch>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Zapped <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Tue Jan 04 18:13:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaASG-0001AN-Q6
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 18:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab1ADRNr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jan 2011 12:13:47 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:45765 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575Ab1ADRNr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 12:13:47 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 18:13:04 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 18:13:45 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <1293240049-7744-1-git-send-email-zapped@mail.ru>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164502>

Zapped wrote:
> Signed-off-by: Zapped <zapped@mail.ru>

As Junio already said, please provide a real name for the sign-off.
But I also found the commit message and content confusing, probably
because I haven't programmed Pascal for 15 years.

You said

  Fixes bug: git-diff: class methods are not detected in hunk headers f=
or Pascal

>  PATTERNS("pascal",
> -	 "^((procedure|function|constructor|destructor|interface|"
> +	 "^(((class[ \t]+)?(procedure|function)|constructor|destructor|inte=
rface|"
>  		"implementation|initialization|finalization)[ \t]*.*)$"
>  	 "\n"
>  	 "^(.*=3D[ \t]*(class|record).*)$",

But the last line very conspicuously already mentions 'class', so why
does it fail?

I had to look up a bit of Pascal syntax.  Google helped with

  http://www.freepascal.org/docs-html/ref/ref.html

which answers this.  Also, as stated in SubmittingPatches, we
generally word the messages as stating the behaviour of the changed
version in the present tense.  So a better commit message would be

  userdiff: match Pascal class methods

  Class declarations were already covered by the second pattern, but
  class methods have the 'class' keyword in front too.  Account for
  it.

  Signed-off-by: =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9 =D0=9A=D1=80=
=D0=B5=D0=B7=D0=BE=D0=B2 <zapped@mail.ru>

Ok, now I feel silly for only having a two-liner despite my
complaints.

That being said, I have now verified that the patch is good, and, you
can include my

  Acked-by: Thomas Rast <trast@student.ethz.ch>

in a reroll if you fix the above.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
