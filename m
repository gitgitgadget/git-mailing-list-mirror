Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86FE71F404
	for <e@80x24.org>; Fri, 24 Aug 2018 14:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeHXSRq (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 14:17:46 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35312 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeHXSRq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 14:17:46 -0400
Received: by mail-it0-f68.google.com with SMTP id 139-v6so2269194itf.0
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFc3e9iQGFgju8h0LH9QA7nW0YZkf69IkdpojQCg2Tk=;
        b=t7bi66VKF76FbRXU+qV1j1jGDdNigNufYIHijC6l4+EV2zBe+BHiXn2iU3EulW6ISH
         0X4UFPlVP2sB3UEr8V+oTr5pxsMcilSaiPhIOMln7iUNt2TZYdr7kbajJApa+SFzg34e
         NYsv3tOMWPAa6sl+rSspstMo0KXOxk4gJoVDr6YjiBOgAgO1XhLLT0xPw1p9EAtqtYr3
         mFOcsi7pxNpouhNdJTSL+Abk9/aBINrZieHieG5so8uPQSUsRCdbpEOhr0vghUCOGMWU
         eg+gDco/x5XNc51HzOrwgUK7DXb5hMnqFgFkNhHg3HTKPCi4uMM1AxttLru1BTOyIrWy
         vhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFc3e9iQGFgju8h0LH9QA7nW0YZkf69IkdpojQCg2Tk=;
        b=KU2CP3HHDtuTvDho2lO/z68Mw9x/vamqj6u6i0Gi2glxh7l1QPUUj1yLUwqNgtpeSp
         fTjlSnXEIPLyG00MvdseoifbbVIcBfHm+K0vzpnIEM2LQFYV7ylw5LA/e/p59Er/lKnO
         yefVwupPsS5eH3enPyFr8+zMDtRQzwZV5eoY51owWKqiUbDHZg3XdoFum6G4gYHa4osT
         2i4DmvS3G3k40X2eP/X3f27+MeIYXLQrYwlN2vZnNig9YLyP4LFGl3al60L6Zy2CuaOE
         XBnHVnTgK/5jcUtda8/8qT/dEFzNatT9m3f8StQRf5qzjq+fLeuVElCIhkobD8JBHF3I
         HHNA==
X-Gm-Message-State: APzg51DZ8iPH5LpB/AGrBGFV2NjVPKQpRpzwe/ap2MxNXXfxn5RqtDf3
        8YexCVDun4fCBqfN2Tz7byNkgJb3Imm5ToOYQXQ=
X-Google-Smtp-Source: ANB0VdaFqnAFHcOdS77Z/3Cr3Bf9Dm/3ul+74utGFnY+JRSwti4gizxeiG3Vr94NDq++YPWBM0gv5/OiFhz6r6sMxmk=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr1524564itk.62.1535121768656;
 Fri, 24 Aug 2018 07:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180820154120.19297-1-pclouds@gmail.com> <20180820193007.GB31020@aiede.svl.corp.google.com>
 <CACsJy8DsEhV6p=cE6FC6Ka4=E0c-8JG0LRU_DEq-Ser5PqMcGw@mail.gmail.com>
 <20180823021156.GD92374@aiede.svl.corp.google.com> <20180823021547.GE92374@aiede.svl.corp.google.com>
 <CACsJy8DdZLxdA4XSVVBSpeZaF+q6=81LxecYea2JtJ6-Krnk-A@mail.gmail.com>
 <xmqqr2ipje5i.fsf@gitster-ct.c.googlers.com> <CA+P7+xq3m8PXo9wYu1L7p4uG4hf-i=uwQdh+e=0QJXG1cBi04A@mail.gmail.com>
In-Reply-To: <CA+P7+xq3m8PXo9wYu1L7p4uG4hf-i=uwQdh+e=0QJXG1cBi04A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 24 Aug 2018 16:42:21 +0200
Message-ID: <CACsJy8AenCeoEmEZbYwgAA_U53D1cPXC1Ob7G-6MsoGQ_U2D0Q@mail.gmail.com>
Subject: Re: [PATCH/RFC] commit: new option to abort -a something is already staged
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 5:02 AM Jacob Keller <jacob.keller@gmail.com> wrote:
>
> On Thu, Aug 23, 2018 at 9:28 AM Junio C Hamano <gitster@pobox.com> wrote:
> > I think the above example forgets "-a" on the final "git commit"
> > step.  With it added, I can understand the concern (and I am sure
> > you would, too).
> >
> > The user is trying to add everything done in the working tree, and
> > "commit -a" would catch all changes to paths that were already
> > tracked, but a separate "add" is necessary for newly created paths.
> > But adding a new path means the index no longer matches HEAD, and
> > the "commit -a" at the final step sweeps the changes to already
> > tracked paths---failing that because there "already is something
> > staged" will break the workflow.
>
> Right. I think this would need to be able to understand the case of
> "different only by new files".

OK so the rules I'm going to try to implement is, if the  version in
the index is not the same as one in HEAD or one in worktree, then "git
commit -a" fails.

The unwritten line is, if the path in question does not exist in HEAD,
then the first condition "as one in HEAD" is dropped, naturally. This
addresses the "git add new-file" problem, but if you have made more
changes in new-file in worktree after "git add" and do "git commit -a"
then you still get rejected because it fails the second condition.

File removal should be considered as well. But I don't foresee any
problem there. Resolving merges, replacing higher stage entries with
stage 0 will be accepted at "git commit -a" as usual.

Let me know if we should tweak these rules (and how).
-- 
Duy
