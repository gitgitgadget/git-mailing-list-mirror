Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6761F576
	for <e@80x24.org>; Fri, 23 Feb 2018 10:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeBWKLu (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 05:11:50 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:41971 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbeBWKLt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 05:11:49 -0500
Received: by mail-ot0-f179.google.com with SMTP id w38so7032875ota.8
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 02:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wZGk1Jgceu+9bK982XnynCCcBk3lL1pT7ySiMUuKxOw=;
        b=lItHkKuhUjx1WMlnRdzQK+PRw/vKbHNTpq46B8KBOzvEIjQ12HPhb247a6ta1o4/iT
         8h3Qxlxmlc/hCSLFOnY9u5roNf9SswOgwFsttFQkTeGhW4CKsh1KnATlI3MfXVfFMVZg
         ZEtbEf/s+VQ4Epxlt+XyCFrqaLafjIszxAWe0n3xtfJMB1gz66gjvC2FIhUSYx8tDaBS
         oFu+evTnU4W4Ag0DXzLGrXFGpwen+b0ZOeFjQNf7IdZ77CwwUUcuXXZ2BTyk5UG5ShcF
         dNuMSuveqrvGAFiBdDAxe5XuFpfDyacSikRGj+5ITZpFITRRWtOwYcyLaNmmuflJBEXj
         IJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wZGk1Jgceu+9bK982XnynCCcBk3lL1pT7ySiMUuKxOw=;
        b=H5m2lvw/RJWDdwhfrNbu5OQ7X4wnTMgJUbL71Ww87dXEPFLlQv4VgLKhrr1Uu3VBLO
         V77va7cJsrFqazO2v037/X1OvkhdoNkAKqDR6O+CJ4DsPsG++bSA5/eC888A9jWDtq1x
         872tFHzLZEhnlLgz2j+fWi+AMCAGTuvgCPAVKW5ood+UOD6pUyBSTu1vItVlCyepxa+1
         ejYxeyEo457BvDcJvg4HNuWNwytcpEF95+My3hDerOAYXLc0Sk3KDVuTi1MBP6jy6l4f
         fRY8fuWpUZxw4tP5bswdJXhiIIAzBBBJXKo+44Gd3dKUqE/yQg4KD5L1O2gj6K5/MweV
         /hEw==
X-Gm-Message-State: APf1xPCgHbCRiMkhNDjY0aFeSMiTPV+HOG8hOpVKpxS+ZEzkQv5G/i71
        YQv8DAVl4VSBKQyvxd8jKaY4k0IoSEd1TE0fqJc=
X-Google-Smtp-Source: AG47ELvu/QulMfz4hwfZG6CosG1npKjGb7D2eeKonkCHXttgvYPPEEJsUx0IuTxtM9qMa2FE28+kuYO70UV+79H4u8w=
X-Received: by 10.157.67.42 with SMTP id s39mr724344ote.14.1519380709324; Fri,
 23 Feb 2018 02:11:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 23 Feb 2018 02:11:18 -0800 (PST)
In-Reply-To: <87606pf8kg.fsf@evledraar.gmail.com>
References: <20180214101019.gaenosifgq3wx2nm@NUC.localdomain>
 <20180214105149.28896-1-pclouds@gmail.com> <87wozffavp.fsf@evledraar.gmail.com>
 <CACsJy8BsUsT6iO9_68+rHnZG5B-tcaXZAXR88nh8DgR65zvVKw@mail.gmail.com> <87606pf8kg.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 23 Feb 2018 17:11:18 +0700
Message-ID: <CACsJy8BqWVh0VY5Ydqez_Kqc-UwWk7YRuJWCUpYhkBU80rKe7w@mail.gmail.com>
Subject: Re: [PATCH 1/2] parse-options: expand $HOME on filename options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, doron.behar@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 8:38 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Ah I see, so you're doing "git init --template=3D~/<TAB>".
>
> ...
>
> I wonder if the consistency with the tab completion wouldn't be better
> done by teaching the tab completion to just expand --template=3D~/<TAB> t=
o
> e.g. --template=3D/home/duy/.
>
> On my (Debian) system doing e.g.:
>
>     echo $HOME/bin/<TAB>
>
> Will expand to:
>
>     echo /home/avar/bin/
>
> Maybe we could intercept that in the completion and ~ to the value of
> $HOME.

Yeah that's what I had in mind (though I still have no idea if it's
hard to do). Let's drop this series then. I'll keep this <TAB> thing
in my backlog and hopefully will fix it soon. I'll have to read
git-completion.bash carefully for another series anyway. And I have a
feeling that "git --completion-helper" needs to tell
git-completion.bash "this argument takes a path" before we start to
expand stuff.
--=20
Duy
