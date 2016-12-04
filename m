Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B59F1FF40
	for <e@80x24.org>; Sun,  4 Dec 2016 00:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbcLDAPz (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 19:15:55 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:36630 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbcLDAPx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 19:15:53 -0500
Received: by mail-io0-f171.google.com with SMTP id m5so404481112ioe.3
        for <git@vger.kernel.org>; Sat, 03 Dec 2016 16:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:cc;
        bh=sfin48bedf8BPGWYKvkYX+mpYESftvCkaiNm1hMkEIg=;
        b=KoCUHQ5EiyfO5/2WxdwTWD01bSoBajMzwU32QxwVlkkmPzMyeT5vHje7CkQ7aKwAVz
         Q4CwmBKBQf1DNpCL93w4qRPIaYsRfy2CsQD6YY0mfaT3Fhl/MIzuPzOosNkrHNInMX94
         UHXSnAMRdxSIjDa+bImS+x+WVNsGARxs/24Lwlu5+dTlJr3gRIe4cqRgFs6HguE+3NRU
         p8oIgCncRbByULlvO6YxdA/QgJ1DUTiQyjMIRtI5Zuuuogvt27Z3/K8uBP4PjWEJDpn/
         NBACkD9AxQfkpP5ma0me1qiWG8W9209trbtTFid0PAebMLLuXu7Jsm4qa7RBd6KUkdSk
         sorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:cc;
        bh=sfin48bedf8BPGWYKvkYX+mpYESftvCkaiNm1hMkEIg=;
        b=mE8vSjtX6Hf3fSfPe00MOGev+mHYIHGpYQyfnwlnJyGzsYo6QCfSk/afMo7Evmdg+4
         vpeCaycY7Qz6FwdcbOc+rN0ieuagumGQ+Dy4vPrLGqAYkjvyV5wNA1CxHLVBJRbWX04v
         lkXtHWr9I94EZZCJCqdLQrsLKufFjAKEoTlJZQkcJ+M/Q5NtHwJLby+RH7gvg1t8csC4
         bgDVORpa7TjwQt2x7ZcN9IMqabbE8s12TgQF0OOT/mtypKi5I0Z38CjDhNjyicuBpq5Q
         o8GVj+dONu/EKa2K0G/q5yQjBybGKxsmgT1v1Zp5Ox61IWY6eqeb+Of0h+wgdy5ZEGX0
         SVcQ==
X-Gm-Message-State: AKaTC01tiG9EBwy4aFp8kw5jdSrH/OGlp1MDrtenNpilHQPDleEr6qyrwtf+6aw3+QLJPSLwC1yTT/7Psw/1SQ==
X-Received: by 10.36.95.140 with SMTP id r134mr3243385itb.76.1480810480858;
 Sat, 03 Dec 2016 16:14:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.30.196 with HTTP; Sat, 3 Dec 2016 16:14:40 -0800 (PST)
In-Reply-To: <f2f8c7c9-cbe0-870d-3c13-fc928dd91dd1@kdbg.org>
References: <CAJZCeG1Eu+5DfaxavX_WGUCa+SY+yepDWZhPXxiFcV__h0xjrw@mail.gmail.com>
 <f2f8c7c9-cbe0-870d-3c13-fc928dd91dd1@kdbg.org>
From:   Julian de Bhal <julian.debhal@gmail.com>
Date:   Sun, 4 Dec 2016 10:14:40 +1000
Message-ID: <CAJZCeG02xJ7XWVU8s_GwTctZ8fwJ1_tCMrvDoCRnTXUjBrjr1Q@mail.gmail.com>
Subject: Re: git reset --hard should not irretrievably destroy new files
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 3, 2016 at 5:49 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 03.12.2016 um 06:04 schrieb Julian de Bhal:
>>
>> If you `git add new_file; git reset --hard`, new_file is gone forever.
>
> AFAIC, this is a feature ;-) I occasionally use it to remove a file when I
> already have git-gui in front of me. Then it's often less convenient to type
> the path in a shell, or to pointy-click around in a file browser.

Yeah, I'm conscious that it would be a change in behaviour and would
almost certainly break things in the wild.

On the other hand, `rm` deletes perfectly well, but there's no good
way to recover the lost files after the fact. You can take some
precautions after you've been bitten, but git usually means never
saying "you should have".

>> git add new_file
>> [...]
>> git reset --hard                 # decided copy from backed up diff
>> # boom. new_file is gone forever
>
> ... it is not. The file is still among the dangling blobs in the repository
> until you clean it up with 'git gc'. Use 'git fsck --lost-found':

Thank you so much! Super glad to be wrong here.

Cheers,

Jules

On Sat, Dec 3, 2016 at 5:49 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 03.12.2016 um 06:04 schrieb Julian de Bhal:
>>
>> If you `git add new_file; git reset --hard`, new_file is gone forever.
>
>
> AFAIC, this is a feature ;-) I occasionally use it to remove a file when I
> already have git-gui in front of me. Then it's often less convenient to type
> the path in a shell, or to pointy-click around in a file browser.
>
>> git add new_file
>
>
> Because of this ...
>
>> git add -p                       # also not necessary, but distracting
>> git reset --hard                 # decided copy from backed up diff
>> # boom. new_file is gone forever
>
>
> ... it is not. The file is still among the dangling blobs in the repository
> until you clean it up with 'git gc'. Use 'git fsck --lost-found':
>
> --lost-found
>
>     Write dangling objects into .git/lost-found/commit/ or
> .git/lost-found/other/, depending on type. If the object is a blob, the
> contents are written into the file, rather than its object name.
>
> -- Hannes
>
