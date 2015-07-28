From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 02/11] ref-filter: add 'colornext' atom
Date: Tue, 28 Jul 2015 21:34:06 +0530
Message-ID: <CAOLa=ZSz8xpDD5LJ3AW6xszTJxCU8EK71V2LJcymB14-ebhnZQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-2-git-send-email-Karthik.188@gmail.com>
 <CAP8UFD2x5rz18hUXmJVWw81EMEVZc5Hm=_GUwfuc6Fo--8Ukfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 18:04:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK7Mw-00056s-71
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 18:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbbG1QEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 12:04:37 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34416 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbbG1QEg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 12:04:36 -0400
Received: by obre1 with SMTP id e1so87881252obr.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DikAzQx/I4QAU9D5rnXJL+0G9+8uToyBo8TSBk8sN80=;
        b=eZXU3PWoZTGd7+EBbJahg5ncUWbn97jPthcwKmiKOpHdoa+dPuvt2G+P1GqGBuvtDe
         6gX46HwQNA1tRmX/PaL6EZ7zcmouQU8+mA5mzN2Sv8rDjCzbAT86RBtWjk9OErhITBNg
         cghaWjWT+a56qKeea53xHA1G213Lqy6OI8GzmUW5PVNho4awYVPD3nZLjcJy47txuIrC
         qoyW5Z63+gehRkRA7PJCRp9+L8BAEUoiKntY0HuKTI8pY7wY2Z7XyHuSGnd6P/f9BtlE
         uBs70Zt1J6dfaKPxSVr1rWY8vx2m61yjvqVWqjY5R5zuBPw4wW581m9wxbwmKPkvinp8
         GJQQ==
X-Received: by 10.60.62.105 with SMTP id x9mr34400481oer.1.1438099476219; Tue,
 28 Jul 2015 09:04:36 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 09:04:06 -0700 (PDT)
In-Reply-To: <CAP8UFD2x5rz18hUXmJVWw81EMEVZc5Hm=_GUwfuc6Fo--8Ukfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274782>

On Tue, Jul 28, 2015 at 2:43 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 8:56 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> @@ -712,6 +713,15 @@ static void populate_value(struct ref_array_item *ref)
>>                         v->modifier_atom = 1;
>>                         v->pad_to_right = 1;
>>                         continue;
>> +               } else if (starts_with(name, "colornext:")) {
>> +                       char color[COLOR_MAXLEN] = "";
>> +
>> +                       if (color_parse(name + 10, color) < 0)
>> +                               die(_("unable to parse format"));
>
> Maybe use skip_prefix(), and die() with a more helpful message.
>

Okay will do. Thanks!

-- 
Regards,
Karthik Nayak
