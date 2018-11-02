Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672F11F453
	for <e@80x24.org>; Fri,  2 Nov 2018 20:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbeKCFPT (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 01:15:19 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:45995 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeKCFPS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 01:15:18 -0400
Received: by mail-vs1-f46.google.com with SMTP id 124so1736844vsp.12
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUj27pAU5ZLzRGVvroYj9Vr6u8+R+MaU7Ofzx6DF4Dg=;
        b=mYK0j/Fsic3MQOcCfs1X+tYDWetKFg+c6quYnfPI9Wlo2rtnWqXoUTQYPsK2jmTVDa
         /AeRFvZFPowoYcOqWFZtDUfxvycL+s5+kfBSApVMQAcmccbDF+QKgtUaXgVYRB/fhUqM
         LsbbJCRltg5DFgtKuvGPard1cVTremXmjv7MRE3+5cmNc5uw6zqsti9aMoP9+u8jn71a
         1BmOnBb49q+2nSv/zZ1Q7hw38PWG6gMVFdq5ni4bSJsg+InSUiOtu8w9nSh1SLqQPmen
         EYC2Q+GhdkGB6HYkD4o9QD/cNE4+R9UwHmugGKn4H7kfGdduw8j3v65krdZ0B2lN7/RV
         n1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUj27pAU5ZLzRGVvroYj9Vr6u8+R+MaU7Ofzx6DF4Dg=;
        b=MvaowYDZ2/c44B0MkcBzZNS/QiFiBPI1FLUY7INTMqYJ5ewNz0IySAPs5PiqRlJrQD
         yjkE2wlF323FrCcTgWfAM70UOgjMirhZbpn7FxljLcAKU4PgABzm7VTYqcZ+GN+n4SXW
         91sCOkZH5L5RcYIqyR5RS9/OklAw1qRW9O9rmuIiEqbrLi7svV3xWz0Xrw163zLm21Fn
         /PywfWLXDgLTVcmy6RwmhfrAns6YifnLoA27qCN1Y4QrrD/yXjdgI4rodQVhJOKmzSb/
         tKAPnRbVxm3SafgdtjLLdTUoxjhI0nzjcnpe3A2q2PQ7iiLw5sUi1L9+EhgOKC4v18Wf
         t+RQ==
X-Gm-Message-State: AGRZ1gKSjodmsar+fs/f/lmrpLFWlQ2i6uANNjp0aoAV/Rr08q4/jfkn
        DWYuPIKBOdJmd1tdM6R4aw7s1JTrg7sCnalT2SfEG0N/
X-Google-Smtp-Source: AJdET5fme7qatWRmjIH6DttKaOH/zFPAoXdgsONZcLCp/pjQOBKrTsGvluvIPzh7gikv+pDnhsggHho/34+jLD1QlBs=
X-Received: by 2002:a67:7648:: with SMTP id r69mr5775331vsc.175.1541189205278;
 Fri, 02 Nov 2018 13:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181019193111.12051-1-newren@gmail.com> <20181102185317.31015-1-newren@gmail.com>
 <232094ce-6872-4039-06a6-af40c709cac0@gmail.com>
In-Reply-To: <232094ce-6872-4039-06a6-af40c709cac0@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Nov 2018 13:06:32 -0700
Message-ID: <CABPp-BG2rFEeKVe8ok+a-jLFvPBfnZs1b3Mp2Jfi2JgNZcO8gA@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Improve path collision conflict resolutions
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 2, 2018 at 12:09 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/2/2018 2:53 PM, Elijah Newren wrote:
> > Major question:
> >    * You'll note that I edited the last two patches to mark them as RFC.
> >      To be honest, I'm not sure what to do with these.  They improve code
> >      coverage of new code, but the same gaps existed in the old code;
> >      they only show up in the coverage-diff because I essentially moved
> >      code around to a new improved function.  Since the new code doesn't
> >      really add new abilities but rather just shifts the handling of
> >      these conflicts to a common function, they shouldn't need any more
> >      testcases than previously and modifying the existing patches thus
> >      feels slightly misleading.  That line of thought leads me to believe
> >      that perhaps putting them in a separate combined patch of their own
> >      with a decent commit message is the right way to go.  On the other
> >      hand, squashing them to the commits they're marked as fixups for
> >      shows which logical part of the code the tests are related to, which
> >      seems like a good thing.  So what's the right way to handle these?
>
> I appreciate the effort you made to improve test coverage! It's
> unfortunate that this portion wasn't covered earlier, because we could
> have broken it and not noticed until a release.

Yes, I agree...except that I think we might not have noticed until a
couple releases down the road; these things tend to not come up a lot
in practice.  (Which may make it even more important to pay attention
to code coverage.)

> I think making them separate commits is fine, and the comment on the
> test case is helpful. The fact that you only had to change the commit
> timestamps in order to get the coverage makes me reexamine the code and
> realize that maybe the "right" thing to do is to reduce our code clones.
> (This is also how I was looking at the wrong block of the patch when
> talking about it not being covered.) I'll look at the patch and see if I
> can contribute a concrete code suggestion there.

Yeah, I had the same feeling, _again_, while re-looking at the tests
and code as well.  I think the history of how we got here goes
something like this:

  * there is some fairly simple code to handle these rename/rename
(1to2 and 2to1) cases, with logic for handling each side being a
neary-copy of each other.
  * someone does some analysis about trying to remove duplication and
notes that there are 3-4 pieces that change; adding logic to change
out those pieces and rewrite it as a loop adds some complexity, which
isn't worth it given the simple code
  * additional issues are discovered, such as D/F conflicts or
inappropriate handling of untracked or dirty files, and due to
merge-recursive's bad design[1], the fixes have to be sprinkled
*everywhere* throughout the whole code base.  Lather, rinse, repeat a
few times.
  * Now, although the original analysis of removing the duplication
was correct given the amount of code that exited at the time, the
weights have changed as new code was added to both codepaths.  But the
original analysis is long since forgotten, the code is more complex,
and we have to think about whether fixing it now is worth it if we're
going to rewrite it all anyway to fix that fundamental design flaw[2].

[1] https://public-inbox.org/git/xmqqd147kpdm.fsf@gitster.mtv.corp.google.com/
[2] https://public-inbox.org/git/xmqqk1ydkbx0.fsf@gitster.mtv.corp.google.com/


> Aside: I hope that I am not being annoying by poking around with the
> test coverage reports. It does give me a way to target my review
> efforts, especially into changes that touch areas outside my expertise
> (like this one).

Not annoying at all; I think it's a very valuable thing you're doing.
And I think these tests make things better (there have definitely been
cases in the past where a merge one way would work and a merge the
other way would have funny bugs).  I was just unsure about what the
best way to present it amongst the other changes was.
