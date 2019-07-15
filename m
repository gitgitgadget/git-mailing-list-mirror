Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1631F461
	for <e@80x24.org>; Mon, 15 Jul 2019 12:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfGOMIN (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 08:08:13 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:42306 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfGOMIN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 08:08:13 -0400
Received: by mail-lf1-f42.google.com with SMTP id s19so10819968lfb.9
        for <git@vger.kernel.org>; Mon, 15 Jul 2019 05:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CnMy+Mt6Uu/PBL2idydmlAIDimEl+rf4hRP5A1SeQuw=;
        b=vYR45Oydl32bteCgWXfZP3yB91y0N3ry/hLHK7Q69vxs9FrmSc5WHP+UijASxc9kc4
         EChvfxNRBQtnKbLv+0bWj/YDYsfvTbl1MamxlSPhXGDMpjNTVmwkXnfwy3q2L9jCYDdv
         +ziIzrrziaPKZZCvr/4U+KCbvwDKkAyous49sb8DVPr3iE3oMEnBWGktGVE1VKVQqzcd
         g2Gpa6xa29V0JQSYxJ8WDQDm0za7IjA8xmU6oaCK2KE/QyGwU5XLamWjStRDaP1vulP4
         ttyS5dlpLHLJGnnpUqBm9gKAE8ATnOMKDNc5V4S/5uPnbbj3FTa+Xv+WYHiZ9GZZxQG1
         x93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=CnMy+Mt6Uu/PBL2idydmlAIDimEl+rf4hRP5A1SeQuw=;
        b=eRfZ1fp4LSr36++4tKCRTXOAUpP1GA1WGzFQcNmDP4Fexj9KvCmD3d1kZ4nZAxyUPy
         ZedqywRMpnLNwwqrFsiJ8UBmWrWHK8eWA/cXl05gBCNAAYgoVi1POzeHz9NbK99QB95b
         ePCFDl9//9dWsfKrtXZpir6XeUIh60HYOrX1bsJPrBef7aVVVYvaSr+Gxiw9vFRTEhEC
         JjHaX3Ax1hGQ2LY7xzDiQm9w0bqcRFWfjWG2cGMMKh2PICj2BNrXklWHHwwMykiS+oZ4
         C/0rypOu/0IbjdzPlxKry3ueLurv8j/PFjipxVLLI0cP3l1N4+sjnpD7gv4h1g6P/VBr
         y6sw==
X-Gm-Message-State: APjAAAWiiELQ49ARhN+IsNR5s0GdgYY8mXkpwvA3kr3k02K6TspdC+jc
        81s0KrttVvlitDeGDc/PfLg=
X-Google-Smtp-Source: APXvYqzlQQHcnn4Vgs26JgRIWxCU7QsoGifATUzT0WWLzkZi+yn0/WG71vcY035R8iwrhT6hnastwQ==
X-Received: by 2002:a19:80c4:: with SMTP id b187mr10937974lfd.122.1563192490392;
        Mon, 15 Jul 2019 05:08:10 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 24sm3463794ljs.63.2019.07.15.05.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 05:08:09 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bryan Turner <bturner@atlassian.com>, usbuser@mailbox.org
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
References: <87blxz9xbh.fsf@osv.gnss.ru>
        <20190712162450.21898-1-newren@gmail.com>
Date:   Mon, 15 Jul 2019 15:08:08 +0300
In-Reply-To: <20190712162450.21898-1-newren@gmail.com> (Elijah Newren's
        message of "Fri, 12 Jul 2019 09:24:50 -0700")
Message-ID: <87zhlfzejb.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Jul 12, 2019 at 6:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> That said, even if we rather all do agree rebase workflow is always
>> inferior to merge one, is it satisfactory excuse to actively resist
>> otherwise logical behavior of 'git merge' that is even documented? I
>> don't think so.
>>
>> Thus, one way or another, I'd still vote for keeping options description
>> intact, and rather fix the implementation to match the manual, i.e.,
>> make the --[no]-ff actually orthogonal to --ff-only.
>
> This seems like it's asking for trouble.  --ff-only and --no-ff,
> ignoring any knowledge of what they do, are contradictory by their
> names.

I agree --ff-only is not the best name for what I have in mind. However,
it's not the best name for actual behavior either, as for this case
[--ff|--no-ff|--only-ff], or even '--ff=[prefer|never|only]' would look
more consistent.

> Attempting to explain to users that they are not opposites but
> can be used together compatibly sounds very problematic to me.

For me current documentation would be clear enough, provided the options
would indeed behave the way they are described. Unfortunately (for me),
they don't behave that way, and it looks like they never will.

> But let me dig a little deeper into your statement of "resisting
> otherwise logical behavior of 'git merge" that is even documented."
> Going back to when the --ff-only option was introduced:
>
> commit 134748353b2a71a34f899c9b1326ccf7ae082412
> Author: Björn Gustavsson <bgustavsson@gmail.com>
> Date:   Thu Oct 29 23:08:31 2009 +0100
>
>     Teach 'git merge' and 'git pull' the option --ff-only
>
>     For convenience in scripts and aliases, add the option
>     --ff-only to only allow fast-forwards (and up-to-date,
>     despite the name).
>
>     Disallow combining --ff-only and --no-ff, since they
>     flatly contradict each other.
>
> We see that the original author even stated pretty clearly and
> strongly that these were polar opposite options.  Our description
> today of --ff-only is the same one he introduced in that patch, and I
> always read the description the same way I think he did: that it
> implied a polar opposite of --no-ff.

OK, so it was at the very beginning where opportunity for better design
has been missed.

> You and Bryan came along and
> pointed out that the description was actually ambiguous and could be
> interpreted a different way...and I then had to re-read the text a
> time or two after you pointed it out to see the alternate reading.  I
> totally admit that the wording is apparently ambiguous and can be read
> the way you have, but I don't at all see that as a reason to keep the
> documentation as-is.  Either it should be clarified to rule out what
> you and usbuser wanted and perhaps misunderstood it to do, or if the
> behavior is changed then it should be clarified so that folks like me
> don't read it to behave as it has since Björn added it.
>
> Personally, I think that if new functionality is wanted, it should
> definitely go in a different flag (perhaps someone can find something
> shorter than --no-ff-and-only-if-ff-is-possible).  But I think Junio
> makes a pretty good argument to be leery of such a new option, and
> Brian points out how to easily get this behavior by just stringing
> together a merge-base command with merge --no-ff.

My argument was *not* that we absolutely must have this functionality,
it was rather that if we had made '--ff-only' option orthogonal (that is
a good thing in general by itself), this functionality would come almost
for free. No documentation change then. However, now I see that such
change at this point will change behavior of certain combinations of
options in incompatible manner, and so is not a good way to go.

BTW, I did suggest a new option for this functionality once, Junio being
in opposition then as well, arguing that it looks like adding a feature
just for the sake of having a feature. At that time I found 'git merge'
happily takes both '--no-ff --ff-only', and made a mistake of assuming,
after re-reading the manual, that it in fact does what is documented, so
I dropped the issue of adding a new option then.

> That's just my $0.02, but since this is the second time in the thread
> that I've suggested improving the documentation, here's a patch to do
> so:
>
> -- 8< --
> Subject: [PATCH] merge-options.txt: clarify meaning of various ff-related
>  options
>
> As discovered on the mailing list, some of the descriptions of the
> ff-related options were unclear.  Try to be more precise with what these
> options do.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/merge-options.txt | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 79a00d2a4a..e888c99d48 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -40,20 +40,21 @@ set to `no` at the beginning of them.
>  	case of a merge conflict.
>
>  --ff::
> -	When the merge resolves as a fast-forward, only update the branch
> -	pointer, without creating a merge commit.  This is the default
> -	behavior.
> +	When the merge resolves as a fast-forward, only update the
> +	branch pointer (without creating a merge commit).  When a fast
> +	forward update is not possible, create a merge commit.  This is
> +	the default behavior.

A side note: except it is *not* the default "when merging an
annotated...", described below.

>
>  --no-ff::
> -	Create a merge commit even when the merge resolves as a
> -	fast-forward.  This is the default behaviour when merging an
> -	annotated (and possibly signed) tag that is not stored in
> -	its natural place in 'refs/tags/' hierarchy.
> +	Create a merge commit even when the merge could instead resolve
> +	as a fast-forward.  This is the default behaviour when merging
> +	an annotated (and possibly signed) tag that is not stored in its
> +	natural place in 'refs/tags/' hierarchy.
>
>  --ff-only::
> -	Refuse to merge and exit with a non-zero status unless the
> -	current `HEAD` is already up to date or the merge can be
> -	resolved as a fast-forward.
> +	When possible, resolve the merge as a fast-forward (do not
> +	create a merge commit).  When not possible, refuse to merge and
> +	exit with a non-zero status.

Yeah, this resolves uncertainty.

However, I think it'd be better to format it after other similar cases,
to make it explicit these options are 3-way choice. I mean something
like this:

--ff::
--no-ff::
--ff-only::
	When the merge resolves as a fast-forward, only update the
	branch pointer (without creating a merge commit).  When a fast
	forward update is not possible, create a merge commit.  This is
	the default behavior, unless merging an annotated (and possibly
	signed) tag that is not stored in its natural place in
	'refs/tags/' hierarchy, in which case --no-ff is assumed.
+
With --no-ff create a merge commit even when the merge could instead
resolve as a fast-forward.
+
With --ff-only resolve the merge as a fast-forward (never create a merge
commit). When fast-forward is not possible, refuse to merge and exit
with non-zero status.


-- Sergey
