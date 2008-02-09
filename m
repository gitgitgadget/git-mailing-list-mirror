From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Janitors] value could be NULL in config parser
Date: Sat, 9 Feb 2008 14:15:20 +0100
Message-ID: <200802091415.20295.chriscool@tuxfamily.org>
References: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org> <5d46db230802081720x122a807do6c63b6b3e435b4c5@mail.gmail.com> <200802091118.11174.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Govind Salinas" <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 14:10:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNpSu-0001W2-4h
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 14:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbYBINJX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Feb 2008 08:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754510AbYBINJW
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 08:09:22 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:58487 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbYBINJW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 08:09:22 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E9DB91AB2DF;
	Sat,  9 Feb 2008 14:09:20 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B6FE41AB2DA;
	Sat,  9 Feb 2008 14:09:20 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200802091118.11174.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73218>

Le samedi 9 f=E9vrier 2008, Christian Couder a =E9crit :
> Le samedi 9 f=E9vrier 2008, Govind Salinas a =E9crit :
> > I think I got all the erroneous ones.  I did
> >
> > find . -name "*.c" | xargs grep git_config\( | awk '{ idx =3D index=
($2,
> > ")"); p =3D substr($2, 12, idx - 12); print  p }' | sort | uniq -u
>
> It seems the "uniq -u" should be only "uniq".
> This way, you will also get the following ones to check:
>
> git_default_config
> git_diff_basic_config
> git_log_config
> git_pack_config

I don't know awk so I cannot tell if there is something wrong with your=
=20
script but with:

find . -name "*.c" | xargs perl -ne 'print "$1\n" if (m/git_config ?
\(([^)]*)\)/)' | sort | uniq

I also get:

git_imap_config
show_all_config

Thanks,
Christian.
