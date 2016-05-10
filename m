From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/6] t1500: avoid setting environment variables outside of tests
Date: Tue, 10 May 2016 15:48:56 -0400
Message-ID: <CAPig+cTtU9_3=2eu0boaPbXKXh2gngEe7byDpJuSFAR4rcbrMA@mail.gmail.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
	<20160510052055.32924-6-sunshine@sunshineco.com>
	<20160510183955.GA16211@sigill.intra.peff.net>
	<CAPig+cRR49iJOkaLfynkvch4zUHVkpcJwVah0rvaEOeR7aY2Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 21:49:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0DeQ-0003uJ-NM
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 21:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbcEJTs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 15:48:58 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35956 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbcEJTs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 15:48:58 -0400
Received: by mail-io0-f193.google.com with SMTP id k129so2898358iof.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=mkOfkdkG+2jfJMhuKjJxv99xIB9DxjQBN828/5bSOp0=;
        b=DD7DAna1EUcfrZ0H158se/5g4RUPyyFwtTd9VogYExuj9TOFQxcM6JwiCkxZimiJhg
         mKr/Utojy3A8w/AOA1gHDE2qLnu8NTYJ0qMsh6SvlqblHgH0q42nQgFdQcPswtsEc6ko
         pJWygLwxO7B3V5UdhtaUejXRgXsQz8KvGr2FhOZ1OD/h5v+uny1W/v4O8fbvLt/8uFJV
         oBE4Vx2RkrTxhPUEh/wlM5grWvZQXRWefvi/Z30H9W1ucmxh23ux7GJ9XznMquuyDyW1
         m4WgTK5P2ilu9EWkC6ZNJksC92IsLfXbAIhOhBgomJYe7Zk7EQJVDv4AtC+v1VmzQjff
         o2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=mkOfkdkG+2jfJMhuKjJxv99xIB9DxjQBN828/5bSOp0=;
        b=mko9TcRLgrhayDl1miPZauxRENLoPghdsMBLdP+5QJaI9FXQXwkPjg6J5p7gMYua93
         +kGhaWO54y0/hUpcPI4pAmYtrAGyRG8qanLZZCDTnbAWuPvWllE1YIlrTdyZWtJ3xkqo
         SsFGxZG+p8GW3J2VHOHuuVbnf8zKqFrtwFsQ5Jh3ez9MipYYcQ87EvFwGm7lBrjyeKzz
         VRxV/czbV1qRguO+me3pfH8KdJfUEDt+gXgjhy6fIi/6B63/jHmsvUr2OJ7QCz0ns81t
         6bysnxdtsJ1MoEhmLEo3yUXYhK/u90j8M+Rxoovv5LRYMT/zq3sP3PIX+tp7bEl/X0Yr
         lkMw==
X-Gm-Message-State: AOPr4FWI0TUXaDGXD3u+r+2Iydvud3vfrx0DNzhlihcmF90YV1HZfSByVKPusk0YgqY8SyFxW0Hf64sMsXCSXA==
X-Received: by 10.107.132.66 with SMTP id g63mr2182iod.34.1462909737210; Tue,
 10 May 2016 12:48:57 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 10 May 2016 12:48:56 -0700 (PDT)
In-Reply-To: <CAPig+cRR49iJOkaLfynkvch4zUHVkpcJwVah0rvaEOeR7aY2Nw@mail.gmail.com>
X-Google-Sender-Auth: LmZ7NPL6lruUA_B2KScTqj37F18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294178>

On Tue, May 10, 2016 at 3:12 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, May 10, 2016 at 2:39 PM, Jeff King <peff@peff.net> wrote:
>> On Tue, May 10, 2016 at 01:20:54AM -0400, Eric Sunshine wrote:
>>>       while :
>>>       do
>>>               case "$1" in
>>>               -C) dir="-C $2"; shift; shift ;;
>>>               -b) bare="$2"; shift; shift ;;
>>> +             -g) env="GIT_DIR=$2; export GIT_DIR"; shift; shift ;;
>>> @@ -36,6 +38,8 @@ test_rev_parse () {
>>>       do
>>>               expect="$1"
>>>               test_expect_success "$name: $o" '
>>> +                     test_when_finished "sane_unset GIT_DIR" &&
>>> +                     eval $env &&
>>
>> This will set up the sane_unset regardless of whether $env does
>> anything. Would it make more sense to stick the test_when_finished
>> inside $env? You could use regular unset then, too, since you know the
>> variable would be set.
>
> I didn't worry about it too much because the end result is effectively
> the same and, with all the 'case' arms being short one-liners, I think
> the code is a bit easier to read as-is; bundling 'test_when_finished'
> into the 'env' assignment line would probably require wrapping the
> line. I do like the improved encapsulation of your suggestion but
> don't otherwise feel strongly about it.

Actually, I think we can have improved encapsulation and maintain
readability like this:

    case "$1" in
    ...
    -g) env="$2"; shift;  shift ;;
    ...
    esac

    ...
    test_expect_success "..." '
        if test -n "$env"
        do
            test_when_finished "unset GIT_DIR"
            GIT_DIR="$env"
            export GIT_DIR
        fi
        ...
    '
