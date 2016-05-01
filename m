From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 53/83] builtin/apply: make find_header() return -1 instead
 of die()ing
Date: Sun, 1 May 2016 18:53:08 +0200
Message-ID: <CAP8UFD2AKOuvGesLHBEo5gkUYQ0N_QvLTmqBUXCFsWBn2JNsbg@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-54-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8B7g8WgWbr4M4LHFyBshN2gi30pL1bCcZcTPB7qtmnWdQ@mail.gmail.com>
	<CAPig+cSdRL3hc81pXXFKAZWisGYPHcd47Z4BBhkeSWZ=5_FT9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 01 18:53:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awuck-00012d-AR
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 18:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbcEAQxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 12:53:11 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36875 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbcEAQxK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 12:53:10 -0400
Received: by mail-wm0-f54.google.com with SMTP id a17so109640415wme.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=DV33AAR0hIGEJRV8D0c/R40VyawxpRoTZmY5tmXzuHg=;
        b=DPgoXFYLSo4JyuP325AiD+AHTR/2vvcrYqBOSZ0VWxBdgQu8X8236p6kRTL+UCfcdj
         QjO6upV3omrKPZnWDFw0IHMbVfRU2eabFMpIhXNOs7FcqguMMxiEDZrjUrvILPexcyPR
         S84k1Th5bhyQ9Ntferwo9kN+lOf6HWKbUQogveVWolMjvd8U48n7jGEXWYHo8VxdCyXV
         2xqfjxXgwmwbQUndzeHvArlpsnEXEXD34k0XTFbalgbcRdt5jmr7ugoDtDzxG7Fehj4b
         7629xhsn/glFQPGPJpZANgp6ZmBsy4s6+4RKFH9RfL4AOQN0ZaIr8LzTg6fzwKSDGPdq
         5ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=DV33AAR0hIGEJRV8D0c/R40VyawxpRoTZmY5tmXzuHg=;
        b=HAZeePPFomVpuAkJX+18aahOpNgyd52Bo5ZU1TifNHsQ4SKgnF612DPjpWJrY16fvn
         A+wP+nO0QL9keSZuEefEe8kxYozUN90j93cSrObu6kHML1wQH2LbewpBQyXA1oHqCRO+
         illfhqFENmi6J1flylVjVNu0faY4TjK31xzYCh2UsfHcw43feHf9tCgq+LGACTBsUKtJ
         LFp/JM7fzx1vKDbiUy2DzBWjhTuOC4Yr+YSuhMQ93PVc1WA27KR3V43ssnWEEw9zVmTa
         DQflYiLvMLlCTz+4XMduLrJZhnIKCjMKO2eiOnJrB49ZK4tkAd1dep6eCEIeJ2F+DOyd
         TDtw==
X-Gm-Message-State: AOPr4FVlLZyv0C6mTH5mAu69sstwGjEsrTPaZPzHUO6tbBWR7XjdXRwGenZfIxoLV4Xr5hNr3IYXS3wPectmOA==
X-Received: by 10.28.129.22 with SMTP id c22mr15321563wmd.89.1462121588874;
 Sun, 01 May 2016 09:53:08 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sun, 1 May 2016 09:53:08 -0700 (PDT)
In-Reply-To: <CAPig+cSdRL3hc81pXXFKAZWisGYPHcd47Z4BBhkeSWZ=5_FT9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293197>

On Wed, Apr 27, 2016 at 8:10 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Apr 25, 2016 at 9:18 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, Apr 24, 2016 at 8:33 PM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> To be compatible with the rest of the error handling in builtin/apply.c,
>>> find_header() should return -1 instead of calling die().
>>>
>>> Unfortunately find_header() already returns -1 when no header is found,
>>> so let's make it return -2 instead in this case.
>>
>> I don't think this is a good way to go. Too many magic numbers. I
>> don't have a better option though. Maybe returning names instead of
>> numbers would help a bit.
>
> I suppose 'hdrsize' could signal this extra condition. For instance,
> always return -1 on error, and set hdrsize to 0 for header not found
> (unless 0 is a valid size?), and -1 for any other error.
>
> But perhaps that's getting too clever...

Yeah, I don't think it would make reading the patch simpler.
