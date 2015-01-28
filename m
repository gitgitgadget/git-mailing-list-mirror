From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH 21/21] t3080: tests for git-list-files
Date: Wed, 28 Jan 2015 09:49:02 -0800
Message-ID: <CAO2U3Qg_w17uDZhqehJnQQLeRTLXN1Fir=v+RJqcknptqJB-6Q@mail.gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
 <1422189476-7518-22-git-send-email-pclouds@gmail.com> <CAPig+cQ8AuoA=ZNaOiZ_JQb-fKtXa-mFhoYQg+eWJxF3eFy9FA@mail.gmail.com>
 <CAO2U3QhA1bGAKmM4OL0VVuOfwaocqmFEsQdZNhSqf_7tkJ+=WQ@mail.gmail.com> <CACsJy8DKJiXpHU4v3vsrgG0dDQ1akGYzfW9cgVJ=mPtdHjsbZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:26:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGZBv-0002Or-CY
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 21:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbbA1U0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 15:26:11 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:38546 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbbA1UZs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:25:48 -0500
Received: by mail-oi0-f49.google.com with SMTP id a3so19719805oib.8
        for <git@vger.kernel.org>; Wed, 28 Jan 2015 12:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RjywzF+fnCyc6Xb/EdrFhhbcTQD1OIqrymEjQac0WqM=;
        b=p77jubB4a0UFknTI4Z6zs3tPwgiphMBuA9QaC8AuomrP8qCcSxaHUqh1BwNOR2YKa3
         FyLtJIa9azK3p94zaDGOQGBE/oi3DYxwcZLruTb5v1QRbi3UVxksSq8fZWPsrXjT99EN
         NT/rPo53aMZOf4VmtLfcOmVcYGoBtNU6BsaD53psWixytouW6HAnMGfCfNKtEpSUzva5
         pER6sAj7PC4zReFmh5aIZ8ud1Tl2TQMjivomaxwtjniAbbEBvJrBAlwYjU8RVtxkLZAb
         sdsQLsMsmUlJfmWGpZmFeceJjEmox0a1o/Pm4zWduXjXhHpDUFn7CcbH4OQMuNvPez2O
         7wnw==
X-Received: by 10.202.214.206 with SMTP id n197mr2838648oig.2.1422467362867;
 Wed, 28 Jan 2015 09:49:22 -0800 (PST)
Received: by 10.202.86.136 with HTTP; Wed, 28 Jan 2015 09:49:02 -0800 (PST)
In-Reply-To: <CACsJy8DKJiXpHU4v3vsrgG0dDQ1akGYzfW9cgVJ=mPtdHjsbZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263107>

On Wed, Jan 28, 2015 at 2:19 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jan 28, 2015 at 11:44 AM, Michael Blume <blume.mike@gmail.com> wrote:
>> Test 3 is failing on my mac:
>>
>> expecting success:
>> test_config color.ls.file red &&
>> test_config color.ls.directory green &&
>> test_config color.ls.submodule yellow &&
>> git list-files --color=always >actual &&
>> test_cmp "$TEST_DIRECTORY"/t3080/color_ls actual
>>
>> --- /Users/michael.blume/workspace/git/t/t3080/color_ls 2015-01-28
>> 04:40:23.000000000 +0000
>> +++ actual 2015-01-28 04:42:59.000000000 +0000
>> @@ -1,3 +1,3 @@
>> -dir
>> -file
>> -gitlink
>> +dir
>> +file
>> +gitlink
>
> Urgh.. colors do not send well over plain text.. I just realized we
> have test_decode_color to convert colors to text descriptions.. will
> fix..
>
> Anyway, I think i may know why it fails. I suppose  the env variable
> LS_COLORS is not defined, or defined as empty in your shell?
> --
> Duy


In case it helps:
https://www.dropbox.com/s/zsm3xgulmsl3rqm/Screenshot%202015-01-28%2009.46.57.png?dl=0

Also no, LS_COLORS is not defined

$ echo $LS_COLORS

$
