From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git-p4 clone @all error
Date: Tue, 6 Nov 2012 13:54:48 +0000 (UTC)
Message-ID: <loom.20121106T135442-279@post.gmane.org>
References: <1351593879401-7570219.post@n2.nabble.com> <CABYiQp=1HEW=53U2Rck5vckhq0PB3C9iuanoXeVvNG6Xv5+oHg@mail.gmail.com> <20121103231305.GB11267@padd.com> <1352109747598-7570575.post@n2.nabble.com> <20121105221212.GA12003@padd.com> <20121106002515.5b7eba50@fenix.utopia.dhis.org> <1352192140569-7570622.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 14:55:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVjca-0004yS-C1
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 14:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785Ab2KFNzC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2012 08:55:02 -0500
Received: from plane.gmane.org ([80.91.229.3]:58848 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989Ab2KFNzB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 08:55:01 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TVjcR-0004uB-LK
	for git@vger.kernel.org; Tue, 06 Nov 2012 14:55:07 +0100
Received: from 57.79.130.182 ([57.79.130.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 14:55:07 +0100
Received: from vitor.hda by 57.79.130.182 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 14:55:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 57.79.130.182 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20100101 Firefox/16.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209110>

Arthur <a.foulon <at> amesys.fr> writes:

>=20
> Thanks for your support,
>=20
> If i get latest r=C3=A9vision on Perforce i have this errors :
>=20
> /    590 errors reported
>     Librarian checkout
> depot/mainline/02_subsystem/10_arinc_429/00_cots/01_bsp_aim/original
> files/api429decryption.txt failed.
>     open for read:
> depot/mainline/02_subsystem/10_arinc_429/00_cots/01_bsp_aim/original
> files/api429decryption.txt,v: Le fichier spcifi est introuvable.
>     Librarian checkout
> depot/mainline/02_subsystem/10_arinc_429/00_cots/01_bsp_aim/original
> files/api429linuxrelnotes.pdf failed.
>     open for read:
> depot/mainline/02_subsystem/10_arinc_429/00_cots/01_bsp_aim/original
> files/api429linuxrelnotes.pdf,d\1.1150: Le chemin d'accs spcifi est
> introuvable.
>     Librarian checkout
> depot/mainline/02_subsystem/10_arinc_429/00_cots/01_bsp_aim/original
> files/lien vers readme.txt failed.
>     .../
>=20
> Perforce can't find the files because they were removed. (option
> obliterate...)
> So the error on the Perforce clone may come from this.

To be honest, I don't know how git-p4 behaves when obliterate is used.

> How i can show git-p4.branchList ?
>
> My depot structure :
>=20
> MAINLINE
>   DEV_DATA
>   RELEASE_1.0
>   RELEASE_1.0.0
>=20

This tells me you did not setup the branchList configuration. In your
~/.gitconfig please add the following:

[git-p4]
    branchList =3D DEV_DATA:RELEASE_1.0
    branchList =3D DEV_DATA:RELEASE_1.0.0

This assumes that the RELEASE branches are integrated from DEV_DATA.
After the import is successful you can move the [git-p4] from
~/.gitconfig to .git/config of the git repository.

Please make sure you keep in CC, because I'm not subscribed to the
mailing list.

Vitor
