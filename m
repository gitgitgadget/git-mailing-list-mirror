Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7106B1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 14:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeCGOgR (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 09:36:17 -0500
Received: from mout.web.de ([217.72.192.78]:34623 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbeCGOgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 09:36:16 -0500
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmcnP-1eJQPR0gFv-00aIQ1; Wed, 07
 Mar 2018 15:36:10 +0100
Subject: Re: [PATCH] xdiff: improve trimming preprocessing
To:     Eric Sunshine <sunshine@sunshineco.com>, Jun Wu <quark@fb.com>
Cc:     git <git@vger.kernel.org>
References: <1520337165-sup-4504@x1c>
 <CAPig+cRYsf161-Xomw7daj8XdEBxZAEQQRdOn4krRTpSAFkPOw@mail.gmail.com>
 <1520370729-sup-3241@x1c>
 <CAPig+cToTv063z-HB=8Y9LkpbqQaKCVJG_nU0Qd7O9ZdJY-p6g@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <35faf81e-b604-d5b5-be51-bfe5cb9ec4cc@web.de>
Date:   Wed, 7 Mar 2018 15:36:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cToTv063z-HB=8Y9LkpbqQaKCVJG_nU0Qd7O9ZdJY-p6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:3uDS1x8bcLW39OylMekY8rj2zBG4kUIxcbFIclxToSaYPdSY2OA
 eeq/J32SY+7SvG3EF9lRJhennFvY7XC0XVJLO1lmQNVPtKdfbWJbpug9hmlhPtO1jxbORT4
 s0EN9Skxyyi2DVuUvQVGQkQYRaTgeKjvF+HbH59AzJ6Sad1RRf5aqn7lq7SaCmdcUzuV87N
 +XLBFpOz0FLfkEtZYW82g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ieBmyt368OA=:QU+nTmhtSjMKokdAjmdYZQ
 fsQSGRIJUDRa1qT8ttuZ8sr6s+ewxuqHUWO67VCLUTl/NR5lOovAMVJQ4vq3RTZNBLdn1UPd6
 TnSzDUtPBAGQswzU6JMRYzgCW9izZ2N/0p2qNVkOlqeKDdJNaHiz/o3PehMou/QIQsxtndl3e
 bUnk3xT1zRqRffItCnEyIxw2OtqJ+fSg68i8j6ry7udUMHitwLsf75dTGr3ZPZs9ps8HUB11I
 JNi1LxkQ5XgEoea3xlQO+oVSat0TqcNcgYrpBwVoOE3Ac6pTFwq+mrX9NRNsPL/X3F09/8HX4
 mRnDLuNqENMmTA8WI7efYYiZ8POssvuaS2/yfAMusWw/Y0am/LWmQBqOr8ipoobThSsz+EMWE
 WyipofICa+WwW+dCukzK+fcKl4AzajVc8zDi8qzi09kUx0vi6WISHc36NaE3ZtEAy6fjkU8+6
 UFC/VyR8cT5mXBqt1AIZX6Ps4TccGjW2HTmVVPMcIof5KmqLOAoCp3YDnqRS+OMJMAVOe93+u
 4NlbhhcPfUl52hZS8JLDuW9feuSwe24vftccGR/Cc4W0E2UmCY5LliPKp9kmaIDA1o6eomb00
 OQWNd4wG+ahPh10ZlHyM6RK4xpje8lO3rxf5bOGtJUtKFh+ilLP/0K7kZdGDeK7zU0qW+HN6g
 qb0gPkjIY1mrh+yC09PpkoTxQDXyexiXMwI/yGd6IOQD7Lw752c/Xj9E1DNZLN0e75x3zX7NX
 MMrBw0HfH0mtmHfGPeZN61p5wZGKlMhwKVTN7onPrJtQ6+akpMuXRUxWvOYz8NqGxsaTX6L2l
 N66YtWPAbddJjzEWT5Pa8Px0F533L4kI1ze8XkPe2NMzqTc/sA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.03.2018 um 10:36 schrieb Eric Sunshine:
> On Tue, Mar 6, 2018 at 6:05 PM, Jun Wu <quark@fb.com> wrote:
>> Excerpts from Eric Sunshine's message of 2018-03-06 14:23:46 -0500:
>>> On Tue, Mar 6, 2018 at 6:53 AM, Jun Wu <quark@fb.com> wrote:
>>>> +  printf "x%.0s" {1..934} >>d # pad common suffix to 1024 bytes
>>>
>>> The expression {x..y} is not portable to non-POSIX shells.
>>
>> Is there a recommended way to generate a repetitive string?
>> Maybe `seq 1000 | sed 's/.*/x/'` ?
> 
> That seems reasonable, although you'd want to use the test suite's
> more portable test_seq rather than seq.

You could also use Perl's repetition operator (x):

	perl -e "print \"x\" x 934" >>d

It is a single command (only one fork()/exec()), simple, produces no
extra newline characters and it's already used e.g. in
t5300-pack-object.sh.

René
