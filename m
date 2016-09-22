Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD2C207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 11:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbcIVLhk (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 07:37:40 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35142 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751895AbcIVLhk (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Sep 2016 07:37:40 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6AFF8207E5;
        Thu, 22 Sep 2016 07:36:41 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 22 Sep 2016 07:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=tLjy1T5d+u9TDf0eCfReovIqJbQ=; b=mq7N6d
        TAbZPcTZeHVWG0iZjxybqMBrCTGRdQBEeGy+uwZq9LdmoMlp8drt7DMiMserIO3J
        kk3iv+WOTLHTT32Y5it9CYyA4sEfyHOirSZ7Ck+MbJOVvJaATEhTMND1lTfdAfMn
        0S4YUceq+XEpKMfzAnUkoElCp2QjQq9tzpyW4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=tLjy1T5d+u9TDf0
        eCfReovIqJbQ=; b=tj9wdo/hzDdwtZ+8jEwNQmHemJVPeGTk8XXBjdZszagwjJk
        nq9gvKvreQXogA16BGx7XpTvNXbVg0g8JXzlQP94nzS5X6NrYOAx838Dp77N4+gy
        nKx9e6457148Vu4WaWHPaJXzoWGAQ9wnux1Q8z36RpaTVmxIfuJZfv/hEsdI=
X-Sasl-enc: G9KPQ+5h+TDf/XYIvA0pYk2GAxrKuBNMZVIMtJUslQ4q 1474544201
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB21EF2D2E;
        Thu, 22 Sep 2016 07:36:40 -0400 (EDT)
Subject: Re: v2.10.0: ls-tree exit status is always 0, this differs from ls(1)
To:     Steffen Nurpmeso <steffen@sdaoden.eu>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20160921132655.h49HMsHbp%steffen@sdaoden.eu>
 <xmqqr38d9ova.fsf@gitster.mtv.corp.google.com>
 <20160921194004.QOizfyGm8%steffen@sdaoden.eu>
 <xmqqeg4d6l7k.fsf@gitster.mtv.corp.google.com>
 <20160921224616.GuR6adBwB%steffen@sdaoden.eu>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <68354d78-fa7a-ee99-2e6e-7ffdcf1a568e@drmicha.warpmail.net>
Date:   Thu, 22 Sep 2016 13:36:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160921224616.GuR6adBwB%steffen@sdaoden.eu>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steffen Nurpmeso venit, vidit, dixit 22.09.2016 00:46:
> Junio C Hamano <gitster@pobox.com> wrote:
>  |Steffen Nurpmeso <steffen@sdaoden.eu> writes:
>  ...
>  |Sorry, but I did not notice that there was an attached patch when I
>  |was reading your response for the first time.  Risk of using an
>  |attachment to e-mail ;-)
>  |
>  |I think this issue does not need a separate bullet point.  The
>  |existing text says:
>  ..
>  |and what caused your surprise is already covered by the first bullet
>  |point, if the reader knows what "patterns to match" means in Git's
>  |command line tools; it just needs to be extended to be more
>  |meaningful to those who don't, I think.
>  |
>  |How about rewriting the first bullet point like so instead:
>  |
>  |  - the behaviour is different from that of "/bin/ls" in that the
>  |    '<path>' are actually patterns to match, e.g. so specifying
>  |    directory name (without `-r`) will behave differently, the order
>  |    of the arguments does not matter, and a '<path>' argument that
>  |    does not match any path is not an error (i.e. if there is no
>  |    path that matches any pattern, nothing is shown in the output).
> 
> Not an error would have been an enlightenment to me.
> 
> But now i'm even getting nervous to read about patterns.
> We have patterns for tags/remotes/branches, author/committer/grep
> patterns, (most of those, maybe all today, with fixed string,
> extended or basic regex), the git-grep patterns ("leading paths
> match and glob(7) patterns are supported").  Is that all?
> I would assume glob-style for ls-tree:
> 
>   ?0[steffen@wales ]$ git ls-tree HEAD `ls mime*`
>   100644 blob ee47419c209da789b606ab6d979c22f4ae632712    mime.c
>   100644 blob 0cfe3766bd5f035eac06b728a4f63224455e13ca    mime.types
>   100644 blob 7d890df7553522691ed09f266ea7f9effb6a2f4e    mime_enc.c
>   100644 blob 430e300d9a8887c5cd48d1cc63034168e47e9721    mime_param.c
>   100644 blob 0338a46d3247ea00b5bcedb2d82ff30fe5d18d48    mime_parse.c
>   100644 blob d62fa8defae27240a5ce81ad2239dd7f94b6c5c5    mime_types.c
>   ?0[steffen@wales ]$ git ls-tree HEAD 'mime*'
>   ?0[steffen@wales ]$ git ls-tree HEAD 'mime.*'
> 
> No, ls-tree is not part of what i use every day, "Git's command
> line tools" is (too) wide afield, in that sense.
> 
> Thank you (also in general, for git), and ciao from a country with
> a pretty real autumn,

Maybe "git ls-files" is the command that you are looking for, really.

That and others have glob pathspec enabled by default, see "git help git".

"git ls-tree" does not understand globs nor pathspec magic. In fact, it
only matches on the first component of a path (complete matches).

Michael

