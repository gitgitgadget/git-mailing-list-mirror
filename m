Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF631F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 15:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbeKPBpS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 20:45:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39463 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBpR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 20:45:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so18438088wmc.4
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 07:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rUmXjGh4nAQjS4HtsViD1/rs5rnwJaiJTvpOJ5uUwZc=;
        b=ia/0FIPRanaLGDqdgQsMrzl19wcUmeThYUxyzbRoQ/yPxKvM/ph3Fx7Mf9Z6oDEMuo
         +MMm2gbkSZ2ChDr+eBzQTZ9U1/6WO9WkqgjCRYFtxzicBibq2slAdazBxcASrSlV/2FH
         LI4h5dRbjbnJRf4LS8TqNqSSdqhbxQ1b7C1/qTpzqI/6vIxLVwb7UUrkN8tU+NeuQa6j
         9Eb+y/0j3vNKRWqN41a4JAvmJck0svZVn1KpyJh+JBsAcKAcIcE9VPLUhbfThJqBpCzm
         VqNaavWWeyLVtezhNzmiQrRZYBE64gMgxDBqUFqVA4iP3iINfjXRr1WjyJNel+kfAriF
         SSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=rUmXjGh4nAQjS4HtsViD1/rs5rnwJaiJTvpOJ5uUwZc=;
        b=ljTy96Vl6EGALBSvo+vjZBLVHz0jMldbTmVYPiGRE7ndcjaa8ktWnrev7TkaWMI5DJ
         oPyDkAECdwslArXsC0sff3WRTdliSO0Fzl+wy43URaYOOqvO+2pXG9YAbNeXQP7JyoTT
         6hGRufMtxMXyxbuEz/IQMEU7L4tAyXfn8wvhjsy//81zOYwXOhBKbuUFzGxvdJl5Iptn
         IqRVSbgEnzS/vuMQsqnjTdEDWN3eFG8CJrKuwPu1RhuL6s5FaNQ94qMbGY5lHhXYAkWR
         Z3XPfAk7k8K6Ui6FMHXF2YOu6IfxTLk9xOClwrKEn4TAg5rDzf/bsI9DvD1n6J5pV1IO
         SaFQ==
X-Gm-Message-State: AGRZ1gL06x/7UawN8WHMtlX6u533YeOCuOtKXv3woeP4RdiJR8+nOQR3
        +4e2s+10xKhhu8HrPIizKd+80UtW
X-Google-Smtp-Source: AFSGD/Vq8Y/CN2bx8qEjfNj33sSlXpAZFAH31m7yfvZAZm5u+B/mN6tPuUBwubglw7k1+IZuVMXGpQ==
X-Received: by 2002:a1c:860b:: with SMTP id i11mr884009wmd.5.1542296215688;
        Thu, 15 Nov 2018 07:36:55 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id o81-v6sm17794456wmo.38.2018.11.15.07.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 07:36:54 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     sxenos@google.com
Cc:     git@vger.kernel.org, sbeller@google.com, jrn@google.com,
        jch@google.com, jonathantanmy@google.com, stolee@gmail.com,
        carl@ecbaldwin.net, dborowitz@google.com
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
References: <20181115005546.212538-1-sxenos@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181115005546.212538-1-sxenos@google.com>
Date:   Thu, 15 Nov 2018 16:36:53 +0100
Message-ID: <87r2fm1hey.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 15 2018, sxenos@google.com wrote:

> +Detailed design
> +===============
> +Obsolescence information is stored as a graph of meta-commits. A meta-commit is
> +a specially-formatted merge commit that describes how one commit was created
> +from others.
> +
> +Meta-commits look like this:
> +
> +$ git cat-file -p <example_meta_commit>
> +tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> +parent aa7ce55545bf2c14bef48db91af1a74e2347539a
> +parent d64309ee51d0af12723b6cb027fc9f195b15a5e9
> +parent 7e1bbcd3a0fa854a7a9eac9bf1eea6465de98136
> +author Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> +committer Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> +parent-type content
> +parent-type obsolete
> +parent-type origin
> +
> +This says “commit aa7ce555 makes commit d64309ee obsolete. It was created by
> +cherry-picking commit 7e1bbcd3”.
> +
> +The tree for meta-commits is always the empty tree whose hash matches
> +4b825dc642cb6eb9a060e54bf8d69288fbee4904 exactly, but future versions of git may
> +attach other trees here. For forward-compatibility fsck should ignore such trees
> +if found on future repository versions. Similarly, current versions of git
> +should always fill in an empty commit comment and tools like fsck should ignore
> +the content of the commit comment if present in a future repository version.
> +This will allow future versions of git to add metadata to the meta-commit
> +comments or tree without breaking forwards compatibility.
> +
> +Parent-type
> +-----------
> +The “parent-type” field in the commit header identifies a commit as a
> +meta-commit and indicates the meaning for each of its parents. It is never
> +present for normal commits. It is a list of enum values whose order matches the
> +order of the parents. Possible parent types are:
> +
> +- content: the content parent identifies the commit that this meta-commit is
> +  describing.
> +- obsolete: indicates that this parent is made obsolete by the content parent.
> +- origin: indicates that this parent was generated from the given commit.
> +
> +There must be exactly one content parent for each meta-commit and it is always
> +be the first parent. The content commit will always be a normal commit and not a
> +meta-commit. However, future versions of git may create meta-commits for other
> +meta-commits and the fsck tool must be aware of this for forwards compatibility.
> +
> +A meta-commit can have zero or more obsolete parents. An amend operation creates
> +a single obsolete parent. A merge used to resolve divergence (see divergence,
> +below) will create multiple obsolete parents. A meta-commit may have zero
> +obsolete parents if it describes a cherry-pick or squash merge that copies one
> +or more commits but does not replace them.
> +
> +A meta-commit can have zero or more origin parents. A cherry-pick creates a
> +single origin parent. Certain types of squash merge will create multiple origin
> +parents.
> +
> +An obsolete parent or origin parent may be either a normal commit (indicating
> +the oldest-known version of a change) or another meta-commit (for a change that
> +has already been modified one or more times).

I think it's worth pointing out for those that are rusty on commit
object details (but I checked) is that the reason for it not being:

    tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
    parent aa7ce55545bf2c14bef48db91af1a74e2347539a
    parent-type content
    parent d64309ee51d0af12723b6cb027fc9f195b15a5e9
    parent-type obsolete
    parent 7e1bbcd3a0fa854a7a9eac9bf1eea6465de98136
    parent-type origin
    author Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
    committer Stefan Xenos <sxenos@gmail.com> 1540841596 -0700

Which would be easier to read, is that we're very sensitive to the order
of the first few fields (tree -> parent -> author -> committer) and fsck
will error out if we interjected a new field.
