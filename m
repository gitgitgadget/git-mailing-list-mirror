Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9602B1F404
	for <e@80x24.org>; Sun,  4 Feb 2018 04:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750798AbeBDEnC (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Feb 2018 23:43:02 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33403 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeBDEnA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Feb 2018 23:43:00 -0500
Received: by mail-qt0-f175.google.com with SMTP id d8so35812833qtm.0
        for <git@vger.kernel.org>; Sat, 03 Feb 2018 20:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=k2ILD/ohfil8uitDGnjMEdBPu3fRO16g2WEDnHG4Uzo=;
        b=FZiRq5++cC043V1/ML+zdolUKGqUcn+W/hTiGslkyCuMSj2LrbPIMFd/KgpgO+OEtn
         GW+jfLXh5VV9dscw83rQgVYpqCagnVIGadK/bXIGvtzLddnSgfLJMX1mgo/Y+P2Cajn3
         uURVW7ZtIsv3y8BcCsDmri3V5E4ncJjE7Y6VCOA7gdwg/lTE1jsecg9VFwyQARt+qJwF
         X9XFYS+umLBM4COlfJvA0JavuXXMazxrQCaoLehDE2S5/H6pzZzpa+P965Lex8VlLWKW
         KczH1brqrrgIOBgMyHWQkfq/qrFAaQBw+6klZ0JBYLLwVcObO/84K0yksmBE9rLhlLkl
         ukMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=k2ILD/ohfil8uitDGnjMEdBPu3fRO16g2WEDnHG4Uzo=;
        b=bCagQtNSa6lP+coM7kZP2Xl224rGpjRFGEfhLDDKf+KBQfvxGifHrFCHZ8lrx9u8b1
         fZfJWW6wLicDR58t7mjUzrhTAJkgExPz0P3UVCyqGP42GqqRtqEtTr6ywJIO1WdU4XgU
         P/pLA2qd/i8vLN1/4+8UpDnHogHvyuP7K7CwLoMFQQbky/TIU5wD4HTKBJSDuuTPQc20
         9svFWI7gwAK4VaZWwKtfERYwbGbM4HuCAzSrE2ju0tYY+9d+n9WVG7FgaWVdsf2uCtnc
         FPO8CMFCLTQjAr3zsW8Of1S6lkOrn44XSXH/nrRU6AgB5krOPr4lLEOUSXFn7YA6fmgC
         POXg==
X-Gm-Message-State: APf1xPAG6v3Imu8qDNATgxudmzdNAn7YEIiRBPNRd1u0rLUvWD5ZBetU
        R/CcmDqoIhCITlh6BSH5hSJxp+He6jqyGUFK328=
X-Google-Smtp-Source: AH8x225O00B4pu2p6lY5BJF0rUsKSC96QhndDMj1apKMui7Yh4PMssiB0cZPhY78c/KcLDjkybszjT/Dc5IKb0Bwjnw=
X-Received: by 10.200.15.194 with SMTP id f2mr5004628qtk.237.1517719379566;
 Sat, 03 Feb 2018 20:42:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sat, 3 Feb 2018 20:42:58 -0800 (PST)
In-Reply-To: <CABPp-BGwAu7_+BJR+43G2SysmBMnZYEBtHnwjMZBRn5XDPubWg@mail.gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-20-newren@gmail.com>
 <CAGZ79kb2+tpr0K0x2VVfFR-u3W2htvbxokxfKBpG60mNjXGPEw@mail.gmail.com>
 <CABPp-BGh7QTTfu3kgH4KO5DrrXiQjtrNhx_uaQsB6fHXT+9hLQ@mail.gmail.com> <CABPp-BGwAu7_+BJR+43G2SysmBMnZYEBtHnwjMZBRn5XDPubWg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Feb 2018 23:42:58 -0500
X-Google-Sender-Auth: 9nzSZonL3evnclNYSg5WODIhstk
Message-ID: <CAPig+cQu20ZH3hj=2MSNqS3K-+qtZjtHAUQA0TL1LOG685yQtg@mail.gmail.com>
Subject: Re: [PATCH v7 19/31] merge-recursive: add get_directory_renames()
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 3, 2018 at 9:04 PM, Elijah Newren <newren@gmail.com> wrote:
> On Sat, Feb 3, 2018 at 2:32 PM, Elijah Newren <newren@gmail.com> wrote:
>> On Fri, Feb 2, 2018 at 5:02 PM, Stefan Beller <sbeller@google.com> wrote=
:
>>> On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote=
:
>>>> +       while (*--end_of_new =3D=3D *--end_of_old &&
>>>> +              end_of_old !=3D old_path &&
>>>> +              end_of_new !=3D new_path)
>>>> +               ; /* Do nothing; all in the while loop */
>>>
>>> Assuming many repos are UTF8 (including in their paths),
>>> how does this work with display characters longer than one char?
>>> It should be fine as we cut at the slash?
>>
>> Can UTF-8 characters, other than '/', have a byte whose value matches
>> (unsigned char)('/')?  If so, then I'll need to figure out how to do
>> utf-8 character parsing.  Anyone have pointers?
>
> Well, after digging around for a while, I found this claim on the
> Wikipedia page for UTF-8:
>
>   Since ASCII bytes do not occur when encoding non-ASCII code points
> into UTF-8, UTF-8 is safe to use within most programming and document
> languages that interpret certain ASCII characters in a special way,
> such as "/" in filenames, "\" in escape sequences, and "%" in printf.
>
> So, unless I'm reading something wrong here, I think that means this
> code is just fine as it is.

You're reading it correctly. Unicode values greater than \U007f
encoded with UTF-8 will never contain bytes which can be confused with
any 7-bit ASCII character.

It's possible that Stefan was thinking of "combining characters"[1]
which may be "precomposed" and "decomposed"[2], but which appear the
same when rendered. For instance, "=C3=B6" might be a single Unicode
codepoint or two codepoints, such as "o" combined with a diaeresis.
It's a potential problem if you're comparing, byte by byte, two
filenames which look the same. However, Git takes pains[3] to avoid
this problem by ensuring (if possible) that filenames are precomposed
within Git even if they happen to be decomposed on the actual
filesystem. So, most likely, your code is okay as-is.

[1]: https://en.wikipedia.org/wiki/Combining_character
[2]: https://en.wikipedia.org/wiki/Diaeresis_(diacritic)
[3]: https://github.com/git/git/blob/master/compat/precompose_utf8.c
