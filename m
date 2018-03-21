Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C7E1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 19:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbeCUToI (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 15:44:08 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:41772 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752637AbeCUToH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 15:44:07 -0400
Received: by mail-pf0-f178.google.com with SMTP id f80so2392264pfa.8
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:to:cc:in-reply-to:from:date:subject:references;
        bh=QxvQ9u+3yTZ4F8Y0G739rz7+W/HDq009zSCeP/YlxRw=;
        b=sn+iFuftYH1DBwWCZKY+iNiLhZFpsUXBu2dme+UmdCENnZpnNcM4TEA3Ia/vPjCTiA
         0maha0A9BZxqQxYuu8fziPO+l/oYMn2x+/N2LdB8kPVxC/i4uZ0H+RBdqBSRKg9TGw2j
         2gC8vi8HWmCGykLWR0Iv3rnzFLzNLfd6IdLF53F+YYIyFmmb+IzpFAFWp7RCnTXKzPcz
         GgjrspnMzraxAEyIpzF954yLdUpR4GrIRSPIAlCEFgXY21/q5KMKXqnOoqTmj/s3At4z
         Ef80KiiawfQwMnqS78zb/Tiv2jQmEdqNBqu/JE6Cdg/CK5WBv6TRpXm3UCbcuJMuoYeD
         PCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:to:cc:in-reply-to:from:date:subject
         :references;
        bh=QxvQ9u+3yTZ4F8Y0G739rz7+W/HDq009zSCeP/YlxRw=;
        b=H6fZ3W59wZToNNHfZ14UEdz/30kVN0pdcVXiYlaXxCABUi8g8jDGkB/T7rJMAJJR5v
         qJM7cma66Wx85YVxinBNAxrUcfEr1cEpUnVrcpejRSdLfC5y0b+y7Hkc4EsIKQw0n2y8
         hCNnkO/CIuaibQCxbBTFniAJhK6gN/Fv/ois+NVfcKD2xqXgaLc4vmW+g3Se//o8qANq
         V7juR73O1kA7VKXuRqVrV543M895BjE8L+8pcXSGRrPC+G58D9cKwwyqEniNNlJ+u+st
         NcMrtp9cjpsU/lW+BYWuiau1dJyQ0X3J/Vb3DbNv7hlsMtAolEMOVF8GOFlcADAYLuck
         deQA==
X-Gm-Message-State: AElRT7GEpdmPTuZzYMFYf3fUrxGwsrEFDb88/njOwiMVIfTgFdiULoXO
        Mf8bpBGm68ZhGWH7xTwdKuQ=
X-Google-Smtp-Source: AG47ELtMbdio08tmfu9cvWi8yo3IT3lHN8J0Wyz2d5yAREbM827H56Zyvrl+dobsjfi9EBPZIt/kQQ==
X-Received: by 10.98.48.195 with SMTP id w186mr18052795pfw.174.1521661446678;
        Wed, 21 Mar 2018 12:44:06 -0700 (PDT)
Received: from localhost (softbank126094241038.bbtec.net. [126.94.241.38])
        by smtp.gmail.com with ESMTPSA id b6sm10263934pfm.160.2018.03.21.12.44.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Mar 2018 12:44:06 -0700 (PDT)
Message-ID: <5ab2b606.86f5620a.c0c10.41b3@mx.google.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org
In-Reply-To: <xmqqwoy5pcno.fsf@gitster-ct.c.googlers.com>
From:   Yuki Kokubun <orga.chem.job@gmail.com>
Date:   Wed, 21 Mar 2018 20:00:00 +0000
Subject: Re: [PATCH] filter-branch: consider refs can refer to an object other than commit or tag
References: <xmqqwoy5pcno.fsf@gitster-ct.c.googlers.com>
        <20180321103504.9483-1-orga.chem.job@gmail.com>
        <1521646299-16193-1-git-send-email-orga.chem.job@gmail.com>
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yuki Kokubun <orga.chem.job@gmail.com> writes:
> 
> > "git filter-branch -- --all" can be confused when refs that refer to objects
> > other than commits or tags exists.
> > Because "git rev-parse --all" that is internally used can return refs that
> > refer to an object other than commit or tag. But it is not considered in the
> > phase of updating refs.
> 
> Could you describe what the consequence of that is?  We have a ref
> that points directly at a blob object, or a ref that points at a tag
> object that points at a blob object.  The current code leaves both of
> these refs in "$tempdir/heads".  Then...?

Sorry, this is my wrong.
I wrongly thought only refs/replace can point at a blob or tree object.

> 
> 	... goes and looks ...
> 
> There is a loop that looks like this:
> 
> 	while read ref
> 	do
> 		sha1=$(git rev-parse "$ref^0")
> 		...
> 	done <"$tempdir/heads"
> 
> which would break on anything but a commit-ish.
> 
> >  # The refs should be updated if their heads were rewritten
> >  git rev-parse --no-flags --revs-only --symbolic-full-name \
> > -	--default HEAD "$@" > "$tempdir"/raw-heads || exit
> > +	--default HEAD "$@" > "$tempdir"/raw-objects || exit
> > +# refs/replace can refer to an object other than commit or tag
> 
> Mention of replace refs in the proposed log message gives an easy to
> understand example and is a good idea, but this in code comment does
> not have to single out the replace refs.  A tag can also point at an
> object with any type, e.g. "git tag v2.6.11-tree v2.6.11^{tree}"
> would make "refs/tags/v2.6.11-tree" point at the tree at the top
> level of the tree-ish "v2.6.11".  It probably is OK to drop this
> comment altogether.

OK, I'm gonna drop the incorrect comment.

> 
> > +while read ref
> > +do
> > +	type=$(git cat-file -t "$ref")
> > +	if test $type = commit || test $type = tag
> > +	then
> > +		echo "$ref"
> > +	fi
> > +done >"$tempdir"/raw-heads <"$tempdir"/raw-objects
> >  sed -e '/^^/d' "$tempdir"/raw-heads >"$tempdir"/heads
> 
> So... is the idea to limit the set of refs to be rewritten to those
> that point at commits and tags?  As I already alluded to, I do not
> think you want to accept a ref that points at any tag object---only
> the ones that point at a tag that points at a commit-ish, so that
> the code will not barf when doing "$ref^0".
> 
> So perhaps
> 
> 	git rev-parse --no-flags ... >"$tempdir/raw-heads" || exit
> 
> 	while read ref
> 	do
> 		case "$ref" in ^?*) continue ;; esac
> 		if git rev-parse --verify "$ref^0" 2>/dev/null
>                 then
> 			echo "$ref"
> 		fi
> 	done >"$tempdir/heads" <"$tempdir/raw-heads"
> 
> or something?  Note that you do not need the "sed" as the loop
> already excludes the negative revs.

