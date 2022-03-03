Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D259C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 21:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiCCVaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 16:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCCVae (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 16:30:34 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA12166E12
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 13:29:48 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id k9so3391816vki.4
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 13:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fc4C6AOPOjphmw9Nye/LUvLCXaA+4VpZGSEm6wOahpQ=;
        b=HGD3UykXNYFV8Ejd02zWQyL07d45r1gajrQCNdsOexpPBR0RWKDwI6GVcOpUbBASI4
         W58w8wzmivIucC272ZUMPPuaQeZeGAEyuR7VKN6jpMTLkvmNmt6XVytmSdCERqvk/MJi
         LsBbFgxo8BBS0TDOUhi1CkLlWj0+skf3vOYFf7TuMNhIB2E/IOi57I5M4YzYZcaOI3oJ
         ZRsxzynYye8Od2J//EbplEVajDLAvwugajSMYLROLRVSOo5/wLtMvHiq8rADTtUqQeXp
         nnAVDP9VN270YfpQWEHGGm1o6zw9rDv8EH0bXGe+VM3VEaDNgYU436rDioES3F6/N+rb
         DLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fc4C6AOPOjphmw9Nye/LUvLCXaA+4VpZGSEm6wOahpQ=;
        b=IfqVAgmE3KE2g4+y4heBfa9ahOXSDozZYsYw+UP7hdFpQnYrosWnm/5dVXGlqzrXtA
         na5gKFIQpppZA0ZwhLSDYeGjwznZ0ya7wR7nthxzwSbqjmEhtiXhP5cRHgny2iJnlgJN
         yNQEGUdlWESCdkhAhWmB3WQopo5SQuD0BgFGtjvge7f2sepQYZ/DoastNg4v39LJEPGq
         fIeyISlLlMDrsyNEno+JxW2a0L0FhtUcwyd/5+4Xx8uQlYc+grOUFdlSMmfdcEzhaD9L
         yiIzevQHcXMt0OsB4DzX8Srmzr2b8Wznff7Ljr2GzCUhLaBxJTfYWgijj3Njx0nzayLh
         LMmA==
X-Gm-Message-State: AOAM532LxElxOEFhGG2J2leq1hQ3T5ajbQRDgMOUHeQ3HTkOJB4pIQ2h
        dkA+6y9d73KG2xLf1+niunh6UjKVx2/K8joTplw=
X-Google-Smtp-Source: ABdhPJwdhaLndUNKbMNMrXeZEBhEm6vheBsRUvLQz8UqehxURNSpgUnfsOKOXEsA02aoh79wx3UO/ueK5g5K1rPiN5o=
X-Received: by 2002:a05:6122:17a6:b0:32d:9ed1:eccd with SMTP id
 o38-20020a05612217a600b0032d9ed1eccdmr16046028vkf.9.1646342987661; Thu, 03
 Mar 2022 13:29:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.1219.git.git.1645386173.gitgitgadget@gmail.com>
In-Reply-To: <pull.1219.git.git.1645386173.gitgitgadget@gmail.com>
From:   Halil SEN <halilsen@gmail.com>
Date:   Thu, 3 Mar 2022 22:29:35 +0100
Message-ID: <CAOeUTushdpiVAADjE8NQ_-EgHpz5sHKErBjW8-8O23foVnK5cA@mail.gmail.com>
Subject: Re: [PREVIEW 0/2] gitk: include y coord in recorded sash position
To:     Halil Sen via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Long time user, first time contributor here.

I submitted this patch for this little bug and
I am afraid that it fell in the cracks.
Not sure what my best course of action is.
I would appreciate your feedback.

Even though little, not being able to resize
a window section is certainly a daily annoyance.

Best
Halil Sen
