Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08DCF1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 18:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeHJVDL (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 17:03:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:36189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbeHJVDL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 17:03:11 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjZhg-1gL33F0bzk-00bYst; Fri, 10
 Aug 2018 20:32:05 +0200
Date:   Fri, 10 Aug 2018 20:32:07 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/4] Introduce a function to lock/unlock file descriptors
 when appending
In-Reply-To: <xmqqtvo3bc0g.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808101843520.71@tvgsbejvaqbjf.bet>
References: <pull.17.git.gitgitgadget@gmail.com> <e449ed75fe3705692175017f98438815aeccf0fb.1533836122.git.gitgitgadget@gmail.com> <xmqqtvo3bc0g.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zYUP6Yc7U1PfmTPV0ShHE2F5olwLiKPXkdWfr4EEQ3OX1YVrhwt
 R7V+Deh2/4jBB3nUg+4Unc3Uqee482kb1IrrH5i7D/MFzXz7PTX95Qg9BT+Y3c3ZajaL2J5
 YTkMHkheC7UZSpd2Jn1AD24yRLtUR9dfqsJn0VA94LlTKcsZP2imQEd4jdyKTwJFQ4hFBvH
 orqq+RkleGZIr5IE5G9ZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3iHvPkpx+M0=:3F3J/gD+SC1o5KKhEqQcup
 /4vpePh7rq/Pr/dym/CJMOW2EzFchnpAVk+LO4Ragj1Hog8UqNrbwRulGUvzE3GgWkUHYWXUL
 0Z3INsyAHDUhkk9QV+E4cRBl4CJdNCfCgzGOK4lxBS4xeF7F4PPyGqiKueIY7+J8Tzc9vH/S3
 LrIFyPqftsJmqBtSgn+U4b4kr9674IMTj+njMzUjuJgOkGSGrexnuNtfs0p+EBFoFIYg3Ewit
 Aaj5SzBdiFo4KKZtyZuCqbSqCxLoTf4sy72ZniVq+5Ij5g1LXvE1AxNkI8W2c6WsTYwU8LWNH
 a8VNBiRpy6WSCKxYWw+r5qLZ2jDO2ZVcSt8p5v3LIAmQTzOhXvfExNwi8lGiJARsZ6nSv2tov
 xRjvldWnWLAJTl5LJsEYgNMWUUwoXod6u2poEwjEr3xwwOjiScWX6JAjg7CbySoHzP8hIvCQs
 2C5oNSx5xdbyo2qhpm3LYw56bhFYPFwMOj+ddYD0VBYC0hK8RG++lSNvLTzZ/MYHrkMBRirL5
 3LDSGNaMRRnlaWmXXpnMvTXSTN4nTdPWK96cuO9z+405C+bBu1fsh1CdU5a/taTDMgL7WP5X1
 Kn8xe0XzhIxDfd5b+kpWMZMDyvTR/hSG7rie99/5glinqj1ZhUk/6i7lyyqVPNcIjZmWUU1Mo
 4aohc4YHmTYYS4zMen/l/2ikUPPBfBH47NGD12ZDySFwpKknFZJpP2pDzcuVPxKc7PNrHsiwI
 e1VwOFSNX7FaZVXq8qFZetYPCbp6fWvfdEbwfTzCyJDEu2wUVADva61TkU11s7hrRzRYcPIwb
 Pq4Gocb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 9 Aug 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This function will be used to make write accesses in trace_write() a bit
> > safer.
> > ...
> > To set a precedent for a better approach, let's introduce a proper
> > abstraction: a function that says in its name precisely what Git
> > wants it to do (as opposed to *how* it does it on Linux):
> > lock_or_unlock_fd_for_appending().
> >
> > The next commit will provide a Windows-specific implementation of this
> > function/functionality.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > squash! Introduce a function to lock/unlock file descriptors when appending
> 
> If we can keep the custom, narrow and easy-to-port API (like this
> patch introduces) focused and resist feature creep over time, then
> it would be worth spending effort to come up with such a custom
> helper that is easy to port.  So I agree with the approach in
> general but I tend to think "set a precedent for a better approach"
> is a way-too-early and wishful verdict.  We do not know if we can
> really keep that custom API easy-to-port-and-maintain yet.
> 
> In short, even though I agree with the approach, most of the
> verbiage above is unnecessary and mere distraction.

I disagree that it is a distraction, because the commit messages are the
very location where I am supposed to detail my rationale, motivation, and
considerations that are not obvious from the diff alone.

Of course, I cannot force you to take this commit message, you can
overrule me and edit it. But you would do this against my express wish.

> > ---
> >  git-compat-util.h |  2 ++
> >  wrapper.c         | 14 ++++++++++++++
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 9a64998b2..13b83bade 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -1202,6 +1202,8 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
> >  #define getc_unlocked(fh) getc(fh)
> >  #endif
> >  
> > +extern int lock_or_unlock_fd_for_appending(int fd, int lock_it);
> > +
> >  /*
> >   * Our code often opens a path to an optional file, to work on its
> >   * contents when we can successfully open it.  We can ignore a failure
> > diff --git a/wrapper.c b/wrapper.c
> > index e4fa9d84c..6c2116272 100644
> > --- a/wrapper.c
> > +++ b/wrapper.c
> > @@ -690,3 +690,17 @@ int xgethostname(char *buf, size_t len)
> >  		buf[len - 1] = 0;
> >  	return ret;
> >  }
> > +
> > +#ifndef GIT_WINDOWS_NATIVE
> > +int lock_or_unlock_fd_for_appending(int fd, int lock_it)
> > +{
> > +	struct flock flock;
> > +
> > +	flock.l_type = lock_it ? F_WRLCK : F_UNLCK;
> > +	flock.l_whence = SEEK_SET;
> > +	flock.l_start = 0;
> > +	flock.l_len = 0xffffffff; /* arbitrary number of bytes */
> 
> If this can be an arbitrary range, do we need to cover this many (or
> only this few, depending on your point of view) bytes?

It can be an arbitrary range, but it does not matter at this point because
we expect only appending callers. Therefore any range will do, as long as
it covers the range of bytes to be written by the trace functions. And
with 0-0xffffffff, I am fairly certain we got it.

Technically, we could even lock the range 0-1, as all of our callers would
agree on that, and block each other. Other Git implementations might not,
though. So 0-0xffffffff is my best bet and cheap.

> Would it be sufficient to cover just the first one byte instead?

As I said, this would depend on no other software trying to append to the
trace file, including alternative Git implementations.

In other words: it would be "too clever". Clever, but asking for problems.

> Or perhaps give l_len==0 to cover all no matter how large the file
> grows, which sounds like a better range specification.

I must have overlooked that option in the documentation.

*clicketyclick*

Indeed,
http://pubs.opengroup.org/onlinepubs/9699919799/functions/fcntl.html
spells it out pretty clearly:

> A lock shall be set to extend to the largest possible value of the file
> offset for that file by setting l_len to 0. If such a lock also has
> l_start set to 0 and l_whence is set to SEEK_SET, the whole file shall
> be locked.

Sorry about missing this. I will change the implementation to this.

> > +	return fcntl(fd, F_SETLKW, &flock);
> > +}
> > +#endif

Thanks for helping me improve the patch,
Dscho
