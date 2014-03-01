From: Faiz Kothari <faiz.off93@gmail.com>
Subject: Re: [PATCH] rewrite finish_bulk_checkin() using strbuf
Date: Sat, 1 Mar 2014 16:50:37 +0530
Message-ID: <CAFbjVcnM8a9pOmkt1ERZ-5mxek6+uP5ZPabwz1EqBFxO=VCJVw@mail.gmail.com>
References: <1393656389-31300-1-git-send-email-faiz.off93@gmail.com>
	<CAJr59C2F93qUFk3g201ykmQbbQmPGN60k=9--3rOuYAvdZHapA@mail.gmail.com>
	<CAFbjVcmghtj80NetKoBeCKfMcECotiC=Q7ZmBR9ASuAtT_wiWg@mail.gmail.com>
	<CAJr59C2SpT_=-tDq1yQSt8j1TNy9vOugw-tusC=KBUnYfjYfeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: He Sun <sunheehnus@gmail.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 12:20:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJhyF-0007eV-JB
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 12:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbaCALUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 06:20:39 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:63256 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbaCALUi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 06:20:38 -0500
Received: by mail-lb0-f178.google.com with SMTP id s7so3467232lbd.9
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 03:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=SIG0wYCBwe64bRq65hdsOpDBsrdJEc/tMv1ACHjAyyk=;
        b=udQJTeT0B6kCepV/7E06r2jQxyl+AoZlNQhYA7bXcK4scRVQTpUZD1qDwqO+3L/o/o
         PrqoDkwZAxR1aQTRWp6uNc3MtQZtgx7ZExUjWu6jByFsEctPQMIGfFhRA1EdRzJq3hU1
         mESybb9n1qU/bkdl1Tpvi2uApgCfSLcOrC47TwgAPXdJoy55u4n4p481sfyaI+2bA+y9
         k0xiQKrt7KtzL7f41KiYqkoYTeg30GXjkIiusx9uVorrkfzO83X7mj9uQobm6m6HUKls
         6M+1SpRIjT4g5EbWtobyD1otMolRrrPwj26ni/2VxUcPrzM9ES+OSFtNP31cnqDrQzrr
         330A==
X-Received: by 10.152.28.200 with SMTP id d8mr95899lah.59.1393672837262; Sat,
 01 Mar 2014 03:20:37 -0800 (PST)
Received: by 10.114.186.35 with HTTP; Sat, 1 Mar 2014 03:20:37 -0800 (PST)
In-Reply-To: <CAJr59C2SpT_=-tDq1yQSt8j1TNy9vOugw-tusC=KBUnYfjYfeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243060>

On Sat, Mar 1, 2014 at 4:33 PM, He Sun <sunheehnus@gmail.com> wrote:
> 2014-03-01 15:18 GMT+08:00 Faiz Kothari <faiz.off93@gmail.com>:
>> Hi,
>> Yup, at that position.
>> I don't know, but it failed a few tests on my machine related to bitmap.
>> Another thing to use would be strbuf_splice()
>
> Eric Sunshine<sunshine@sunshineco.com> has came up with a more
> elegant way to finish this task. That's using strbuf_setlen() instead of
> strbuf_remove(). Because of the unstable network of this afternoon. The
> former email is sent without the above information.
> Sorry about it.
You mean first use strbuf_setlen() to reduce len and then add ".whatever" to it?
strbuf_splice can do strbuf_remove() and add string in one shot as per the doc.
If using strbuf_setlen() is still better, I'll implement using that :)

> I find out that you didn't attach strbuf_remove() in your finish_bulk_checkin().
> That may cause problems not only related to bitmap, because the input
> packname is different from the output packname..
>
I am not sure how that is causing the problem, because tests run just fine.
I'll still look into it. Thanks for pointing that out :)

Cheers,
Faiz
