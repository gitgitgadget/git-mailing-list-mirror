Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40451202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 17:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbdGERqX (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 13:46:23 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34944 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbdGERqW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 13:46:22 -0400
Received: by mail-pg0-f47.google.com with SMTP id j186so127696704pge.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f9GTHrENr3L2+S66AOS15FsCRXA1xvKWl8fCIh8pYKA=;
        b=tUGZBs/AXj5+dXhnRxw0mOn9u+8wqFiEvJkZVZ8c4mU6zf23OKK9OIobHzike87kAt
         lk9r+aGYksH3PYTYoCL1XPfJesrpD9IJGq2bxJ70xKVN+0GmRB94QrrKLpMvQEfZri5O
         bY1nhTJJThujQHlqJXgyWuU4pOd3YBRXWQDiyuASM19btJ//JzlvrAip98UoCIpa5gu/
         363RqKd9MMjFXQajtm5OVktqKnZXz5PD9MONKKuXWzNbw+hurfo6iytK2738IF3i4HX8
         1vjnr49Y3g8xpincU/Zxr7AFbh/8QstwDZVDK70XOMBCTEHnO3UOHErCLW2HOBaZvYHU
         Bjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f9GTHrENr3L2+S66AOS15FsCRXA1xvKWl8fCIh8pYKA=;
        b=LrouP5QUDZ/GR5oCYRrGeXcJAjpzETHkBjhmJ+5FdZID9DTWuDTGGdQ1BgPlL/6dDX
         RxVgo82BOtTmHMx7rgKlxEhwyKqgt3gpdsYjaajLN0Bz+j9MhoFdlQ9GwmmMePNrDdU3
         5S8RbJzvln8Y6mkJkcOiTJOLhcHWq2BmiAK9JlbGVy0k6vU3sAlcZ5Qu6LC6YN//SgRb
         cDl5obfzOA8z7Xe/Bq+Khn6y39Cn4EzYcPBcJb90qskIXPJKfuUgS+tyyR/acpQXGi34
         CyMWraFfcxoCErky1Tv0Yum7LhhxZj78ixJtxxvvhkT5C2XfbOCAAe7yN3p8mKKpk8IP
         bwkg==
X-Gm-Message-State: AIVw1103SPvrP6YNcnj6lVtNKoW+r6qdqj4XEUyduLQeHukFOOwQ83Ll
        RRGi0aUgBtPHYY26sZuIbvBW/H5jO3OiAII=
X-Received: by 10.84.224.74 with SMTP id a10mr23224706plt.210.1499276781987;
 Wed, 05 Jul 2017 10:46:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Wed, 5 Jul 2017 10:46:21 -0700 (PDT)
In-Reply-To: <xmqqinj7k5ot.fsf@gitster.mtv.corp.google.com>
References: <20170701220547.10464-1-avarab@gmail.com> <20170627121718.12078-1-avarab@gmail.com>
 <20170701220547.10464-3-avarab@gmail.com> <xmqqa84lmonj.fsf@gitster.mtv.corp.google.com>
 <874lutclie.fsf@gmail.com> <xmqq4luskt9l.fsf@gitster.mtv.corp.google.com>
 <87fuebbyvl.fsf@gmail.com> <CAGZ79kZqF3_PyrCnCMDyLNAUMRnvq96L3yoE0j=yzMigu4LUzg@mail.gmail.com>
 <xmqqinj7k5ot.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 5 Jul 2017 10:46:21 -0700
Message-ID: <CAGZ79kaHLi7iotAT-eKkFv5fsG1fTA2k4SYZAPAmU7h3uAA8Jw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 4, 2017 at 6:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, Jul 4, 2017 at 3:50 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>
>>>
>>> I think some invocation of "git submodule update ???" will do the same,
>>> but I can't from the docs see what that is right now.
>>
>> '--remote' is what you are looking for.
>>
>> When we have the branch field configured, the workflow for *creating*
>> the patch sent
>> to Junio might be different than it currently is. Currently, you would
>> send a patch that is
>> produced as:
>>
>>   git -C sha1collisiondetection pull origin master
>>   git add sha1collisiondetection
>>   git commit -m "serious reasoning in the commit message"
>>
>> This could be 'simplified' to
>>
>>   git submodule update --remote
>>   git add sha1collisiondetection
>>   git commit -m "serious reasoning in the commit message"
>>
>> but as we had different branches in the submodule field,
>> I wonder how much of an ease this is.
>>
>> For Junio the workflow stays the same, as he would just
>> apply the patch, so I understand why he might see the
>> branch field as pollution.
>
> My reaction was more about "the rest of us", not me or those who
> choose to bind a new/different commit in the submodule to the
> superproject.

Currently the rest of us would not care IMHO, as there is no
difference with the field recorded or not. (I just checked if it
would provide slight benefits for shallow clones, but not so)

> I was recalling a wish by submodule users in a distant past that
> lets "submodule update" to detach to the tip of the named branch in
> the submodule, regardless of what commit the superproject points at
> with its gitlink.

Yes, I heard that a couple times when poking around for opinions
and I think the issue has 2 facets:
* They actually want to be on a branch, such that the workflow
  is 'normal'. (Whatever that means, "detached HEAD" sounds
  scary, but workflow-wise it is not. It just requires an additional
  "checkout -b" once the work done seems worth preserving)
* None of the people I talked to wanted to get rid of exact-tracking,
  solely. But they always came in trade off with the first point
  outweighing the benefits of exact tracking.
  Although for this purpose the "update --remote" also doesn't
  quite fit as it does not re-attach the HEAD to a branch at
  the same commit as the remote tracking branch.

> When those merely following along with this project did "pull &&
> submodule update", I do not want the submodule directory to check
> out the commit that happens to be at the tip of their 'master'
> branch.  If "submodule update" requires an explicit "--remote"
> option to work in that way, then my worry is allayed, greatly.
>
> Thanks.
