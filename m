Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA62B1F461
	for <e@80x24.org>; Sat, 18 May 2019 08:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfERI20 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 04:28:26 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:35911 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfERI20 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 04:28:26 -0400
Received: by mail-lj1-f174.google.com with SMTP id z1so8263938ljb.3
        for <git@vger.kernel.org>; Sat, 18 May 2019 01:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2Eqt8XqKO0YkHTtOqIPI4QnZ9qpTxOLDMCI33D9Cto=;
        b=Mq/Hf3dP7mcfuQ/JO267cW0+dpP0WkWa+n7ufW6GiWHjyfUktaapfyIuCg2WZIF6Tc
         HnTjnlOfxWIutF6R5Z+FWdjbzmroim508bZQpvu5tS1Lr/bOWmeO8RMoSMelg+O5hZFA
         FFBYAvxXlPRnipaqWfjd7Qmdcj4pzThr74XDghuwJ1gyajpaTLONWvJsa3a9wXL8/PDh
         s6SU2qI1cG50G4SZ3yC9HFSV2SFlpNdshecJnMyXs3ATpn38nFCO4CC+dl1r/TMaL6W9
         QgKOz/XrmE7tfE4j5Hb7MC0tHrn1A57E6ZtfzgElj2wN9qhIfF0NPPfaNNNoGcMBb4b8
         wnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2Eqt8XqKO0YkHTtOqIPI4QnZ9qpTxOLDMCI33D9Cto=;
        b=Pl4fBBdj2ImrAvI9m+jLdvFMZuMc6JfiYXRJGxWMsObJ+Cjkvz8xCrunktsc5PD13F
         iYtsz/AN8SveRPSjbJHP7NO07HD6ZoAy17GFCKlEJSxWXpmeKXwzNpHWI7EErXOVPnqg
         /BK8ox9EOVLWupw7yWlw0aUUuUyovzMwUfLQac9dQ7wVgBcdivoyMF0c1MmyUWzW63EZ
         Tzrv/uBOEGVc/l2SA4F3v/HGIljcPBaZmwfueSYxwk8jZr1TGYN7mTgU16p4CUEwYOM8
         rZAH/iZ1WIn8A3MYQBK7z2GW10mZrOUyKtoJ0mBkl0ujmItOA/+80of3h0olYih9HVBZ
         7sbQ==
X-Gm-Message-State: APjAAAWVQ0vsYiBy3bIL8RGKSgUr5HfaG/FY9TZPDCN0uE8aOVr+AloS
        DRVJaPDSFE7HGHhak0kqer0/ldnyd1JHODHbfbc=
X-Google-Smtp-Source: APXvYqz3DeSoiGwKKDIcPoJqgfU4Ty96fsiCpUNjXM8TJHs9coG+3i679gbVDi1obEmylCKIAkcihrgVN0t1JpV5MgQ=
X-Received: by 2002:a2e:91c3:: with SMTP id u3mr1384364ljg.130.1558168104656;
 Sat, 18 May 2019 01:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAN2Gq-Rb3v8-8PKmKUGKJ3wP-UvAF2n59a9UGbtjiGibE8q=zg@mail.gmail.com>
 <b3e170ed-ca5f-c754-892a-d11d4b71d989@iee.org> <CAN2Gq-RNt2x-023qC2LWawYGUz5g08=oVK+ub4iLGnh90aQdyQ@mail.gmail.com>
In-Reply-To: <CAN2Gq-RNt2x-023qC2LWawYGUz5g08=oVK+ub4iLGnh90aQdyQ@mail.gmail.com>
From:   Rocky Ji <rockyji3438@gmail.com>
Date:   Sat, 18 May 2019 13:59:11 +0530
Message-ID: <CAN2Gq-TvGATQ_Nn1UDVgf4MxKeY83BDPNHdiOQiqSiETevQeZQ@mail.gmail.com>
Subject: Re: How to update Git's metadata without affecting working dir?
To:     Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip Oakley,

Minor correction: the Google groups question is a duplicate of this &
not the other way around.

My first mail to git[at]vger.kernel.org got rejected, claiming some
virus reason (I don't even know C or OS basics, server is just blaming
me). So I reposted it from live-ubuntu machine; I was afraid my
question would never show up on mailing list.

Also git-scm site says this mailing list is for bug reports also. I
was afraid my question would be ignored as trivial.

Because of those doubts, I duplicated it on
git-users[at]googlegroups.com, I had no intention to spam this awesome
group.

Thank You.

On Sat, May 18, 2019 at 5:42 AM Rocky Ji <rockyji3438@gmail.com> wrote:
>
> Hi Philip Oakley,
>
> Minor correction: the Google groups question is a duplicate of this & not the other way around.
>
> My first mail to git[at]vger.kernel.org got rejected, claiming some virus reason (I don't even know C or OS basics). After reposting; I was afraid my question would never show up on mailing list.
>
> And git-scm site said this mailing list is for bug reports also. I was afraid my question would be ignored as trivial.
>
> Because of those doubts, I duplicated it on git-users[at]googlegroups.com
>
> On Sat, May 18, 2019, 02:24 Philip Oakley <philipoakley@iee.org> wrote:
>>
>> This is a duplicate of a question on the Git Users list.
>>
>> On 17/05/2019 18:04, Rocky Ji wrote:
>> > I am working individually at the moment.
>> > I have the habit of committing related changes on a regular basis, but
>> > I push to GitLab only at the end of class session.
>> >
>> > -------Events to reproduce the situation--------
>> >
>> > Thursday, in school:
>> > - `git clone https://gitlab.../my-repo`
>> > - create a few .rst documentation files
>> > - commit the above changes before I `git push -U origin master`
>> >
>> > Friday, in school:
>> > - start working on new feature, create a test file `test_A.rb`
>> > - I commit the changes but forget to push
>> >
>> > Sunday, **in home**:
>> > - I `git clone https://gitlab.../my-repo`
>> > - work on the exciting new feature that popped in my head, create `feature.rb`
>> > - commit the changes before I `git push -U origin master`
>> >
>> > Monday, in school:
>> > - running `git status` shows `Your branch is ahead of 'origin/master'
>> > by 1 commit.`
>> >
>> > --------end problem reproduction----------------
>> >
>> > Questions I have
>> >
>> > 1. What will happen if I follow Git's recommendation `use "git push"
>> > to publish your local commits`?
>> > 2. How do I resolve this situation? I don't want loose any information
>> > i.e. preserve `test_A.rb` and `feature.rb` along with their commit
>> > messages and timestamps.
>> > 3. Why does Git assume that local-working-dir is "ahead" without
>> > consulting the Gitlab server first?
>> > 4. How to make Git "consult" (but not mess the working-dir) GitLab
>> > repo before starting my day's work?
>> >
>> > Thank you.
>>
