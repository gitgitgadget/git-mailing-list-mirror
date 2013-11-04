From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: git status: minor output format error
Date: Mon, 4 Nov 2013 08:53:00 +0100
Message-ID: <CAN0XMOK3NqcAyk5c246+CCDZETxGfsZ_AxbBEmUC0RX9aXW8mw@mail.gmail.com>
References: <31465687.35grSWXxkx@i5>
	<CACsJy8DyX-cxJNYe3HXeb8e96O36h4aEJrBo+P5035b-vuz0hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wolfgang Rohdewald <wolfgang@rohdewald.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 04 08:53:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdEyB-0004eY-Fb
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 08:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab3KDHxD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Nov 2013 02:53:03 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:39890 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab3KDHxB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Nov 2013 02:53:01 -0500
Received: by mail-wg0-f45.google.com with SMTP id z12so1720948wgg.0
        for <git@vger.kernel.org>; Sun, 03 Nov 2013 23:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bwQRT5QdtiMqYItgs6Ypf+0oTipam/3EySo+EDVPMLk=;
        b=la9TXHlwetrCuN0pJ7kH1y8N3PxML3gc3RivXrS1uuNv52gCs7KQAqacuWiC0mQtQW
         QsJSTq7EVKxGRL2OYeVyosUuEU6fEvrR1hwS6DYfskBjw8w7r45uFDqEG7sL0tNEKWYK
         AbViiHgJOHbYiFpABye0YG334udoY+SxcUKxar3bF0fITINgJaOCtSq1m7zyrWRVwN+r
         Tt+aTmL6ih7yBgtcEMGsaZkl7znkm2YRlUnhEqojnZDxjh9dRRpOb8N8GajfA985FX8G
         HN7Y8x8VulctlEWAkTlFxI2mPJiqocOwHvoBI/4amtxSc9KaYKTWxB10osNL74eek9ry
         YFWw==
X-Received: by 10.180.76.114 with SMTP id j18mr11090488wiw.35.1383551580056;
 Sun, 03 Nov 2013 23:53:00 -0800 (PST)
Received: by 10.194.165.163 with HTTP; Sun, 3 Nov 2013 23:53:00 -0800 (PST)
In-Reply-To: <CACsJy8DyX-cxJNYe3HXeb8e96O36h4aEJrBo+P5035b-vuz0hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237287>

On Mon, Nov 4, 2013 at 2:46 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Nov 4, 2013 at 12:17 AM, Wolfgang Rohdewald
> <wolfgang@rohdewald.de> wrote:
>> git version 1.8.3.2
>>
>> git status in German says (extract)
>>
>> #       ge=C3=A4ndert:   kajongg.py
>> #       gel=C3=B6scht:    playfield.py
>>
>> as you can see, there is one space too much before playfield.py
>>
>> LANG=3DC git status is correct:
>> #       modified:   kajongg.py
>> #       deleted:    playfield.py
>>
>> so it seems the spacing between the columns expects "deleted" to hav=
e the same number
>> of letters in all languages.
>
> No, the translations control the number of columns in this case
> (although it's not very intuitive for translators). Something like
> this may fix it. I haven't tested because I don't have "de" locale
> installed.
>
> diff --git a/po/de.po b/po/de.po
> index 35a44b9..d1846d2 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -1404,7 +1404,7 @@ msgstr "kopiert:     %s -> %s"
>  #: wt-status.c:313
>  #, c-format
>  msgid "deleted:    %s"
> -msgstr "gel=C3=B6scht:    %s"
> +msgstr "gel=C3=B6scht:   %s"
>

The columns don't match in other related messages, either.
Let's see what happens with [1].

[1]
http://article.gmane.org/gmane.comp.version-control.git/237283

>  #: wt-status.c:316
>  #, c-format
> --
> Duy
