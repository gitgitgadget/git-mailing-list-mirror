Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF8A2035F
	for <e@80x24.org>; Wed,  9 Nov 2016 00:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbcKIAQG (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 19:16:06 -0500
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33278 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753358AbcKIAQF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 19:16:05 -0500
Received: by mail-yw0-f173.google.com with SMTP id r204so199393017ywb.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 16:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tpSt2lrTAS9NR7ACjr0XbL86NokpW+690ZTSGaBcluw=;
        b=s8a9eHNzghG6VKd7U1fhFCmUP6V6Kb0BX3K8yWE6wid24lCDhUxdb/Lg6weMR2CX5P
         qsAFS5332cLxNg6Dk9xbkXmjUlDNvV/IS36Py/tSUaFQCeJyWjL/3GdW+1bx/Tdds1pB
         oeAbFhM5O2k2t7LeXT8HRVH8drvMPMmuqg5LdTGA0GDCoAa3j7lLZCCjtNapIxxmwlFI
         DvhIStYcuabjke33sAdXWdvP6xCtLpUv7gHwwLC5s4LnP4t0USO2BX1Digbdxr3Xzmt5
         +ay347yJ4uaAsnljX4r7abhQmUIUeDktpJchudo4ulL4n1p6lwHvyzhMgnO7J+n4vssP
         Bk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tpSt2lrTAS9NR7ACjr0XbL86NokpW+690ZTSGaBcluw=;
        b=Unx7djPl55OYXrFq3otTBPJnINlYWs8tMke2grqRxGTCTiw+2DaDLEeK1Pi71a24y1
         4equ+K8XLrwT4zzwEmyJPSlKoZrc76UUD4T1P+4qBDXNWBNvplWGggPZ11gYMoBJqqjN
         p0er7qzd/LZD9yr/1p13g41EG0wf4L1kGcnSsggke8qHjmh8vV8+PL8t8V+87ZLrbDkp
         0d9F7cyJuhXL6+Jiw/MaBjD0CTPBIaOd3SXCAoLqm0Eyti6bP0mtfSYUWdeBuJAwqvsZ
         PrwoAPbW6IubNrsqgqXyzj4whOTxwpsXh6sn3vor7qcKhLhKeHRLKycWWnxDW/rpzNI4
         FLLA==
X-Gm-Message-State: ABUngvesg/+UOosq/hpLIg5Ewf5eEiBIpRvPCtZ8foEYvslpkJTsoo7AqamDxuVW5eO7i3lETcTTf+FVBA27DQ==
X-Received: by 10.129.74.65 with SMTP id x62mr14345623ywa.59.1478650564989;
 Tue, 08 Nov 2016 16:16:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 16:15:44 -0800 (PST)
In-Reply-To: <20161108201211.25213-1-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 16:15:44 -0800
Message-ID: <CA+P7+xqRjMThZF7u_W6G0sHjFP3j5PMr=TszC6UxL2XCYO+CVA@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] port branch.c to use ref-filter's printing options
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2016 at 12:11 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> This is part of unification of the commands 'git tag -l, git branch -l
> and git for-each-ref'. This ports over branch.c to use ref-filter's
> printing options.
>
> Initially posted here: $(gmane/279226). It was decided that this series
> would follow up after refactoring ref-filter parsing mechanism, which
> is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).
>
> v1 can be found here: $(gmane/288342)
> v2 can be found here: $(gmane/288863)
> v3 can be found here: $(gmane/290299)
> v4 can be found here: $(gmane/291106)
> v5b can be found here: $(gmane/292467)
> v6 can be found here: http://marc.info/?l=git&m=146330914118766&w=2
>

I reviewed the full series. I found a few minor things I would have
done differently, but overall I think it looks good. Thanks for the
hard work and the time invested here. I remember seeing this on the
list quite some time ago, so it's nice to see it finally come
together.

Thanks,
Jake

> Changes in this version:
>
> 1. Rebased on top of master.
>
> Karthik Nayak (17):
>   ref-filter: implement %(if), %(then), and %(else) atoms
>   ref-filter: include reference to 'used_atom' within 'atom_value'
>   ref-filter: implement %(if:equals=<string>) and
>     %(if:notequals=<string>)
>   ref-filter: modify "%(objectname:short)" to take length
>   ref-filter: move get_head_description() from branch.c
>   ref-filter: introduce format_ref_array_item()
>   ref-filter: make %(upstream:track) prints "[gone]" for invalid
>     upstreams
>   ref-filter: add support for %(upstream:track,nobracket)
>   ref-filter: make "%(symref)" atom work with the ':short' modifier
>   ref-filter: introduce refname_atom_parser_internal()
>   ref-filter: introduce symref_atom_parser() and refname_atom_parser()
>   ref-filter: make remote_ref_atom_parser() use
>     refname_atom_parser_internal()
>   ref-filter: add `:dir` and `:base` options for ref printing atoms
>   ref-filter: allow porcelain to translate messages in the output
>   branch, tag: use porcelain output
>   branch: use ref-filter printing APIs
>   branch: implement '--format' option
>
>  Documentation/git-branch.txt       |   7 +-
>  Documentation/git-for-each-ref.txt |  82 ++++++-
>  builtin/branch.c                   | 277 +++++++---------------
>  builtin/tag.c                      |   2 +
>  ref-filter.c                       | 456 +++++++++++++++++++++++++++++++------
>  ref-filter.h                       |   7 +
>  t/t3203-branch-output.sh           |  16 +-
>  t/t6040-tracking-info.sh           |   2 +-
>  t/t6300-for-each-ref.sh            |  73 +++++-
>  t/t6302-for-each-ref-filter.sh     |  94 ++++++++
>  10 files changed, 725 insertions(+), 291 deletions(-)
>
> --
> 2.10.2
>
