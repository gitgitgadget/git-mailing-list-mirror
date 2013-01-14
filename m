From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v3 03/31] Add parse_pathspec() that converts cmdline args
 to struct pathspec
Date: Sun, 13 Jan 2013 16:05:16 -0800
Message-ID: <CANiSa6icv7V7hoEzHQT0mgqjCDcSkuLvZ2M=6Q5gp6NcXJ20jQ@mail.gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
	<1358080539-17436-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 01:05:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuXYk-0001iO-DS
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 01:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab3ANAFX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 19:05:23 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:41221 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab3ANAFR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2013 19:05:17 -0500
Received: by mail-ie0-f170.google.com with SMTP id k10so4465536iea.29
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 16:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=eJaAPkFl5r72X4HuTbQnvoH4ASIDyzprKsmwUjLqhII=;
        b=w4wZuSwkl6Zbur0olc7wZ/qZr9bKTLeIatojD4yhdWOX8MPyumaqS6kb1OaBSKDSTG
         795PRDhhhnCqKhRRPewoDjclVN6xKurHLZv3ZD5EmzSn0o5rTroRA3qPJ0RKlCoX1Azy
         l3SrcDaGipOhT5j+Ntnyx+VHgv7LOcgxq0TzBPOa8IyJ70Zwulc60h6FMOBKJEjTTuJ9
         cOMQ9H/rzWl71qlCWubxMB44oktoomEnWWo0CrC7WWPKNG4/z8tGJq4F/0D5tXcxNMqC
         lQWw1KAxObopOqgpl5Wj8NHtxvWOhIu+A+NTxxHnsgIqTcQy2yQCM8aTSoWYz2UscGCd
         5EcQ==
X-Received: by 10.50.196.130 with SMTP id im2mr5469562igc.17.1358121916238;
 Sun, 13 Jan 2013 16:05:16 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Sun, 13 Jan 2013 16:05:16 -0800 (PST)
In-Reply-To: <1358080539-17436-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213411>

On Sun, Jan 13, 2013 at 4:35 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> +static void parse_pathspec(struct pathspec *pathspec,
> +                          unsigned magic_mask, unsigned flags,
> +                          const char *prefix, const char **argv)
> +{
> +       struct pathspec_item *item;
> +       const char *entry =3D *argv;
> ...
> +       for (i =3D 0; i < n; i++) {
> +               const char *arg =3D argv[i];

Nit: "*argv" was assigned to "entry" above. Reassign that variable inst=
ead?
