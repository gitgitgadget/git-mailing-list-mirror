Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3661F1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 13:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfHSND3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 09:03:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52023 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfHSND3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 09:03:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so1555706wma.1
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tip4fFBxwD6lY6A6NLo3hLYbUCtUdOsf3yHy6EbiTg0=;
        b=YygsWKGg8bVaS4K8/vNLilwFJ1Ckh5G8I6kQoBsNdTiC8FEL3YO47R++uynjpPdH99
         piOSXKToIlZ8E9VJjY2V/bcxA+VEzgIy+ou3mPgGIJvqBDbdVV/YO1obgdwXEEvcp6Sl
         hhjX5IoIp6P51LUNO9QPSnn4PFJZY23d+H3Bvm/Zh2cRYQIHV6RdC3LxDUWlf3MsnYlY
         hbfbFnjdQb1whpoG7BozqXD4xGBc1H34nq3Z6CUcT6gjOknvrcoH/84j+GXdafPh2f9y
         XiPZ5mCCV7kNY3L7lhPQdIQxiDSpIX7aSY7vPpX5bja1I2Ld5cZkg+W3NvS7h4I9plsH
         Ei0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tip4fFBxwD6lY6A6NLo3hLYbUCtUdOsf3yHy6EbiTg0=;
        b=musPN4Hhpj5HFtNS0NfrAZvwFoGEhwZEs5XLUhiV0hlihTuFB6FcIyZBhJsOYVC1I9
         39JkUKjlMjVDhF3ANWcj/3rBOyaO1iQlOgnZNKrE6S0mVbLBLeRetumAg5uiYJxnIY2k
         hyMvQysI+B8wz1mrqODMmrIcqVqO0wdYdZmDQ16iqIWYrDDdq+o0hGTL6v6h5KvLgwVj
         XfrZwmhgZdsVJEWs1V04qJ6qoqn1ECuBsIoMeLvdSPWW/kzAwhkhZxv7lEOPFKo2Wpnh
         qpqSpIF5FZcpBFPptsxSJV3OtB9FbOi6emltOZ3x+lJvYarqYq54pz16xIqd3OvGzLPb
         +JXQ==
X-Gm-Message-State: APjAAAWOeSflo3+IANlJm4Wt3bxYg5E9c5/20Jl4GJlUrsQ30fQc79AE
        PDgVil8EB9TlxBnWnOWhtzo=
X-Google-Smtp-Source: APXvYqyZ8POh6gb30Nu5luzrggKA5JVNX2R0q1cQtaC7jq1G+TJpSAhiBSBizYMhKNAZxSNMGLXhkw==
X-Received: by 2002:a7b:c7cb:: with SMTP id z11mr18887403wmk.24.1566219806400;
        Mon, 19 Aug 2019 06:03:26 -0700 (PDT)
Received: from szeder.dev (x4db60b9a.dyn.telefonica.de. [77.182.11.154])
        by smtp.gmail.com with ESMTPSA id f23sm10967836wmj.37.2019.08.19.06.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 06:03:25 -0700 (PDT)
Date:   Mon, 19 Aug 2019 15:03:23 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [RFC PATCH 0/5] line-log: towards a more responsive, incremental
 'git log -L'
Message-ID: <20190819130323.GU20404@szeder.dev>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
 <a3f8b468-5ee5-4056-db67-bb8ba5390002@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3f8b468-5ee5-4056-db67-bb8ba5390002@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 08:00:11AM -0400, Derrick Stolee wrote:
> On 8/18/2019 2:27 PM, SZEDER Gábor wrote:
> > Line-level log performs a preprocessing step in
> > prepare_revision_walk(), during which it filters and rewrites history
> > to keep only commits modifying the given line range.  This
> > preprocessing causes significant delay before the first commit is
> > shown, wastes CPU time when the user asks only for a few commits, and
> > does parent rewriting with no way to turn it off.
> > 
> > This patch series addresses these issues by integrating line-level log
> > filtering into the revision walking machinery and making it work
> > together with generation number-based topo-ordering (though for now
> > only in the case when the user doesn't explicitly asks for parent
> > rewriting, which is probably the common case).
> > 
> > The first two patches are quite straightforward (and arguably somewhat
> > unrelated), but the rest deals with history traversal and parent
> > rewriting, which I don't usually do, hence the RFC.
> 
> Hi Szeder,
> 
> Thanks for sending this series! I'm particularly excited about it
> because we recently got a bug report from a user in the Windows OS
> repo about "git log -L" being very slow. I put it on the backlog [1]
> but haven't had time to investigate it myself. After we are done
> updating to v2.23.0 [2], I'll have time to test your changes on
> the Windows repo. I anticipate your change to provide a massive
> boost.

Well, it depends on what you mean by "boost"...  As discussed in patch
4's commit message, this series doesn't really optimizes much, and the
total amount of work to be done remains the same, except that 'git log
-L... -<N>' will be able to return early.  So when you benchmark it
with e.g. 'time git log -L... >/dev/null', then you won't see much
difference, as it will still take just about as looooong as before,
apart from the faster generation numbers-based topo-ordering.  (But I
have a few WIP patches waiting to be cleaned up that might bring about
3-4x speedup in general.)

In the meantime, until these changes trickle into a Git release, for a
faster line-level log I would recommend to:

  - Limit the revision range up front, i.e.:

      git log -L... ^a-not-too-old-version

    because this can greatly reduce the amount of commits that that
    expensive preprocessing step has to churn through.

  - Use '--no-renames'.  Although it won't follow the evolution of the
    line range over file renames, this might be an acceptable
    compromise.  (this is what those WIP patches are focusing on)

  - Or both.

