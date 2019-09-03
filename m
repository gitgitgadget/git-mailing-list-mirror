Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD131F461
	for <e@80x24.org>; Tue,  3 Sep 2019 08:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfICIxK (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 04:53:10 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44893 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfICIxK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 04:53:10 -0400
Received: by mail-vk1-f195.google.com with SMTP id 82so3388842vkf.11
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/HrCn4Z8fCqhnUouveW2GPaUQbwNNoQx5DS/Ylo6pM=;
        b=chcf8ZFhtlZH3TCv+n/P1nrdTRvfs7XEOaDbAS2q7PQ1MqEU13yfBUdy7oDNPkZHCW
         0CjFaJumytKGK8DOCDoppjfCIoVeju1yWF+BO3dnDm2tkWeEMixOPrqaxlrZcV4oR7ne
         ByW/GvtYPiDBolgTOb/8k/DxjdMj/eA39HH1Lr3va75gTYi5dffvJlH9NsMot/9UOscm
         q6GdcsgwVGTyYGxUwWu6r7TQQnZnnZQdhbTaChgR7byZxwaRra9sa1+cJAXSjw7PoGfG
         QJRAf25k3RfZKKX2xovi5EoaQlu0TZxO4VdfTWR4nD+rYnxTjh/Orb0FBmsdW62txPWR
         69hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/HrCn4Z8fCqhnUouveW2GPaUQbwNNoQx5DS/Ylo6pM=;
        b=q0N1zUI+FX8h28e98ULE3uxpT43bYmM3iebo4topwmPJNQoP8mlqC8WFNPzAdOB6vN
         2aek8FCcx1utO1KZ6wjO8y9uGRf/KzyI3suZ+6vEv9jAQ7BslPECZYizNKELhWKoFTN4
         n4j65In9gdlQGJSFWjP4agFGrUXaRZ/qRfqLdpVrBhnx1ocy2BLfgb16IYU57irszy78
         nrnwGPFvaE8EKWsrlrq8cLp1jhmXly8cqtyk4xWCew2JiNYhN2IZgS34He8ZfDu+RDXn
         vXEGWSDvfzo5DMkR2WfiGHJDCIHxW20QNCACbKn6qBg7gQiHxsVaaZTOf7tY3ma+gHX7
         YIsg==
X-Gm-Message-State: APjAAAXoc1jKLsbbuy1dM47QP2xRQdHarWjpQ0UdQBVwjL0VMe3fXYWP
        +N9cQweJdC1+S1BOa8vWlwNmxV+Py6rQ1UzRCo4=
X-Google-Smtp-Source: APXvYqylQPPBPBIQK0qm4upTqALZwXNCxtc0HCsl0Z/uDg1XWOyV5YKEjvwmX0TqcRP++MoIKjas49AhIz4ayK5QqAI=
X-Received: by 2002:ac5:cdfb:: with SMTP id v27mr9304450vkn.45.1567500789491;
 Tue, 03 Sep 2019 01:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <20190902195618.3820-1-birger.sp@gmail.com>
In-Reply-To: <20190902195618.3820-1-birger.sp@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 3 Sep 2019 10:52:58 +0200
Message-ID: <CAKPyHN0tFzRDYFkjwTDi6MvN3DmzDRNH6V0Y5Ay1U6K2T-H6sA@mail.gmail.com>
Subject: Re: [PATCH] Add hotkey to toggle "Amend Last Commit" radio selector
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        David <bouncingcats@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Birger,

On Mon, Sep 2, 2019 at 9:56 PM Birger Skogeng Pedersen
<birger.sp@gmail.com> wrote:
>
> Selecting whether to do a "New Commit" or "Amend Last Commit" does not have
> a hotkey.
>
> With this patch, the user may toggle between the two options with
> CTRL/CMD+e.

David A. (in Cc from git-cola) suggested, that we try to re-use
existing key bindings in Git GUIs. Here is Git-Cola hotkeys:

http://git-cola.github.io/share/doc/git-cola/hotkeys.html

and this indicates, that it already uses CTRL+m for "amend". Though
I'm unsure if this is a toggle like in git-gui or a one-shot. David
A., can you please clarify?

>
> Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> ---
>  git-gui.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 5bc21b8..14be1e0 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2640,6 +2640,16 @@ proc show_less_context {} {
>         }
>  }
>
> +proc toggle_commit_type {} {
> +       global selected_commit_type
> +       if {[string match amend* $selected_commit_type]} {
> +               set selected_commit_type new
> +       } else {
> +               set selected_commit_type amend
> +       }
> +       do_select_commit_type
> +}
> +
>  ######################################################################
>  ##
>  ## ui construction
> @@ -3843,6 +3853,7 @@ bind .   <$M1B-Key-equal> {show_more_context;break}
>  bind .   <$M1B-Key-plus> {show_more_context;break}
>  bind .   <$M1B-Key-KP_Add> {show_more_context;break}
>  bind .   <$M1B-Key-Return> do_commit
> +bind .   <$M1B-Key-e> toggle_commit_type

The commit type has also a two toggle menu entries (under "Commit")
they should now also indicate the key binding.
disable

Though how to express a toggle keybinding in the menu? I don't know if
you can assign the same keybinding to the same menu entry. Maybe we
need to add/remove the keybinding depending on the current mode.

Bert

>  foreach i [list $ui_index $ui_workdir] {
>         bind $i <Button-1>       { toggle_or_diff click %W %x %y; break }
>         bind $i <$M1B-Button-1>  { add_one_to_selection %W %x %y; break }
> --
> 2.21.0.windows.1
>
