From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] use xgetcwd() get the current directory or die
Date: Sun, 20 Jul 2014 19:45:33 +0700
Message-ID: <CACsJy8CX5iDejuKZSEoeP_mNCyGzpZ+vQteYfQosw6x6aBJvbw@mail.gmail.com>
References: <53CBA59C.8050901@web.de> <53CBA65B.7090504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:46:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8qVN-0001pk-Ar
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 14:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbaGTMqJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 08:46:09 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:53213 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbaGTMqI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jul 2014 08:46:08 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so4528766qgd.23
        for <git@vger.kernel.org>; Sun, 20 Jul 2014 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DrtDdL+XZOeiITck48PJNu5N4jx1ww88aUwRN3L8HCg=;
        b=LBizk1L5aU35J/nOyLsksg7nWTubT+Xj1h3ZGv9yj++qETxzQEIHFSrLi4Ni15b2fE
         qo6AaiAtBZ1qz93pgND92I+4Dwd5BNpTxHk74cH6OVg6UJFQ8uhV3xUWgnNFUn9NbvGE
         B+C0bJeOaawHE2+CPFEAWS6hQQRT0QisHU1C8uDKtAfzdMZmXCENdgky/38IeTP0C9D2
         EJ/e4w/HbIqf3VeKpL+SMfrFJtOIHP9zn90469kX6gOYqo6h5OXs/U2+rgZPL11whoOT
         2CSeGIaexEi5pKvI4bkZ62F5lb6W2khgC7uaDdOau8Fw3PJ38YH8d5gt4W+jIndmnklI
         OI9w==
X-Received: by 10.224.15.72 with SMTP id j8mr31201629qaa.8.1405860364823; Sun,
 20 Jul 2014 05:46:04 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sun, 20 Jul 2014 05:45:33 -0700 (PDT)
In-Reply-To: <53CBA65B.7090504@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253923>

On Sun, Jul 20, 2014 at 6:22 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> Convert several calls of getcwd() and die() to use xgetcwd() instead.
> This way we get rid of fixed-size buffers (which can be too small
> depending on the used file system) and gain consistent error messages=
=2E
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/init-db.c   | 17 ++++++++---------
>  builtin/rev-parse.c |  6 +++---
>  dir.c               | 12 ++++++++----
>  trace.c             |  7 ++++---
>  4 files changed, 23 insertions(+), 19 deletions(-)

There should be a 4/3 to replace the remaining getcwd with
strbuf_getcwd. But I guess we could add that to the low hanging fruit
list.
--=20
Duy
