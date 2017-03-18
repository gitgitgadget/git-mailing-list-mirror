Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B9B2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbdCRV0t (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:26:49 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34818 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbdCRV0o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 17:26:44 -0400
Received: by mail-vk0-f42.google.com with SMTP id x75so55730682vke.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 14:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YFokg647tyVvcrqeACr3ndinViGlI0bqMYxnVpIvLnc=;
        b=qY3mhKhKnyek/swtQH181POeof3EGDahAC9bFj+5wNZ/dTI4XkQ3WOZ7K2tosy+WeX
         HTeAqChYS9xzMtuWx0pvsAb+QdoeeyJIrl3EN9gfDsYyVV4pNFKpr3nVOwFMcJ84MPL9
         95w6GRlPfaqBeZE5Gb+H/+Zz4LMp7hHrlOwIUc6VfNUYJUT4pLg35up8fms1UYI99KGA
         WlGcSY/U7A43WAFiEh4dVw3CyAA6xo+RP6U9pBvIoZOLQkh5MMEbOPk0toNqIQ+AETWD
         gfpC7pc8DnfZbFKHck49Rmnxk6FY1BaLqCn8DcI+Xkb79+kHeA71ZZD+1iqZiOWwuvZk
         9Nag==
X-Gm-Message-State: AFeK/H3KqbUOSpTwJJraXYOraXA7fOMF5O8LzwpoT/yAmNzyqcgFVtk7KKBLETjjWQySpALYZXWKi9+A+r/lk1kB
X-Received: by 10.31.180.200 with SMTP id d191mr3003173vkf.54.1489872367402;
 Sat, 18 Mar 2017 14:26:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.25.15 with HTTP; Sat, 18 Mar 2017 14:26:06 -0700 (PDT)
In-Reply-To: <xmqq7f3m1gqd.fsf@gitster.mtv.corp.google.com>
References: <1489866696-17487-1-git-send-email-agruenba@redhat.com> <xmqq7f3m1gqd.fsf@gitster.mtv.corp.google.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sat, 18 Mar 2017 22:26:06 +0100
Message-ID: <CAHc6FU7xdyU-c5x3jGqy20g9N=BQo9KcWsZjh39eFX1mk+kSvQ@mail.gmail.com>
Subject: Re: [PATCH] Inconsistency between git log and git rev-parse for ^HEAD^@
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonas Fonseca <jonas.fonseca@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 9:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Andreas Gruenbacher <agruenba@redhat.com> writes:
>
>> Hello,
>>
>> the log and rev-parse commands both support the rev^@ syntax which stands for
>> all parents of rev.  The log command also supports ^rev^@ to exclude all of the
>> parents of rev, but rev-parse does not.  Should this be fixed?
>>
>> If so, the following patch would be a start.
>
> Hmph, would ^A..B and ^A...B also be turned into B..A and B...A in a
> similar way?  I think the latter would not make much sense but ^A..B
> might.

The previous patch supports neither. I agree about ^A...B, and I don't
think supporting ^A..B is relevant.

> In any case, accepting ^rev^@ may make sense nevertheless.

Andreas
