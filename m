Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D483020196
	for <e@80x24.org>; Thu, 14 Jul 2016 18:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbcGNSua (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 14:50:30 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34871 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbcGNSu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 14:50:29 -0400
Received: by mail-io0-f181.google.com with SMTP id m101so83862909ioi.2
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 11:50:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=79vwdYMS9QgUxHLUDcXxI0k3gtxY94bYht8Opk9Tt5E=;
        b=N7BbDEw7HIZuQ/InI+hHtW861/qh5ybRl02wmUuTZ9h/PZq4+lbc6DeexzXeFesUmW
         t+Jm7j0tSYaP6ao0sLTjwwnTPEpZQuOCCfEcMyrd0j7TOAvOzjKTfs7HTZBOochqK5MK
         RC84ZFifWo2PBfae34Oikos9bLoKyduKha4ys0ibkNYFdnojgusVdFu59u0nxmr4RK1n
         R+64q03+iGrMYLq2kQts4XO6H3STVm/jpHgzotj/39qkRX7CPzUa+p6DZ1rN0PsPQGT2
         ZTvm+vR9J8ELE1eHnckb7K/doBw1zCrccXdbnZTGz9qhyWVi3+cQ3UbhF6ycqFTG/kWA
         bJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=79vwdYMS9QgUxHLUDcXxI0k3gtxY94bYht8Opk9Tt5E=;
        b=E6xOnsuXKiYCtEONff4vwqLjZwd6YtGW6Yk0CzWGCsO8ArWwsbHetgrOrIfqyIN2Z+
         yWeH6ZrjIqXt8isAv3Qkhw89kghm9XlPDaDc52PJng91It2Tzht8k/UhamN9gqcoeIYM
         2PyBE4aPjNAeSgmJaYlwh/OPaCkevF+kHoSUeHJc5SOSeeSJCB8skTe8FQEwkocyJfAs
         UUjTqviLFW+/YRV4Z7fWiudts7jjcnDhJBkTWMHlNaxeUMhSmwf+m2kFMrio/ZNTEEhy
         TvR5V4g5uKqBVvqNYitVmlJXEvlFcS8nCpZj1olMyLWlm9IKcbWXZtHw5jdflT0T1LT9
         jshw==
X-Gm-Message-State: ALyK8tIrclHXxmTIOJ9jXk5MF0eAY+WYD7VLW5H6XFe3ySEjKOmSgRcMZjkSIXkrNrCVgeRRG7mdlsirpEssB+cm
X-Received: by 10.107.131.38 with SMTP id f38mr16921047iod.173.1468522228134;
 Thu, 14 Jul 2016 11:50:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 14 Jul 2016 11:50:27 -0700 (PDT)
In-Reply-To: <CAPc5daXxAqXtUvs1Xr_vgncXqcvR8-VG67oDAgOQ8xPcT7nCeQ@mail.gmail.com>
References: <alpine.DEB.2.20.1607141725390.25238@tglase.lan.tarent.de>
 <CAGZ79kb=2rpYucjhavNB_XHLk9rjKSoHzL9bwM5buDO0GyW3vw@mail.gmail.com>
 <alpine.DEB.2.20.1607141948530.25238@tglase.lan.tarent.de>
 <xmqqpoqgqdlz.fsf@gitster.mtv.corp.google.com> <CAPc5daXxAqXtUvs1Xr_vgncXqcvR8-VG67oDAgOQ8xPcT7nCeQ@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 14 Jul 2016 11:50:27 -0700
Message-ID: <CAGZ79kYFb5UJ=cnXZTbcO3L4+wc5G24_pV2BhHkOH-+wM9CFJQ@mail.gmail.com>
Subject: Re: Server-side preventing some files from being overwritten
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Thorsten Glaser <t.glaser@tarent.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 11:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Thu, Jul 14, 2016 at 11:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Thorsten Glaser <t.glaser@tarent.de> writes:
>>
>>>       if test x"0" != x"$(comm -23z \
>>>           <(git ls-tree -r -z "$old" "$subdir" | sort -z) \
>>>           <(git ls-tree -r -z "$new" "$subdir" | sort -z) | wc -c)"; then
>>>               echo >&2 'Untouchable files touched, commit rejected!'
>>>               exit 1
>>>       fi
>>
>> Can't this become simpler, e.g.
>>
>>         if ! git diff-tree --quiet "$old" "$new" -- "$subdir"
>>         then
>>                 echo >&2 "Ooh, $subdir is touched"

No need to go for >&2 here, as it makes no difference to
the client.

>>                 exit 1
>>         fi
>
> Ehh, you need to tell diff-tree to recurse, i.e. "diff-tree -r".
