Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FC3A2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 19:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbcF1TIf (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 15:08:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:59272 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbcF1TIc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 15:08:32 -0400
Received: from [192.168.71.20] ([77.179.59.51]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MdaiW-1azDbI0iVg-00PPmQ; Tue, 28 Jun 2016 21:08:24
 +0200
Subject: Re: Shallow submodule efficiency
To:	Stefan Beller <sbeller@google.com>
References: <f572d4ee-c618-6501-a8e5-717feca3ed7c@gmx.net>
 <CAGZ79kZQTv=QuuSGeYBQ+J89xQwtMmEsq7rvyFOAfSZfM+0YLA@mail.gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
From:	Martin von Gagern <Martin.vGagern@gmx.net>
Message-ID: <2808201e-130a-55a4-a4ee-70f4d2f428f6@gmx.net>
Date:	Tue, 28 Jun 2016 21:08:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZQTv=QuuSGeYBQ+J89xQwtMmEsq7rvyFOAfSZfM+0YLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:PLR4OK/URJ2lOzLTCdll+y5dHbELE0uynXCxDAcqoWpDT5Lduik
 bg1qGSbHn6+E0Vk7VFrHdOEdrRQ39QEfQN5ii4u+aTzdZmokI0Miy3U9YW//fmynGMJ2itt
 5W4wxKCi9/xn/1EYaXTgFlpWol4VfQ0L3YacvihMG7KWiPKHn7ccZ/mP+iQc628F9yrYWCw
 S3jD/u+sBPC6I6hqvhshA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:HYFABWGHnIE=:a90Q+hGZ7KYStuXWBkIaUM
 V/aJN2w1PIeOctQPUWbRdCRa1aBm0OKc27RPd327e/xcxYzfavgVEwxcnl1ekmC+sLjS109FD
 7but0khkj4xI+dJ+Fu6fISkcXlwZs80Ep5FuEZ16WbjAdXrBrjaMjXiOIXbap9K9MuJAPn11r
 8Fm8fVhX0aeP+cbobn8EpK5FYmreglOh4Q9VigJd0kAKcPYn1JLTpoM3jvkZFvdTddxR46ekS
 Sp/LAcG/9xk9R9xHdGLzTG8mRDj0DkiGJnA1IxlsLNXBlgEys4ohvfw9G6mqAQvRGXTjzJdVx
 aCOW7Ahb7X0EKIzfjEp3C6sQCh5ffoU+r2ZQa9SqOy8ExD3g23zfx4DRE2CdxXrTy4hIPkE11
 XI0T87NaCaHgYHPFQWBMR8uKijcEWqzS78CMbTAzt3pLlPGhRUmDLYdTI+Is2dY7f+C8Hfaxd
 egygll8EMu67rSOaaupcIyI6PICBSfVZD2iMqu9sQBRzs748gXiSRGFLJ5iZTmXOgkL/Cq+XD
 Dr3Scg/6ujZutmP0lyMNt4au+buHjbF3cJTg2QXppv4TISCEf4ZX+IbZ1kY42qkYGkTKeFQTe
 7cOhNRwQmgz6hjwod/o82u9iEVxj0y9fxm7rintlofT2DtUOZ1ZuJJzKmIojGthulNS5ofZml
 ZUUpCospqj3oe7ubuCevpUU0aZ/SVk1/YNNpk6eZV5gMztnPYdtzjKP496KXyZlsMUU/oc1Cm
 b6R2mcnHsl3z7tF92Kp2DgklSLK2+mJX+4Tsg4hU3nqpLasQ464wsSNvrHwwxxnJL+QcT5Dpy
 bKBIM9H
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Stefan,

On 28.06.2016 19:20, Stefan Beller wrote:
>> I have the feeling that “git submodule update --depth 1” is less clever
>> than it could be. Here is one example I observed with git 2.0.0:
> 
> 2.9.0 (as "Direct fetching of " is not part of 2.0.0 IIRC) ?

Yes, sorry. I had this tested with 2.8.3 at first, then waited for my
update to 2.9.0 to reproduce, and garbled the text while adjusting it.

> Makes sense! I think the easiest way forward to implement this will be:
> 
> * `git clone` learns a (maybe undocumented internal) option `--get-sha1`
>   `--branch` looks similar to what we want, but doesn't quite fit as we do not
>   know, whether we're on a tag or not. The submodule tells us just the
>   recorded sha1, not the branch/tag. So maybe we'd end up calling it
>   `--detach-at=<sha1>`,

That name makes a lot of sense to me.

>   that will
>   -> inspect the ls-remote for the sha1 being there
>   -> if the sha1 is there (at least once) clone as if --branch <tag> was given

Clone but detach, to be consistent. Yes.

>   -> if not found and the server advertised  allowReachableSHA1InWant,
> try again inside the clone

All of this has to pass through transport and get-pack, right?

> * `submodule--helper update-clone` passes the  `--get-sha1` to the
> clones of the submodules
> 
> * cmd_update() in git-submodule.sh will only checkout submodules and
> not try again
>   to fetch them if `just_cloned` is set as the cloning did the best it could.

Sounds like a very reasonable roadmap to me.

Do you think there will be someone volunteering to tackle this?

Greetings,
  Martin
