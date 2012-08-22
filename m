From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] precompompose_utf8.c: iconv_open_or_die
Date: Wed, 22 Aug 2012 13:13:46 +0700
Message-ID: <CACsJy8AqtsUJT7ukfn4PpT+Huy-SHPwiBNyO1r=3RFHKUjuTfA@mail.gmail.com>
References: <201208212120.56444.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 08:14:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T44Cu-0007iC-7n
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 08:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab2HVGOT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Aug 2012 02:14:19 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46351 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab2HVGOR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2012 02:14:17 -0400
Received: by ialo24 with SMTP id o24so566257ial.19
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 23:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=353voa3Q7mvN6SeOs2YaOhd/uFcd24nlDIBgWgKtC5s=;
        b=UFaAoG7NqTx9/qJ7PgDnQ7zTPibrAiZJvuG8N0FIqHzZK5CbpLLifH4yKVaNg43ISv
         uy+eDAVlynNgCmMsKDpqiHW/q+AsiYXS2uUANjB/7d9/UMeAVKRTQZppf16P0JUcdCeY
         lnzFP0unIAOr6QaahsUAUFR5FJjTGPfmxwKcAOlyGdf9jpCsOj1/HPHAzJmKRl+ThT9y
         y23przAvWbs2F0/tByW4X7mwIcz0rC1CgVur/PVkrWDe41KGft23mDQIiRAra3oAJtFe
         aTNe+kuZhhD2rXOS3yIsa31Q0aZjyyp9jYU2p9drg/MPI7dhtf/smFlGjlKVzZKKU0Yp
         QdcA==
Received: by 10.50.13.200 with SMTP id j8mr937723igc.48.1345616056705; Tue, 21
 Aug 2012 23:14:16 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Tue, 21 Aug 2012 23:13:46 -0700 (PDT)
In-Reply-To: <201208212120.56444.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204007>

On Wed, Aug 22, 2012 at 2:20 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> +static iconv_t iconv_open_or_die(const char* tocode, const char* fro=
mcode)
> +{
> +       iconv_t my_iconv;
> +       my_iconv =3D iconv_open(tocode, fromcode);
> +       if (my_iconv =3D=3D (iconv_t) -1) {
> +               die(_("iconv_open(%s,%s) failed, but needed:\n"
> +                                       "    core.precomposeunicode n=
ot supported.\n"),
> +                               repo_encoding, path_encoding);

You might want to use die_errno.

> +       }
> +
> +       return my_iconv;
> +}
--=20
Duy
