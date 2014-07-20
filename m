From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] wrapper: add xgetcwd()
Date: Sun, 20 Jul 2014 19:35:40 +0700
Message-ID: <CACsJy8BUaAkO8_fjGCtVDyoSKkBQ+VKJLtjN_HZfV7XHOnS_yA@mail.gmail.com>
References: <53CBA59C.8050901@web.de> <53CBA640.1010601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:36:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8qLi-0003JM-MS
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 14:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbaGTMgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 08:36:13 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:51027 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbaGTMgL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jul 2014 08:36:11 -0400
Received: by mail-qc0-f176.google.com with SMTP id i17so4785050qcy.35
        for <git@vger.kernel.org>; Sun, 20 Jul 2014 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tMAvTQ4QPXSRyS2TUEIqOMlKBOme4ndCDnG6rGocPZQ=;
        b=T0pNMpca1h1l35+C1AselFF0K5Z8q3wrgrO16hhuM7yArqZTr0N6VUlSNL+aRGnaX5
         5O7nyXQsob+orBYsOHouunoNMRIEkd4JK/1BfhFAqBiybfUcIrXdcchMHHaCIC8AyhSP
         1tqyZ9crd3vg39J4NF1oHbTr2/AF3BgNn+mXpc4ZoDpu2CnOBnfQaecHMv0sdCbHxOed
         rwOayKQoHDqUcLY1b2J2xXO8+qmaXEGZR9++na3666/s1Wx+M9l5d4zaeD2Y8jhQMQII
         kvnaQTdWHqXihXOhRJGccgv/Z6k1uhY9ZdJrLF/9yz/BIp7DkPmWOyuYEWVO1StHA4bW
         ZE1Q==
X-Received: by 10.224.15.72 with SMTP id j8mr31105124qaa.8.1405859770187; Sun,
 20 Jul 2014 05:36:10 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sun, 20 Jul 2014 05:35:40 -0700 (PDT)
In-Reply-To: <53CBA640.1010601@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253922>

On Sun, Jul 20, 2014 at 6:21 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> +char *xgetcwd(void)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       if (strbuf_add_cwd(&sb))
> +               die_errno("unable to get current working directory");

Wrap the string with _() to make it translatable? I can't see why any
script would want to grep this string..

> +       return strbuf_detach(&sb, NULL);
> +}
--=20
Duy
