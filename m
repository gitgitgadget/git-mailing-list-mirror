Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2849520A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLGWBU (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:01:20 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:45885 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGWBU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:01:20 -0500
Received: by mail-pf1-f171.google.com with SMTP id g62so2537390pfd.12
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 14:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zC3aHmpoAeEwZvzjAGjp0aQrnERzhIMivLekZ9jeolE=;
        b=W+dorc2/84Sa+UvctJ1g4zOfLABTrwcUPLTHvqSCOzSgLdEr6BOQ9qpq+uyIkv8qxE
         ljFK1YAChNJxqWxM906n2k4yancg0i4tD6+vzf582Q0vjNp9bLvV6QnyBInxHHTKHGLX
         PmuRzUExUndfxhjouVFQ5RLgnirSEKvYVyMoGNvTq+T3f2710vreT8JfjdhC8vITjjiq
         YV6N4JcNxs9Jk+kX8jL/Be4Mpcdc7a7VCTVQ16sSnmUu/1AKN9ZGK1I5TNx/dbYDxT7E
         CTtUyfvUy2FjqBsMLbAT1bPB6LeZegDCBZ51FtZ1uYDiiSybLx+jxjo+toxA9+zjtBC5
         nzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zC3aHmpoAeEwZvzjAGjp0aQrnERzhIMivLekZ9jeolE=;
        b=XygXbRL13BK10YURcB11rNbPPg3mwcZD8pEN5p682HnicVUvDQzRZD+NbXXqs6oS4m
         NyQ5AdWQeZ+94Y1yp8TC63ANtX/Sss4DLXJv2ekEmmuLSIaYAMfLFY26QVWw4zzyKFv3
         V/XS6mSBHr+Ni0pmYDwf0RSiOQ+4rOLJP1tYJi5bupvPN78ej2oFsXE93odKSgA1s/wY
         T/1MpMbY7/mG7diVNTMMrW4/g/nA2bhIBR17d7suKI+ETeZaTYGJrQ+/NG3hijYjbl06
         NNyPxtRLMJ2+utAJl12ScWoQWSjB1IdUq38oHiUDiALBrWlsOUtwn+W+kt/EpXVLUNfq
         WQ9g==
X-Gm-Message-State: AA+aEWaJVLqDwDSOYJjMfFw8ad67sNXxMwP6UKT8CXjITtn01RUJFW1R
        sa/J3gNoWj8x9HGCpFuiHP0=
X-Google-Smtp-Source: AFSGD/Wgg+bM0xQFqm4YaTlxF3TzHfbf696QOx6d9igXrO1xcmrbp6o6FzfHKeg5scdG3A9FmUOfyA==
X-Received: by 2002:a63:8c2:: with SMTP id 185mr3529204pgi.26.1544220078727;
        Fri, 07 Dec 2018 14:01:18 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id m65sm11253807pfg.180.2018.12.07.14.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 14:01:18 -0800 (PST)
Date:   Fri, 7 Dec 2018 14:01:16 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: RFE: git-patch-id should handle patches without leading "diff"
Message-ID: <20181207220116.GB73340@google.com>
References: <20181207181942.GA6411@pure.paranoia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181207181942.GA6411@pure.paranoia.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Konstantin Ryabitsev wrote:

> Every now and again I come across a patch sent to LKML without a leading
> "diff a/foo b/foo" -- usually produced by quilt. E.g.:
>
> https://lore.kernel.org/lkml/20181125185004.151077005@linutronix.de/
>
> I am guessing quilt does not bother including the leading "diff a/foo
> b/foo" because it's redundant with the next two lines, however this
> remains a valid patch recognized by git-am.
>
> If you pipe that patch via git-patch-id, it produces nothing, but if I
> put in the leading "diff", like so:
>
> diff a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>
> then it properly returns "fb3ae17451bc619e3d7f0dd647dfba2b9ce8992e".

Interesting.  As Ævar mentioned, the relevant code is

		/* Ignore commit comments */
		if (!patchlen && !starts_with(line, "diff "))
			continue;

which is trying to handle a case where a line that is special to the
parser appears before the diff begins.

The patch-id appears to only care about the diff text, so it should be
able to handle this.  So if we have a better heuristic for where the
diff starts, it would be good to use it.

"git apply" uses apply.c::find_header, which is more permissive.
Maybe it would be possible to unify these somehow.  (I haven't looked
closely enough to tell how painful that would be.)

Thanks and hope that helps,
Jonathan
