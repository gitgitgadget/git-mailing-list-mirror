Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 035B020802
	for <e@80x24.org>; Thu, 22 Jun 2017 22:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753474AbdFVWKf (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 18:10:35 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34421 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbdFVWKe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 18:10:34 -0400
Received: by mail-pf0-f173.google.com with SMTP id s66so14682224pfs.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 15:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgWHCsQ6nB+vg4eLFKJ7tY0G3EJwsWxk1CExD1Zhhrw=;
        b=jXfx5psmYnuvq4zkhcb4JOswKHe5GVPePdXSIE+48pLs2wGieEZj9Ti+Yum1da9w/x
         7M3bj/JRCmDLGdE0Q1Dt83k5A095oP+pF21wjFhF98xBViDbkB62dPGv6WWUCg5xRlCS
         Q3Gw1evN/moPkICfOhzAI7I4QQaxXVQzajV6Xx8jGqXFh6rqJeHfHIwE9kqU1xTio+iS
         CeY1dPqYuZEeBRhNZ8xMBF7eu/oEKZbXRuYhl6eMP245W1Ut2uG9vSLi67vTYWs0NVuY
         88SjSZmq6QgqTcL+tmOqyJlLdBaaiSjU2M3NEOhdkcyqhoKSgsBcKadiHbQQ4IzlMmLF
         oaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgWHCsQ6nB+vg4eLFKJ7tY0G3EJwsWxk1CExD1Zhhrw=;
        b=codtVuil/kIIUcNigcg/5q/wgAzfPU1VYqmK/HtEodW4F74IbUVYgYz3+gOjLlw2Sf
         KynfEqjZs0b2q1Q6Q+9ByWXmXh1Gv26A2uRsRsl4amPyeVTlfRdmvHOy27uSgDa+EtUK
         g/AmQZ93v/XMsCHQSGU/N456wAl9oEKIVshfVVD5LxYRWs5m1wedw3fw3rYmN3LXxVRs
         CFjuld46Lbig+IZBSBULw2YdbjGH5/CxBVKglj2ayJwv/iWy2h8MRtklX2Y8A1I4mIoD
         UTWxxeGH+tIr7XJbpTP+szQOuCLgeUekLddh/PqslCHZ8RUaZIKl2elxywVqdleFQD5y
         aunQ==
X-Gm-Message-State: AKS2vOwvfMmz5TMTXbl+IfIpI4EBuqfgkWdLKR80XpM4/9734kXk5+FC
        WOOjQlv4Dr2HU/Y9DcBLLA==
X-Received: by 10.84.216.26 with SMTP id m26mr989159pli.112.1498169433350;
        Thu, 22 Jun 2017 15:10:33 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:3100:42b2:b45a:528c])
        by smtp.gmail.com with ESMTPSA id r90sm5716026pfj.37.2017.06.22.15.10.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 15:10:32 -0700 (PDT)
Date:   Thu, 22 Jun 2017 15:10:28 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/3] list-objects: add filter_blob to
 traverse_commit_list
Message-ID: <20170622151028.07827b50@twelve2.svl.corp.google.com>
In-Reply-To: <20170622144526.3f5813f5@twelve2.svl.corp.google.com>
References: <20170622203615.34135-1-git@jeffhostetler.com>
        <20170622203615.34135-2-git@jeffhostetler.com>
        <20170622144526.3f5813f5@twelve2.svl.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 22 Jun 2017 14:45:26 -0700
Jonathan Tan <jonathantanmy@google.com> wrote:

> On Thu, 22 Jun 2017 20:36:13 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> > 
> > In preparation for partial/sparse clone/fetch where the
> > server is allowed to omit large/all blobs from the packfile,
> > teach traverse_commit_list() to take a blob filter-proc that
> > controls when blobs are shown and marked as SEEN.
> > 
> > Normally, traverse_commit_list() always marks visited blobs
> > as SEEN, so that the show_object() callback will never see
> > duplicates.  Since a single blob OID may be referenced by
> > multiple pathnames, we may not be able to decide if a blob
> > should be excluded until later pathnames have been traversed.
> > With the filter-proc, the automatic deduping is disabled.
> 
> Comparing this approach (this patch and the next one) against mine [1],
> I see that this has the advantage of (in pack-objects) avoiding the
> invocation of add_preferred_base_object() on blobs that are filtered
> out, avoiding polluting the "to_pack" data structure with information
> that we do not need.
> 
> But it does add an extra place where blobs are filtered out (besides
> add_object_entry()), which makes it harder for the reader to keep track
> of what's going on. I took a brief look to see if filtering could be
> eliminated from add_object_entry(), but that function is called from
> many places, so I couldn't tell.
> 
> Anyway, I think both approaches will work (this patch's and mine [1]).
> 
> [1] https://public-inbox.org/git/6f7934621717141ce3bb6bc05cf1d59c7900ccc5.1496432147.git.jonathantanmy@google.com/

Also it should be mentioned somewhere that this does not cover the
bitmap case - a similar discussion should be included in one of the
patches, like I did in [1].

And looking back at my original cover letter [2], I wrote:

> This is similar to [1] except that this
[...]
> is slightly more comprehensive in
> that the read_object_list_from_stdin() codepath is also covered in
> addition to the get_object_list() codepath. (Although, to be clear,
> upload-pack always passes "--revs" and thus only needs the
> get_object_list() codepath).

(The [1] in the quote above refers to one of Jeff Hostetler's patches,
[QUOTE 1].)

The same issue applies to this patch (since
read_object_list_from_stdin() invokes add_object_entry() directly
without going through the traversal mechanism) and probably warrants at
least some description in one of the commit messages.

[1] https://public-inbox.org/git/6f7934621717141ce3bb6bc05cf1d59c7900ccc5.1496432147.git.jonathantanmy@google.com/
[2] https://public-inbox.org/git/cover.1496361873.git.jonathantanmy@google.com/

[QUOTE 1] https://public-inbox.org/git/1488994685-37403-3-git-send-email-jeffhost@microsoft.com/
