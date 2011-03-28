From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Reduce number of changes to pack file.
Date: Mon, 28 Mar 2011 15:40:20 +0200
Message-ID: <AANLkTik19360G7t_cjimCFOAURnuJEA3ztnu3VACWLNV@mail.gmail.com>
References: <AANLkTikqaD7QPCCw86OgGvCHLz1ySu5CzQXoY2rAojxB@mail.gmail.com> <AANLkTimFKGrSCgBShtERaGfd=9y+=q-aHsN3u5Lvf52v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chandra Sukiman <tmcchandra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 15:40:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4CgZ-0003N3-27
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 15:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145Ab1C1Nkl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 09:40:41 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50204 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475Ab1C1Nkl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 09:40:41 -0400
Received: by qyk7 with SMTP id 7so1156988qyk.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 06:40:40 -0700 (PDT)
Received: by 10.229.51.134 with SMTP id d6mr3360606qcg.89.1301319640190; Mon,
 28 Mar 2011 06:40:40 -0700 (PDT)
Received: by 10.229.109.205 with HTTP; Mon, 28 Mar 2011 06:40:20 -0700 (PDT)
In-Reply-To: <AANLkTimFKGrSCgBShtERaGfd=9y+=q-aHsN3u5Lvf52v@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170126>

On Mon, Mar 28, 2011 at 5:33 AM, Chandra Sukiman <tmcchandra@gmail.com>=
 wrote:
> Hi,
>
> I am using git with Dropbox (see
> http://stackoverflow.com/questions/1960799/using-gitdropbox-together-=
effectively).
> Basically I created a bare repository at dropbox and everyone uses
> that for central repository.
> As the repository size is getting bigger, sometime during the git gc,
> it will create a huge .pack file (300 mb) which need to be uploaded
> and downloaded by everyone.
> I tried to limit the size of the pack to 10m (pack.packSizeLimit =3D
> 10m), but when doing gc, what happens now is that most of the pack
> files will get re-arranged and modified. This will cause the same
> upload/download issue that I want to solve.
>
> Is there any way for git gc to reduce the number of file changed?

Yes, you can mark those packs you want to keep creating an empty file
in .git/objects/packs/ with the name of the pack but with .keep as the
extension, i.e.:

=2Egit/objects/pack/pack-f525c8673216b3302b4ec2b515e807a2dcfeff57.idx
=2Egit/objects/pack/pack-f525c8673216b3302b4ec2b515e807a2dcfeff57.keep
=2Egit/objects/pack/pack-f525c8673216b3302b4ec2b515e807a2dcfeff57.pack

HTH,
Santi

>
> Thank you
>
> Chandra
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
