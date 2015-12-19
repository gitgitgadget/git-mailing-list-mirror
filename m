From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 05/11] ref-filter: skip deref specifier in match_atom_name()
Date: Sat, 19 Dec 2015 10:37:04 +0530
Message-ID: <CAOLa=ZRiWVy604j0bFyo0C4dkr-r65gLTCFxXCrzp5-CS30AGQ@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
 <1450279802-29414-6-git-send-email-Karthik.188@gmail.com> <CAPig+cROdhYVW2f9ciwsMeXHNvu3BQP5bp4-no93x26dxor5cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 06:08:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA9kb-0002l8-LQ
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 06:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbbLSFHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 00:07:35 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34802 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbbLSFHe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 00:07:34 -0500
Received: by mail-vk0-f44.google.com with SMTP id j66so76450352vkg.1
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 21:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uxPIYwEA7yu/jDr+pvJ7w/nLayeyeDnoGGLc+Ouo7Ko=;
        b=bPN7//lrfoVyh5OQr1SbV4+FJFV8ukna7XsOPDadqgq1+F7b4cjJsbBuZiZgWLtSAr
         y+8LTvohcwzahKs0M7CQ1/Fzh83LbdU4iL6SOTRwg3fMgjePtjmxxw9FlVt4c5fNO+5j
         hEqqNCgcEEiWdaYRPd7Nugk6yScyhhOke42ejlkv9hthBApBn6tdJl3BhxsCwqrfjXo6
         HLn01Di9nOfSrrjaI52h7t3bdlQLSPa7ox+LtBb3T3PwEv/mJKjojfByyed8oLtLl4Tw
         7XLb1sWpbWiflg8o8YGLI97uf1FAq7okkiqdSSkNBdMOhQRl4Paaj6DktYHfgkAV03kz
         eB3Q==
X-Received: by 10.31.157.144 with SMTP id g138mr5039805vke.71.1450501653657;
 Fri, 18 Dec 2015 21:07:33 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Fri, 18 Dec 2015 21:07:04 -0800 (PST)
In-Reply-To: <CAPig+cROdhYVW2f9ciwsMeXHNvu3BQP5bp4-no93x26dxor5cA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282736>

On Thu, Dec 17, 2015 at 2:41 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 16, 2015 at 10:29 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> In upcoming patches we make calls to match_atom_name() with the '*'
>> deref specifier still attached to the atom name. This causes
>> undesirable errors, hence, if present skip over the '*' deref
>> specifier in the atom name.
>
> I'd drop the second sentence since it doesn't add much or any value.
> Instead, you might want to explain that skipping '*' is done as a
> convenience.
>
>     Subsequent patches will call match_atom_name() with the '*' deref
>     specifier still attached to the atom name so, as a convenience,
>     skip over it on their behalf.
>

Thanks will put that in.

>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -37,6 +37,10 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
>>  {
>>         const char *body;
>>
>> +       /*  skip the deref specifier*/
>
> Too many spaces before "skip".
> Too few spaces after "specifier".
>

Will fix.

-- 
Regards,
Karthik Nayak
