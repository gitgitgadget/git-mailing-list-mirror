Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC561F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 23:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbcHOXB2 (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 19:01:28 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:35144 "EHLO
	mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbcHOXB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 19:01:27 -0400
Received: by mail-yb0-f177.google.com with SMTP id z10so7139144ybh.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 16:01:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vV1TwsbUX2U6a4Rh9ANlOo4HlolGn+Xv4URCU2wPKrs=;
        b=PLutvntFMIHHzIX/WsH10QqcaVQvvjaYKMx9/QtY9uJhJmlfbnW+i0IMd6fzI8ULfr
         uSCY2NJ+gZXjQxNWOPBBSFfE4ybzO0VBLde4KgiT5xIiSXK5mHQBCUp4iV8ecnSOQdMR
         OZ0ayETHsdFocSlLFdCOwXPf69Zf+eJsb0otomxUI/HFsNDI8Z+nJCSQw0dldN0ZhsOb
         U4XyVFZ5RFV0I+/Mpn6JyU65LYk7bmEklxM5UR+AXMVD+VrD+aCcpvrMes6SohzK1ai8
         nfNS6im0TJjNmYt43yutc7BwzfvXrVVzCp7DGDqpZZf6c4WRUd07w+mCUj//j21id9k5
         UJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vV1TwsbUX2U6a4Rh9ANlOo4HlolGn+Xv4URCU2wPKrs=;
        b=lJIMvYqfAoMYCaql9Q33Mz0AbO6q/eAWMG8AhS5a7e0+3NAIxkRIEqi0RvoDiOXutc
         BXCCzC1+1+Cb7QknI1C7uHqF/kvxcbs2d56MKRwXsbT+Fp+qlh1j7i7tXajnPLIditc8
         4aNDPBu5pFiupNDPsgJf2VfSTt6CsyBF02Miabg2EK26wqa0jSaJUSlbtq3yc82h5VBU
         gLHlSnifPqvdGolqDG0gL9jkmdHCEnJTbHkq7YFaXR2GgEsrbuKfUAs9t+tRM1oFCo8v
         C2Tqr07bQ9loyR2rWtpfu7Vd2j3Vhjie+PCVkmSRSr0aMcuC1SLkg+zxOMm4+RTokO7X
         RW4g==
X-Gm-Message-State: AEkoouvuUpAbR/G3xRMnHW6yjJPfhq8FvNyzrt7IPovlazS02wK/aUKrA6UsSWW63KguF8vTCKQPXXyaBC0M5w==
X-Received: by 10.37.60.67 with SMTP id j64mr21436463yba.111.1471302086235;
 Mon, 15 Aug 2016 16:01:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Mon, 15 Aug 2016 16:01:05 -0700 (PDT)
In-Reply-To: <xmqqwpjhg42v.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
 <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
 <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
 <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
 <CACsJy8BdmR5USJvjJ6xbjj=bP787tdS72_oL+PDq0D+FPYmiPA@mail.gmail.com>
 <DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley> <CA+P7+xqbmZznxq024fhkejp2FeCVYkOYHTSdR69Di3nkzYJooA@mail.gmail.com>
 <xmqqwpjhg42v.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Mon, 15 Aug 2016 16:01:05 -0700
Message-ID: <CA+P7+xpVOMH6qa6j+oCizcWvO30t1zYA1MD3jkw-7yzw6SPy2w@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 1:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> Some people have suggested this simple idea, and I like it, but they
>> did mention that modifying the cover letter now requires a rebase over
>> a potentially large series of patches, which can get annoying.
>
> That can be simply solved by keeping the cover at the end.  When you
> are updating the real patch on the series with "rebase -i", you
> would have a chance to update the cover at the same time that way.
>

It has problems keeping it at the end as well because that makes
regular commits and commit --amend funky.., but you could do squashes
into the cover letter easily enough as suggested by Philip Oakley. I
think that might be the most natural flow we have now that doesn't
depend on creating some fancy new object type.

Thanks,
Jake
