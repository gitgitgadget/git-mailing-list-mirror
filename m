Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1841F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 01:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbeKVLl3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 06:41:29 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34720 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbeKVLl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 06:41:29 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so14144006itd.1
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 17:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4SGKyNst7cTAqsVsmxJuCuce2250LQ1xM5ar4AEU1oA=;
        b=KpHYxeIGgcod4j+22+NZWcE819AaLLHub7Z9+nkUxLrRm+ltrN8jPQH73IAg1y8mf6
         AR22Y68WUAnHYalys8AeOnyP3pwGlVfitxpUDFZUhtZ5whbTyDwqGSHz2a47zdyOBzzQ
         ih39BoWjE404UE9TIK1310ZsJNPbU0RURMBqPFeT2glO63CsX2cFQg6147/lJ2LSI5r9
         H2viq3ECnHaE6+8JAGAT4o1rJkuqI+B+wuLHiuP2Q8sYhZlimFnuFD/wp+VdChrmYKEm
         VHnmmEDPWF9u9pJUG+R6ukpZtqKaNZa0WilqO/HsFSk2HbdUThZCilX05MZgW5VMw5ns
         Ls5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4SGKyNst7cTAqsVsmxJuCuce2250LQ1xM5ar4AEU1oA=;
        b=Llj4IV09ERwECBdWziJXTCBhLUKuisBdz3SJNwv7oxUQGyHacb3x6RcCcNNzIR8x8y
         LSqsekVzpULyw/15Xhig+j21ljFXcGw5xzVHjjpi00lOQxyqpq+LEQoQJPPIdGXXv8nw
         JyquTZM4liHL7TSPPvJxW6mqqWE9Kv2IKbdKgm93jfY+oF5ny4iyw21hhzK5u/9n62Lh
         FUQFxklnp6pTvjombF4E8YJJiC1aZHTWgICYKnObPTyPVB4hlcnug8zZCcxypFaFHsYJ
         KVmm0Fh9msGJumihkrljx12Od5ws/oHTnhU3XjcvSKxZvQJgq3gdUqY8kv7uLXL+IQhP
         DSSw==
X-Gm-Message-State: AGRZ1gIjcFAWYCRigCNUEWFhiJW90BySeRllQwFAPVA/Ojd+w8R9tHX5
        Sdz7k/hu45IF5oiVMFhMqaMcGEJuEVbjuOvN/DJGAgNT
X-Google-Smtp-Source: AJdET5d8Hj5gcj/M2U9+HdfghH5PO+E430Dw9/KzNDN5/ywq0DSARog7e6uzQVRuas9Ni/9jMDKZTJUuD9qLmdbBkSA=
X-Received: by 2002:a24:7596:: with SMTP id y144mr8478797itc.68.1542848676913;
 Wed, 21 Nov 2018 17:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20181119101535.16538-1-carenas@gmail.com> <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
 <20181120091107.GA30542@sigill.intra.peff.net> <CAPUEsphaYBXp4V2FYqoB8-A2dyqppH=hSAaoQXGk4NMwXznCiA@mail.gmail.com>
 <20181121224929.GD5348@jessie.local>
In-Reply-To: <20181121224929.GD5348@jessie.local>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 21 Nov 2018 17:04:25 -0800
Message-ID: <CAPUEspjeiT=Odc7ENd0Qjeg=8w-+Qh9uGjL+BQXihiK1G1vkjA@mail.gmail.com>
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
To:     max@max630.net
Cc:     peff@peff.net, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 2:49 PM Max Kirillov <max@max630.net> wrote:
>
> On Wed, Nov 21, 2018 at 04:02:04AM -0800, Carlo Arenas wrote:
> > for some tracing, it would seem that it gets 0 when
> > trying to read 4 bytes from what I think is a pipe that connects to a
> > child that has been gone already for a while.
>
> Could you clarify it? I'm afraid I don't understand.

the error that gets eventually to stderr in the caller comes from
get_packet_data, who is trying to read 4 bytes and gets 0.
when looking at the trace (obtained with ktrace) I see there is no
longer any other process running,

the last child of it is long gone with an error as shown by :

  9255      1 git-http-backend CALL  close(1)
  9255      1 git-http-backend RET   close 0
  9255      1 git-http-backend CALL  read(0,0xbfb2bb14,0)
  9255      1 git-http-backend GIO   fd 0 read 0 bytes
       ""
  9255      1 git-http-backend RET   read 0
  9255      1 git-http-backend CALL  write(2,0xbfb2a604,0x36)
  9255      1 git-http-backend GIO   fd 2 wrote 54 bytes
       "fatal: request ended in the middle of the gzip stream\n"
  9255      1 git-http-backend RET   write 54/0x36
  9255      1 git-http-backend CALL  write(1,0xb781f0e0,0x94)
  9255      1 git-http-backend RET   write -1 errno 9 Bad file descriptor

not sure how it got into that state, though

Carlo
