From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: remove duplicate code and not needed break statement
Date: Sun, 18 Jul 2010 20:29:06 +0200
Message-ID: <AANLkTinrg2cp0XL0HOApGN25kmuL7xdik5aEo3lfRqz0@mail.gmail.com>
References: <1279475399-6081-1-git-send-email-ralf.thielow@googlemail.com>
	<AANLkTilhNLWEF-40hE9tWdJQX6FXpYWXCu7yhAC11Zvq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Valeo de Vries <valeo@valeo.co.cc>
X-From: git-owner@vger.kernel.org Sun Jul 18 20:29:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaYbz-00043I-NN
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 20:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756982Ab0GRS3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 14:29:11 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50049 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756907Ab0GRS3K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 14:29:10 -0400
Received: by wyb42 with SMTP id 42so3679865wyb.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W0KKYMFX2cYIc+3xthtDuj3t5bX20WZxY+FR63D5WpY=;
        b=dTrtTpQbBs3jHdHFGTJ+5L1sPEALH298oVkR38cNFRhaTPOPBGnBwPTnW+JLXRLQGp
         dYfr/AQd50aQdStoLIaxHaov9g0V6jX2nG3sFfhPwrKs9yAgAC8LadYS69UJ4e2oiAmV
         1LSlmzohxFwZpT0lfNAt/uFNtkUE4DAFNT6BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dvpeynkwSFLlSiyWj+eYoXMKx9IYSnMlxl9KGFM4xH9r79AJ7Nwzve7Z8Ms5J3DZ/S
         xAKJR0QsbvpvZ9sA4zvNGfVhRuzy46PAJNJgs4OLqNcybOT053pXKd5oRfwp7lsUv3FW
         rJmn5SPwGWintSOjDJj+VnrrBr+71u8bASy8w=
Received: by 10.227.141.138 with SMTP id m10mr1789851wbu.20.1279477746375; 
	Sun, 18 Jul 2010 11:29:06 -0700 (PDT)
Received: by 10.216.91.11 with HTTP; Sun, 18 Jul 2010 11:29:06 -0700 (PDT)
In-Reply-To: <AANLkTilhNLWEF-40hE9tWdJQX6FXpYWXCu7yhAC11Zvq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151237>

2010/7/18 Valeo de Vries <valeo@valeo.co.cc>:
> On 18 July 2010 18:49, Ralf Thielow <ralf.thielow@googlemail.com> wro=
te:
>> Remove duplicate code and not needed break statement.
>>
>> On switch statements you can use multiple cases for one
>> statement and on a goto statement you not need a break.
>>
>> From 5b3e7c8f8b81a295b5c58534be250f5a818ccc64 Mon Sep 17 00:00:00 20=
01
>> From: Ralf Thielow <ralf.thielow@googlemail.com>
>> Date: Sun, 18 Jul 2010 18:48:58 +0200
>> Subject: [PATCH] remove duplicate code and not needed break statemen=
t
>>
>> ---
>> =C2=A0server-info.c | =C2=A0 =C2=A03 ---
>> =C2=A01 files changed, 0 insertions(+), 3 deletions(-)
>>
>> diff --git a/server-info.c b/server-info.c
>> index 4098ca2..9ec744e 100644
>> --- a/server-info.c
>> +++ b/server-info.c
>> @@ -113,11 +113,8 @@ static int read_pack_info_file(const char *info=
file)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_stale;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
>
> You seem to have missed another, or am I just lacking context? ;)
>
> Valeo
>

There were 2 cases on that switch statement which do the same thing.
in case 'P' there is an if-statment before.

Ralf