I feel using "git rev-parse --verify" is a good way as you said.
I'm gonna modify the patch to use it.

> 
> >  test -s "$tempdir"/heads ||
> > diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> > index 7cb60799b..efeaf5887 100755
> > --- a/t/t7003-filter-branch.sh
> > +++ b/t/t7003-filter-branch.sh
> > @@ -470,4 +470,17 @@ test_expect_success 'tree-filter deals with object name vs pathname ambiguity' '
> >  	git show HEAD:$ambiguous
> >  '
> >  
> > +test_expect_success 'rewrite repository including refs/replace that point to non commit object' '
> > +	test_when_finished "git reset --hard original" &&
> > +	tree=$(git rev-parse HEAD^{tree}) &&
> > +	test_when_finished "git replace -d $tree" &&
> > +	echo A >new &&
> > +	git add new &&
> > +	new_tree=$(git write-tree) &&
> > +	git replace $tree $new_tree &&
> 
> Perhaps something like this here:
> 
> 	git tag -a "tag to a tree" treetag $new_tree &&
> 
> can tell su how well it works with a tag that points at a tree?

Sounds good. I'm gonna add such tags to the test case.

> 
> > +	git reset --hard HEAD &&
> > +	git filter-branch -f -- --all >filter-output 2>&1 &&
> > +	! fgrep fatal filter-output
> > +'
> > +
> >  test_done
