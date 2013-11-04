From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git status: minor output format error
Date: Mon, 4 Nov 2013 08:46:01 +0700
Message-ID: <CACsJy8DyX-cxJNYe3HXeb8e96O36h4aEJrBo+P5035b-vuz0hw@mail.gmail.com>
References: <31465687.35grSWXxkx@i5>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Wolfgang Rohdewald <wolfgang@rohdewald.de>,
	Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 04 02:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd9FV-000763-0q
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 02:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab3KDBqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Nov 2013 20:46:33 -0500
Received: from mail-qe0-f53.google.com ([209.85.128.53]:46537 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab3KDBqc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Nov 2013 20:46:32 -0500
Received: by mail-qe0-f53.google.com with SMTP id cy11so3798268qeb.26
        for <git@vger.kernel.org>; Sun, 03 Nov 2013 17:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AGaZapDbJ1w2eEWSgqH3ygOegLERZEvWCyco0WERF6Q=;
        b=z4dp0wZkeO7wfYA4nzi31Zu+v5d4czNzDKVS+vhEssK8UB8++ePiVSg4bHT7dG8k/C
         7n4xc7EUYozvA6FeUO8x7ckrcWOWTEYQHL/MPJTxd8gfurbj3cY+DqhXPZf5vHxXiqa1
         CPIFZ91s+5JHRy0QvcaTS5qfiyx379nQXP8H+yc3Vfh/vS8uoAd0PRKGJBotR7rqhS7U
         7B3N/amDWzjw5ckPTEgSRFUT5hj7EzwmjyEc1qVo6ZJ8JJvXl59HCfW9G/j6wTnwvGwn
         cVtYP3c4NiuCPhkCFK9KFOF9qeSkZftMmzTlLaj9cBev5U3K6EPwPo3EQvP0JpzjWw8S
         NbGw==
X-Received: by 10.49.82.52 with SMTP id f20mr19469204qey.73.1383529591771;
 Sun, 03 Nov 2013 17:46:31 -0800 (PST)
Received: by 10.96.27.202 with HTTP; Sun, 3 Nov 2013 17:46:01 -0800 (PST)
In-Reply-To: <31465687.35grSWXxkx@i5>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237282>

On Mon, Nov 4, 2013 at 12:17 AM, Wolfgang Rohdewald
<wolfgang@rohdewald.de> wrote:
> git version 1.8.3.2
>
> git status in German says (extract)
>
> #       ge=C3=A4ndert:   kajongg.py
> #       gel=C3=B6scht:    playfield.py
>
> as you can see, there is one space too much before playfield.py
>
> LANG=3DC git status is correct:
> #       modified:   kajongg.py
> #       deleted:    playfield.py
>
> so it seems the spacing between the columns expects "deleted" to have=
 the same number
> of letters in all languages.

No, the translations control the number of columns in this case
(although it's not very intuitive for translators). Something like
this may fix it. I haven't tested because I don't have "de" locale
installed.

diff --git a/po/de.po b/po/de.po
index 35a44b9..d1846d2 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1404,7 +1404,7 @@ msgstr "kopiert:     %s -> %s"
 #: wt-status.c:313
 #, c-format
 msgid "deleted:    %s"
-msgstr "gel=C3=B6scht:    %s"
+msgstr "gel=C3=B6scht:   %s"

 #: wt-status.c:316
 #, c-format
--=20
Duy
