Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3582022D
	for <e@80x24.org>; Thu, 23 Feb 2017 17:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbdBWRUJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 12:20:09 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35028 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdBWRUF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 12:20:05 -0500
Received: by mail-qk0-f169.google.com with SMTP id u188so37795574qkc.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 09:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Mz4/vSxjpQmW8WFV/kivh802zF3T9yiZNm+EJ0tvL5c=;
        b=RWJXL3Dcl+z1TIJejuEet8UnuPxgIinBvVA4F/jtuV0vzHrl033LyJ6cmuLDXdJh99
         5GP6B0JkXpusbaVffqZbEeM9BWG/Qvd2QwXKEgYCXJ6CTWaBhVFRmYXcqhWL/hat9AgM
         /gCP9VCVOeunT6+Z3Lt1cjcUroG7gCxsjUsGwWStY/7+nN+CzBy3No3wAt4405A8HzmI
         3sQaO04Ju35+IopIiXzfZSHwukgUvER1yJg50SegaQsiI6AQ6LhU8QKKq+soETSfTiz4
         KhTTKbxYnrQnReHsy+yAyP+j74ISJ4eEeSY+72XFwU0IOK95CsSy/FHbTxQFAc8Ts+3x
         a1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Mz4/vSxjpQmW8WFV/kivh802zF3T9yiZNm+EJ0tvL5c=;
        b=oyXh7i/4rOKy67MZMTwaEIGKEt7mAZxW1MLR2eXv/Z+fz+crJw70qoUDTSpXc7Cj/x
         d4kM9jmyauec8FJmmkzl007Q02NVv3jWf5yV2QTe+X5vNLDUrNrCEYzcwifMbc4vfUF+
         XHQnhjerD8QYfvdMt40NSLiIu9fRI+E2Tfk2pdML4gg+Djtl5OjKuSyXB/CK+YriaX0w
         wO9XSA1pyVF8RzsuySrJMZmBSEv71fonFXmBsMoUQ4Tfs0i2pt3Lveoty27aAotQTLbK
         5TSUBJ5P6UzLZG5hU4M//tzDZ5Lp+uzLdMQtgvAJYESFZxqAKyw20m3Qf+TzVDMbnmUU
         b/4A==
X-Gm-Message-State: AMke39nlfFxSZXiSH9ZH5ww5AbOgKJEv6f7gtBkEK3pADeRhFRTW8+eBcLNteJlwN2/iaNmqlYYvW9PRvFYo5g==
X-Received: by 10.55.142.7 with SMTP id q7mr40797091qkd.104.1487870349206;
 Thu, 23 Feb 2017 09:19:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.20 with HTTP; Thu, 23 Feb 2017 09:18:48 -0800 (PST)
In-Reply-To: <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Thu, 23 Feb 2017 09:18:48 -0800
X-Google-Sender-Auth: UicPxYVh27a5qUEfPyKMYBsFldk
Message-ID: <CAPc5daVfw50dWPF0rc3kCnx_qCEdDCU5X1w=VJDHGut5FbMbRg@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Joey Hess <id@joeyh.name>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 9:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Thu, Feb 23, 2017 at 8:43 AM, Joey Hess <id@joeyh.name> wrote:
>>
>> Since we now have collisions in valid PDF files, collisions in valid git
>> commit and tree objects are probably able to be constructed.
>
> That may be true, but
> https://public-inbox.org/git/Pine.LNX.4.58.0504291221250.18901@ppc970.osdl.org/

IOW, we want to continue the work to switch from SHA-1, but today's announcement
does not fundamentally change anything and we do not panic.
