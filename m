Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3E51FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 16:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbcFPQut (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 12:50:49 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33910 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbcFPQuq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2016 12:50:46 -0400
Received: by mail-qk0-f176.google.com with SMTP id s186so59360330qkc.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 09:50:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xOIjD+nc3Eo6KgtiHkMC5zZfaB5DKSSd7Hw2eFAUgzk=;
        b=bHQNNS7SGGD5wvEjQXHKtvyipRmLYf3kyLThTRIj7VBIsQziZYEDGxnJbsMf0wO5CO
         J2oO8Iso0+x+fXd4bT4xpVHddgAV/f3kU1zcx/AYAOdax8MGwVAaVL+KLqSn9EUnNAv8
         KxHIVurrYeUc+ejgXl6PC1Td7HMilPGEr0ldvA69ZRvyGlZLYZ3GwGCrG+DYtnEhBuWs
         1HpIdu9N25nI8pOS3kjvyzYGoUTLgjAG1mo7yMxS9Vm9ED119T3WbNqhCPcVDKdqEjyl
         WpMY23xro7E3RVorz7cUXTQssX0yjxBjNuYMHvoOZ6mxXhV6HeZe1Z++TmFBqlkU5VBX
         Eicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xOIjD+nc3Eo6KgtiHkMC5zZfaB5DKSSd7Hw2eFAUgzk=;
        b=G/o0aDUEqtS+OMw7tKn9ze7GDi+XFrJIGqUsjMgWF8NJCwrWSfV+KEdIcceV5KvM2e
         +/sopRW0atzXBRPfktYdy0agnrgtmWE9/cPlU3jPuVZi0ICVcc3rLqvb0qmrtf+jgQKZ
         maFRnFIL7bu6cnQwWIazLyZxzBnGl4XhZiR89C7ybWh7nR1ByujFCJunFAwlnuoq0i23
         ZNN+Yq1ZMhvlQh6g3yCPqWQ/rq07rTmt1OOkFXpVvFA2QA0dJq6+l/aTMpc5eZePdD4M
         aoa0PW71BOLPJCPcohHLXX09T5yDzUsZZvnjJ5b45N3jwYlNtHq42B4oPV18urcEQm3I
         +9Ig==
X-Gm-Message-State: ALyK8tLD1/7p+ZZMTL5S5fLEzN2wCEZZmvLGhgmYwR8YTuxPE0wiib5qbq/7xuOCB1zinN0613OsH1fR5HmnljfE
X-Received: by 10.55.10.147 with SMTP id 141mr6196015qkk.91.1466095845700;
 Thu, 16 Jun 2016 09:50:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.42.226 with HTTP; Thu, 16 Jun 2016 09:50:45 -0700 (PDT)
In-Reply-To: <20160616122729.GC15988@sigill.intra.peff.net>
References: <CAEtHF9Na7yppEzuutp5=98KjLucgq=7Xv9GPidhaYEuC0oeqQQ@mail.gmail.com>
 <20160614214211.GB21560@sigill.intra.peff.net> <xmqq37of8mx4.fsf@gitster.mtv.corp.google.com>
 <CAEtHF9Ne7a25cOF_6L=ZXRnmR4NbnUBDFR+6V-PryjtK8yNO8g@mail.gmail.com> <20160616122729.GC15988@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 16 Jun 2016 09:50:45 -0700
Message-ID: <CAGZ79kaPVFT=yeSAkmf55+qXcCgMkwpgkC8jXhuZvqj5mWtgLw@mail.gmail.com>
Subject: Re: [PATCH] add--interactive: respect diff.compactionHeuristic
To:	Jeff King <peff@peff.net>
Cc:	=?UTF-8?Q?Alex_Preng=C3=A8re?= <alexprengere@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 5:27 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 15, 2016 at 08:24:47AM +0200, Alex Prengère wrote:
>
>> I see, it makes sense ;-) Indeed it would seem logical to have all
>> commands showing diffs (diff, add -p, log -p, reset -p, etc..) respect
>> the diff options.
>
> Here's a patch to do so, similar to what we do for diff.algorithm.
>
> -- >8 --
> Subject: add--interactive: respect diff.compactionHeuristic
>
> We use plumbing to generate the diff, so it doesn't
> automatically pick up UI config like compactionHeuristic.
> Let's forward it on, since interactive adding is porcelain.
>
> Note that we only need to handle the "true" case. There's no
> point in passing --no-compaction-heuristic when the variable
> is false, since nothing else could have turned it on.

because we don't want to implement --[no-]compaction-heuristic
as a command line switch to git-add?
Fine with me.

Stepping back and looking how the compaction heuristic turned out,
I think this is what we did not want to see, i.e. the need to bring it in
every command, but rather enable and release it. But we backed off
of the default-on, and now people may ask for the  --no-compaction-heuristic
in interactive add eventually, when they run into a corner case.

For now:
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks,
Stefan



>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git-add--interactive.perl | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 822f857..642cce1 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -45,6 +45,7 @@ my ($diff_new_color) =
>  my $normal_color = $repo->get_color("", "reset");
>
>  my $diff_algorithm = $repo->config('diff.algorithm');
> +my $diff_compaction_heuristic = $repo->config_bool('diff.compactionheuristic');
>  my $diff_filter = $repo->config('interactive.difffilter');
>
>  my $use_readkey = 0;
> @@ -749,6 +750,9 @@ sub parse_diff {
>         if (defined $diff_algorithm) {
>                 splice @diff_cmd, 1, 0, "--diff-algorithm=${diff_algorithm}";
>         }
> +       if ($diff_compaction_heuristic) {
> +               splice @diff_cmd, 1, 0, "--compaction-heuristic";
> +       }
>         if (defined $patch_mode_revision) {
>                 push @diff_cmd, get_diff_reference($patch_mode_revision);
>         }
> --
> 2.9.0.160.g4984cba
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
