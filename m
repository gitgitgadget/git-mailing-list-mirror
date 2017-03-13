Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EFBF20373
	for <e@80x24.org>; Mon, 13 Mar 2017 19:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbdCMTjD (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:39:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:58339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbdCMTjC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:39:02 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTjqS-1cebpr17x2-00QUu0; Mon, 13
 Mar 2017 20:38:43 +0100
Date:   Mon, 13 Mar 2017 20:38:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v5 10/11] setup_git_directory_gently_1(): avoid
 die()ing
In-Reply-To: <xmqqefy5yn4k.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703131826330.3767@virtualbox>
References: <cover.1488897111.git.johannes.schindelin@gmx.de> <cover.1489098170.git.johannes.schindelin@gmx.de> <a1e24f1b31773f4d2f7f06ab7d5870e920211d51.1489098170.git.johannes.schindelin@gmx.de> <xmqqefy5yn4k.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eBb1H2SYaP3PnkFrGnbXbwCrDB5fzAh53sGPsLFyWNX12A/7bN6
 4cV0xmTyEhWvYPq6lT8+pQstzKEGmBxQv9fF5UIP2QOIM4OTvSGDklpBS2DeCbmkKtB+Vkr
 pV/mbms4P8w+xKef+BPRNod6xK2MYbz8gv3Iu9GbfUDcp0NqLV+DWJfre8oNvkOOjgLkttB
 o2l0Sxw524TZ3h5AK0ilQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dI2HKoLEW/k=:k/3mcaoia13RdenLCkyOzP
 D6AJiQlmnRSir/sZUA4Ysdy/XZ+rRa2BclE3vadrcnXHix3Z53WQB5L/N2dGw+rhi/nAfow5a
 ArtqZrTa7Bf+jFm5IhW8RKvk67haX9cat56kYCzMXkWFwuGb+Y2s7GMfhEst2v7SNkyB1zoZj
 DCkUCHD2EwTZjQaWNC7OByXGg4XOfjURDqyE6O92h6SKmQ+4ezLGtb/6UtdAleQz8+z9DTauV
 K+tRUKtcoCQKbPDkc8x04ThW/DvZuZgTPFgmB3NZieqXrme8OxfwTobPJYAS1H4SqFStkiMSR
 RnofgYU2Dotgm1+QBALkuTOcmAUf0qIE4oWLKD8IrRV5ybT5WEK8gF3QzR9yXETyC8lSBfZVh
 EwMzoT0reQNnjV90kOUfpWxGTWQKysCGtWCkEK6jqO3hcxmKWiaIrpA+k1nLhNpI4tPN/e95B
 f097hB+ZCiCm9BMavxFEL6wY2S3l5CF9nri/DM8FSbwNApSUJ6Ph6GhBkD+pbmtirvdCb2PBu
 4pr4c8Qy/QxPp2RmouYOmkvvIDiSPk6PVWW+CnLJD4QCHM2pO9Z+H/aPOKbDw3QADyY3JjYkh
 6Um0jAH+vmLl5N2VhOhlDW6nvgkKPBPe5BygaU2CIn1Qh7BpjODNO1Cyhk7ERCWI9PqI1y/bP
 k0/JpEp+4XNggeWQNzYSb/g9UjIBS8H1Fy3x+0M3MMNInBNwmXde8Jl2/usoy4Fmwd83mGj+R
 LDilUfsD88SLqagmVaQu4E123vEZbttuuxfuDY5GaFfAYj4BFFgVOj3agtZdlx+82U3nIfUdN
 C5kQ2Bz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

PLEASE NOTE: the purpose of this patch series is to allow the same
function (setup_git_directory_gently_1()) to be the work horse for
setup_git_directory() as before, but also for the new
discover_git_directory() function that is introduced to fix
read_early_config() to avoid hardconfig .git/config.

The purpose is *not* to change any current behavior. Please do not ask me
to do that in this patch series.

Now to your comments:

