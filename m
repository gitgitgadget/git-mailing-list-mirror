Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21ADC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 16:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhLUQOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 11:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhLUQOo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 11:14:44 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63335C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 08:14:44 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id kj16so8879659qvb.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 08:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMOn1it1Joe4mFGhYTrR9xNPeJ8vQIemH3EpnCVgFME=;
        b=CfPOD69NcX0pKsXHWD7tHnG9vyUUy0ZVdiMG9VtKB7hFw07v66QTLxbEzs5c45xoVh
         VXKRU4vhSqjPrMvf4OFCuYUJsJlXJwtDrvFLYWEFMKLN+7HXxMj9+WbnvXRJu4hZCknI
         nACeMRX5CiKTF3+99MgHITudxIJwgUMrX38R7g699XZXw10arI0gD+SkkpklaVC+CMiQ
         FSeY59DMsrbuiDXir/nuOcFZPAWGHCehoRw9wg5KLAcD2cH9XgQ/JYbMaiMH8Q1FnG4o
         iNKtE8OMkJQ5tTn1oa0LC42Dy72kmJrpfCB7Mwnxv2vNBuFYDoLGtGerbDIgvgVSYEmg
         kSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMOn1it1Joe4mFGhYTrR9xNPeJ8vQIemH3EpnCVgFME=;
        b=XywBD6fV0pmnTX+WE1XLTmo7EDVnQnL/VALTttMhllPRER0CZVDsLUctGecmjhrv99
         T5Vr2jAw+rwSqqKzw/mB95+5KZcbKQUEi5d8IqiGGoJ8SKiYPbVbB4F+FZ0vroQ/pGqx
         tDluP0Zs7V0HNyDhe1LVGmKTOtQriQsJBReixiYmLuGl9m841srYKyXoTmD4m3xAHmG3
         Ad0BsXRTpy2rjZZSWRm0ptiadhyAoO/DrJzuDozpF9Ap2E7oAAj+om/8vZpZz21Ovi6q
         BSSSoTYb5IZ1/U7/zxkpj4FsxDr3qIvSDa2ZvsBi9VK8QNat+uzWE3PNWSRnXHdXPW6s
         VynA==
X-Gm-Message-State: AOAM532lJ9TDJ+ptsh+ADEEguNjiPJHlsMoskLXePQBFimUZiP4+6Fos
        e3dNQDksVcz+HTyHf7y+q24dfsKrcN8HGGG0nt4=
X-Google-Smtp-Source: ABdhPJxl6TdFfOgkqVD6RgFoz4eg5TVPMFmIkrBccUiR/PojKPuXdfH6EdTs6mZ/S5xfL7/4kaExXCcwjzZ67UrvrWI=
X-Received: by 2002:a05:6214:2308:: with SMTP id gc8mr3173041qvb.12.1640103283562;
 Tue, 21 Dec 2021 08:14:43 -0800 (PST)
MIME-Version: 1.0
References: <CAGr--=JiCv3XTrxP=foy+FrxbiYeMf=11eG_6kGBFmBr+P-=Jw@mail.gmail.com>
In-Reply-To: <CAGr--=JiCv3XTrxP=foy+FrxbiYeMf=11eG_6kGBFmBr+P-=Jw@mail.gmail.com>
From:   Sashank Bandi <bandi.rao999@gmail.com>
Date:   Tue, 21 Dec 2021 21:44:39 +0530
Message-ID: <CABkJDHF6gS+j6LmT0hr2Z23izb0uBj7cs+XU_14O8wB8yTEpZw@mail.gmail.com>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Here is the preview I said: https://pasteboard.co/rwUBvWbX6m66.png .
> > The checkbox needs some tinkering.
> > Looking forward to any suggestions.
>
> I would really appreciate it if you could help me make my git-gui look
> like this. What do I need to do, exactly?

It's really good to know that there are people interested in this.
But I am sorry to say that my work on it is temporarily stopped as I
cannot figure out a way to make the top caption bar of a window black
on Windows.
I am trying workarounds in C++ by disabling DWM, but they don't seem to work.
There is a hidden unpublished API in Windows 10 and 11. But I would
like to instead make it work for all OSes starting from Windows 7 at
least.

But, I have the code that will make the screenshot possible.
Simply put:
1. Press Win + R
2. Enter "git-gui.exe --trace" and press Enter
3. Paste the following code(indented for clarity) in the console
window(a white window with red and black text) that appears.
    ttk::style theme use default
    ttk::style configure TFrame -background #333
    ttk::style configure TLabelframe -background #333
    ttk::style configure TLabelframe.Label -background #333 -foreground #fff
    ttk::style configure TPanedwindow  -background #333
    ttk::style configure EntryFrame -background #333
    ttk::style configure TScrollbar -background #666 -troughcolor #444
-arrowcolor #fff -arrowsize 15
    ttk::style map TScrollbar -background \
        [list active #333 disabled #000]
    ttk::style configure TLabel -background #333 -foreground #fff
    ttk::style configure TButton -background #333 -foreground #fff
-borderwidth 2 -bordercolor #fff
    ttk::style map TButton -background \
        [list active #555 disabled #111 readonly #000]
    ttk::style configure TCheckbutton -background #333 -foreground
#fff -indicatorbackground #666 -indicatorcolor #fff
    ttk::style map TCheckbutton -background \
        [list active #555 disabled #111 readonly #000]
    ttk::style configure TEntry -fieldbackground #333 -background #333
-foreground #fff -insertcolor #fff
    ttk::style configure TRadiobutton -background #333 -foreground #fff
    ttk::style map TRadiobutton -background \
        [list active #555 disabled #111 readonly #000]
    option add *TCombobox*Listbox.background #333 interactive
    option add *TCombobox*Listbox.foreground #fff interactive
    option add *TCombobox*Listbox.selectBackground blue interactive
    option add *TCombobox*Listbox.selectForeground #fff interactive
    option add *Listbox.Background #333 interactive
    option add *Listbox.Foreground #fff interactive
    option add *Text.Background #333 interactive
    option add *Text.Foreground #fff interactive
    ttk::style configure TSpinbox -fieldbackground #333 -background
#333 -foreground #fff -insertcolor #fff -arrowcolor #fff
    .vpane.lower.commarea.buffer.frame.t configure -background #0d1117
-foreground #fff -insertbackground #fff
    .vpane.lower.diff.body.t configure -background #0d1117 -foreground #fff
    .vpane.files.workdir.list configure -background #0d1117 -foreground #fff
    .vpane.files.index.list configure -background #0d1117 -foreground #fff
    .about_dialog.git_logo configure -background #333
4. Enjoy Git GUI.

If you get "git-gui.exe: command not found", it implies that the exe
for Git GUI isn't installed in your path. Then you should manually
find the path to the exe(mostly will be in "C:\Program Files\Git\cmd")
and execute it in Win + R prompt as "C:\Program
Files\Git\cmd\git-gui.exe --trace" and then press Enter. Then enter
the code.

The code I provided also changes some of the Tcl/Tk core defaults for
maximum dark mode effect. So, it isn't possible to revert to light
mode on the run. Closing and reopening all the Git GUI windows will
revert it back.
I did not test a location for the persistence of dark mode, I will dig
deeper into the TCL soon.
You should execute the code at the start of the Git GUI for it to work
perfectly.

Preview for
"Create Branch": [0]
"Checkout Branch": [1]
"Options": [2]

[0]: https://pasteboard.co/PVXqzigC1Hvs.png
[1]: https://pasteboard.co/MRjlQ23ldVKO.png
[2]: https://pasteboard.co/HalaJ8Rw1BDU.png
