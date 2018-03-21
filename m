Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777A31F404
	for <e@80x24.org>; Wed, 21 Mar 2018 18:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeCUSLL (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 14:11:11 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:40542 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752285AbeCUSLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 14:11:09 -0400
Received: by mail-wr0-f175.google.com with SMTP id z8so6137776wrh.7
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 11:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pss5HCFT6xXVPDDE6e9f6PzzHBPZAw2AiCU238ISPnE=;
        b=OhdujqV4a3PUSLrPU8oM52pnOizTA6YrQVOw33uLG3WQEwDW5oLoOboTonYAM9HAwx
         5EySyWKCJC1Lo9zFX4RTLkEq9wC7Ez6F0x1T9HTyXe4QDOksOdULD2kZ1lxsTqJcg8Kc
         KLqprgvZlT5nKcQsby7fi/n9Qel76k7YRv84cw7sYnpc4HiQ/VkmDTGis70KrRX+lK60
         CyBep5dSImRD+KjCe0wKgMhLjjao1zH7qQeT8vkxkSzeYTvfpYzqj1fKSRrf4VWKRYF3
         DH/+/c7KEhgIw2dNd+3KI5Sry8AuzyX1i71eco5ncHMOFaxwD/BnWGpbTU/7pXA1F7pC
         zqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pss5HCFT6xXVPDDE6e9f6PzzHBPZAw2AiCU238ISPnE=;
        b=octGSY7G1v5bqCZUoPCJ/HWAe1f66uS/PYBpbZM5HQD5vUKeqoOagySAw51hDEEda+
         A44aFMcVirJFbpou/VV7NWndv2P+8L6FotnpFK8U9xoUayZa4/vc2XRQ2o6fQxIVXyub
         YlZffUMp2anmhTEV5P71USdiGs3gHmEysHXOtkJXVVsZe+L5ajJmuThvHUuwBbnQhKQU
         VsqSMZ5Nl1kfScVeVwbcrHTJetAt5K/Ar2CAOX6v6oNa33Kd76BIEwZhn+6/7jdfspCv
         e6V7yYw7zBViRngT6jUG3rziMKyVexMF4pxv/QykZWZHCVBjrMHOU1Bob7Crh0zXm2ze
         N9cw==
X-Gm-Message-State: AElRT7GoKj0lhFyX063NRZhRrA5FCIF8jd9srvATCvjlV7vqXg35yzMJ
        8Pnh+/fGbT4La0t1sgQ6I6D1/xzJ
X-Google-Smtp-Source: AG47ELshqpk6p7fmmH3FW+otmqnqgJ5hgW8R+5NNrDDoTpUyWkCgV6aDN1f8P1znvqYaQFeYzp93Iw==
X-Received: by 10.223.209.198 with SMTP id m6mr16050235wri.267.1521655867909;
        Wed, 21 Mar 2018 11:11:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v22sm4751312wrd.43.2018.03.21.11.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 11:11:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v3] test: avoid pipes in git related commands for test
References: <CAPig+cTKkp6kpFcJfVV8W1ejCrCWQH33mHtgFUn+MpMgw5i1pA@mail.gmail.com>
        <20180321152356.10754-1-predatoramigo@gmail.com>
Date:   Wed, 21 Mar 2018 11:11:06 -0700
In-Reply-To: <20180321152356.10754-1-predatoramigo@gmail.com> (Pratik Karki's
        message of "Wed, 21 Mar 2018 21:08:56 +0545")
Message-ID: <xmqqo9jhpadh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratik Karki <predatoramigo@gmail.com> writes:

> Thank you Eric, for the review. This is follow on patch[1].
>
> The changes in patch increased from v1 to v2 because I
> got excited to work in Git codebase and I tried to
> fix the exisiting problems as much as possible.
> Hence, the large number of changes.

Eric understands why the scope was increased between the two; he
explained why it is not a good idea to increase the scope in the
middle, and I tend to agree with his reasoning.  The reason why the
scope was increased does not matter.

>>> @@ -120,18 +122,20 @@ test_expect_success 'test another branch' '
>>>         git config --add svn-remote.four.url "$svnrepo" &&
>>>         git config --add svn-remote.four.fetch trunk:refs/remotes/four/trunk &&
>>>         git config --add svn-remote.four.branches \
>>> -                        "branches/*/*:refs/remotes/four/branches/*/*" &&
>>> +                        "branches/*/*:refs/remotes/four/branches/*/*" &&
>>>         git config --add svn-remote.four.tags \
>>> -                        "tags/*:refs/remotes/four/tags/*" &&
>>> +                        "tags/*:refs/remotes/four/tags/*" &&
>
>>I guess you sneaked in a whitespace change here which is unrelated to
>>the stated purpose of this patch, thus acted as a speed bump during
>>review....
>>Therefore, you should omit this change.
>
> I used tabify in Emacs and it must have messed up the whitespace
> change.

