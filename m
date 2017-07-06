Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98AFC202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 18:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbdGFSFs (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 14:05:48 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35941 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbdGFSFr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 14:05:47 -0400
Received: by mail-pg0-f54.google.com with SMTP id u62so4594826pgb.3
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gCB8M/kK+4RliXYobnCe/kIPOX61IL0+RUlYANIRcfg=;
        b=jvrXCTILchQ6gMktl4gHzq57oW3WUR+xEKU/3f/SFaodh+5FkaBBMdaxuUPui3BeOq
         GxJ1CkffcWu+m2GACayjijwuP0bD2vn0upj43rmSXq0YgGYFGSGM/FgLZ95gbnsRza8D
         uTkphj32dgwQpahQWnr7T4Y4OMKV0iN5hTb2rHZW79yfeG6WpldKsgl6bcvKlQjDm/TD
         TmnW/H95/McHFU0lZU3UCXBW8VvZq8DhXEwtLa752x9WyNreYhLA23//yQu0eoSQwu73
         NOpKZZYs0CdLfYDz0z6MWh3a6OUuFzosTDLcmK0uIS+w6osl5gwWQzF1j9MHm1VzrMFF
         tv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gCB8M/kK+4RliXYobnCe/kIPOX61IL0+RUlYANIRcfg=;
        b=nGWL2yC2ojBS5RhaXqZyj4ip7YIr1mwaJOnwDoMGJj2QxOuw9xgJTMULccEIn0Cw6t
         gS/jXiZ1QUFwM1xN+2rQ/l+NW7LTVLxlGkPOGHpL8QLjZKS9ye5NaymzHM8cuREh3L0Z
         TPGxpIONmyPDZ5oPxEoPWgp9yIcfjmAejiTYFn7pnDNpRGzu0OUTrbfWz9al8DjedVHv
         3DYn3qUcjUKUZh+fPbEDiP20LtTqjQbnuXybwrp8oJZ/p4iRttdOiw9SQirlXs2HBI+u
         T8h5t3vBfnxXu9+26kinFIK8K7318Kf2eUbPnei2XIrbr8WXg1Vd5RpuEUJEWYPqNUsK
         NDLQ==
X-Gm-Message-State: AIVw111mzE94M8CWWt4SQDk7N4+L+GtI7CrNPxBoYGzG3R3a/m3hJJI6
        spXC3snexxDyuw==
X-Received: by 10.98.157.207 with SMTP id a76mr27243800pfk.25.1499364346751;
        Thu, 06 Jul 2017 11:05:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id 124sm1127220pgi.62.2017.07.06.11.05.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 11:05:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Lewis <utoddl@email.unc.edu>
Cc:     git@vger.kernel.org
Subject: Re: bug report: dates on diff
References: <b28bc109-b06f-0acf-960b-0b6761b0ee38@email.unc.edu>
        <xmqqo9sxfscp.fsf@gitster.mtv.corp.google.com>
        <53f97d43-6984-6a46-bde2-a8cf64e7bb9e@email.unc.edu>
        <xmqqbmoxfnns.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 06 Jul 2017 11:05:44 -0700
In-Reply-To: <xmqqbmoxfnns.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 06 Jul 2017 11:03:35 -0700")
Message-ID: <xmqq7ezlfnk7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Imagine this scenario:
>
>  - Contributor A writes a change on 2017-07-01 and send it in to me
>  - Contributor B writes a change on 2017-07-03 and send it in to me
>  - I apply change from B on 2017-07-04 on 'master'
>  - I apply change from A on 2017-07-05 on 'master'
>  - You clone the resulting repository from me on 2017-07-06
>
> Now, you have at the tip of 'master' in your repository the commit
> that records the change by contributor A.
>
> And there are three times that are relevant to your tip of 'master'.
>
>  - When was the commit that sits at the tip of 'master' made?
>  - When was the change recorded in that commit made?
>  - When was the commit made at the tip of _your_ 'master'?
>
> and the answers are 2017-07-01, 2017-07-05 and 2017-07-06, respectively.
> They are called "committer", "author" and "reflog" timestamps.

Oops, obviously the dates have to be 2017-07-05, 2017-07-01 and
2017-07-06.  I made the commit on the 5th (i.e. "committer"
timestamp) that records a change written on the 1st (i.e. "author"
timestamp).
