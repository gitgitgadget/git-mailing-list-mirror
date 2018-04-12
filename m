Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0D61F404
	for <e@80x24.org>; Thu, 12 Apr 2018 23:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeDLXfW (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 19:35:22 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:32858 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeDLXfV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 19:35:21 -0400
Received: by mail-it0-f52.google.com with SMTP id x144-v6so3758942itc.0
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 16:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=V13Q/NdlHdfQn9+4aelU0QxTGPS5xTwYHZVF7xXwob8=;
        b=nJiIj112Mk+DbHI+Ut0+ls9YFWifayyA41e6rLDfczGWzQ/2F2SQJvyA1jMQS/hWlH
         izmcMzq5wNHJXLrlrOTIx3b7W0meUrYw4oVMXOlzhZPwLQGPdeaXiZ+IBPckXwr//ykN
         S3Bj3ef3koqv3KAdKrSmTDl+enUoQO9tQlVdEUhjD2wokSy2bII5Duw0OY+iCr5nlQnw
         exbA/a/V0L/55sDhWgIyVoKPf0wwF6xrmlZ9DdNZ2fcRHz3cE8jVNvBnmviqWBOp+uxz
         xMWtv4NsY4X8tdVWyKtqHw55IiUuF5aqkz+ri0aH7onV1g/TBmSY4wHrhClra3sEaPWy
         zfqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=V13Q/NdlHdfQn9+4aelU0QxTGPS5xTwYHZVF7xXwob8=;
        b=Od08Egkk2i0yvUyM96lVWS82PyLH4hSjLDo+oCxy3f5Yn1PDtfVsZZ89FL1grBlckn
         UxaNdWE43vnoEqmZPs8EOyCYutCacXGQFgvLMGjG/W0gpTGrTp1lA1vKmmrIGH7pogdf
         OgZtIfQ1u0lXO4CETU3A0XSJG89BpeoR7Z1N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=V13Q/NdlHdfQn9+4aelU0QxTGPS5xTwYHZVF7xXwob8=;
        b=diJRnDT1m66aTO2IYagaFQDwDzx+rOxIv1jrRGvogel4G23vbf+CL81BDDjfq9zyF1
         EGcdPaSo37mFQLuK4PVMYfopy63jmCiwsLimEa4eXDX8sJymUvVtgq4NLfD/CXqe0Yjc
         ns2aAEQCV2dpaWzdTBKmc09qT2AgYYWRfJ/SutH4vbh4XhQMjojYMGQ44tanaDekAz/H
         R/D3dnThvd0KZ0J9goClpWh+ObBE/ETAh/h5GIn5Hfgq4N5/TydCDkvW3KpdkaeAANlH
         5p8DgYap5eYh1aK44thKDxLHB98aykSiMplysa+8r22/q+XCaXMuO7ManJPvHVrxellm
         ApBA==
X-Gm-Message-State: ALQs6tC/OcNgGxqTAUT3e88TmvMGqLJAvNV2YE6f7DpKhrTPFMtWDrdQ
        KZ0dHhSDaGl3DHHx38rIqemM5XMQnewI6s1WVNAQ7hEm
X-Google-Smtp-Source: AIpwx4/GSkWUMi2aOLZOo6/vbiCsgBDzN3C6hTK/CMiCWhETsweEb1BGjfPupZ+tn2QJz6ESw52Thbc/s5PFp4JLkbE=
X-Received: by 2002:a24:87c8:: with SMTP id f191-v6mr3098403ite.16.1523576120462;
 Thu, 12 Apr 2018 16:35:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Thu, 12 Apr 2018 16:35:19 -0700 (PDT)
In-Reply-To: <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Apr 2018 16:35:19 -0700
X-Google-Sender-Auth: bxvF7J5gHonZrT-T06LatEKQeGQ
Message-ID: <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 12, 2018 at 4:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> A bit of detour.  "Change in side branch happened to be a subset of
> the change in trunk and gets subsumed, but we end up writing the
> same result" happens also with the simpler resolve strategy.
>
> Here is a fix.

Heh. Except git-merge-one-file.sh is *only* used for that case, so
this doesn't fix the normal case.

I verified that the normal case situation is that
"update_file_flags()" thing that checks out the end result.

It's called by this case:

        } else if (a_oid && b_oid) {
                /* Case C: Added in both (check for same permissions) and */
                /* case D: Modified in both, but differently. */
                clean_merge = merge_content(o, path,
                                            o_oid, o_mode, a_oid,
a_mode, b_oid, b_mode,
                                            NULL);

in process_entry(), and I think  we could just there add a test for if
o_old,o_mod == a_oid,a_mode or something?

              Linus
