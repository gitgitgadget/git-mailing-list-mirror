From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 09/12] pretty: add %C(auto) for auto-coloring on the next placeholder
Date: Sun, 17 Mar 2013 04:59:49 -0400
Message-ID: <CAPig+cTsq82zaEn8779vc3StD_-Ms2jgfGc4nhiB+EBTHA=+2w@mail.gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
	<1363400683-14813-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 10:00:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH9Rx-00084Z-Vj
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 10:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191Ab3CQI7v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 04:59:51 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:58401 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140Ab3CQI7v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 04:59:51 -0400
Received: by mail-la0-f46.google.com with SMTP id fq12so4989589lab.5
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4XVuD3sSekJbRyvSNg34RwiDOXz7fKecI1Bk/7XksgQ=;
        b=05qOaHenwSRLagYvVQ73O3KI0L9g9hYGnhnD7d/paxRDtFd1X3ToCZ/7Fa2P9tOEa1
         cwFKjWZvlJoPwXk38r6rIsv69QIAs0t66O3kbBsVAAhEGfm21342JVMQV/KSdBBkEybR
         Mjwnzbe+9byW97NjUWda/9mN0wNU7zap9zm8+I/MZPA4qqq0vjEQztM53ndQ+shdxJUv
         nfNL4FVlRgNkk+J67Hykn06wpkuopd1G78s/utwnYqeVZy1/kdiR/tJLs1yp2aS7g0VK
         cCPc/I+KbMjE5AvlLzsWIoRMmR+KPWc66MihQFc5RIybGGQXNFl5OLQFVQ4oQdst6MjJ
         vp0g==
X-Received: by 10.152.104.199 with SMTP id gg7mr10824550lab.14.1363510789241;
 Sun, 17 Mar 2013 01:59:49 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sun, 17 Mar 2013 01:59:49 -0700 (PDT)
In-Reply-To: <1363400683-14813-10-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: iU060ZoNNK1qo3dxLZyefkSIY0s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218356>

On Fri, Mar 15, 2013 at 10:24 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> This is not simply convenient over $C(auto,xxx). Some placeholders

s/\$/%/

> (actually only one, %d) do multi coloring and we can't emit a multipl=
e
> colors with %C(auto,xxx).
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-=
formats.txt
> index 66345d1..8734224 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -154,7 +154,8 @@ The placeholders are:
>    adding `auto,` at the beginning will emit color only when colors a=
re
>    enabled for log output (by `color.diff`, `color.ui`, or `--color`,=
 and
>    respecting the `auto` settings of the former if we are going to a
> -  terminal)
> +  terminal). `auto` alone (i.e. `%C(auto)`) will turn on auto colori=
ng

s/auto coloring/auto-coloring/

> +  on the following placeholder.
