Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835031FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 13:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759334AbcLSNeO (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 08:34:14 -0500
Received: from mout.gmx.net ([212.227.17.22]:50078 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759145AbcLSNeN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 08:34:13 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMoU7-1cEsHJ3iZD-008XFd; Mon, 19
 Dec 2016 14:33:59 +0100
Date:   Mon, 19 Dec 2016 14:33:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 01/34] sequencer: support a new action: 'interactive
 rebase'
In-Reply-To: <xmqqk2b31sfs.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612191408250.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <297140020a7312af03136848dcdd0353ee3abdfe.1481642927.git.johannes.schindelin@gmx.de> <xmqqk2b31sfs.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qc/RqWyYukxYYxFBHreW5GuyCsnLJRLn7s3u4MdcDyWAfVnLUTe
 S5n1/bpAB2SsuBgmDtKUgeHdNR1FgBHhLCK+5Sxgu2izHOKaYFCY7TRWoMLnSAGxYLf444w
 /rVPB5+hEFQKwT/ogfyY9JtVsGx8RMPrkxcG2HCQjg6hNkGTiJP36p7WAaCAdGXpxA+GGn7
 GY13gDj7lNaHXpUeakI+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yJTVtRSqGxE=:eNCmqRME8uZWdeVyO49RYa
 ctCXaDsR6jNN4uwSHY8DL4TXgq/vUwG3GOzG7ITF10IqKVtwD8Frq54nYg8EoqKdURTBrPXwP
 WlmAUJUkuitvilxh1RM5bo/Dfl0LNCeUfdwjzPFHWUKfaoAs7hPWLYFRNpkBqnYw+qQQK0tCB
 4/vF1hraW2bwVa/lbNvpH39fIbweRvesND6uN04eOsIQUlv0IxRev5iYm+xau6r2RhkqQgHzH
 EdOAQM7W6zxzQJUrA4Hmzf0RSsy2j+ix1UrSqrgZSdSea8+7W4QTmL1JhyYeKEvAuvTgMAmCN
 hIFkDBW37nN7ik9IgN38ymFiUYDPY6z+s5lhibDM6CzqVvS3HGtq4OoRixp5AMu1MALFdoDGI
 DWR/ItXvaeBgljKwMqJLPI3s6acjrPruvCEYt+KgxYeLVPQy6hhRByUpv3Zc5xfCRsbFtvKBE
 v8RBAYtuu5M0fu/lmO3Lm4p9MhULQUj5dc1JFEDcUzk0cu/hPAZkHfjm34OX4Md+pAF8OeBGZ
 F16MzQcu+JnNZoVvXgE6s5s/WdeAD8MK+PADnSNx/5AHcqh/bwD29q6YGx51V6yonHHq+JhsO
 QfTXsXUMQWyOzeExVUQ1aPkQMWg+lKKppJg3QiTwgrYTgrcvK3IxnvuI5DezdIe2gSEkJhY3v
 LtvvdrN0pBGu1BDUFKeXyOHLc0gkH3PeFfcORM5BAa/nZWf1i+/Xdh7en4Le1a6WO0wlk/72g
 gAu9w2IMema++FlRA2R2c+q4VMGfWcwoibVBLVUsYUmxsN07MlPYmGCIXV+Ll0n1bHE2YwdC3
 PlyGN6K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > @@ -395,7 +414,10 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
> >  
> >  	if (active_cache_changed &&
> >  	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
> > -		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
> > +		/*
> > +		 * TRANSLATORS: %s will be "revert", "cherry-pick" or
> > +		 * "rebase -i".
> > +		 */
> 
> IIRC, the "TRANSLATORS:" comment has to deviate from our coding
> style due to tool limitation and has to be done like this:
> 
> > +		/* TRANSLATORS: %s will be "revert", "cherry-pick" or
> > +		 * "rebase -i".
> > +		 */

Aargh. I had fixed that in another patch series already, but failed to do
so in this here patch series. Sorry.

Fixed.

> > @@ -1204,6 +1226,9 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
> >  	const char *todo_path = get_todo_path(opts);
> >  	int next = todo_list->current, offset, fd;
> >  
> > +	if (is_rebase_i(opts))
> > +		next++;
> > +
> 
> This is because...?  Everybody else counts 0-based while rebase-i
> counts from 1 or something?

No. Since its conception, edit-patch-series.sh (the artist now known as
rebase -i) processed each line of the "todo script" by writing a new
"todo" file, skipping the first line, and appending it to the "done" file.

The sequencer chooses to write the new "insn sheet" after a successful
operation.

This is not an option for rebase -i, as it has many error paths and it was
simply impossible to express "save the todo script in case of failure" in
shell script.

I added a comment to clarify why the current command is not written to
git-rebase-todo.

Ciao,
Dscho
