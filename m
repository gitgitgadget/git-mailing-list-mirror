Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB8A1FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 21:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760968AbdJQVGM (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 17:06:12 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:50919 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbdJQVGL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 17:06:11 -0400
Received: by mail-io0-f181.google.com with SMTP id 97so3778836iok.7
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 14:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O6JLhPDwO7jF0kk1B6/BburRpOinK5fsv6wMkJhSbnc=;
        b=qA67BHsSQdIQeQPernXwUVzOLf2tnuJmPc6/yevtY3ptnVBUjRVJAUQrhwuRyDifHX
         4beMlkShJxhfA9GAV+BQINKlQDtI/um8+9Eduz7JnNgT49om3G7A2Cqc32+5ZmP8u49Y
         kky1oDz2vSnkLcU3rrckYKy9PsG2EDz+roRK/E5Axfo81dEhOlnSkUQsqjaQNiE7hv/u
         vB+TDi9rWs6KBoqZNCpmrlj9sdkX4TKkTgU6AW+jmPBxA2EHmSQ2ZhkvNPMtBQORnDTF
         nc6eQpbUkbJWmRW/5Plnr6CgeoZZLSYO9RlDTWavcN+XnzLgiV9f/yo6IsQzSWBzTUJg
         BsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6JLhPDwO7jF0kk1B6/BburRpOinK5fsv6wMkJhSbnc=;
        b=qE98lA/DU5VATNPlJNUPSH1jYM9S1F56CKxKlUs78gX3tTCzmKpPC10zCcIn9Gb+B9
         jEwxMz0edjuLxH9i08hAi1OuVMqJWp+Mal5Kq1iJNuFqSuL31LIt4mS1sw6BUbGm3RDd
         S+WUGqoiKlwImBBnNHlzVjOlbLNsIjPhoYQpCRpmPWhAwGtQW8WEU6r0Gq/Xhs2B0YAa
         97LDyNOtzawazj/e2caWAWnnD3yNVif5yOzD8NHfnp/9eYoYbOeE69JQLQhUJVg6PAK8
         15KkpRwFBqbCHi4M0z5KCy8ph9ED8a/fHMyIe8NhGJJkJFLCE7GdDhyBpOFAJrqdnHnX
         HTJg==
X-Gm-Message-State: AMCzsaWJywjZVHc358dd5m7Ljh+e7AxmzOBCbNN9igi1FQH1yH+yloY3
        yX39S4SUM46JYFtvwV+lNUo=
X-Google-Smtp-Source: AOwi7QDM4BTDayrEOhOp1emIw9pOTcXYfMj6ov/yOhIMO98mCOOv+vxzE32J9yFq9PQ0hFf5GkNlhw==
X-Received: by 10.107.204.1 with SMTP id c1mr17756322iog.72.1508274370664;
        Tue, 17 Oct 2017 14:06:10 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 16sm2133014itw.38.2017.10.17.14.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 14:06:09 -0700 (PDT)
Date:   Tue, 17 Oct 2017 14:06:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Marko Kungla <marko.kungla@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] check-ref-format doc: --branch validates and expands
 <branch>
Message-ID: <20171017210607.rwvaxarkallzahq6@aiede.mtv.corp.google.com>
References: <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
 <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
 <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
 <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
 <20171017024203.6hqzy2paed6fyvym@sigill.intra.peff.net>
 <xmqqo9p6phxg.fsf@gitster.mtv.corp.google.com>
 <xmqq7evupemj.fsf@gitster.mtv.corp.google.com>
 <20171017070619.bdgvujmbw4uxvwle@aiede.mtv.corp.google.com>
 <20171017071234.m6j4rqn6izdvla6d@aiede.mtv.corp.google.com>
 <xmqq60bdo5op.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60bdo5op.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> From: Junio C Hamano <gitster@pobox.com>
>>
>> "git check-ref-format --branch $name" feature was originally
>> introduced (and was advertised) as a way for scripts to take any
>> end-user supplied string (like "master", "@{-1}" etc.) and see if it
>> is usable when Git expects to see a branch name, and also obtain the
>> concrete branch name that the at-mark magic expands to.
>>
>> Emphasize that "see if it is usable" role in the description and
>> clarify that the @{...} expansion only occurs when run from within a
>> repository.
>>
>> [jn: split out from a larger patch]
>>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>
> Missing sign-off, unlike the other two, intended?

Oops.
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

> I'll take these three to replace what I tentatively queued, not
> necessarily because I like the change in 1/3 better, but because
> these are explained much better; besides I prefer a version that at
> least two people deeply looked at.

Okay, thanks.  I'll add the rest of the change as a patch on top. :)

Thanks,
Jonathan
