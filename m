Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C611F461
	for <e@80x24.org>; Mon,  2 Sep 2019 18:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfIBSfU (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 14:35:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35918 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfIBSfU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 14:35:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id u15so13683427ljl.3
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJZCwXi0Z+At+DPl64jRGAy62r+eiGYAwLKgBBvA9DQ=;
        b=nCnChGw2dyO6lEsRt8rwxOkZ2AagtxfKOHEZ/jakexKJu6Zm/MfXMW1LpdE3d6VNSg
         d5i8UoOaGAVixsM2rOdWqiwINxs6MMoF0KRvt7WRvuqJ/MyIY21es8MlIv/Qd9tn5cb3
         lu4HeYdgt7CSOCkDa4b4s3jbvqD9fqWdIM26N5yuDg5vaThfzGjt91paFHFcxrYwUVgF
         WbWlsJtmbmPEDnCE+qURpryS0720jWM6fptc9/o5IXmaTrq2+R7E9caOdxGrMy167RyR
         G7v1c6bOAU0XN/ungOtFl6ixvd+HDmEa3O0u76A64IoIWKrtKs+muWSqCKzSR9YKBab7
         sDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJZCwXi0Z+At+DPl64jRGAy62r+eiGYAwLKgBBvA9DQ=;
        b=oTiXht0PCl+wRAKwNZGhlDXlEsA+fT8+TirJXE7WqNJ3oPphuOqNryFYgkop60oWSs
         kdXEYwtmErWhMt4unqi++O0aEWAJHpDBQxj30vR3YjPbHbhKlmX8yy8ZFl91Ovw6Qxcw
         xpQNNUpRN1lD4mMmxPu0uJrDOvX/JZRx+W55rHdPfss+cpZdDbONQ1zNaOIPo+xZ0Ww+
         UfUbFW6NbT3ei/5tRmwwSgXJYCOPmk8kwlJ3Jx6yeMi6zWthZ2oQ7UL+vpi0mxOb50Bt
         ne45zR9bsD3D1rWW2R7/PVgNTohHxIYxx9Vyix+Uzt+Sir7nyjVYLwhfu1xHCh52mC6Z
         /WlA==
X-Gm-Message-State: APjAAAXpVkKBsVx08bo1qUclEuI3PJ+9e+Hdat1IvOqHveJYD199V8Cl
        vOx2FER5jziMYmyG9R2bV58VKNtGqwoRSGBS+oheTYdSDzGEZw==
X-Google-Smtp-Source: APXvYqwfXfqkZxIg3Mv7fHM3P2m/iljmyH934psZ7eyddgo9vKRZBRsVw/8kpLABjvdvgczArim2eprZQj4hNfGDK5g=
X-Received: by 2002:a05:651c:1023:: with SMTP id w3mr16246550ljm.94.1567449317852;
 Mon, 02 Sep 2019 11:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPyHN2_CpaJahKo2Ju2SWvU=Y79k2ArKVkkxPTbeW1t2TYRZQ@mail.gmail.com>
 <20190901193652.21086-1-birger.sp@gmail.com> <20190902181954.zcxuyqrdzs3dzjtq@yadavpratyush.com>
In-Reply-To: <20190902181954.zcxuyqrdzs3dzjtq@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 2 Sep 2019 20:35:07 +0200
Message-ID: <CAGr--=L64jiE=x_McdfWJuQTz1Qo3wp0nc8xaeKBGe0GgW5Kxg@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] git-gui: Add hotkeys to set widget focus
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 2, 2019 at 8:19 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> You missed removing this extra blank line. Will fix it up locally.
>
> > +             set _index $file_lists_last_clicked($widget)
> [snip]


To be honest I felt the blank line there was appropriate, in an
attempt to follow the same code style as the rest of the git-gui.sh.
For instance, the "add_range_to_selection" function
(https://github.com/prati0100/git-gui/blob/master/git-gui.sh#L2601-L2625)
has blank lines like this;


proc add_range_to_selection {w x y} {
    global file_lists last_clicked selected_paths

    if {[lindex $last_clicked 0] ne $w} {
        toggle_or_diff click $w $x $y
        return
    }

    set lno [lindex [split [$w index @$x,$y] .] 0]
    set lc [lindex $last_clicked 1]
    if {$lc < $lno} {
        set begin $lc
        set end $lno
    } else {
        set begin $lno
        set end $lc
    }

    foreach path [lrange $file_lists($w) \
        [expr {$begin - 1}] \
        [expr {$end - 1}]] {
        set selected_paths($path) 1
    }
    $w tag add in_sel $begin.0 [expr {$end + 1}].0
}


Not saying the blank line should defintely be there, I'm just saying
my reasoning for keeping it there in the first place :-)


Birger
