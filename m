Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13D3202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbdJBFMU (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:12:20 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:52151 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdJBFMT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:12:19 -0400
Received: by mail-pg0-f44.google.com with SMTP id k193so2433670pgc.8
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 22:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AZGfXoJXtCA9FxdWxLHNZN0MlWY9kg6+shdEiLEX3so=;
        b=QaGwz3U1VNq4F7BWkQ9PK0lGLTKo3ufWA39wlsIwzS1TN53iirJIyJHcge2LcPvQ7M
         Igy5p/+1EuiNITnwlrlNy/cWMhUW0qdLQlgqSsO+A/kunG4SACz6DB9d6bQHx3c4LVXq
         sWa6OW/leDfYYsmJl8QOoiZWf68XLQGUOoE8U943BXib5FSHMrrqxeqqq3gcB6XNZxOS
         um5xeFwx6gd5ktbF4Y6ZZ6X0MdQbY20qP+Nz71e7YKyuGN0QnvcUwFI21JqdHRYW/SUt
         MWk2XRlIQhYUaxjOcXNZNDwhEI2bAfuWUWQeJnxKCj+zovbZhHWiZvtOoS9r7UUrAjgl
         etlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AZGfXoJXtCA9FxdWxLHNZN0MlWY9kg6+shdEiLEX3so=;
        b=B5BJCpkNi7341IhKOBgAxFn5YN5oN1t4fGI+lg+4FsqzlSoRqvdlYU09nee75b2+A2
         NPb2ifIXWoUDICO/bLsXRKlLFh11Lu5onB2yJ3qD7IQ8dWVz85KsQ7DHjw+9PWOLRN3R
         xw/usmfkNutTsfRPDj9p4aULYLt5qEI/5iCFrtppNXSF0ZNV4WY9jReRh0rhfoX+VoKN
         u7dNM7zySPDVPTS1+rsrbxcsIx/tcyuX/gassiRaIuNDDSuh7Z4wiL9M2rRLlC91th4G
         usTzDVTykvVVrvYek0gvkVLwn74e6Mc3lsf52GbqmVFDn1pv4w7HclUGM+nM8aD9Hg8k
         hxGQ==
X-Gm-Message-State: AHPjjUgH7VqUNaa/7m9mLKz9h8jSpBwWanC7PtlcDEACeCzvsuUC1Iw6
        NEtzNRY5iVGCXPbFzZ2bvLERow==
X-Google-Smtp-Source: AOwi7QBJhct1mwVf+pOfNEihzE+diDHjnZzPnjP9JYI21+THaEwJTP7mX+jPLwwCm3MzOxAZx2RQpA==
X-Received: by 10.99.42.11 with SMTP id q11mr11333285pgq.7.1506921138613;
        Sun, 01 Oct 2017 22:12:18 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id e7sm14689986pfi.188.2017.10.01.22.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 22:12:17 -0700 (PDT)
Date:   Sun, 1 Oct 2017 22:12:16 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 6/6] ref-filter.c: parse trailers arguments with
 %(contents) atom
Message-ID: <20171002051216.GB5566@D-10-157-251-166.dhcp4.washington.edu>
References: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
 <20171002003304.77514-1-me@ttaylorr.com>
 <20171002003304.77514-6-me@ttaylorr.com>
 <20171002050351.imuntcy3xnq4wxux@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002050351.imuntcy3xnq4wxux@sigill.intra.peff.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 01:03:51AM -0400, Jeff King wrote:
> On Sun, Oct 01, 2017 at 05:33:04PM -0700, Taylor Blau wrote:
>
> > The %(contents) atom takes a contents "field" as its argument. Since
> > "trailers" is one of those fields, extend contents_atom_parser to parse
> > "trailers"'s arguments when used through "%(contents)", like:
> >
> >   %(contents:trailers:unfold,only)
> >
> > A caveat: trailers_atom_parser expects NULL when no arguments are given
> > (see: `parse_ref_filter_atom`). This is because string_list_split (given
> > a maxsplit of -1) returns a 1-ary string_list* containing the given
> > string if the delimiter could not be found using `strchr`.
> >
> > To simulate this behavior without teaching trailers_atom_parser to
> > accept strings with length zero, conditionally pass NULL to
> > trailers_atom_parser if the arguments portion of the argument to
> > %(contents) is empty.
>
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
>
> which seems a bit unfriendly. As we're on v6 here, I don't want to
> suggest it as part of this series. But maybe a #leftoverbits candidate,
> if others agree it's a good direction.

I think #leftoverbits is fine here, but I think addressing this before
2.15 is reasonable. I can take a look at this in a future patch series.

--
- Taylor
