From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 10/12] pretty: support padding placeholders, %< %> and %><
Date: Sun, 17 Mar 2013 05:03:23 -0400
Message-ID: <CAPig+cSdoPad=fuhNOp+ChXyh+c8fUD2ewxoaarQQRhJ19SjjA@mail.gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
	<1363400683-14813-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 10:03:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH9VQ-0002uD-5d
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 10:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195Ab3CQJDZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 05:03:25 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:64341 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140Ab3CQJDY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 05:03:24 -0400
Received: by mail-lb0-f173.google.com with SMTP id gf7so3814380lbb.4
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 02:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xr5JPeGIrCVU79+jcKDKGSGs+37+5VlTg9ZFrAsCj5s=;
        b=ppDZIgiTU2yz89NeVohkopv1q/A5+nPAoBF6MQPmZgzwDmxQPvlq5T41PsEsGATFWZ
         qu0O1/0/wZzH34Glx5u8GRvAQIVpUSstovhPb1f8ObX+lphn6TY/5oRnZzo89wmq6FTE
         OJtnPkNIfnbhvi0MnkD2pYAjBbf7+FzKk7vR+MPJ+CKjksht/RibSsbnTijUHeEa59G7
         T2jsT9tuaTU5XiJrZwBNMsqD1EZq+TbBdA7g1P0tSHvBEmA+LPFp3DdxNnCXUJyB5qDf
         OSqpKDCm/UudV72AUb2OgYuancX6XcCTd5LNEciNqt1O96l375/G9TO77gNo4d3TeMJ9
         i1mg==
X-Received: by 10.112.41.101 with SMTP id e5mr4669752lbl.120.1363511003308;
 Sun, 17 Mar 2013 02:03:23 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sun, 17 Mar 2013 02:03:23 -0700 (PDT)
In-Reply-To: <1363400683-14813-11-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: LcTpqkfbgmi1WcxuK0xmrPRmk9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218357>

On Fri, Mar 15, 2013 at 10:24 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> Either %<, %> or %<> standing before a placeholder specifies how many

s/%<>/%></

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-=
formats.txt
> index 8734224..87ca2c4 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -162,6 +162,14 @@ The placeholders are:
>  - '%x00': print a byte from a hex code
>  - '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w optio=
n of
>    linkgit:git-shortlog[1].
> +- '%<(<N>)': make the next placeholder take at least N columns,
> +  padding spaces on the right if necessary
> +- '%<|(<N>)': make the next placeholder take at least until Nth
> +  columns, padding spaces on the right if necessary
> +- '%>(<N>)', '%>|(<N>)': similar to '%<(<N<)', '%<|(<N<)'

s/<N</<N>/g

> +  respectively, but padding spaces on the left
> +- '%><(<N>)', '%><|(<N>)': similar to '%<(<N<)', '%<|(<N<)'

Ditto: s/<N</<N>/g

> +  respectively, but padding both sides (i.e. the text is centered)
