X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: For all you darcs lovers: git-hunk-commit
Date: Wed, 6 Dec 2006 01:36:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612060129310.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612051936480.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <45760CA3.9060003@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 00:37:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45760CA3.9060003@xs4all.nl>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33394>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrkmQ-0006Qs-70 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 01:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758849AbWLFAgz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 19:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758829AbWLFAgz
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 19:36:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:58137 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1758849AbWLFAgy
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 19:36:54 -0500
Received: (qmail invoked by alias); 06 Dec 2006 00:36:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp010) with SMTP; 06 Dec 2006 01:36:52 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Han-Wen Nienhuys wrote:

> This is the interactive interface for commits in Darcs. It uses the
> same interface for pushing and pulling, where I mostly use y/n/a/d but
> sometimes the other letters too.
> 
> 
> ****
> Shall I record this change? (1/?)  [ynWsfqadjkc], or ? for help: ?
> How to use record...
> y: record this patch
> n: don't record it
> w: wait and decide later, defaulting to no
> 
> s: don't record the rest of the changes to this file
> f: record the rest of the changes to this file
> 
> d: record selected patches, skipping all the remaining patches
> a: record all the remaining patches
> q: cancel record
> 
> j: skip to next patch
> k: back up to previous patch
> c: calculate number of patches
> h or ?: show this help
> 
> <Space>: accept the current default (which is capitalized)
> ****

All but "y" and "n" are unsupported in hunk-commit.bash... Do you use all 
of these?

> If you want to get a feel for it, grab darcs and run

I already grabbed darcs a long time ago. And run, I did.

> > done < <(git ls-files --modified -z)
> 
> > 	done < <(git diff "$filename")
> 
> > 	done < <(echo ${hunks[$index]} | tr , '\n')
> 
> am I running the wrong bash? it barf on this. Don't you mean $(echo ... )

I hoped that I did not use a too new bash. Unfortunately, I seem to have 
been wrong. These constructs redirect the output of the command as input 
to the while loop, because

	bla | while ...; do blub; done

opens a subshell, so that all changes done in "blub" are lost as soon as 
the while loop is finished.

> Frankly, I am amazed that people write things in bash at all--I vowed 
> never to write bash again a couple of years ago.  If you start doing 
> arrays and counting, wouldn't a more high-level language be suitable?

Me, being one of the loudest proponents of C builtins on this list, I 
agree fully.

But in this case, bash was faster to script and debug, and unless people 
speak up, saying "I want that feature badly!", I do not plan to do 
anything with it.

Ciao,
Dscho
