From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCHv5 GSoC] gitweb: Move static files into seperate 
	subdirectory
Date: Tue, 25 May 2010 01:58:07 +0530
Message-ID: <AANLkTilqa8HAs9jHJQ5KxWic1IYOZxCj10f11KBRMA-b@mail.gmail.com>
References: <1274714564-7553-1-git-send-email-pavan.sss1991@gmail.com>
	 <201005242205.43194.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, normalperson@yhbt.net,
	pasky@ucw.cz
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 24 22:28:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGeG0-0007eW-9E
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 22:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979Ab0EXU2L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 May 2010 16:28:11 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:52297 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab0EXU2J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 May 2010 16:28:09 -0400
Received: by gxk27 with SMTP id 27so885744gxk.1
        for <git@vger.kernel.org>; Mon, 24 May 2010 13:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k2lzTufY9gH8wdB2VIMyo2cjO87pNylj/IrqwOTH8vo=;
        b=LTNLSXAeMYjiFZTvz5WNkz1kJzAxsJu3ebU9M96f0DQLonr0F8+iifiT1FhHDfZu+s
         0We+3sTxE+7ZsRgWxvghX0L9SDTWYOPNJh+T9rcZKGj7ajx08OdYFPYTd4INUQkQu7Bg
         9PPyTvH7qM/DrkZDi4F+2cKzdJuWqk+ATeuE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uuAeRGgicHP9cL8yAdrZ/Bx3MqDJhEqv9lbMroCvB3U+8rsUWPTlMbvvowldZEOXUx
         gt75xBkwQDxQb7qW7UcFw1ujRReNK05wipPwyWSutmYvmSAqxH1LjRcDB1o1lTkWetK2
         g7CrgD8pzD9kbZJW2dqwTSnIwEoj6/oSAnzlI=
Received: by 10.90.40.18 with SMTP id n18mr3163424agn.28.1274732887885; Mon, 
	24 May 2010 13:28:07 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Mon, 24 May 2010 13:28:07 -0700 (PDT)
In-Reply-To: <201005242205.43194.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147646>

I don't understand why the binary files aren't moving into static/ dir.
I haven't faced this type of problem before. Give me some time to figur=
e it out.

On Tue, May 25, 2010 at 1:35 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> On Monday 24 May 2010 17:22:44 Pavan Kumar Sunkara wrote:
>>
>> =A0gitweb/{ =3D> static}/git-favicon.png | =A0Bin 115 -> 115 bytes
>> =A0gitweb/{ =3D> static}/git-logo.png =A0 =A0| =A0Bin 207 -> 207 byt=
es
>> =A0gitweb/{ =3D> static}/gitweb.css =A0 =A0 =A0| =A0 =A00
>> =A0gitweb/{ =3D> static}/gitweb.js =A0 =A0 =A0 | =A0 =A00
>
> The patch is supposed to move git-favicon.png and git-logo.png into
> gitweb/static but it doesn't.
>
>> =A0diff --git a/gitweb/gitweb.css b/gitweb/static/gitweb.css
>> similarity index 100%
>> rename from gitweb/gitweb.css
>> rename to gitweb/static/gitweb.css
>> diff --git a/gitweb/gitweb.js b/gitweb/static/gitweb.js
>> similarity index 100%
>> rename from gitweb/gitweb.js
>> rename to gitweb/static/gitweb.js
>
> Only gitweb.css and gitweb.js are moved into gitweb/static and that g=
ives some
> errors when running make install:
>
> install -d -m 755 '/home/christian/share/gitweb'
> install -m 755 gitweb.cgi '/home/christian/share/gitweb'
> install -d -m 755 '/home/christian/share/gitweb/static'
> install -m 644 static/gitweb.js static/gitweb.css static/git-logo.png
> static/git-favicon.png '/home/christian/share/gitweb/static'
> install: cannot stat `static/git-logo.png': No such file or directory
> install: cannot stat `static/git-favicon.png': No such file or direct=
ory
> make[1]: *** [install] Error 1
> make[1]: Leaving directory `/home/christian/work/git/gitweb'
> make: *** [install] Error 2
>
> Best regards,
> Christian.
>
