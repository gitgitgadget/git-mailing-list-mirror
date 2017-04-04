Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A000E20964
	for <e@80x24.org>; Tue,  4 Apr 2017 16:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932095AbdDDQjM (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 12:39:12 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34497 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932082AbdDDQjM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 12:39:12 -0400
Received: by mail-pg0-f53.google.com with SMTP id 21so157718762pgg.1
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R8oRpigeW9JGHiA5XrvqQgmS3QsosG9SOIYGX5yx5uQ=;
        b=vP0E5mU0ESRHyiOyIcIYvxRcXxJvTLpa7374cGnBdhMArkPeNgUzfNik4B9a4vKYSB
         oHKoCRaPv++PybskPWbsBtDHy876p0Dr1IVhoHljL8On90statB0Tdc/kBkCD8W+JU/b
         RbZs/AYwNLm7rPeS3ur74O7lbexe7UuQsRK+VRdeJ8x7BO2zNg3sn5JIqUjBjLNBVAfD
         fXoXr/L+Drra1gUR0U1Brw1RM5EYVU2hSRAvVLDtPHZNubxpEvcmXXIahRe1STrekSPE
         wK5AJ+UN7jCTqk7JhxSQNxYRekD7QpvjzfEG8eVUFbd0HuORmxWqaygBZbjp/WdNtC+L
         r/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R8oRpigeW9JGHiA5XrvqQgmS3QsosG9SOIYGX5yx5uQ=;
        b=SHozKfg+sQt3m63phv8rX/j+XTaJVQvUODyLz1KW0XeYbTGsjwv7FPpKuRuDPC2v5k
         bZoHqXp9wBBG1asu5EvllOmULj+AlthionYPaeBV7zTpVmkxO/UO+NjJX3Ubh5VdCZpU
         6/kH7L05y+6a9pIRgVCYBxynCJMUYGWCUjv37ZSjQ3vut3MztX75S5LHbu8hBe26Lhvg
         5uwf4DsOlOZkl8SAoMFUdqBwXX9KxdRsj7NosRHD+emvvG7xWjARWfcuoPeLx+thbklR
         173x30jdteMK85eTfErINbXa3+8X7bZ2PjL2ZD8d896fI1znu3arO8UaLjiib+M79zcP
         FGEA==
X-Gm-Message-State: AFeK/H32FGfEoN8C2O7FLehwUXxEU/EpmQQ+cL+hu/sFrGEnOaBcDwuwAJGRZHv/HqJIVLSw
X-Received: by 10.99.232.21 with SMTP id s21mr25179774pgh.67.1491323951104;
        Tue, 04 Apr 2017 09:39:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c58e:393:23cb:53be])
        by smtp.gmail.com with ESMTPSA id q64sm144568pga.56.2017.04.04.09.39.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Apr 2017 09:39:10 -0700 (PDT)
Date:   Tue, 4 Apr 2017 09:39:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] pathspec: honor `PATHSPEC_PREFIX_ORIGIN` with empty
 prefix
Message-ID: <20170404163909.GA189807@google.com>
References: <4650e1396a5ad006b2b4f355685e3c59efd554d6.1491297393.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4650e1396a5ad006b2b4f355685e3c59efd554d6.1491297393.git.ps@pks.im>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/04, Patrick Steinhardt wrote:
> Previous to commit 5d8f084a5 (pathspec: simpler logic to prefix original
> pathspec elements, 2017-01-04), we were always using the computed
> `match` variable to perform pathspec matching whenever
> `PATHSPEC_PREFIX_ORIGIN` is set. This is for example useful when passing
> the parsed pathspecs to other commands, as the computed `match` may
> contain a pathspec relative to the repository root. The commit changed
> this logic to only do so when we do have an actual prefix and when
> literal pathspecs are deactivated.
> 
> But this change may actually break some commands which expect passed
> pathspecs to be relative to the repository root. One such case is `git
> add --patch`, which now fails when using relative paths from a
> subdirectory. For example if executing "git add -p ../foo.c" in a
> subdirectory, the `git-add--interactive` command will directly pass
> "../foo.c" to `git-ls-files`. As ls-files is executed at the
> repository's root, the command will notice that "../foo.c" is outside
> the repository and fail.
> 
> Fix the issue by again using the computed `match` variable when
> `PATHSPEC_PREFIX_ORIGIN` is set and global literal pathspecs are
> deactivated. Note that in contrast to previous behavior, we will now
> always call `prefix_magic` regardless of whether a prefix is actually
> set. But this is the right thing to do: when the `match` variable has
> been resolved to the repository's root, it will be set to an empty
> string. When passing the empty string directly to other commands, it
> will result in a warning regarding deprecated empty pathspecs. By always
> adding the prefix magic, we will end up with at least the string
> ":(prefix:0)" and thus avoid the warning.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> 
> This is the second version of [1]. It fixes a bug catched by
> Brandon when the pathspec is resolved to the empty string and
> improves the test a bit to actually catch this issue.

This version looks good to me.  Thanks for fixing that small issue!

-- 
Brandon Williams
