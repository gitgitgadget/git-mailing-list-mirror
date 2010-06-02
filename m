From: =?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>
Subject: Re: Best way to apply textconv to a working tree file
Date: Wed, 02 Jun 2010 11:56:59 +0200
Organization: Ensimag
Message-ID: <1725d013942b49b804102cca573d2999@ensimag.fr>
References: <a1ace6b77167a2ad4b4995e8c4d09761@ensimag.fr> <20100601170426.GC9702@sigill.intra.peff.net>
Reply-To: clement.poulain@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 11:57:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJkhb-0008Mv-Vm
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 11:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757679Ab0FBJ5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 05:57:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49514 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014Ab0FBJ5E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 05:57:04 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o529nahN032169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 2 Jun 2010 11:49:37 +0200
Received: from ensicom.imag.fr (web-ensimag [195.221.228.24])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o529ux2W009330
	for <git@vger.kernel.org>; Wed, 2 Jun 2010 11:56:59 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by ensicom.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id o529uxdE032702
	for <git@vger.kernel.org>; Wed, 2 Jun 2010 11:56:59 +0200
In-Reply-To: <20100601170426.GC9702@sigill.intra.peff.net>
X-Sender: clement.poulain@ensimag.imag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 02 Jun 2010 11:49:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o529nahN032169
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
MailScanner-NULL-Check: 1276076980.09494@u97bunu23vxLaPFOU8RhPw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148239>

On Tue, 1 Jun 2010 13:04:27 -0400, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 01, 2010 at 03:41:05PM +0200, Cl=C3=A9ment Poulain wrote:
>=20
>> We are wondering what is the best way to do the textconv. Here are s=
ome
>> solutions we thought about:
>=20
> One solution you didn't mention would be to do it all yourself:
>=20
>   driver=3D`git check-attr diff "$file" | cut -d: -f3`
>   textconv=3D`git config diff.$driver.textconv`
>   $textconv <$file >$file.converted
>=20
> This has the advantage of working with existing versions of git. The
> downside is that it's more code (e.g., my parsing above is quite slop=
py
> and loose. Doing it right would be a few more lines).
>=20
> Furthermore, it doesn't use the textconv cache at all. For working tr=
ee
> files, this might not matter (if you pull the sha1 out of the index,
> though, you can still check the cache, and unchanged working tree fil=
es
> are likely to be in the cache). But for blobs in general, the cache i=
s
> worth using.
>=20
> -Peff

It seems to really fit for git gui.=20
About the cache : this method will be only used by git gui (when it's
launched) on working tree files, so it seems OK for me.
Thank you
