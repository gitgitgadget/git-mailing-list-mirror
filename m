Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D976C433F5
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 01:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbhKUBWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 20:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbhKUBWh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 20:22:37 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3C2C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 17:19:33 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id m25so13065607qtq.13
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 17:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YjM1asyZpRyxNnb35Vwo3vWzILeP8kH8bhi7eILB+/E=;
        b=PtGfAh5Su8mtVJ8LjY6Br5rDPxTLReY5S2EBVL3gUfrhBtaLdxSgok1fnN96CGiz7l
         uZ20fCFyNPwuhHYL50F8NK1JsUpgTQeQ4/S6Q5gnwd6hOtx9htOnxxxPe5GZI6noAWUB
         kZCtX4vOoeELseZyhNV1E+B0vQQSjIMtymz28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YjM1asyZpRyxNnb35Vwo3vWzILeP8kH8bhi7eILB+/E=;
        b=tkNu1maYDH4lXeGZkypBnUNe44UhWWa3t4p5C6w/kMOwZTE3AYHt8Jd0NEk9yUqRtM
         SazHfSbSjKUKvU8ndZ5U01XFTtMmkIV7hTaW4c/e2K2/ug+aeA8GZk8n6hzzNsNXNp5E
         Lv5GixfZtb3oaZzKzcWpnbD0S9DVy4AHMqF/3y9Ab6Pz3mdz5tMn9wrIqfao010yw37e
         eikBFetYAIRXn3oItdlWXlopaOnm6/FMHq8xE+ck/aySbnNY4Yr+YOpjZEmlcdJuw2jx
         /MzZPnFr3EoBgkhrILSM54mtYSRgZVCQ1ml7PMJzqP9URf8KcRSXWypMcWL5bCbeX2eK
         E37Q==
X-Gm-Message-State: AOAM531wl09rQzsA/tbMJgrjtG0RjeKy5H2D21wi0JdLWO3xSkdJP4lt
        UHkW46UNUgPHQHDlZL1Azqg6FQ==
X-Google-Smtp-Source: ABdhPJy6YXrlZkU61Uf4tz3Ul0zfeK7dAGp+2XanzHHfz4AjeT5sRdSuwUzGbM0iIkdYXZ/F9jc9Vg==
X-Received: by 2002:ac8:7f85:: with SMTP id z5mr18804180qtj.171.1637457571327;
        Sat, 20 Nov 2021 17:19:31 -0800 (PST)
Received: from localhost (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id d16sm2061833qtn.59.2021.11.20.17.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 17:19:30 -0800 (PST)
Date:   Sat, 20 Nov 2021 20:19:28 -0500
From:   John Cai <jcai@gitlab.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 0/4] Flag to add a newline after decorations for
 --oneline log output
Message-ID: <20211121011928.srxogmaswqdmfd2c@Johns-MacBook-Pro-3.local>
References: <pull.1065.git.1635542128.gitgitgadget@gmail.com>
 <CAP8UFD3Uh7AJTFaVv25f7gGQkTxgMQTCO=NMHCWoSm9sjmw26g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD3Uh7AJTFaVv25f7gGQkTxgMQTCO=NMHCWoSm9sjmw26g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 12, 2021 at 05:27:45PM +0100, Christian Couder wrote:
> On Fri, Oct 29, 2021 at 11:17 PM John Cai via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > Add a flag --newlineafter to be able to pass in "decorations" to enable a
> > nicer format for the --oneline output so the commit subjects are aligned
> > when decorations are printed.
> 
> I wonder if --newlinebefore or --newlinefor rather than --newlineafter
> would be better. It seems to me that it would be easier for users to
> guess what the result will look like with --newlinefor.
> 
> Another possibly more generic solution would be something like
> --format-field=<field>:<format> where, in the output, the field
> <field> (which corresponds to the "%(<field>)" format) would be
> replaced by <format> which should contain "%(<field>)". For example
> `--format-field=decorations:'[[%(decorations)]]\n'` would enclose the
> decorations using [[...]] and would add a newline after them.
> 
> Also it would be nice if this could be extended to other fields and to
> formats other than "oneline". You might want to discuss a bit about
> how it could be done with generic code.
> 
> > 0b96396ef5ff7a3a01e137b3735893c970759dfa (HEAD -> jc/two-line-pretty-decoration, john-cai/jc/two-line-pretty-decoration)
> >                                          Improve UX for oneline with decorations
> > e9e5ba39a78c8f5057262d49e261b42a8660d5b9 (origin/master, origin/HEAD, master)
> >                                          The fifteenth batch
> > c6fc44e9bf85dc02f6d33b11d9b5d1e10711d125 Merge branch 'ab/test-lib-diff-cleanup'
> > 63ec2297d26155adb0e38745bf2284cd663add8e Merge branch 'ab/fix-make-lint-docs'
> 
> Not sure why the above lines are included in your cover letter.
> 
> > original thread in
> > https://lore.kernel.org/git/CA+55aFwT2HUBzZO8Gpt9tHoJtdRxv9oe3TDoSH5jcEOixRNBXg@mail.gmail.com/T/#t
> 
> It would be nice if you could summarize the threads a bit in this
> cover letter, and tell a bit about how your design evolved from what
> was discussed.
> 
> > John Cai (4):
> >   oneline: parse --newlineafter flag
> >   oneline: print newline after decorations if flag provided
> >   oneline: test for --newlineafter feature
> >   doc: add docs for newlineafter flag
> 
> The 2 last patches look very small and might want to be squashed into
> the patch that introduces the --newlineafter flag.
> 
> Thanks!

There was a discussion in https://lore.kernel.org/git/CA+55aFwT2HUBzZO8Gpt9tHoJtdRxv9oe3TDoSH5jcEOixRNBXg@mail.gmail.com/T/#t

about improving the --oneline output with decorations. To summarize, currently, when
decorations are printed with --oneline the subject message ends up misaligned like so:

```
7140c4988f t/lib-git.sh: fix ACL-related permissions failure
88d915a634 (jc-test-peff-revlist-patch) A few fixes before -rc2
9cc14a5b5d Sync with maint
5fbd2fc599 (origin/maint) Merge branch 'vd/pthread-setspecific-g11-fix' into maint
494cb27e57 Merge branch 'ma/doc-git-version' into maint
```

It would improve the user experience of this format if we could allow a newline after
the decorations so that the logs are formatted in the following manner:

```
7140c4988f t/lib-git.sh: fix ACL-related permissions failure
88d915a634 (jc-test-peff-revlist-patch)
           A few fixes before -rc2
9cc14a5b5d Sync with maint
5fbd2fc599 (origin/maint)
           Merge branch 'vd/pthread-setspecific-g11-fix' into maint
494cb27e57 Merge branch 'ma/doc-git-version' into maint
```

In order to accomplish this, we can add a new flag called --format-field=<format>.
<format> is similar to what is passed into --format.

For example, if --format-field=[[%d]]%n is used, the --oneline format will print
decorations enclosed with [[ ]] and a newline after it.

This would be convenient when one wants to modify just one field of the
log output.


cc: Christian Couder <christian.couder@gmail.com>