On Fri, 10 Mar 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > @@ -890,14 +892,22 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
> >  	if (one_filesystem)
> >  		current_device = get_device_or_die(dir->buf, NULL, 0);
> >  	for (;;) {
> > -		int offset = dir->len;
> > +		int offset = dir->len, error_code = 0;
> >  
> >  		if (offset > min_offset)
> >  			strbuf_addch(dir, '/');
> >  		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
> > -		gitdirenv = read_gitfile(dir->buf);
> > -		if (!gitdirenv && is_git_directory(dir->buf))
> > -			gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
> > +		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
> > +						NULL : &error_code);
> > +		if (!gitdirenv) {
> 
> We tried to read ".git" as a regular file, but couldn't.  There are
> some cases but I am having trouble to convince myself all cases are
> covered correctly here, so let me follow the code aloud.

It is subtle and finicky, I agree.

> > +			if (die_on_error ||
> > +			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
> > +				if (is_git_directory(dir->buf))
> > +					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
> 
> If we are told to die on error, but if it is a Git directory, then
> we do not have to (and want to) die and instead report that
> directory as discovered.
> 
> If we are to report the failure status instead of dying, we also do
> want to recover when the read_gitfile_gentrly() failed only because
> it was a real Git directory.  READ_GITFILE_ERR_NOT_A_FILE could be a
> signal for that, and we recover after making sure it is a Git
> directory.
> 
> Among the READ_GITFILE_ERR_* codes, ERR_NOT_A_FILE is the only one
> we attempt this recovery.  All others just take the "else if" thing
> below.
> 
> What happens when is_git_directory() test here does not pass,
> though?  Let's say stat() in read_gitfile_gently() found a FIFO
> there, it gives us ERR_NOT_A_FILE, is_git_directory() would say
> "Nah", and then ...?  Don't we want the other side for this if()
> statement that returns failure?

The current code as per `master` detects the NOT_A_FILE condition, and as
the parameter return_error_code was passed as NULL (because read_gitfile is
actually #define'd in cache.h to call read_gitfile_gently with NULL as
second parameter), it calls read_gitfile_error_die(). That function
*ignores* the NOT_A_FILE error condition, and as a consequence returns to
read_gitfile_gently() which then returns NULL because there *was* an
error_code.

That means that setup_git_directory_gently_1() will retrieve a NULL from
the read_gitfile() call, which means it then goes on to test whether it
is looking at a .git/ directory via is_git_directory() and if that returns
false, the loop will continue to look at the *parent* directory.

That, in turn, means that what you are asking for is a change in behavior,
and as I am unwilling to introduce a change in behavior with this patch
series, my patch does the exact right thing.

> > +			} else if (error_code &&
> > +				   error_code != READ_GITFILE_ERR_STAT_FAILED)
> > +				return GIT_DIR_INVALID_GITFILE;
> > +		}
> 
> On the other hand, if read_gitfile_gently() didn't say "we found
> something that is not a regular file" we come here.  If the error
> came because there wasn't ".git" in the directory we are looking at,
> i.e. stat(2) in read_gitfile_gently() gave ENOENT, it is perfectly
> normal and we just want to go one level up.
> 
> But shouldn't read_gitfile_gently() be inspecting errno when it sees
> a stat() failure?  If there _is_ ".git" but we failed to stat it for
> whatever reason (EACCES, ELOOP,...), we do not want to go up but
> give the INVALID_GITFILE from here, just like other cases, no?
> For that I imagine that ERR_STAT_FAILED needs to be split into two,
> one for true ERR_STAT_FAILED (from which we cannot recover) and the
> other for ERR_ENOENT to signal us that there is nothing there (which
> allows us to go up).

True. But again, you are asking for a *change in behavior*, which is not
the purpose of this patch series.

> By the way, is the "error_code &&" needed?

It is not! I had the order of the if/else blocks completely differently
originally [*1*] and just overlooked that the error_code could no longer
be 0 in that condition.

Ciao,
Dscho

Footnote *1*: Yes, I wanted to construct an English sentence with three
-ly words in a row.
