Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 486AD1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 17:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeCMRJE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 13:09:04 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:39743 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbeCMRJD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 13:09:03 -0400
Received: by mail-vk0-f46.google.com with SMTP id f6so222105vkh.6
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 10:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LrjQB17ATG0UFI1U5W0UF49snjDLPOOkatXMHxKNiqA=;
        b=OFIuWmYnY9kTQOjJoY30xrJdcpGxB/zyT/2ZJBDA145Nf0prfJB0NeIFZYRrNSGhPn
         NCUk+5NHFQvvTH5wodaP8bzsz3Xci8jaC8QDktdQwiNMxPgAZfWgBQAuEGASfW9sciIs
         muiGS0OhNqKTa2bI0BrXzYg7wZOePkJKdX3OKGDFJYEgjnSQLlTu9XdkJ2XOLDCfxFSu
         JpcAwwlguc5h+YqBc6ty5r9DHeOoTpO1t+cDSdPpbhSPMtp9oJaiKHRMpnbtA6skQKab
         I0Tt51mFiyf5abIr+pByvtXTV9bq2y1GtXmzDq3cbaXwuX6/GzBsoDoDKHOrgSdOrONk
         NXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LrjQB17ATG0UFI1U5W0UF49snjDLPOOkatXMHxKNiqA=;
        b=ru19CK1vs2rVXfT7zIPC1CBl0s+s1U5en8Pc/fKT9Z80Ku6x+rdjSDKsgyfD/3e6AC
         9L8sD1D7xnoyOOGYRMeFAYdVAogjI8/+j1iRNoxtnidqLLxpIha/RD3v7w73HUllPZJd
         kPFxrk9S7WNk/8nQVack1x09tm/LgFSDoss5wjveabPYbsXiIPbUYxpyfIeJZnaW1VGp
         Hxp4psrNyxr5ykGMAb+V+qtBBt1Tk/o6hfFE12yx75QSo130QH47WQMe+yzvvdn6BeIe
         tNi0CqR3SZnJwWif4CYQx1h/fbln4AgjNmAWFDQuTxQ8JeNBur/cGNOiyfmGvFFKl3VM
         eUyw==
X-Gm-Message-State: AElRT7F5aajr2oFCTvXOyM0S0e9ISwsiYuvrsThgMdVk4PLMSohyU5Fn
        0NqDtrxqzwCmI9desvF7pgzu4KbzlEt6K5Uf5oo=
X-Google-Smtp-Source: AG47ELvIWguXH63rBXHZm1KgZEgIU3AbdKE7CDIjK+q4+pyYiGiX+0hHQRWTpbFDZj0lT6RKZmLcoZ2wPNPHg4ZXpT0=
X-Received: by 10.31.115.197 with SMTP id o188mr1101733vkc.106.1520960942417;
 Tue, 13 Mar 2018 10:09:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.3.241 with HTTP; Tue, 13 Mar 2018 10:09:01 -0700 (PDT)
In-Reply-To: <871sgoqos3.fsf@evledraar.gmail.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <876061q6m6.fsf@evledraar.gmail.com> <CABPp-BHDOimDoLxWxS=BDOBkm6CUTrXTzD16=TSkWGN-HOiU2g@mail.gmail.com>
 <871sgoqos3.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Mar 2018 10:09:01 -0700
Message-ID: <CABPp-BEOi6GAoHUZyfcJdd-eLwPLoyRMOiS-J1dvkjqm7VGj9Q@mail.gmail.com>
Subject: Re: Opinions on changing add/add conflict resolution?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 13, 2018 at 2:59 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Mar 13 2018, Elijah Newren jotted:

>> However, I'm far more concerned with the three collision conflict types
>> having consistent behavior than I am with changing add/add conflict
>> handling.  And if your two concerns or Jonathan's concern would prevent =
you
>> from wanting to use the new merge strategy (and possibly prevent it from
>> becoming the default in the future), I'd much rather just modify rename/=
add
>> and rename/rename to behave like add/add.  Would that be more to your
>> liking?
>
> I don't really object to these changes, I don't know enough about this
> area, I skimmed your patches and 90% of it is over my head (although I
> could keep digging...).
>
> I'm just chiming in because it seems to me from upthread that you're
> purely focusing on the use-case of the user of git who's using git at
> the abstraction of using a dumb editor that doesn't do anything to help
> them with conflict markers to resolve conflicts.

Yeah, that's totally why I started this separate thread; I was worried
the original would push away folks who weren't familiar enough with
merge-recursive or were just overwhelmed by all the different changes
and rationale, but I really wanted to get feedback on at least the
piece that people were likely to hit in practice and would understand.
Thanks for doing so; your, and Jonathan's, and Junio's comments have
provided some good context.

> Also another caveat: Since these are new side-files what happens when
> you're in a conflict and run `git clean -dxf`, are these new files wiped
> away, or are they somehow known to the index?

A git clean would wipe them out...and if that scares you (and I can
totally see how it might), then rest assured that the situation is a
whole lot worse: this isn't limited to rename/add and
rename/rename(2to1) conflicts.  There are several paths in
merge-recursive.c that call unique_path() to get a temporary filename
that is in no way tracked in the index but which is used for storing
content relevant to the merge.  These include directory/file
conflicts, untracked files being in the way of putting a renamed file
where it belongs, untracked files being in the way of a modify/delete,
untracked files being in the way of simple adds on the other side of
history, rename/rename(1to2)/add/add, and maybe others.  In all cases,
a git clean is going to wipe out the files that were written to
different temporary locations.

My rewrite I'm trying to find time to work on would get rid of the
code paths involving untracked files being in the way of other stuff,
but would do nothing for the other cases.  I would love to get rid of
all of them, but don't have a clue how to do so.
