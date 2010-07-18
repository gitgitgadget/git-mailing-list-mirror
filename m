From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: remove duplicate code and not needed break statement
Date: Sun, 18 Jul 2010 20:19:55 +0200
Message-ID: <AANLkTimXOhibJyVu7Z8Obye8ph-xjAbyqQ4rCiodYvpx@mail.gmail.com>
References: <1279475399-6081-1-git-send-email-ralf.thielow@googlemail.com>
	<AANLkTilhNLWEF-40hE9tWdJQX6FXpYWXCu7yhAC11Zvq@mail.gmail.com>
	<AANLkTimuIBe2mvCH15D0RCzlgKTxhHEoX8KEsqiTJgO0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Valeo de Vries <valeo@valeo.co.cc>
X-From: git-owner@vger.kernel.org Sun Jul 18 20:20:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaYT4-00016k-FQ
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 20:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883Ab0GRST5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 14:19:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39362 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756867Ab0GRST5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 14:19:57 -0400
Received: by wyb42 with SMTP id 42so3674127wyb.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WbWthdBhZ/R0gPfulFOsir6ip52kBHg4PEN7lFm56mM=;
        b=HobZI4I/KUaIuM7r7I+LuTzAoPJwF4uOpX5Ym08O1zWYLL86IJjY4bPMr60j+Zv4+q
         9Wssr2Yu/duWy5GHCj8da8HFSR2P57mI2p1e/hSXhpUBSPVZdlGrs3L4hPRhzhMT1Pfc
         RH4k+70CcTd7EN5LUxo0oU1ZM6cgFdjRnz58E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vkNZ1bQUY3gQrULVN5WxqYD2zWGbkCajdtoZ+gsYsAJ0Q0QUSJSYu5BqzaK0MH44bt
         KN4lHRPwCZuXLsNUnpfG3zkrP48R6P/RUBwzZVgy8B2ILHZnPs6b5MijjaSsZXjAvl+o
         2sDpACixufd9TBVOdqjqf9TvJxy94KAep7eWI=
Received: by 10.227.141.138 with SMTP id m10mr1783018wbu.20.1279477195437; 
	Sun, 18 Jul 2010 11:19:55 -0700 (PDT)
Received: by 10.216.91.11 with HTTP; Sun, 18 Jul 2010 11:19:55 -0700 (PDT)
In-Reply-To: <AANLkTimuIBe2mvCH15D0RCzlgKTxhHEoX8KEsqiTJgO0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151230>

There were 2 cases on that switch statement which do the same thing.
in case 'P' there is an if-statment before.

Ralf
> 2010/7/18 Valeo de Vries <valeo@valeo.co.cc>:
>> On 18 July 2010 18:49, Ralf Thielow <ralf.thielow@googlemail.com> wr=
ote:
>>> Remove duplicate code and not needed break statement.
>>>
>>> On switch statements you can use multiple cases for one
>>> statement and on a goto statement you not need a break.
>>>
>>> From 5b3e7c8f8b81a295b5c58534be250f5a818ccc64 Mon Sep 17 00:00:00 2=
001
>>> From: Ralf Thielow <ralf.thielow@googlemail.com>
>>> Date: Sun, 18 Jul 2010 18:48:58 +0200
>>> Subject: [PATCH] remove duplicate code and not needed break stateme=
nt
>>>
>>> ---
>>> =C2=A0server-info.c | =C2=A0 =C2=A03 ---
>>> =C2=A01 files changed, 0 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/server-info.c b/server-info.c
>>> index 4098ca2..9ec744e 100644
>>> --- a/server-info.c
>>> +++ b/server-info.c
>>> @@ -113,11 +113,8 @@ static int read_pack_info_file(const char *inf=
ofile)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_stale;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
>>
>> You seem to have missed another, or am I just lacking context? ;)
>>
>> Valeo
>>
>
