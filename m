Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8300202AB
	for <e@80x24.org>; Mon,  3 Jul 2017 17:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755854AbdGCR5S (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 13:57:18 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33486 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755830AbdGCR5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 13:57:17 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so23818811pgb.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nh9onZ0tFdwZHCURnIEChzGKb9W2An9yoEpd6lsjfQY=;
        b=uWKxdwnaomqS5AR6RC/+2WNJK+L6JYl7Z0ziHaaCHT83w+0XumdrgIW6dpnA0ynA4b
         xZ+BY6xneBQFlp7qwXVRuqAtyv9qSkt2b4JSvu/A+NVzI2Ya6rSnLh4DqqBjiv6h0Nky
         5sZ2B0ISHqm1oIvDasWbRc/rsSBU4z4qhwZLxE1JIT+zdzXAyF4CUT3lFhvktJoMiEZP
         BRYUsPWn6jN12J1ppN8KJgHyCgyOW/VBKM4N2iiqBwftPPdwWX4ceLyBYcPQ20vF5n0b
         Vdp+LXSXj9KE56rcMRVXQF+1CAm0GEbAXzqDg0GOZC7ardJeeEluhyKek2l/BYBgRlvm
         Ww8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=nh9onZ0tFdwZHCURnIEChzGKb9W2An9yoEpd6lsjfQY=;
        b=IP8JFZIJh7VPaRWzA6ba6S0C8QwcDOH0s6n8q1p3myC+bDfsSnjkCPRGcDAjsS1pTB
         5y/r35CcHd9WQ4klkwMgiU+wy6hPcPHiclvLsttaGymDVOqQRITsvRY62Nl68oobSS1X
         1iaZ6Xe1GimC5cTny++jrlfszY9hwEq5SY7pVAysUTnuA8Oc3UdXX2w4CHBxKNdhecxF
         6z5UGnH7kzFGSHioHHeggJfDzxoQ2GBOv49V8733JcpEBmtUEhiLr7d9U23icPeZTbFA
         n9tlFzZ4aaUlK4kpS34FRGnXXsJmOU6btsTXnUjmwJG6voHMSw0GuYo91x93pT7mcFsl
         bYKw==
X-Gm-Message-State: AIVw110eGaxmnm3PjV88PAgpktZD0Tu3X4n/61XnHGLHiDkq+YCbbvJT
        +qhMh24FJfkOJ5h1YoQ=
X-Received: by 10.98.178.150 with SMTP id z22mr11130877pfl.165.1499104636225;
        Mon, 03 Jul 2017 10:57:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:30:4739:ca21:b5b4])
        by smtp.gmail.com with ESMTPSA id z86sm40407626pfl.40.2017.07.03.10.57.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 10:57:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C5=81ukasz?= Gryglicki <lukaszgryglicki@o2.pl>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] area: git-merge: add --signoff flag to git-merge
References: <0102015d07e215ae-a711670e-8315-40b9-90cf-f95075525622-000000@eu-west-1.amazonses.com>
Date:   Mon, 03 Jul 2017 10:57:10 -0700
In-Reply-To: <0102015d07e215ae-a711670e-8315-40b9-90cf-f95075525622-000000@eu-west-1.amazonses.com>
        (=?utf-8?Q?=22=C5=81ukasz?= Gryglicki"'s message of "Mon, 3 Jul 2017
 09:57:23 +0000")
Message-ID: <xmqqwp7pl7yh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Łukasz Gryglicki <lukaszgryglicki@o2.pl> writes:

> Subject: Re: [PATCH] area: git-merge: add --signoff flag to git-merge

s/area: //; 

> Added --signoff flag to `git-merge` command, added test coverage,
> updated documentation.

That can be seen from the title and the patch text.  While it is not
wrong to list what you did, that shouldn't be the only thing the log
records.  Explain the problem the patch attempts to fix, why it is a
problem, and then give orders to the code to "be like so".

	[PATCH] git-merge: honor --signoff flag

	The "Signed-off-by:" line is a social convention to certify
	that you are legally allowed to do so when you are giving
	changes to or recording changes for the project.  

	The "git commit" command has a handy option "--signoff" to
	add it under your name, because committing is the primary
	way for you to record your changes (which may later be sent
	to the project in a patch form).

	On the other hand, the "git merge" command does not.  [You
	make an argument to justify why merge commits also should
	have signoffs here].

	Teach "git merge" to honor "--signoff" just like "git commit"
	does.

or something like that.  It is a norm for a new feature to have
documentation and test, so it is of lessor importance to say "Add
tests and document the new feature" (on the other hand, those who do
not test and document need to justify their omission).

