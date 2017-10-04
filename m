Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1CFD20365
	for <e@80x24.org>; Wed,  4 Oct 2017 18:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbdJDSHm (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 14:07:42 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:43114 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbdJDSHk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 14:07:40 -0400
Received: by mail-pg0-f41.google.com with SMTP id s184so5249569pgc.0
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P95/yFSr0220e2iutsF8daAhRud1mB3xmlJ5gZ0i1BI=;
        b=ttV1Ls3WYNKmchujpqb70pU1kfnRRZdCAfAzlYnAuKucSh15BJmNcCl1FA53Fjr1Sh
         kZuPpUNKD48qUAT8smkER9TieHLPF9q/0uLdXLUE4y+VgJW2bXYrNTACOcmwylxc2O2n
         PjuB/gKZZAB2jqjgYABpdrXCh+BmTeggTKpUoNu5jkNcFrv2Opc5EOC/+BLehHXMSo2u
         ysFsfG26MXWAiRUY4aQBPEnmtKSVzZNU3H9ctZEpt6fWG0uxjlEqDSVB8kpxOMJVfpGy
         O/zOKT7aGFDlTvBxJWUKtAgzO7/Le6xpwuJesDdJNAMZpLYBhPT6eRZtjvnqftMJrsOL
         LTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P95/yFSr0220e2iutsF8daAhRud1mB3xmlJ5gZ0i1BI=;
        b=hQ8XX7Ac99BxQVtGta5dlKNAGes0EMroOs5tx4nUzLBOORqJyYwua5Fo7FjNCmYid+
         AwKatlEPbeVIG31LA9xmDUrRTvLm2R0YmNqECEgZw64D9Ow5wP6yB1JR/KsR4AZK4oNE
         9vI7BEQeRoK9HH4APPLZDm6DfjJGHQbX7e43D4WOV+z+89JwhBCn140dwf6gqL67LuJz
         hxtAEV6hP1YjezOCLhhcyTjYaot18hH9RbjW/14Iek0YKs6N1W4JlgVZSX4lsiuz980r
         fAntVrod5n6JE7+Z8OjvWBvSPcXUglTxAxGSKHeKHT6J1wKeTY0/X8+26n56cJJ4DhkF
         /NWw==
X-Gm-Message-State: AMCzsaX1MoFvf5ZY/MvvwF+MatMe9RpFUONJ6qHupl9FIGxu8/puXZXg
        ZGTyEnHI/zdPrRIwaX+0YAq7xQ==
X-Google-Smtp-Source: AOwi7QBSe/3zXEQ0jV3bCyT6Wt9z0wTxYwzR4rtCu0die0teaLcNzMYFLzu6NgWmi1OxbFIEOkEplg==
X-Received: by 10.98.6.3 with SMTP id 3mr6629088pfg.282.1507140460022;
        Wed, 04 Oct 2017 11:07:40 -0700 (PDT)
Received: from localhost (D-173-250-188-46.dhcp4.washington.edu. [173.250.188.46])
        by smtp.gmail.com with ESMTPSA id k90sm13645573pfk.93.2017.10.04.11.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 11:07:38 -0700 (PDT)
Date:   Wed, 4 Oct 2017 11:07:37 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #01; Wed, 4)
Message-ID: <20171004180737.GA90224@D-173-250-188-46.dhcp4.washington.edu>
References: <xmqqy3orbcrr.fsf@gitster.mtv.corp.google.com>
 <20171004083111.5y7su63scydg2yzk@sigill.intra.peff.net>
 <xmqqr2ujb8rm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2ujb8rm.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 05:46:21PM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> >>  - pretty.c: delimit "%(trailers)" arguments with ","
> >>
> >>  "git for-each-ref --format=..." learned a new format element,
> >>  %(trailers), to show only the commit log trailer part of the log
> >>  message.
> >>
> >>  Will merge to 'next'.
> >
> > I think we want the first patch of this series to graduate before v2.15,
> > even if the rest doesn't make it. It tweaks a new syntax introduced
> > earlier in this cycle by jk/trailers-parse. If we ship without the
> > tweak, then we'll have to support the colon-delimiter to remain
> > backwards-compatible.
>
> Yeah, thanks for reminding me.  I actually was hoping that this will
> prove to be stable enough by the time -rc1 gets tagged, but yes, the
> bottom one looks innocuous/safe enough and should be fast-tracked to
> 'master' soonish.

It may make sense to send my other series to 'master' as well
("ref-filter.c: pass empty-string as NULL to atom parsers").

The series you're discussing here adds support for "empty" sub-agruments
(via: --format=%(contents:trailers:)), but Peff points out that this is
not a consistent user experience:

> Doh, that string_list behavior is what I was missing in my earlier
> comments. I agree this is probably the best way of doing it. I'm tempted
> to say that parse_ref_filter_atom() should do a similar thing. Right now
> we've got:
>
>   $ git for-each-ref --format='%(refname)' | wc
>      2206    2206   79929
>   $ git for-each-ref --format='%(refname:short)' | wc
>      2206    2206   53622
>   $ git for-each-ref --format='%(refname:)' | wc
>   fatal: unrecognized %(refname:) argument:
>       0       0       0

"ref-filter.c: pass empty-string as NULL to atom parsers" makes this
behavior of allowing empty sub-argument atom formats in
git-for-each-ref(1) consistently OK.

To avoid introducing a case where %(atom:) is sometimes allowed and
sometimes not, I would recommend that both of these patches be applied
to master at the same time.

--
- Taylor
