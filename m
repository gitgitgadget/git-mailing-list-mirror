From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] refs.c: repack_without_refs may be called without error
 string buffer
Date: Thu, 20 Nov 2014 10:56:02 -0800
Message-ID: <CAGZ79kZZfjqhRyFsyPmgBv5bz70TxmStXnHnAV8aMHessEfeWg@mail.gmail.com>
References: <1416506666-5989-1-git-send-email-sbeller@google.com>
	<1416507040-6576-1-git-send-email-sbeller@google.com>
	<20141120183523.GD15945@google.com>
	<CAL=YDWkZcoXBreoPyf1EnSmYcaUPFCPW8tGkCNaD+is2hOiR_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:56:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrWtl-0003RF-CJ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371AbaKTS4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:56:04 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:57849 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756899AbaKTS4D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:56:03 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so5264293igb.11
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 10:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wdIJfWS2GZ9Gy4nvvjoMKviClSBYyaX5YAS9mSewvBQ=;
        b=miV4P348u2zhaOaRC5HznXrNZOJ95MdCpdEtyxj1QevGV55P3ItWCYtj4RnW1hNels
         j1r1NfwZEq/D7gWgqi1GStcMXdhhMG0xBrBthnNfl/kC+FUmf/6TJh/di/j/yd4RGArh
         IZ9Qj1cZqsN0qs8dvx7Iq36GTtQ5lInrtSjvfu2F9sxuVglQLLZyoy7cPB39aufEAyxn
         8wMNFxkIZfxYOSpkias7o0RUf3UPZ0LCkxWjuCuIyy+7xSgyZyabn6RmoHMqUbnq/9Sz
         pbpSn8y1LyEsn3SOOEz/FXrAcoVWT5BZCBqqSGCQ2XSQNBnvHeYCQzRgAJHfVckYhWpC
         Tltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wdIJfWS2GZ9Gy4nvvjoMKviClSBYyaX5YAS9mSewvBQ=;
        b=ZQGI+1n9Y6hgE/HYeDvskde5VXYO4AE3BOZotb9XpwYIzJGvMAMQ9XVnydGvcn/aZE
         uY6SOkLsUZJ0Wu+w8uAb5FwHHkInWH1f2UqI8hmb8VcpTv441Ut44+/hA8Ol6hnW/A81
         e7pBi8L1D9kSE0cm1i/Z+GvIsMX1Fzwx1OMZ2ZwRG2gT8kNgd/NElVVCA1XEH0uNSOLA
         5FVJ2IUBzS/FsehWnv3yEoddxzL22ZOJ4IwyzMIBjXYDNlMoYJMjmr2GNdAvSaTJeeEr
         2eh0LvkK0yDVb1tlYZTAc6dk3GlTuM0pDCuzKTwN5e5Rm/MKmToUI8ns33uUlNnwwGJY
         /p/Q==
X-Gm-Message-State: ALoCoQluRM5vx25PM5OC1TsbDgmC5retf9tA4idIVgZRwKjOATwuUXuglQtJyz4VDTPhIUQ12hMX
X-Received: by 10.43.158.197 with SMTP id lv5mr1232205icc.88.1416509762096;
 Thu, 20 Nov 2014 10:56:02 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Thu, 20 Nov 2014 10:56:02 -0800 (PST)
In-Reply-To: <CAL=YDWkZcoXBreoPyf1EnSmYcaUPFCPW8tGkCNaD+is2hOiR_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ok, will drop the patch due to bad design.

On Thu, Nov 20, 2014 at 10:36 AM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> On Thu, Nov 20, 2014 at 10:35 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Stefan Beller wrote:
>>
>>> If we don't pass in the error string buffer, we skip over all
>>> parts dealing with preparing error messages.
>>
>> Please no.
>>
>> We tried this with the ref transaction code.  When someone wants
>> to silence the message, it is cheap enough to do
>>
>>         struct strbuf ignore = STRBUF_INIT;
>>
>>         if (thing_that_can_fail_in_an_ignorable_way(..., &ignore)) {
>>                 ... handle the failure ...
>>         }
>>
>> The extra lines of code make it obvious that the error message is
>> being dropped, which is a very good thing.  The extra work to format a
>> message in the error case is not so bad and can be mitigated if the
>> error is a common normal case by passing a flag to not consider it an
>> error.
>>
>> Silently losing good diagnostic messages when err == NULL would have
>> the opposite effect: when there isn't a spare strbuf to put errors in
>> around, it would be tempting for people coding in a hurry to just pass
>> NULL, and to readers it would look at first glance like "oh, an
>> optional paramter was not passed and we are getting the good default
>> behavior".
>>
>> This is not a theoretical concern --- it actually happened.
>>
>
> Fair enough.
> Un-LGTM my message above.
>
>
>
>> My two cents,
>> Jonathan
