Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4C81FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 15:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933428AbcLIP6k (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 10:58:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:54214 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932664AbcLIP6j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 10:58:39 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhRI2-1c1Xwo1TG6-00MckV; Fri, 09
 Dec 2016 16:58:32 +0100
Date:   Fri, 9 Dec 2016 16:58:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     David Turner <novalis@novalis.org>
cc:     git@vger.kernel.org
Subject: Re: [REGRESSION 2.10.2] problematic "empty auth" changes
In-Reply-To: <1481231552.20894.20.camel@frank>
Message-ID: <alpine.DEB.2.20.1612091048540.23160@virtualbox>
References: <alpine.DEB.2.20.1612081538260.23160@virtualbox> <1481231552.20894.20.camel@frank>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RADek6grhxGVZ2ueIzDKMJd9i/K1JkVjKlg6eVRoRJOeH087/wu
 ZaMxFEnMy7FhQJ0FLYQVWHX2tzAvwAIriVYbAKlcv3vCV4acuCba81/KtGr87KaqUocxC6x
 AHfkbjeZ+mF4Vj6bKwqfC8uXm3VbA9gTgZmdK7UjL8DG9vlwvOAnGHS/Bz39TujMPx0ELU4
 BF9E1kUqhqcPrbRbPyEug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QNMVljx3BKQ=:Gub4fErowNrle4BriSLtab
 vvqVsLP4lxSPLLxTmOv+p4oLil4yfY/oQY6zHns2IKUUoFPi8ke7tJ+3ZE49afUSoXJ85wbDp
 MwveIh3RtQb9MpACm8ADLAZ7Cf+30n8PKqrHI1h5wRrqK62x9OZWyvJkCBtJhMAzrMh9m9pS6
 AMRISULB/PTWF18cLL4elBfks+Fb0jqbzZ83vn4M5OfGFTQAnCzXC2PIjya8OYXoXPJxliEJj
 z3lEQyYsckzE30J1M+9zOCzgsvzBtu3JAuu2CBSrIJ6TyVwTOWkfxYn4qRuTU9uhwAWGtBP3Y
 ajkzJy3grHaG8SQKd7gYbgqFvgzDk0Ef/Li6MY32aEBj5kRh4rFN+Nm3kbLLfj1G+iQpwURRC
 uN29ap/RNI9Hv14teiva6rbZ1SsIAzOL3hw1f9fYINKczjWfr7vYBxmfRsbWWhNKlYjggs6CN
 fwy/6X97J4qROGMVUde5mY+ZEHTV/kXk5BbaBNS+jXCnwBSBSYo5mKeRnNXLdslYcUMRmCC0U
 YGY8zsZ5C97WxExkzAgktgU5KJK1E+R9fv7WiNrM3FwbSpWWq8rPUhHC3Ds6np4RaMPdyHxwx
 n1NQHbH+wj0raSCPfWs0EFhyK90Hreb4IRng/pVl6piPVFkV5/4aleKx0PIIfq/WmFXzDnOyp
 knCDfi/WXaLFmntOpWyjP73Z0CyKg2juOvqVUmqiKslpLc65JM1kgOdSake6qfutnetrPnkxv
 +HqcrKKTLFACQpl2hfkaifpLKvx6YUDUnNRuhzEf4y1td0g+0aB3WosfeKcAl9KDMQrwydxvL
 4sz+bTX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

On Thu, 8 Dec 2016, David Turner wrote:

> On Thu, 2016-12-08 at 15:47 +0100, Johannes Schindelin wrote:
> 
> > I got a couple of bug reports that claim that 2.10.2 regressed on
> > using network credentials. That is, users regularly hit Enter twice
> > when being asked for user name and password while fetching via
> > https://, and cURL automatically used to fall back to using the login
> > credentials (i.e.  authenticating via the Domain controller).
> > 
> > Turns out those claims are correct: hitting Enter twice (or using URLs
> > with empty user name/password such as https://:tfs:8080/) work in
> > 2.10.1 and yield "Authentication failed" in 2.10.2.
> > 
> > I tracked this down to 5275c3081c (http: http.emptyauth should allow
> > empty (not just NULL) usernames, 2016-10-04) which all of a sudden
> > disallowed empty user names (and now only handles things correctly
> > when http.emptyAuth is set to true specifically).
> > 
> > This smells like a real bad regression to me, certainly given the time
> > I had to spend to figure this out (starting from not exactly helpful
> > bug reports, due to being very specific to their setups being
> > private).
> > 
> > I am *really* tempted to change the default of http.emptyAuth to true,
> > *at least* for Windows (where it is quite common to use your login
> > credentials to authenticate to corporate servers).
> > 
> > Before I do anything rash, though: Do you see any downside to that?
> 
> I know of no reason that shouldn't work.  Indeed, it's what we use do
> internally.  So far, nobody has reported problems.

Good.

> That said, we have exactly three sets of git servers that most users
> talk to (two different internal; and occasionally github.com for
> external stuff).  So our coverage is not very broad.

Okay. I think I will extend that coverage rather boldly, then ;-)

> If you're going to do it, tho, don't just do it for Windows users -- do
> it for everyone.  Plenty of Unix clients connect to Windows-based auth
> systems.

Makes sense.

> That said, I could imagine that there are cases where it would cause
> failures for a different set of users.

Let's see. At the moment, my main concern is that Git for Windows is
broken for corporate users (i.e. users who rely on the implicit
login authentication provided through their domain accounts). I cannot
imagine that defaulting http.emptyAuth=true could cause any worse
breakage.

It would be different, of course, if http.emptyAuth would *not* allow the
user to type their credentials when accessing something like
https://github.com/dscho/shhh-secret-repository, *only* trying the login
credentials. But that is not the case, with http.emptyAuth=true, login
credentials are attempted first, and when they fail, the user is still
asked interactively for their credentials.

All I can see is that this would be *an improvement*: corporate users
trying to access a Git repository that requires their login credentials
would now not even need to enter empty user name/password.

This alone would be already a good reason to change the default, IMHO.

So here is my plan:

- change the default of http.emptyAuth to true in the next Git for Windows
  version

- publish a prerelease for early adopters to test

- contribute this patch here on the Git mailing list, in the hope that it
  will make it into the next major version

Ciao,
Dscho
