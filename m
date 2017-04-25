Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED32207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954991AbdDYV44 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:56:56 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33948 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954928AbdDYV4z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:56:55 -0400
Received: by mail-pf0-f170.google.com with SMTP id c198so32330221pfc.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L07cs4QctSH15GKNDGNIBnfmElp3V9xClstOON1rPM0=;
        b=OFtl5I241nBtSJOnmrNH/E61S0RXWhzHySAB5e26PHbn/rHeTG8tBn0sAlNfKKJn7V
         WVQyy9FzlIpgkJhOjQUk5sY1wuU/n00g5xr2FotqjYb7j7MMTwsLEuNfaItJxABeCRgJ
         4tsrzdlbDm0yf4XsZA3ye9Vn/Ou+6FA0e1W+YJo0aXECzl+QRjwcXfmcjRqSz1vrV9yP
         0PgOPo0G3XdEeM7n5ZloXUGxp7nm7BOMzX9UPWs4EPsVxaMz7ygcmP0h4qPCzApyz2Vq
         jB9oUS0O1xB8qfdyepRDEvCnjf7vKnhHG4RsdQmUZuMMIHW6v7sr4gvoKIucfjviUNFZ
         YPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L07cs4QctSH15GKNDGNIBnfmElp3V9xClstOON1rPM0=;
        b=SXQMTlmIYaSUulIeL3stFa0/cY1bNkcIsL//GVVwPrhZwY3Manvr7p3CgK0wm7bMYH
         I3+mnBQqVPGYXx+GJYp7WPdmxB6ThbTgWcypHckl2znQYVKosIo6gD0qgLofLIUa1eGx
         hLhPbtg8xCSJpgNaV3CQiuLUWZY8EfrzXAqkSncIEwyxA2afIdCS16tNssuHjUQ428qH
         RkZziX5KEVsv35SAa7QhyBNvOBFJTF/bbMygXzqpTs0Gw9i3sAo7cRO9MnweUBh+V8SW
         XNHSAUMwNIKZKMclsn0BLYA6ycWBjKGIEjMvwb/3yQT0LdkNxeHuaekwoSuvVvfcE7hf
         FAHA==
X-Gm-Message-State: AN3rC/5xOKi+43Sw685YoEeCq+2gAdiJnUIUvHsZYioCtRYhUO9Op4cx
        JvxolSeEJfepLWF1HjwBTRUXyx+fQTPS
X-Received: by 10.99.107.198 with SMTP id g189mr29233047pgc.162.1493157414397;
 Tue, 25 Apr 2017 14:56:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Tue, 25 Apr 2017 14:56:53 -0700 (PDT)
In-Reply-To: <f49a858b-26da-7e8c-e0f2-8d66158f016a@google.com>
References: <20170421220155.GA142345@google.com> <20170425190651.8910-1-jonathantanmy@google.com>
 <CAGZ79kapU5AL_iPJXCavCKAQ0Fw=pqWZS4F6Vri-Q1M1WMVs_w@mail.gmail.com> <f49a858b-26da-7e8c-e0f2-8d66158f016a@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Apr 2017 14:56:53 -0700
Message-ID: <CAGZ79kbhxjO-tFW4_kObTZiauetjsgY1NBSKvo1NV5nKNEy2xA@mail.gmail.com>
Subject: Re: [PATCH] sequencer: require trailing NL in footers
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 2:51 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On 04/25/2017 02:04 PM, Stefan Beller wrote:
>>
>> Thanks for the fix. :)
>> Do we want to test for this use case in the future?
>
>
> Thanks!
>
> I'm not sure of the value of including a test for this specific use case,
> because Git normally does not create commit messages with no trailing
> newlines. (To test this, I suspect I would need to use hash-object with a
> specifically crafted commit object.)

Okay, makes sense to omit a test.
In that case: Is it needed to hint at how this bug occurred in the wild?
(A different Git implementation, which may be fixed now?)
