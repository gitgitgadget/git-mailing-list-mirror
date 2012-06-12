From: Simon Perrat <simon.perrat@gmail.com>
Subject: Re: [PATCHv2 2/2] git-remote-mediawiki: refactoring get_mw_pages function
Date: Tue, 12 Jun 2012 11:06:07 +0200
Message-ID: <CA+hdvHhn1G=T=KjNvgXa-2M6oh2znbHmfZFZYPdqKhtybh_MoQ@mail.gmail.com>
References: <1339442945-8561-1-git-send-email-Pavel.Volek@ensimag.imag.fr> <1339442945-8561-2-git-send-email-Pavel.Volek@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Volek Pavel <me@pavelvolek.cz>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 11:06:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeN3a-0003fT-RB
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 11:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899Ab2FLJG3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 05:06:29 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60020 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777Ab2FLJG1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 05:06:27 -0400
Received: by obbtb18 with SMTP id tb18so8036245obb.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 02:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Fb6LgP99m3SvOeTDcBLOnUNtp+rkLbnFixwCQ6f3RAw=;
        b=AnOtjjf0/3uQJ/u8svKIP1HuWtY6QqjY/l4TmgdeS/U0BnAswwc/PsjGHijiu7/+wB
         9Cxhn/wzpBpU4kCOK7XdI3LUPJX2yarqXafr0oF9UCA5QEZhcDnZhx+i2e/bcqoab/cC
         dBEfPZXcEah872mvCCgoFLcJ1XLkVY+Nd5Zwmyl5dV1Y3UrBvmSUjAb7ywV59aQSHRac
         kcyl+7/8+37bVXo8iP2kcNCEJ86rqBeVFDYqwof61utZ9+2kgEaL8E81D3d5nP4JKq7o
         EyA3ihYn4T0l2o02lwyS5tpp5FxM3JjykMKYPD8tsim8g1vi3/I4hW7iGv7B1Pz0AbsY
         Xu8w==
Received: by 10.182.40.5 with SMTP id t5mr19497137obk.68.1339491987326; Tue,
 12 Jun 2012 02:06:27 -0700 (PDT)
Received: by 10.60.169.107 with HTTP; Tue, 12 Jun 2012 02:06:07 -0700 (PDT)
In-Reply-To: <1339442945-8561-2-git-send-email-Pavel.Volek@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199772>

2012/6/11 Pavel Volek <Pavel.Volek@ensimag.imag.fr>:

> +sub get_mw_all_pages {
> + =A0 =A0 =A0 my $pages =3D shift;
> + =A0 =A0 =A0 # No user-provided list, get the list of pages from the=
 API.
> + =A0 =A0 =A0 my $mw_pages =3D $mediawiki->list({
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 action =3D> 'query',
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list =3D> 'allpages',
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 aplimit =3D> 500
> + =A0 =A0 =A0 });

Indentation should be 8 columns wide.

> + =A0 =A0 =A0 if ($import_media) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 # Attach list of all pages for meadia f=
iles from the API,

me*dia

> +
> + =A0 =A0 =A0 # Get pages of related media files.

This comment seems to be paraphrasing the line below, could be removed =
maybe.

> + =A0 =A0 =A0 if ($import_media) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_mw_pages_for_linked_mediafiles(\@tr=
acked_pages, \%{$pages});
> + =A0 =A0 =A0 }
> +}


Not much to say on this patch, as this is basically splitting existing =
code.
