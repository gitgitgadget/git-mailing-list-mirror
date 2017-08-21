Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88442208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 16:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753979AbdHUQqZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 12:46:25 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33502 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753726AbdHUQqY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 12:46:24 -0400
Received: by mail-yw0-f169.google.com with SMTP id h127so26141853ywf.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mBg+1lMwR0lxKebEkvi056Es+Bh4cigHw/7lw9Ig5w0=;
        b=kQBM6Hf92mqtf33KsD5YqTFWoOxDUIeUnS6t11zj3gx67OJ7KDbCA9G8HkMEgahst9
         vYEzlSMZrkowt4ScKqFYsjhEAQmajb8vp6S9ucLQyv/zZSPv2hmPZ135B0xyu3fWUyms
         v6U305O0GTSlWgFwD8cVT6QEYX0QKkZlDJ5Cn52cj4EXY9tMI4exF3xS+Vrh6W1p+qd0
         ZJqxqP8lJmV556/S5F7w0awyz1hDb5IKTdsqGpYbWg/fVJ2JUDtn2/KRV1aoS4KXqY4I
         t+ycCQeoMtm83CmwSayvQw3A3NZeir4oSC8zuGnn1KTz8ex/bXIPKwsf7paeR11Vnt03
         9fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mBg+1lMwR0lxKebEkvi056Es+Bh4cigHw/7lw9Ig5w0=;
        b=iVN+qyGTqMj7WT4CxtxK/OjjFX5WsmoxbDsW7jkLLlarp5k8wFVidAh6ia3DTgqMZN
         rrLlEPlul9vdW9fbAj5+XAuiNHkiE+0Wv0EI/nLP1cH6/y6+oOWbOCuIvZE8lXdwjh/P
         MJCE4U9isYoa99LKe6zNI+bBzUKc+BEz8xSfpVaNKXvXDccVmKi+7XhTz6z/+fZ/DrT5
         3DOf6PRL7fpv1e/74YzRiILbHPethdaaoVtsih9OX/+IZRvnu7LOsYAfBc5hu5/HkGli
         jmkZ4eTMi54qyjWN+yZpedKMZF4FuydvTbAGoQhk0nYF25ziHLpWQYOWDdpKtIgIUjSs
         ncpg==
X-Gm-Message-State: AHYfb5hzMcHVTjADfJUF9pC7nnQCgLxgBcX5KpN0X4eVNEG4GHhB2wQB
        nc4asR0W3ysTROoSs5kHJz2zv6ng4YpbH/o=
X-Received: by 10.13.218.129 with SMTP id c123mr14109530ywe.175.1503333983867;
 Mon, 21 Aug 2017 09:46:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 21 Aug 2017 09:46:23 -0700 (PDT)
In-Reply-To: <xmqqpobs9hjy.fsf@gitster.mtv.corp.google.com>
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
 <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
 <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com> <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
 <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com> <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
 <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com> <CAGZ79kap-4k7n48dvBAv2pJjNy2s_LPHS-NdfQD0A-BbWqh4aQ@mail.gmail.com>
 <xmqqpobs9hjy.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Aug 2017 09:46:23 -0700
Message-ID: <CAGZ79kYaBGDyScWihJ7gRdbiJfMPOnNo8LfkB58+WAcOtXyibQ@mail.gmail.com>
Subject: Re: Submodule regression in 2.14?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 11:51 PM, Junio C Hamano <gitster@pobox.com> wrote:

> As long as we are talking about idealized future world (well, at
> least an idea of somebody's "ideal", not necessarily shared by
> everybody), I wonder if there is even any need to have commits in
> submodules in such a world.  To realize such a "monorepo" world, you
> might be better off allowing a gitlink in the superproject to
> directly point at a tree object in a submodule repository (making
> them physically a single repository is an optional implementation
> detail I choose to ignore in this discussion).

Then the sharing between superprojects (e.g. send an Android's linux
patch upstream or to another distro that also uses a superproject),
becomes cumbersome as the commit messages are missing and
potentially not specific to that subtree.
