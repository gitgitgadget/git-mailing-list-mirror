Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42528200B9
	for <e@80x24.org>; Tue,  8 May 2018 17:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeEHRHc (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 13:07:32 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38855 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeEHRHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 13:07:31 -0400
Received: by mail-yw0-f193.google.com with SMTP id y123-v6so9878284ywa.5
        for <git@vger.kernel.org>; Tue, 08 May 2018 10:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gEsqKHN02CawHPBdhjjxvhT1qYFjVqyxw9mPosMnBYY=;
        b=Kq9dFkhzKVmCfE7qX/ExF84bppMVjZxySnIFvMdw6W/m7Vf+KMgKVZfAynTHrSD3WQ
         6xV521YjM9bB86lfT+ajmWhLagjUXwSKHw7fuJmdgMbleleozMQyOKkVejosVN+pat+L
         7pwDL6MfwsS8sS+iSSSNyxXUrteASST9SjPlEVqjkE9fV4DaMdYNSUAS0e9//AARm1rZ
         d6+Imq/nVLDBkbldfiD0eJxW2rLqW+j6cyEA4rfXeo6XW4tppB0jTuCxA8nJFZ2BNyCe
         VrGaVnl7ohSEqCP3HE2X1U9To82ktpz/zFU2fC6lbDBnwuQccZQ/GFPJeb2hI4DAwFVB
         zwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gEsqKHN02CawHPBdhjjxvhT1qYFjVqyxw9mPosMnBYY=;
        b=NTsnUZU8pqBnW3feJL/vge0FtKK/uboM5btSyCrK9UW9TXE4IPZ/m43nTV50wu7u8/
         Qgz2e7mE5nRfVBiyroWq+K3V7+pf91zDOP2/t9xnyb5kUqfApu8wXgMEckQYMwB4n8nW
         hXRzD4Vpcp5vWebFFB9RIOinMQ6za7HW3xjysCCu8fj9FtZN+qaKIZVmlS/lJD/CcZLH
         LdCTLVSczvceNKDtTjyOCBg3eYBhHEJf7OOGnwxj8uIh+6SMT3wuVQhn19KePQ8ET2tB
         nD3RcPgBNTqT82MAdW9PIDZRB5hQ66AYAlIkcUdCVZgyFUNoFYM7Jjc4cly2C/sNrBzT
         0Fvg==
X-Gm-Message-State: ALQs6tC8P5NxbF0B39waiUq0WGUtzR9UFTzWJLM80luNj8Bu07aqYWMw
        MBe2Z6WuCkZtL2BsI5k6OSX/vtkIFAFGIHU71xaJGA==
X-Google-Smtp-Source: AB8JxZqrQnANISMO1O8ZdMAS0rLJfbXG8+E+WS1FLgpBU7zx1LaP/88l/SxFLXCMCGRoeSmiVAGA1NvrEaCbewXjDIE=
X-Received: by 2002:a0d:fd84:: with SMTP id n126-v6mr22601069ywf.33.1525799250216;
 Tue, 08 May 2018 10:07:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 8 May 2018 10:07:29 -0700 (PDT)
In-Reply-To: <20180508122229.k3n3ccpa5g3g4dxa@pflmari>
References: <20180508121104.rtsrektxiihvpqtx@pflmari> <20180508122229.k3n3ccpa5g3g4dxa@pflmari>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 8 May 2018 10:07:29 -0700
Message-ID: <CAGZ79kYxZ43kJwS_odhNwCO2e_n-8JLNynAZj0+Hp3ugzYbqUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gitk: show part of submodule log instead of empty
 pane when listing trees
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 5:22 AM, Alex Riesen
<alexander.riesen@cetitec.com> wrote:
> From: Alex Riesen <raa.lkml@gmail.com>
>
> Currently, the submodules either are not shown at all (if listing a
> committed tree) or a Tcl error appears (when clicking on a submodule
> from the index list).

I do not understand where this appears, yet.
Where do I have to click to see the effects of this patch?

>
> This will make it show first arbitrarily chosen number of commits,
> which might be only marginally better.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>  gitk | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
>
> diff --git a/gitk b/gitk
> index a14d7a1..d34833f 100755
> --- a/gitk
> +++ b/gitk
> @@ -7627,9 +7627,10 @@ proc gettreeline {gtf id} {
>             if {$i < 0} continue
>             set fname [string range $line [expr {$i+1}] end]
>             set line [string range $line 0 [expr {$i-1}]]
> -           if {$diffids ne $nullid2 && [lindex $line 1] ne "blob"} continue
> +           set objtype [lindex $line 1]
> +           if {$diffids ne $nullid2 && $objtype ne "blob" && $objtype ne "commit" } { continue }
>             set sha1 [lindex $line 2]
> -           lappend treeidlist($id) $sha1
> +           lappend treeidlist($id) "$sha1 $objtype"
>         }
>         if {[string index $fname 0] eq "\""} {
>             set fname [lindex $fname 0]
> @@ -7659,21 +7660,42 @@ proc showfile {f} {
>      global ctext_file_names ctext_file_lines
>      global ctext commentend
>
> +    set submodlog "git\\ log\\ --format='%h\\ %aN:\\ %s'\\ -100"

Do we want to respect the config option diff.submodule here?
The -100 is chosen rather arbitrarily. Ideally we'd only walk to the
previous entry?

> +    set fcmt ""
>      set i [lsearch -exact $treefilelist($diffids) $f]
>      if {$i < 0} {
>         puts "oops, $f not in list for id $diffids"
>         return
>      }
>      if {$diffids eq $nullid} {
> -       if {[catch {set bf [open $f r]} err]} {
> -           puts "oops, can't read $f: $err"
> -           return
> +       if {[file isdirectory $f]} {
> +           # a submodule
> +           if {[catch {set bf [open "| sh -c cd\\ \"$f\"&&$submodlog" r]} err]} {

Can we have $submodlog use the "git -C <path> command"
option, then we could save the "cd &&" part, which might even
save us from spawning a shell?

Thanks,
Stefan