Alternatively, if the problem is so obvious that it does not need to
be explained, the solution often does not need more explanation than
the patch title.

I this case, I think the "problem" is not that obvious; the need for
signing off a merge commit deserves explanation in the log message.


> Signed-off-by: lukaszgryglicki <lukaszgryglicki@o2.pl>
> ---

"Signed-off-by: Łukasz Gryglicki <lukaszgryglicki@o2.pl>", like you wrote
on your "From:" e-mail header.

>  Documentation/git-merge.txt  |  8 ++++++
>  builtin/merge.c              |  4 +++
>  t/t9904-git-merge-signoff.sh | 60 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
>  create mode 100755 t/t9904-git-merge-signoff.sh
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 04fdd8cf086db..6b308ab6d0b52 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -64,6 +64,14 @@ OPTIONS
>  -------
>  include::merge-options.txt[]
>  
> +--signoff::
> +	Add Signed-off-by line by the committer at the end of the commit
> +	log message.  The meaning of a signoff depends on the project,
> +	but it typically certifies that committer has
> +	the rights to submit this work under the same license and
> +	agrees to a Developer Certificate of Origin
> +	(see http://developercertificate.org/ for more information).
> +

Good description.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 900bafdb45d0b..cb09f4138136b 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -70,6 +70,7 @@ static int continue_current_merge;
>  static int allow_unrelated_histories;
>  static int show_progress = -1;
>  static int default_to_upstream = 1;
> +static int signoff;
>  static const char *sign_commit;
>  
>  static struct strategy all_strategy[] = {
> @@ -233,6 +234,7 @@ static struct option builtin_merge_options[] = {
>  	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
>  	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>  	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
> +	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
>  	OPT_END()
>  };
>  
> @@ -775,6 +777,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>  	strbuf_stripspace(&msg, 0 < option_edit);
>  	if (!msg.len)
>  		abort_commit(remoteheads, _("Empty commit message."));
> +	if (signoff)
> +		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);

I think this is a wrong place to do this, because 

  (1) it is too late to allow "prepare-commit-msg" to futz with it.
  (2) it is too late to allow the end user to further edit it.

A better place probably is before merge_editor_comment is added to
the msg strbuf in the same function, but I didn't think it through.

> diff --git a/t/t9904-git-merge-signoff.sh b/t/t9904-git-merge-signoff.sh
> new file mode 100755
> index 0000000000000..eed15b9a85371
> --- /dev/null
> +++ b/t/t9904-git-merge-signoff.sh

Do we need a new script?    I think t7608 is about the messages in
the merge commit.

> +# A simple files to commit
> +cat >file1 <<EOF
> +1
> +EOF
> +
> +cat >file2 <<EOF
> +2
> +EOF
> +
> +cat >file3 <<EOF
> +3
> +EOF
>
> +
> +# Expected commit message after merge --signoff
> +cat >expected-signed <<EOF
> +Merge branch 'master' into other-branch
> +
> +Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
> +EOF
> +
> +# Expected commit message after merge without --signoff (or with --no-signoff)
> +cat >expected-unsigned <<EOF
> +Merge branch 'master' into other-branch
> +EOF
> +

All of the above should be done inside the first set-up test so that
they can be protected from errors.

> +
> +# We configure an alias to do the merge --signoff so that
> +# on the next subtest we can show that --no-signoff overrides the alias

Do we even need to risk these tests broken by an unrelated breakage
to the alias mechanism?  Wouldn't testing

	git merge --signoff --no-signoff ...

directly sufficient?  The alias test may be a good thing to have _in
addition to_ such a basic test, though.

> +test_expect_success 'merge --signoff adds a sign-off line' '
> +	git commit --allow-empty -m "Initial empty commit" &&
> +  git checkout -b other-branch &&
> +	git add file1 && git commit -m other-branch &&
> +  git checkout master &&
> +	git add file2 && git commit -m master-branch &&
> +  git checkout other-branch &&
> +  git config alias.msob "merge --signoff --no-edit" &&

Strange indentation.

> +	git msob master &&
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&

Style: no space between redirection and target.

> +	test_cmp expected-signed actual
> +'
> +
> +test_expect_success 'master --no-signoff does not add a sign-off line' '
> +	git checkout master &&
> +  git add file3 && git commit -m master-branch-2 &&
> +  git checkout other-branch &&
> +	git msob --no-signoff master &&
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
> +	test_cmp expected-unsigned actual
> +'
> +
> +test_done

Other than the above issues, looks like a very well done patch for
somebody who is posting a patch for the first time here.  Welcome to
Git development community.
