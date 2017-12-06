Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6ABD20C11
	for <e@80x24.org>; Wed,  6 Dec 2017 18:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbdLFSKH (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 13:10:07 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:43073 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbdLFSKG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 13:10:06 -0500
Received: by mail-it0-f46.google.com with SMTP id u62so8447153ita.2
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 10:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FaqcrCywaJVYXN4LJ0laNLN0+M7TRACt6IppZzAsVx8=;
        b=vvWfYmEpYo0OP5EwvUu07M090kbZaqVgfEBQ0zci7TqszuHhxgK2X7J85KGrNK6B0P
         08A0lVlXPzQm3B7yXAA44nGvDIv7nUgfq1Q0uljd/P6iwf7OCBWYN9wPnLcymmpZn3Mp
         cNMUVpbjVfh18xDaHg1bOX9X/plSYIJgrBQ3ReeXOWjMxrlOsZzM9rIe84jigOr2BmuX
         ksdgLuHczgM+rOs0MV7CW9Cfq3/MM1NPLzwhUp51IEaqJKEdOg1g+ZGutS8dMMnINqJO
         dyVzbhhOFqoYFO7NyB9bP4n0HtijqT09FxJiiHiVH+Kk/eA3fGz0j4o8f4ETkHr24MXu
         Hy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FaqcrCywaJVYXN4LJ0laNLN0+M7TRACt6IppZzAsVx8=;
        b=h8XJ8hNKQ1k0oRijsswC/k36baPGybGmStw0732PmoxFrBDh+qqs3ho7tVvYHasAmQ
         /mg4i/ifrkdZNw0+USWfzYZ/YJfshPEnBwJD4tPnmyqsnlKWe9KI6B7wS4rT5R8MeSUA
         J17QPjM/wFXmlNZO5vfRJvChv5NrHVrw2ZfeiF2ooaS9MycqX+eglosV+DL2KkjnUJng
         qxPKm7fVg90mPJPven/ekTvP95aae9MJwBD80t1uksGPCEwL2oF61gyyhdjk7Hq8vrDp
         HE0+3KbzizbTOyHBSgdw//yL2SCAiUtV535/zAGoFFpQJu6FYqYrKSQWx32ArzXapy+L
         ZdNw==
X-Gm-Message-State: AJaThX5bfZPoU5C3BUf2M2e8ob8nUtpw0fSzSWSTn0t0rmq+w2PwcdaO
        AuzHTq1vESwE5XXj2H56gQVokQ==
X-Google-Smtp-Source: AGs4zMbiFC8FzIrGRxx4xnThpo/cdk3SpiOFeAyS+7165itkqmQ1/nbPpTCHrEE6/VBkSzGtvAbHwQ==
X-Received: by 10.107.47.234 with SMTP id v103mr32388247iov.96.1512583805111;
        Wed, 06 Dec 2017 10:10:05 -0800 (PST)
Received: from google.com ([2620:0:100e:422:cc82:408c:b424:d98c])
        by smtp.gmail.com with ESMTPSA id e185sm1797194itb.27.2017.12.06.10.10.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 06 Dec 2017 10:10:04 -0800 (PST)
Date:   Wed, 6 Dec 2017 10:10:02 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] 'unsigned long' to 'size_t' conversion
Message-ID: <20171206181002.GA59217@google.com>
References: <a660460d-b294-5113-bfaf-d98bcf99bad5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a660460d-b294-5113-bfaf-d98bcf99bad5@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/06, Derrick Stolee wrote:
> There are several places in Git where we refer to the size of an
> object by an 'unsigned long' instead of a 'size_t'. In 64-bit Linux,
> 'unsigned long' is 8 bytes, but in 64-bit Windows it is 4 bytes.
> 
> The main issue with this conversion is that large objects fail to
> load (they seem to hash and store just fine). For example, the
> following 'blob8gb' is an 8 GB file where the ith byte is equal to i
> % 256:
> 
> $ git hash-object -w --no-filters blob8gb
> 5391939346b98600acc0283dda24649450cec51f
> 
> $ git cat-file -s 5391939346b98600acc0283dda24649450cec51f
> error: bad object header
> fatal: git cat-file: could not get object info
> 
> An existing discussion can be found here:
> https://github.com/git-for-windows/git/issues/1063
> 
> The error message results from unpack_object_header_buffer() which
> had its most-recent meaningful change in 'ea4f9685:
> unpack_object_header_buffer(): clear the size field upon error' (in
> 2011).
> 
> In my opinion, the correct thing to do would be to replace all
> 'unsigned long's that refer to an object size and replace them with
> 'size_t'. However, a simple "git grep 'unsigned long size'" reveals
> 194 results, and there are other permutations of names and pointer
> types all over.
> 
> This conversion would be a significant patch, so I wanted to get the
> community's thoughts on this conversion.
> 
> If there are small, isolated chunks that can be done safely, then
> this may be a good target for a first patch.

I think that an effort like this would definitely be worthwhile.  Much
like the unsigned char[20] -> struct object_id conversion I would think
that the best way to go about such a conversion would be to do it in
small chunks as you've mentioned.  That way you are only causing churn
in hopefully small parts of the code base at a time instead of one
monolithic change that is sure to cause conflicts.

-- 
Brandon Williams
