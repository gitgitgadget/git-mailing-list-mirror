Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0B951F453
	for <e@80x24.org>; Fri, 21 Sep 2018 21:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391507AbeIVC7u (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 22:59:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52092 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391321AbeIVC7u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 22:59:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id o20-v6so645901wmh.1
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 14:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e8gS0KsrniPykcpewvDlhLeDYPvNdkwUjrJaD//whbE=;
        b=b8CNKdLB9yYoSyN0Lnk6nSw3jDrWR7+m7DDiU3Yy8vbNIKGpk8yd567ffuSZCT65NE
         w/CIZBdPfZez1PmnBvRbwBPR4cwZJ8Z45ORhLQ8QGS+aiO93S3EGBdJ9YSKjM6TNYBZ0
         ytuyphP2fXPJ/YDpL2OL/4puOqSxLM1EbRZ+3dEd5zcsE21hfTZdWxEtbbDt2Ob9lGnB
         Q6DBX5QmKRoprgZXHGKGZCFiy4cWQy+yoG9eu+vAmrzmGbTvVF/GR64Gtn+HvWikHfBn
         9B+iZK8RNDaLENJ4EcV5rZgOhinoYCKB/kPXgVs2U6R2I3SGo70iAFFJJ5cPtJB5UUMH
         CsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e8gS0KsrniPykcpewvDlhLeDYPvNdkwUjrJaD//whbE=;
        b=GduGek4FL9r+6ZGXKFDnvsljVec7Lckk9ht7tqvfYEAqDvcDsCaqBPdrJJ2X5Z2IKD
         BLunaamLVi0E3DDUOfy/ykrnTZ0XWNoXpsyWUKfPxcOWaz7NfCOBSuGHAn6DVbxC1tqo
         EcR7GxH5vJK3eMZMmnZ5yEIBR9DuxPnayzTtagLgKqKoI9T4uuWHbh3PpXU3tGJXHanq
         PTJqAwOwwClQLDknuS9njUFKg8X89p8I6nLhQXvyZGskx0y4GVCvB85/AOo9CvCkM522
         e4suMKgDcdzDpWNE2wO4Ig3DsSNnsFTdtiwH1tTjEg+pHWWbSy74WIqa9br105K5CsB9
         EhTg==
X-Gm-Message-State: ABuFfog8kR5jFyBn3DuZ+cZVz90dhKc7Kr4aHpNmyMbfSujPb4xs6biq
        HmN677qx8bn6lzp+U/vap2i7wzZQ
X-Google-Smtp-Source: ACcGV62zVVupUGZjsFxXr/emziNozg0SBb4U2+upLboa8GWeBkIzsw1ddivEqzVTpr4U9maMs1F0Dg==
X-Received: by 2002:a1c:68f:: with SMTP id 137-v6mr9278083wmg.82.1537564149803;
        Fri, 21 Sep 2018 14:09:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s131-v6sm8852377wmf.2.2018.09.21.14.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 14:09:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        sbeller@google.com
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
References: <cover.1537466087.git.me@ttaylorr.com>
        <cover.1537555544.git.me@ttaylorr.com>
        <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
Date:   Fri, 21 Sep 2018 14:09:08 -0700
In-Reply-To: <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 21 Sep 2018 14:47:43 -0400")
Message-ID: <xmqqfty2v9qj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> +core.alternateRefsCommand::
> +	When listing references from an alternate (e.g., in the case of ".have"), use

It is not clear how (e.g.,...) connects to what is said in the
sentence.  "When advertising tips of available history from an
alternate, use ..." without saying ".have" may be less cryptic.  

I dunno.

> +	the shell to execute the specified command instead of
> +	linkgit:git-for-each-ref[1]. The first argument is the path of the alternate.

"The path" meaning the absolute path?  Relative to the original
object store?  Something else?

> +	Output must be of the form: `%(objectname) SPC %(refname)`.
> ++
> +This is useful when a repository only wishes to advertise some of its
> +alternate's references as ".have"'s. For example, to only advertise branch
> +heads, configure `core.alternateRefsCommand` to the path of a script which runs
> +`git --git-dir="$1" for-each-ref refs/heads`.
> +
>  core.bare::
>  	If true this repository is assumed to be 'bare' and has no
>  	working directory associated with it.  If this is the case a
> diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> new file mode 100755
> index 0000000000..2f21f1cb8f
> --- /dev/null
> +++ b/t/t5410-receive-pack.sh
> @@ -0,0 +1,54 @@
> +#!/bin/sh
> +
> +test_description='git receive-pack test'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit one &&
> +	git update-ref refs/heads/a HEAD &&
> +	test_commit two &&
> +	git update-ref refs/heads/b HEAD &&
> +	test_commit three &&
> +	git update-ref refs/heads/c HEAD &&
> +	git clone --bare . fork &&
> +	git clone fork pusher &&
> +	(
> +		cd fork &&
> +		git config receive.advertisealternates true &&

Hmph.  Do we have code to support this configuration variable?

> +		cat <<-EOF | git update-ref --stdin &&

Style: writing "<<-\EOF" instead would allow readers' eyes to
coast over without having to look for $variable_references in
the here-doc.

> +		delete refs/heads/a
> +		delete refs/heads/b
> +		delete refs/heads/c
> +		delete refs/heads/master
> +		delete refs/tags/one
> +		delete refs/tags/two
> +		delete refs/tags/three

So, the original created one/two/three/a/b/c/master, fork is a bare
clone of it and has all these things, and then you deleted all of
these?  What does fork have after this is done?  HEAD that is
dangling?

> +		EOF
> +		echo "../../.git/objects" >objects/info/alternates

When viewed from fork/objects, ../../.git is the GIT_DIR of the
primary test repository, so that is where we borrow objects from.

If we pruned the objects from fork's object store before this echo,
we would have an almost empty repository that borrows from its
alternates everything, which may make a more realistic sample case,
but because you are only focusing on the ref advertisement, it does
not matter that your fork is full of duplicate objects that are
available from the alternates.

> +expect_haves () {
> +	printf "%s .have\n" $(git rev-parse $@) >expect

Quote $@ inside dq pair, like $(git rev-parse "$@").

> +extract_haves () {
> +	depacketize - | grep '\.have' | sed -e 's/\\0.*$//g'
> +}


Don't pipe grep into sed, especially when both the pattern to filter
and the operation to perform are simple.

I am not sure what you are trying to achive with 'g' in
s/pattern$//g; The anchor at the rightmost end of the pattern makes
sure that the pattern matches only once per line at the end anyway,
so "do this howmanyever times as we have match on each line" would
not make any difference, no?

> diff --git a/transport.c b/transport.c
> index 24ae3f375d..e7d2cdf00b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1328,10 +1328,21 @@ char *transport_anonymize_url(const char *url)
>  static void fill_alternate_refs_command(struct child_process *cmd,
>  					const char *repo_path)
>  {
> -	cmd->git_cmd = 1;
> -	argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
> -	argv_array_push(&cmd->args, "for-each-ref");
> -	argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
> +	const char *value;
> +
> +	if (!git_config_get_value("core.alternateRefsCommand", &value)) {
> +		cmd->use_shell = 1;
> +
> +		argv_array_push(&cmd->args, value);
> +		argv_array_push(&cmd->args, repo_path);
> +	} else {
> +		cmd->git_cmd = 1;
> +
> +		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
> +		argv_array_push(&cmd->args, "for-each-ref");
> +		argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
> +	}
> +
>  	cmd->env = local_repo_env;
>  	cmd->out = -1;
>  }
