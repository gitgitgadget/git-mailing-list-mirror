Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C634AC433ED
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 02:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981D561369
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 02:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhDDCNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 22:13:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62969 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbhDDCNN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 22:13:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 195F110CECD;
        Sat,  3 Apr 2021 22:13:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tD2D5IgcaKnBN7JXIZ3BCMz6Xq4=; b=TRYXnu
        Ig6fpRjyXAmKTVqKU5azzXkParp6fnw+GOSkejxVDRY9X87jmqbMbOGfxiDSpZqk
        IVg7b3rKf5TVHU4jV7mB4zgvcHJkUF7j/Kx/LqieFlospTyulV1RqImJxDCP9o+P
        5Bmv0kPh8dAGFR/TnVgx1DGrCHbTFU9yGN8EY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kLY5FmfPOXM5O/izsyxCkJ4j2UpaHdZV
        VW547yXQTfW+QGUG5avuUQWWcZJsq7iLKNJMtmf7JJy0FVblDIw3l9XpLIHEYnXM
        gvQAeZRjcgYMlyC/wUphpO9VwAzcC5Up/0GAmkPGdR8/gd/LhncGcw6v0Avst0HO
        MURDztdomUg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1274F10CECC;
        Sat,  3 Apr 2021 22:13:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4B12410CECB;
        Sat,  3 Apr 2021 22:13:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "gh acct via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gh acct <tony@viulogix.com>
Subject: Re: [PATCH] gitk: fix selection color not persistent
References: <pull.926.git.1617391375445.gitgitgadget@gmail.com>
Date:   Sat, 03 Apr 2021 19:13:05 -0700
In-Reply-To: <pull.926.git.1617391375445.gitgitgadget@gmail.com> (gh acct via
        GitGitGadget's message of "Fri, 02 Apr 2021 19:22:54 +0000")
Message-ID: <xmqqim52ztji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BB39314-94EB-11EB-BB24-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"gh acct via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ghacct <tony@viulogix.com>
>
> Dear git community,
> Is it possible please for the gitk selection color setting to be persistent?  Since 2015 this has been working for me.
> Thank you for considering!
>
> Signed-off-by: tgomez <tgomez@usa.wtbts.net>
> Signed-off-by: ghacct <tony@viulogix.com>

cf. Documentation/SubmittingPatches
[[describe-changes]]
[[summary-section]]
[[meaningful-message]]
[[imperative-mood]]
[[sign-off]]
[[real-name]]

Also 'gitk' patches should be based on Paul's tree, not mine.
cf.  "Subsystems with dedicated maintainers" section in
Documentation/SubmittingPatches

So the diff should look more like 

	diff --git a/gitk b/gitk
	index ...
	--- a/gitk
	+++ b/gitk
	@@ ...

As to the contents of the patch itself, I am not the best person to
comment on.  I no longer use gitk myself unless I am testing gitk,
and I no longer speak Tcl/Tk.

Having said that, I see no existing instance of -selectforeground so
in the absense of somebody who is better versed in Tk, I'd be wary
of this change.  I, however, see that

    text some-widget \
    -background $bgcolor -foreground $fgcolor -selectbackground $selectbgcolor

is a recurring theme for other text widgets like $cflist and
$top.list, so if the change were only to add the missing
"-selectbackground $selectbgcolor" there, I would imagine it would
be a safe improvement (or adding the "-selectforeground $fgcolor" to
other text widgets that currently lack might turn out to be a sensible
change, too, but as I said, I do not speak Tcl/Tk).


>  gitk-git/gitk | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 23d9dd1fe0d0..d255654b02fd 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2412,6 +2412,7 @@ proc makewindow {} {
>      text $ctext -background $bgcolor -foreground $fgcolor \
>          -state disabled -undo 0 -font textfont \
>          -yscrollcommand scrolltext -wrap none \
> +        -selectbackground $selectbgcolor -selectforeground $fgcolor \
>          -xscrollcommand ".bleft.bottom.sbhorizontal set"
>      if {$have_tk85} {
>          $ctext conf -tabstyle wordprocessor
>
> base-commit: a65ce7f831aa5fcc596c6d23fcde543d98b39bd7
