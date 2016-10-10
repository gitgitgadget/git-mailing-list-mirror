Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E689220986
	for <e@80x24.org>; Mon, 10 Oct 2016 13:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbcJJNH0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 09:07:26 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33007 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbcJJNGs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 09:06:48 -0400
Received: by mail-qk0-f173.google.com with SMTP id n189so109607633qke.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 06:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gforgegroup-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UM+7AW6GVTw1UyQTj/MjVWlM7eL0pskVi013PYda85I=;
        b=le71uf5bYtEOPcJxnvJzO0VC7tkPX8qAu6lmdgCSmDpJgqcN0wGK/5OcTqVRvNdXai
         sDAiDRgDn0Q9LHs2N5JlufF/twsQ9IUQhlbxiEKH5MLqPTLd9MAPCPZOx1BwOr7pyb4w
         88V8qeb5fvlnBgQ8EmRl6aAgbN+obOjjjtUph+NM0xFt2VXcSO+wz2xVxpwAw3/1kVY/
         yriElbhHN40ruisGY9YdFATpyS2Z7rE/fwvMAirZm9L+H2w3tgJiFhY9pWMLRrsialtv
         Il7kp23d5CVw/wo+X9uguZPyIX814/RTjZQptFJpAddJNwydOx4I9fS8crk+XBI/wu69
         koCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UM+7AW6GVTw1UyQTj/MjVWlM7eL0pskVi013PYda85I=;
        b=c18PA6gq6TK0JD3MEprNw2XnIqPOKM3dwouq+clobKfBSnE+XCterqjXYi4azTW6gC
         BzmPg7Hu+BsIfF7YcKBc6HmTP7VHCt0Spc1iz2GJoLrto2rX+HSM+UEb6k5G2OkUPdjd
         H3iHNGzbeXsxtIzMWrd0OXUlxQDCPr4X+cMgcVwlNV2nje85wXzny0bIGAqk0WfgW7kJ
         TLByjn9cVLNXub5+pKS6ei+KKokMf138iuje8egWAhCZ+NDxOA6Akk4iN99gWY79FTPD
         qxDuxAesGzTZJhWdXugVxhDmgr7p6Z5Rw16jC5YMK1sy136YkthQGfclnCVOMsogKu2R
         kOvQ==
X-Gm-Message-State: AA6/9RluakFvhvNQkAHFI+j9WZmplMEsCPbfB620ZQLxdztC6jlx+2tgJSmI413p0j/1FNZ4GQpWcLyBIVTvewz6
X-Received: by 10.55.221.146 with SMTP id u18mr29521313qku.42.1476104807722;
 Mon, 10 Oct 2016 06:06:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.164.69 with HTTP; Mon, 10 Oct 2016 06:06:47 -0700 (PDT)
In-Reply-To: <CACsJy8DMKWeZ+DuQ0uoY6rdPfusq8D1SfBCkPyn+6X9S589ncg@mail.gmail.com>
References: <CAOi_75+2SG2WYHBMQhfGj96eKsZ66niJzOevVGM5eJv-qqrVNg@mail.gmail.com>
 <1475999513.7410.8.camel@kaarsemaker.net> <CACsJy8CmgmGLEi0xQUY9Eo-4FkA4eDNk9WJ2LtEDVFQBjbFdCA@mail.gmail.com>
 <CAOi_75+Zoeeq5FD1HKgG4MjeL9LkBshsSfdrMOTi8m-Mt-OQNQ@mail.gmail.com> <CACsJy8DMKWeZ+DuQ0uoY6rdPfusq8D1SfBCkPyn+6X9S589ncg@mail.gmail.com>
From:   Michael Tutty <mtutty@gforgegroup.com>
Date:   Mon, 10 Oct 2016 08:06:47 -0500
Message-ID: <CAOi_75KR+AEAD540L=GtQ7jH5ngTFdHMq53+FzjzAfsZtTqfwg@mail.gmail.com>
Subject: Re: Bug? git worktree fails with master on bare repo
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If I create a bare _clone_, then "HEAD" could be detached, or point to some branch, depending on where "HEAD" is in the source repo

I didn't mean a clone, I meant a brand-new (bare) repo.  Then I would
clone it somewhere, add commits and branches, and push them to the
bare repo.


> If source repo's HEAD is "master", I got the same behavior (worktree add fails)

So if it's possible for a bare repo to have HEAD pointing at master,
is there a safe way for me to change this (e.g., as a cleanup step
before doing my actual merge process)?

On Mon, Oct 10, 2016 at 4:45 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Oct 9, 2016 at 8:42 PM, Michael Tutty <mtutty@gforgegroup.com> wrote:
>> Dennis,
>> Thanks for the great response, and for spending time on my issue.
>> I'll try that first patch and see what happens.
>>
>> In the meantime, it got weirder...
>>
>> I created a brand-new (bare) repo
>
> Elaboration needed here. If I create a bare _clone_, then "HEAD" could
> be detached, or point to some branch, depending on where "HEAD" is in
> the source repo. If source repo's HEAD is "master", I got the same
> behavior (worktree add fails). If it's detached or points to some
> other branch, it's ok. If this is "git init --bare" then I got "fatal:
> invalid reference: master".
>
>> and was able to git add worktree
>> /path master.  I was able to do this repeatedly, even using the
>> worktree to merge other branches to master.  I didn't find any
>> condition or step that caused some kind of orphan master work tree,
>> which was what I thought the underlying problem might be.
> --
> Duy



-- 
Michael Tutty, CTO

e: mtutty@gforgegroup.com
t: @mtutty, @gforgegroup
v: 515-789-0772
w: http://gforgegroup.com, http://gforge.com
