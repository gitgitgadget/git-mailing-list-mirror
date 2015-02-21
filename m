From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Support customized reordering in version sort
Date: Sat, 21 Feb 2015 10:33:03 +0700
Message-ID: <CACsJy8BFZ2O62f+QofSqZRoQ9BOX0SLnXHY_g93iMnyikW8H7g@mail.gmail.com>
References: <20150218191417.GA7767@peff.net> <CACsJy8B_zkAecL2Wag8a5c9-_C9eoA9dYj4ciBXqXRVmRW77zw@mail.gmail.com>
 <20150220071342.GB8763@peff.net> <CAPc5daVJ_nYk=tWqpUYPpsX6Z50H429jOh8QfMwUdNDdTDMq9w@mail.gmail.com>
 <20150221030209.GA567@lanh> <CAPc5daXtmvfgkFA_YeQxunjSWYGUQB0uWCQVgfxMP_M9fB9qEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 04:33:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP0p1-0002u2-Qy
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 04:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442AbbBUDdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 22:33:35 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:39001 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990AbbBUDde (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 22:33:34 -0500
Received: by iecvy18 with SMTP id vy18so12404272iec.6
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 19:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=y7K+2EMYYi4xNyNM9A2N9x3U11I9cHeCqxxs4riDbLY=;
        b=wZOhqfHYix5ammiWeLEjJoGLZeRkZT9Buh0pK356/r9PiDkULBWfnuRhBnMDTt4GEn
         gSj/Qtkly9KQRnGvY9HhjofUHToQDl/CWnjaT6sX7K9IE3zJiKTH/XpnoeQJLs7c42N3
         qkAhixXGn1X54+k5hAouILIsJWwxd22/Rjmo+PXHkuO3p1w1rz/AP5aiG1Fo88Nn4ZHM
         bLi9ePFrD9ro0xcCZxft+Sub6pJ4bHEDOjs0PW7wJ6GJjuEfWXhN47qrTaQuTDDwa+ji
         +G09GIPO71SDCq4AyeGy8g56O0sa9mWPSWDidbnFsYen1FAfzOXrFV+vtAc7DuhAwYrL
         6dtQ==
X-Received: by 10.43.19.134 with SMTP id qk6mr1171429icb.29.1424489614069;
 Fri, 20 Feb 2015 19:33:34 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Fri, 20 Feb 2015 19:33:03 -0800 (PST)
In-Reply-To: <CAPc5daXtmvfgkFA_YeQxunjSWYGUQB0uWCQVgfxMP_M9fB9qEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264201>

On Sat, Feb 21, 2015 at 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Fri, Feb 20, 2015 at 7:02 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> My idea is to make it easy for the user to change the sort algorithm.
>> And it's probably intuitive to just substitute a string with
>> something. So if "1-rc1" is put incorrectly before "1.1" and you
>> realize that "1.999" ought to be the last one before "2". You could
>> tell git to internally replace "1-rc1" with "1.999".
>>
>> This patch does that. The user feeds substitution rules via
>> versionsort.substitute config keys, e.g.
>>
>>     git config versionsort.substitute "-rc .999"
>
> I would say 1-rc1 comes and then 1-rc2 and then 1-rc3 ... 1-rc10 and then
> 1-rc11 and then finally 1. It will probably be followed by 1.1-rc1, 1.1-rc2, ...
> and then 1.1 (aka 1.1-final).
>
> If 1-rc1 is equated with 1.9991 because -rc is replaced with .999, how does
> it make 1 come after 1.99911, and 1.1.9992 come before 1.1?
>
> I didn't read the patch text and perhaps the explanation above is the only
> thing faulty about your message, or perhaps my reading is faulty and the
> above describes a sound idea, but I do not see how the above makes sense.

No, faulty thinking. Back to the whiteboard..

-- 
Duy
