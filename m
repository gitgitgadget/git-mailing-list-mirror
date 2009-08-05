From: Mark Rada <markrada26@gmail.com>
Subject: Re: [PATCHv4 3/3] gitweb: update INSTALL w.r.t. snapshot format 
	changes
Date: Wed, 5 Aug 2009 13:13:50 -0400
Message-ID: <88f4c4ee0908051013o267f5c6fk3875b39903e63663@mail.gmail.com>
References: <5250C22D-E4D9-4A7C-ABF5-D01316FB1B56@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 19:14:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYk3s-0006h3-2y
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 19:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934404AbZHERNw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 13:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934303AbZHERNv
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 13:13:51 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46575 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934292AbZHERNv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 13:13:51 -0400
Received: by bwz19 with SMTP id 19so223946bwz.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=WqD3iT5OZ0IilsSoKLPzucM8DD+xsgaoZoFRWsBIdFs=;
        b=SV6pT4C5SjzNj3RdjYXuPmp8c41jrwoeWb3ayWPOkc2uxjVC6WoZrMfL70R4BFrOsg
         zBSEtyxGP2sGOiJPMxWH47SQ118r+LULl6rhcVl3/1O3QMacrn//gFnfV0AtqwY5Vn+9
         k12U3Gfr9fUqLYo3qqlBfYJ7DtM/fe5Lhyin8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=kQAVMxGH91fv09Qk1rmroLBV8tBK+kuvqr6dPzDQ6jGUMuhCNYZZBX2xaU8+WlBKAT
         Vc8xzT36rX03WZu7iqBSXpvY2IEpb99aqQ+Jh4HjrOYBTCV8zlIBPQoxnd4yACso0oTS
         fgiCVzZDRZBN8vyYVOwMrqtfyxN+UdBFeZyU8=
Received: by 10.204.115.7 with SMTP id g7mr1034713bkq.183.1249492430736; Wed, 
	05 Aug 2009 10:13:50 -0700 (PDT)
In-Reply-To: <5250C22D-E4D9-4A7C-ABF5-D01316FB1B56@uwaterloo.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124925>

I suppose this actually opens the door to other ways of doing things.

Instead of modifying gitweb.perl for XZ support, there could just be
additional documentation on how to add new formats for compression
in $GITWEB_CONFIG.

Does Gitweb install a default $GITWEB_CONFIG file?

--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


On Wed, Aug 5, 2009 at 9:20 AM, Mark A Rada<marada@uwaterloo.ca> wrote:
> Documentation is now a little bit clearer.
>
> --
> Mark A Rada (ferrous26)
> marada@uwaterloo.ca
>
>
> -------->8-----------------
> From: Mark Rada <marada@uwaterloo.ca>
> Date: Sat, 1 Aug 2009 22:36:54 -0400
> Subject: [PATCH 3/3] gitweb: update INSTALL w.r.t. snapshot format ch=
anges
>
> Details about how to enable/disable a compression format and how to
> set the compression level for any given format, except Zip which does
> not have that ability to set a compression level.
>
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
> ---
> =A0gitweb/INSTALL | =A0 11 +++++++++++
> =A01 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/gitweb/INSTALL b/gitweb/INSTALL
> index 18c9ce3..d53e1bb 100644
> --- a/gitweb/INSTALL
> +++ b/gitweb/INSTALL
> @@ -123,6 +123,17 @@ GITWEB_CONFIG file:
> =A0 =A0 =A0 =A0$feature{'snapshot'}{'default'} =3D ['zip', 'tgz'];
> =A0 =A0 =A0 =A0$feature{'snapshot'}{'override'} =3D 1;
>
> +Furthermore, if you enable overriding of the snapshot feature you ca=
n
> +still disable specific compression formats from being used (XZ is
> +disabled by default). You can also change the default compression le=
vel
> +for non-Zip formats by specifying the level after the compressor nam=
e.
> +For example, we can disable BZip2 compression, and enable XZ compres=
sion
> +at level 6 by adding the following to your GITWEB_CONFIG file:
> +
> + =A0 =A0 =A0 $known_snapshot_formats{'tbz2'}{'disabled'} =3D 1;
> + =A0 =A0 =A0 $known_snapshot_formats{'txz'}{'disabled'} =3D 0;
> + =A0 =A0 =A0 $known_snapshot_formats{'txz'}{'compressor'} =3D ['xz',=
'-6'];
> +
>
> =A0Gitweb repositories
> =A0-------------------
> --
> 1.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
