Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373F71F6C1
	for <e@80x24.org>; Tue, 16 Aug 2016 03:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbcHPDpg (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 23:45:36 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:35627 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbcHPDpf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 23:45:35 -0400
Received: by mail-it0-f45.google.com with SMTP id x131so4599735ite.0
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 20:45:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wZ4nnLu3ms4549aC79ql+v7Nh/EXm2vhtY5lW4vMhho=;
        b=DSLG30ufxXzs61iRavsnxIGQTynrjE4AqtHTtecY72s0QUoDgAa0UzTfaDlXou71Jf
         Y89hfyCSmST+E1HGu9ppM/d1nGD5J0NUBLk1xkcnjbga6qOK8rfOgSXGat3vczUWjTpe
         M6vKSx7lW8Ioi+MPMAKf6Jd+0sDln2vylPoPlCVvnY1El06RiwDBQpogzW4B+RdAzACW
         S5nhq4RzqeEO6LJP7VuMWMe8igqbr2jRWDbGwsgWnx3x+aYG0lsmEeqGXuVnkGYQQTwD
         oGU/Vm1mWvB9xaHBdIVMF0xJo3W69oIFMIYFr5PDv1q4pLjqxQRO2h8NnKiyaOskivzQ
         J8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wZ4nnLu3ms4549aC79ql+v7Nh/EXm2vhtY5lW4vMhho=;
        b=BuHbh57Cv8I0BOEzSykUvGIsNEwh0k1ngHBYcu2Nr2xeRcypAgyGa5CMTUozwZkgDB
         sQaXN7WbMX7tf1y7AsIQ1TtzHuU92MaboEgI1QBCxNk31IbHCXOxeaKIfYWTk4WllG5x
         ZAAX3v83CJqUpbNbBLlCYYB17bkdI/HIDNUQxo07tHEd+BL2ryDTZLN7QWJUgH+p44uU
         ukhroXbyYlqgYKEcpOdTtqu09rqnMmBjCquFN0bNQ9yVLHjKk9k+1ti3mqJuqYyEzaI1
         ZZXBnbVfbhfRWSyYNvYJOGI5sMPTeXYCSW4pjUCgJ7UkhGtxWuN2xMwf5xcz8ZRyZsQw
         xMvg==
X-Gm-Message-State: AEkoousV9cEu/yZYnB+GoowjQJK8/p29OAqbSMyDOmEDnZjlrRTtjNF95Wo29MX9mdDccuqvhguFTaTZCpnH8Q==
X-Received: by 10.36.43.88 with SMTP id h85mr18935700ita.57.1471319134603;
 Mon, 15 Aug 2016 20:45:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Mon, 15 Aug 2016 20:45:04 -0700 (PDT)
In-Reply-To: <3E80981D72F74A11A41A228901644E1C@PhilipOakley>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
 <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
 <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
 <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
 <CACsJy8BdmR5USJvjJ6xbjj=bP787tdS72_oL+PDq0D+FPYmiPA@mail.gmail.com>
 <DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley> <CA+P7+xqbmZznxq024fhkejp2FeCVYkOYHTSdR69Di3nkzYJooA@mail.gmail.com>
 <3E80981D72F74A11A41A228901644E1C@PhilipOakley>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 16 Aug 2016 10:45:04 +0700
Message-ID: <CACsJy8CXKcjo6KO8HvBpx+N4Lj7MO5yMH2q4bVWi-x3mbvWsmQ@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Philip Oakley <philipoakley@iee.org>
Cc:	Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 3:46 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Jacob Keller" <jacob.keller@gmail.com>
> [nip]
>>>
>>>
>>> I've no problem with more extensive methods for those preparing very big
>>> patch series, or with those needing to merge together a lot of series and
>>> want to keep the cover letters, but ensuring that a simple flow is
>>> possible
>>> should still be there.
>>> --
>>> Philip
>>>
>>
>> Some people have suggested this simple idea, and I like it, but they
>> did mention that modifying the cover letter now requires a rebase over
>> a potentially large series of patches, which can get annoying.
>>
>> Thanks,
>> Jake
>
>
> They can just add "squash! cover! <series>" commits for that ;-) Though more
> likely the advanced workflow would be used... We'll need both (more than
> one) options.

Or even better, "git commit --reword $SHA1" brings up the editor with
commit message of $SHA1. Modify any way you want and it creates a new
empty, "reword!" commit that contains the diff between the old commit
message and the new one. "reword!" can be consumed by "rebase -i
--autosquash" without bringing up the editor again. I realize making
"git commit --reword" run multiple times would be tricky though...
-- 
Duy
