From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 6/6] Automatically switch to crc32 checksum for index when
 it's too large
Date: Mon, 6 Feb 2012 15:54:37 +0700
Message-ID: <CACsJy8Dv9fUzL3COZKVw_KR6aF20kHaw8M4CdBXJDA9H3fbxLw@mail.gmail.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
 <1328507319-24687-6-git-send-email-pclouds@gmail.com> <E799595D-61B3-4978-BCE1-BA6A33034B55@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:55:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuKLy-0000dY-VA
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741Ab2BFIzJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 03:55:09 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56535 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab2BFIzI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 03:55:08 -0500
Received: by wgbdt10 with SMTP id dt10so5977875wgb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 00:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=TNvFZQJ4VSmXLY5CSVeqMTA1ffvo8aY1Xm52dWSTEbI=;
        b=EMS8Yp6GhmRg1zBtJsHKVm+qoEXthxaCt8UjfKEJuxR2oTLqAJjoMQdz7ksg1rYu9P
         ZoI74H+fAKsQgsdHLV524XNnUPBOrPcQfhJi7UIdXeeIu8R7FQIVlZ9wzl353kVqZaPg
         AnbE3/FPkwUp+2yM4DOciGFXLnl6ifBf5NaX8=
Received: by 10.180.90.212 with SMTP id by20mr26188531wib.12.1328518507245;
 Mon, 06 Feb 2012 00:55:07 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Mon, 6 Feb 2012 00:54:37 -0800 (PST)
In-Reply-To: <E799595D-61B3-4978-BCE1-BA6A33034B55@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190051>

2012/2/6 Dave Zarzycki <zarzycki@apple.com>:
> Which crc32 polynomial is being used? crc32c (a.k.a. Castagnoli)? It =
would be great if this were the same polynomial that Intel implements i=
n hardware via SSE4.2.

It's zlib's crc32.

> On Feb 5, 2012, at 9:48 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
>
>> An experiment with -O3 is done on Intel D510@1.66GHz. At around 250k
>> entries, index reading time exceeds 0.5s. Switching to crc32 brings =
it
>> back lower than 0.2s.
>>
>> On 4M files index, reading time with SHA-1 takes ~8.4, crc32 2.8s.
--=20
Duy
