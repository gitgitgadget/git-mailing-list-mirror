Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9653F1FAFC
	for <e@80x24.org>; Sun,  5 Feb 2017 11:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbdBELCK (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 06:02:10 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35022 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbdBELCI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 06:02:08 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so15221676wmu.2
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 03:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M9pK2Up3m07WBBkpCQXk9EnW87tsjecBlhl7KCcVLtk=;
        b=INAfjZznfOx9p7HKwvMdx9F0irWP9JsdeN/qTumsS7iOrqoaNc8TtrRPcQOR52/s0b
         bNo3pzgfJqmVVVJ5C7ALok+DKuMoQY26UxWwKK4xel1RzvSE5KqutIGrB7xNMxtsewan
         eyIjK3wRPmGU2BrSSZPslQE2SeyD+mWR+jJE92cBXuU90oxkWXKHGXNvaN52SumOIewD
         cMUPRqIAl0fh2wkSjz0xhi1CsrAd4VN6Pr9tqdYLv34f/zd+tFkpl6vc1ks5nI0Bzxei
         0xa/OyvPPpsxJxAx6qotDxwkhU3WfhQ0HFf1/b77jsU5CUflCU6DmtRi9yCxs4wDT2O7
         GkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M9pK2Up3m07WBBkpCQXk9EnW87tsjecBlhl7KCcVLtk=;
        b=N3Sq1MfwABBWZCUhNbC5+ciJskunHrwOp+5rOt+X97gQ3UvnyY6kf7b7KSXIh4D64L
         pW0oaAju/CZVEi+Bm2X2RwsdPitS0BnWm1GFsxPYTJwKHYxFAUSniodpi8JhXnUQ8fA5
         n6OF0ztx1nrp0qgpP+s+vYBccLGs7m5ekF6CP4JweKE61mQaRjFzBPkttr55MbvhIDoG
         3+dOBSiGnQAOb6mJdZ8v+6FjSY1bxq7rYdoeIqbtPkrzN9s1U0CDj5peinHeBQCnaNvN
         z90nOWmPGLAym7PBxuYjtGGJEgFZ15FOxuiaSRHtsZvixidBhipA3siMVSNplNcPQI9W
         yD9w==
X-Gm-Message-State: AMke39lXgKruZLBjU6hmWL7RuQT6hZTpqtFGzd2PlnkZwDlHXpLxfk0ffJzp6WlZWfMkCg==
X-Received: by 10.28.54.90 with SMTP id d87mr4918137wma.89.1486292526771;
        Sun, 05 Feb 2017 03:02:06 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id c202sm6941902wmd.10.2017.02.05.03.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2017 03:02:05 -0800 (PST)
Date:   Sun, 5 Feb 2017 11:02:33 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?B?2Hl2aW5kIEEu?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 4/4] stash: support filename argument
Message-ID: <20170205110233.GG31189@hank>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170129201604.30445-5-t.gummerer@gmail.com>
 <xmqqa8a8uuc9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa8a8uuc9.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/30, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Add an optional filename argument to git stash push, which allows for
> > stashing a single (or multiple) files.
> 
> You can give pathspec with one or more elements, so "an optional
> argument" sounds too limiting.  
> 
>     Allow 'git stash push' to take pathspec to specify which paths
>     to stash.
> 
> Also retitle
> 
> 	stash: teach 'push' (and 'create') to honor pathspec
> 
> or something.
> 
> > @@ -56,6 +61,10 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
> >  	only <message> does not trigger this action to prevent a misspelled
> >  	subcommand from making an unwanted stash.
> >  +
> > +If the paths argument is given in 'git stash push', only these files
> > +are put in the new 'stash'.  In addition only the indicated files are
> > +changed in the working tree to match the index.
> 
> Actually the stash contains "all paths".  You could say that you are
> placing _modifications_ to these paths in stash, even though that is
> not how Git's world model works (i.e. everything is a snapshot, and
> modifications are merely difference between two successive
> snapshots).  A technically correct version may be:
> 
> 	When pathspec is given to 'git stash push', the new stash
> 	records the modified states only for the files that match
> 	the pathspec.  The index entries and working tree files are
> 	then rolled back to the state in HEAD only for these files,
> 	too, leaving files that do not match the pathspec intact.
> 
> > diff --git a/git-stash.sh b/git-stash.sh
> > index 5f08b43967..0072a38b4c 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -41,7 +41,7 @@ no_changes () {
> >  untracked_files () {
> >  	excl_opt=--exclude-standard
> >  	test "$untracked" = "all" && excl_opt=
> > -	git ls-files -o -z $excl_opt
> > +	git ls-files -o -z $excl_opt -- $1
> 
> Hmph, why "$1" is spelled without dq, implying that it is split at
> $IFS boundary?  This line alone makes me suspect that this is not
> prepared to deal correctly with $IFS.  Let's read on...
> 
> > @@ -59,6 +59,7 @@ create_stash () {
> >  	stash_msg=
> >  	untracked=
> >  	new_style=
> > +	files=
> >  	while test $# != 0
> >  	do
> >  		case "$1" in
> > @@ -72,6 +73,12 @@ create_stash () {
> >  			untracked="$1"
> >  			new_style=t
> >  			;;
> > +		--)
> > +			shift
> > +			files="$@"
> 
> Isn't this the same as writing files="$*", i.e. concatenate the
> multiple arguments with the first whitespace in $IFS in between?
> 
> > @@ -134,7 +141,7 @@ create_stash () {
> >  		# Untracked files are stored by themselves in a parentless commit, for
> >  		# ease of unpacking later.
> >  		u_commit=$(
> > -			untracked_files | (
> > +			untracked_files $files | (
> 
> ... and this lets it split at $IFS again when passing it down to the
> helper.  But the helper looks only at $1 so the second and subsequent
> ones will be ignored altogether.
> 
> This cannot be correct, and any hunk in the remainder of the patch
> that mentions $files will be incorrect for the same reason.
> 
> Is it possible to carry what the caller (and the end user) gave you
> in "$@" without molesting it at all?  That would mean you do not
> need to introduce $files variable at all, and then the places that
> do things like this:
> 
> > -	create_stash -m "$stash_msg" -u "$untracked"
> > +	create_stash -m "$stash_msg" -u "$untracked" -- $files
> 
> can instead do
> 
> 	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
> 
> That would allow you to work correctly with pathspec with $IFS
> whitespaces in them.

Thanks for taking the time for this explanation!  It cleared quite a
few things up in my head.  I'll make these fixes in the re-roll.

-- 
Thomas
