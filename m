Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E662B211BC
	for <e@80x24.org>; Thu, 27 Dec 2018 23:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbeL0XFA convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 27 Dec 2018 18:05:00 -0500
Received: from elephants.elehost.com ([216.66.27.132]:21747 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbeL0XFA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 18:05:00 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea ([99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wBRN4qYd059310
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Dec 2018 18:04:53 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     "'Stefan Beller'" <sbeller@google.com>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Joachim Schmitz'" <jojo@schmitz-digital.de>
References: <002401d49d07$325c7900$97156b00$@nexbridge.com> <875zwm15k2.fsf@evledraar.gmail.com> <87pntmegq1.fsf@evledraar.gmail.com>
In-Reply-To: <87pntmegq1.fsf@evledraar.gmail.com>
Subject: RE: Missed Commit in 2.20.1
Date:   Thu, 27 Dec 2018 18:04:46 -0500
Message-ID: <001501d49e38$931aa0a0$b94fe1e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEkOnglU4pVwJdNRvieFq8SenQIdwJL1nZkAq7jI+ymzCLSEA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 27, 2018 17:40, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Dec 26 2018, Randall S. Becker wrote:
> 
> > Please stay tuned for patches. We are very much looking forward to
> > having the two (or three) different NonStop hardware personalities
> > supported without mods in the very near future. Our goal, assuming
> > those patches are acceptable, is to move our build/test/distro into a
> > Jenkins config that runs with minimal human involvement (a.k.a. me).
> 
> Portability patches like that are definitely wanted.
> 
> In case you haven't seen my recent work on getting GitLab CI up & running
> check out https://public-
> inbox.org/git/875zwm15k2.fsf@evledraar.gmail.com/
> 
> It differs from existing CI implementations for git.git in being focused on
> doing the actual run on remote hosts that can be ssh'd to.
> 
> So perhaps you'd be interested in some of:
> 
> a) Contributing a NonStop box to the GCC Compile Farm
>    (https://cfarm.tetaneutral.net/machines/list/). Then I can add it to
>    my tests, but also other people porting free software will fix bugs
>    pro-actively before you spot them.

If I win the lottery, sure. Right now, a contribution like that is a bit beyond my budget. I'm not sure that anything "GCC" will fly with management since GCC does not port to the platform at all at this point in time. Many have tried. Many have failed. We're limited to c89 and c99.

> b) I now have a gitlab-runner I maintain powering this git-ci.git stuff
>    & presenting it on gitlab.com, if you give me SSH access I can add it
>    to my own runs...

Sorry, no can do on this one.

> c) ...or you can just run your own gitlab-runner on
>    https://gitlab.com/git-vcs/git-ci/ (although this amounts to giving
>    me ssh access, since you'll be running my code)....

This may be more possible. I've been considering putting up a GitLab instance but it's a matter of not having enough time. I have more than enough LXC ubuntu instances still available for something like that.

> d) ... or reuse the CI code I wrote to setup your own runner/pusher
>    against NonStop, only you'd have access to this....

More likely. Private chat worth it perhaps.

> e) Or do whatever you're planning with Jenkins.

We are currently using Jenkins to build/test git. I was thinking about contributing a Jenkinsfile that would build on a Controller (what happens today for our git port), or setting up a parameterized form for SSH for an Agent that might be better in a farm setting. I am close to the point where human interaction is limited to 'git branch -f production vn.mm.l' and git is tested and built for distribution without further touching. At least once my platform patches are applied it will be.

> If you want to just go with e) that's fine, just saying that you could re-use
> some existing stuff with a-d) if you wanted.

I am interested. Let's see how my $DAYJOB goes in the next few months. I really do like the idea of setting up a community instance of GitLab to do this and include a CI runner. Hmmm.

Cheers,
Randall


