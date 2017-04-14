Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CB9920970
	for <e@80x24.org>; Fri, 14 Apr 2017 16:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbdDNQ1a (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:27:30 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34567 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbdDNQ13 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:27:29 -0400
Received: by mail-lf0-f53.google.com with SMTP id t144so44033231lff.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xy1UbFAqx/Mmy/hi2+lcca+cb1LgeRgzzY86CDLa2XY=;
        b=c56COSxiCRSbjfrqlYT3BL15SwrxX0+F7nFW+B+JhFIC3cp1QnMrY9rCb4GDAdZzz8
         Ew31SSdphGiE1yPU+wbyqsaMVUS9ZBt3KyZwXti0hBewysovJiHe9brcFY/pNvzDe+a9
         QsM5ZpiAsjQ+V9hLNJI82LHXE4WDeyIxgpBfR3uu9l3c/ttCMGJwT2baWapVdsZetBOK
         e+i9IYVpWYuF44JhKau5ycsOpqLgHyDMi6YxkzSNLHOT/OWnZ6jr55Is1mAEZe45jX3F
         N5jXQEppwhqGpApUNAFa2OqtaDrm5lXnpk6KxPTw79ZwBKNMwWQdPgBiOfBEbYwdQl2f
         cEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xy1UbFAqx/Mmy/hi2+lcca+cb1LgeRgzzY86CDLa2XY=;
        b=ZPyRkDK43dwvwbDYKyhcuC7l/XNmcTLTCNFeJM9cdhMimmOoix/eHnQqdMaSRAxCvh
         mpE0k5FwPjcUnrIlAgs7W03m5KTbB+95Sgl0+r6dxwFdnl8wljKTHU2AIvlcTWTmyBdl
         XGMSbDaxTJxSVhfnSV2vKPYpJpVzfbBT2lGh2V8dSdyhrE/CbgIHD4IrS421saBTEAvn
         KahVxVZGLASULJqvzafmGWpUVX8NCedg3zzq1kK5AQf16ari0TtOw7PC7YxkQcjBIPmQ
         p4Vcvuhc4zUqBiWaOOT3DKYz1k16TXEL7mHUkjY2xvCT2XpBZdf8qg0tcOWN4uCePQHo
         D1uQ==
X-Gm-Message-State: AN3rC/5b2TnVHdkt5VPkeIjvPszu6YiMe9kER4N2mq1bv0+8z7Vi7618
        KUqKBd24CDPXa9MStnat8kGAJxd/3Q==
X-Received: by 10.25.100.5 with SMTP id y5mr3202183lfb.58.1492187247509; Fri,
 14 Apr 2017 09:27:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Fri, 14 Apr 2017 09:27:06 -0700 (PDT)
In-Reply-To: <xmqqy3v3orc3.fsf@gitster.mtv.corp.google.com>
References: <63F1AEE13FAE864586D589C671A6E18B0CFBF7@MX203CL03.corp.emc.com>
 <20170412135805.29837-1-pclouds@gmail.com> <xmqqy3v3orc3.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 14 Apr 2017 09:27:06 -0700
Message-ID: <CA+P7+xrdM-DGbs4PcN-E+yh=A5Fr40ZGr2RaoihkooUnorfHxA@mail.gmail.com>
Subject: Re: [PATCH] worktree add: add --lock option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git mailing list <git@vger.kernel.org>,
        David.Taylor@dell.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 3:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> As explained in the document. This option has an advantage over the
>> command sequence "git worktree add && git worktree lock": there will be
>> no gap that somebody can accidentally "prune" the new worktree (or soon,
>> explicitly "worktree remove" it).
>>
>> "worktree add" does keep a lock on while it's preparing the worktree.
>> If --lock is specified, this lock remains after the worktree is created.
>>
>> Suggested-by: David Taylor <David.Taylor@dell.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  A patch that adds --lock may look like this.
>
> This looks more like "I do believe the idea by David is a useful
> addition and here is how I did it to the best of my ability---let's
> make sure we polish it for eventual inclusion" than a mere "it may
> look like so---do whatever you want with it" patch.
>
> To me "git worktree add --lock" somehow sounds less correct than
> "git worktree add --locked", but I'd appreciate if natives can
> correct me.
>
> Thanks.

I think either "--lock" or "--locked" works for me. "--locked'
suggests "this is the state I want the tree in" while "--lock"
suggests "this is the action I want taken on the tree".

Thanks,
Jake
