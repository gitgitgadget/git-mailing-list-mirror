Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60F51F803
	for <e@80x24.org>; Tue,  8 Jan 2019 23:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfAHXls (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 18:41:48 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:35055 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAHXls (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 18:41:48 -0500
Received: by mail-pg1-f201.google.com with SMTP id i124so3007658pgc.2
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 15:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w80zIpomVwcPqx9zsiuX/u8TDPB9m1Bd2CpZIGyt4AU=;
        b=Ld8/HqEIjia3Mc9OcLUWmCUhD/v6o0dntRgBDTWJwwA/73OcdL3PCC6Tprir+rU469
         +w/JmwxZFRJxoD4kyp8QwM5Yb3uk+SN4ySRnQy6m4XFvsv/ISFRz1HBd3XZCb+6zadcS
         41fc8finaEmxmTSX+l2U9GGew50/sO/rMSZ4f7syIgVwGkN7oUJKAw+iy5X8ElJTMUuN
         nNgF/+4nYD8u5TUi/y9DsMhz+//EPQFwsX4a8UqFIJEVYxKtK0exKBIIwwBHv2fSp+bv
         kIywh7Bw88Yb5pi61qEYjqWKShbRbdNt2KkNoPqHxip78w12onB9vEqVQ/Ql/bsu1EC6
         iLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w80zIpomVwcPqx9zsiuX/u8TDPB9m1Bd2CpZIGyt4AU=;
        b=HNYPCsHtYqs90dM7Dgy9RL57nn0JWdkjFfXMySgL0lJHkEW40Vx3K72GjkLUDfDVQ9
         D9osFaF90SBW0ohbDToAzwqIu7hGaewi6ZH1CrsRYaANPqdRnOqLx9RdK5Lwey5i2RO9
         W6QY+l7BFXMVBXiPaSJn3V+I1QZ/US1q+yluLheBiUtxg998Jzkm2LFwBNBSXjkcepJb
         0+C6Gx/7oM7b1C0qHg/cQmrCB1hUTJIUAspc4FJur6PSG/cUEZg2FVbxJDHMIVXD+8J5
         UqgFnCjve9Meg6+q8iXCLn2qeOkjnAsC4vk6EbP8F3T4Fw7WR4Z7PkAo2FFbWCJHxwJM
         7/zQ==
X-Gm-Message-State: AJcUukc0n3mVGhOajhWecZFC9nk7y2FXwYhF+rhJ2ftXbXE6g4DIH0TT
        NZBYSFNz7hs/IQcs35uK4my5jQRv0VtZfkEFiRzi
X-Google-Smtp-Source: ALg8bN5ubdvpbvdGGjtbMNVlOgGBs42K4pi3szRitd4zFowe9eTwnEr7Iekj1vKT8iVQ9rtCyp5LVAU7sHzS0iK5MaB7
X-Received: by 2002:a17:902:a5cb:: with SMTP id t11mr1481231plq.3.1546990907876;
 Tue, 08 Jan 2019 15:41:47 -0800 (PST)
Date:   Tue,  8 Jan 2019 15:41:40 -0800
In-Reply-To: <xmqqftu24t80.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190108234140.41554-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqftu24t80.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v2 1/2] list-objects-filter: teach tree:# how to handle >0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, matvore@comcast.net, matvore@google.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> For your reference, here is an interdiff for this particular patch after 
> >> applying your comments:
> >
> > The interdiff looks good, thanks. All my issues are resolved.
> 
> Just to make sure.  That's not "v2 is good", but "v2 plus that
> proposed update, when materializes, would be good", right?  I'll
> mark the topic as "expecting a reroll" then.

Yes, that's right - there should be a reroll of this topic. Also,
besides the proposed update, I have a comment in patch 2 of this set.