Then don't.  Make sure the lines _you_ change are indented and
formatted correctly.  Do not touch near-by (or far-away for that
matter) lines that you do not have to touch only to change the
formatting.

> I read SubmittingPatches guideline[2] for git where it
> is said that whitespace check must be done and git community is
> picky about it and 'git diff --check' must be done before commit.

Yes.

> If I change this change back to original the 'git diff --check'
> reports whitespace identation with space.

I do not think 'diff --check' would.  Save the patch you sent to a
file, edit it so that these two lines Eric pointed out are not
changed, and then apply it with "git apply --whitespace=nowarn".
Then ask "git diff --check"---it should not complain about an
existing whitespace glitch that you did not introduce.

> So, isn't this
> supposedly a fix?

Unless it is a "here is a patch to reindent and fix whitespaces"
patch that does nothing else, it is an unwelcome noise that
distracts reviewers from the real changes.

> ------------------------------------- >8----------------------------------------

This is not wrong per se, but just a

-- >8 --

is sufficient ;-)

>
>  Avoid using pipes downstream of Git commands since the exit
>  codes of commands upstream of pipes get swallowed, thus potentially hiding
>  failure of those commands. Instead, capture Git command output to a file and
>  apply the downstream command(s) to that file.

Please do not indent the body of the log message by one space.

> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 9c68b9925..707208284 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -311,9 +311,9 @@ test_expect_success 'unpacking with --strict' '
>  	rm -f .git/index &&
>  	tail -n 10 LIST | git update-index --index-info &&
>  	ST=$(git write-tree) &&
> -	PACK5=$( git rev-list --objects "$LIST" "$LI" "$ST" | \
> -		git pack-objects test-5 ) &&
> -	PACK6=$( (
> +	git rev-list --objects "$LIST" "$LI" "$ST" >actual &&
> +	PACK5=$( git pack-objects test-5 <actual ) &&
> +	PACK6=$((

I thought that Eric already pointed out and explained why this
change to PACK6 is wrong in the previous round?

> diff --git a/t/t9111-git-svn-use-svnsync-props.sh b/t/t9111-git-svn-use-svnsync-props.sh
> index 22b6e5ee7..a4225c9f6 100755
> --- a/t/t9111-git-svn-use-svnsync-props.sh
> +++ b/t/t9111-git-svn-use-svnsync-props.sh
> @@ -20,32 +20,32 @@ uuid=161ce429-a9dd-4828-af4a-52023f968c89
>  
>  bar_url=http://mayonaise/svnrepo/bar
>  test_expect_success 'verify metadata for /bar' "
> -	git cat-file commit refs/remotes/bar | \
> -	   grep '^git-svn-id: $bar_url@12 $uuid$' &&
> -	git cat-file commit refs/remotes/bar~1 | \
> -	   grep '^git-svn-id: $bar_url@11 $uuid$' &&
> -	git cat-file commit refs/remotes/bar~2 | \
> -	   grep '^git-svn-id: $bar_url@10 $uuid$' &&
> -	git cat-file commit refs/remotes/bar~3 | \
> -	   grep '^git-svn-id: $bar_url@9 $uuid$' &&
> -	git cat-file commit refs/remotes/bar~4 | \
> -	   grep '^git-svn-id: $bar_url@6 $uuid$' &&
> -	git cat-file commit refs/remotes/bar~5 | \
> -	   grep '^git-svn-id: $bar_url@1 $uuid$'
> +	git cat-file commit refs/remotes/bar >actual &&
> +	grep '^git-svn-id: $bar_url@12 $uuid$' actual &&
> +	git cat-file commit refs/remotes/bar~1 >actual1 &&
> +	grep '^git-svn-id: $bar_url@11 $uuid$' actual1 &&
> +	git cat-file commit refs/remotes/bar~2 >actual2 &&
> +	grep '^git-svn-id: $bar_url@10 $uuid$' actual2 &&
> +	git cat-file commit refs/remotes/bar~3 >actual3 &&
> +	grep '^git-svn-id: $bar_url@9 $uuid$' actual3 &&
> +	git cat-file commit refs/remotes/bar~4 >actual4 &&
> +	grep '^git-svn-id: $bar_url@6 $uuid$' actual4 &&
> +	git cat-file commit refs/remotes/bar~5 >actual5 &&
> +	grep '^git-svn-id: $bar_url@1 $uuid$' actual5
>  	"

I also thought that Eric already pointed out that the above is not a
good idea because it forces readers to wonder if "actual[1-5]" need
to exist together with "actual" at the same time in the previous
round?

