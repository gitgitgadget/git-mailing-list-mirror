Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21761FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 11:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161117AbdDULrD (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 07:47:03 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35228 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036416AbdDULq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 07:46:58 -0400
Received: by mail-lf0-f45.google.com with SMTP id 75so43508491lfs.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UFcbaJudD7tqYPG5utC4ruO3+37AoRtXkW3qnhw9NUg=;
        b=e+LMM102ESmyMA437eYr5Pn/DU9NcEm2TVc9th9XML/ud2D9kqZ07gqhRhwRNTjM3E
         EdUHGDL8RnRFyHHoYQ9+UK+5mLMcCis/P3H+NHC3FQrjKUdwF0gKrPj+4d2ttv34VQm4
         OmzScZKPppFx4PG2OyXiO3St/LxmQP+8Nj8aAZYLLzWPmG16l49UcPP4PlkrWAH1tHtx
         ngh0AjoYgvnf3XmqD67wdb2FxADgKnVu+6vX4WvSUc+Tqy4jzT1Fj7/J4tESMlw63NRq
         e3+ICRhmYr4o+dUvd8lw0QVPkbB0Cqi3TZOvRlt0m8crL4HN6ttFJ/+zE3rXMP26YCW8
         5dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UFcbaJudD7tqYPG5utC4ruO3+37AoRtXkW3qnhw9NUg=;
        b=U5/z2pxB1RfqBSiDB90f+q5LDe492Muu9el4KG2RlfwyOTRxKmC7DmKQoDt8KypOae
         tnr37/IMWI2XtXxtVnkofarQGWED2ZdLsUKgCkvqExM9Zj4J0KJmEw87ETiE0L2GdFU2
         9g1GzgD90tjJpjSpDe5ObmsFm5UgafIP279RwA2whPSDdEXPmb0kK+jDxhT8VVi9RwrB
         ERnNmIJEl/qbKvneqoVe2oVw8lFCCCQBu7Bek5eS9o3q31EdkJzZuKhNlH6SvJ5x2CoC
         f9y8MjBoR13gikLAFq7hUCC01UFw0o7FrNJ/Agd4IiLB9IYHdtG5pZT0YnM2/zHv2DQi
         dcqg==
X-Gm-Message-State: AN3rC/53QIRJbXjMCizeRu+FlJTuvsOuqv0/Jc3CwU66+HThlh9bFK20
        XhBldeaFervDBPNVaAkkbhZmc8lSNg==
X-Received: by 10.25.235.76 with SMTP id j73mr4286310lfh.151.1492775211469;
 Fri, 21 Apr 2017 04:46:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.67.78 with HTTP; Fri, 21 Apr 2017 04:46:51 -0700 (PDT)
In-Reply-To: <CACsJy8DotVErJjbUBmt9bxu90CSKEsqAT_nYTNXwstEk3YhN2g@mail.gmail.com>
References: <20170420205214.GB4989@hank> <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
 <20170420212436.GC4989@hank> <CAP8UFD25tJgQD=bREOG-_q0jCLw-nxhO6pYbOaaYMuAH4VxN3Q@mail.gmail.com>
 <CACsJy8DotVErJjbUBmt9bxu90CSKEsqAT_nYTNXwstEk3YhN2g@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 21 Apr 2017 13:46:51 +0200
Message-ID: <CAP8UFD2v-X3KfsvFSQrFvgTWRB7P684qN=DowNK2GunJys1i=Q@mail.gmail.com>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 11:53 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Apr 21, 2017 at 2:10 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Thu, Apr 20, 2017 at 11:24 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>> On 04/20, Christian Couder wrote:
>>>>
>>>> Could you try with the following patch:
>>>>
>>>> http://public-inbox.org/git/20170330210354.20018-1-chriscool@tuxfamily.org/
>>>
>>> Yeah, I tried with and without that patch with the same result.
>>> Unless I'm screwing something up when testing I don't think this fixes
>>> the issue unfortunately.
>>
>> Ok, I will take a look soon.
>>
>> By the way I think that GIT_TEST_SPLIT_INDEX has become redundant now
>> that there is core.splitIndex.
>> So perhaps in the long run it will be best to deprecate
>> GIT_TEST_SPLIT_INDEX and eventually remove it.
>
> I think you can't, at least the way I understand this variable. It's a
> _test_ variable to force exercise split index code path a whole lot
> more, by running the entire test suite with split index always
> enabled, instead of just a couple in  t????-split-index.sh. We can't
> achieve the same with core.splitIndex because that's more about user
> control and you can't just set core.splitIndex for the entire test
> suite (can we?).

Yeah, you are right.
It looks like we have GIT_TEST_OPTS to pass options like --debug,
--valgrind, --verbose, but we don't have an environment variable to
set config options.
