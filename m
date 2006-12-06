X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: For all you darcs lovers: git-hunk-commit
Date: Wed, 06 Dec 2006 01:19:47 +0100
Message-ID: <45760CA3.9060003@xs4all.nl>
References: <Pine.LNX.4.63.0612051936480.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 00:19:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 66
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82-171-213-190.dsl.ip.tiscali.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.63.0612051936480.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33392>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrkVp-0004an-N4 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 01:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758661AbWLFATr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 19:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758687AbWLFATr
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 19:19:47 -0500
Received: from main.gmane.org ([80.91.229.2]:49594 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1758661AbWLFATq
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 19:19:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrkVh-0001dl-LB for git@vger.kernel.org; Wed, 06 Dec 2006 01:19:41 +0100
Received: from 82-171-213-190.dsl.ip.tiscali.nl ([82.171.213.190]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 01:19:41 +0100
Received: from hanwen by 82-171-213-190.dsl.ip.tiscali.nl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 01:19:41 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin escreveu:
> I was inspired by Han-Wen. This script allows you to commit selected hunks 

Wow!

> In darcs mode, all hunks are presented one by one, and you are asked if 
> you want to commit this or not. If you make a mistake: ^C and back to 
> start. I do not really know darcs, so this might not be how it works -- I 
> did not find any good documentation how a "darcs record" looks like.


This is the interactive interface for commits in Darcs. It uses the
same interface for pushing and pulling, where I mostly use y/n/a/d but
sometimes the other letters too.


****
Shall I record this change? (1/?)  [ynWsfqadjkc], or ? for help: ?
How to use record...
y: record this patch
n: don't record it
w: wait and decide later, defaulting to no

s: don't record the rest of the changes to this file
f: record the rest of the changes to this file

d: record selected patches, skipping all the remaining patches
a: record all the remaining patches
q: cancel record

j: skip to next patch
k: back up to previous patch
c: calculate number of patches
h or ?: show this help

<Space>: accept the current default (which is capitalized)
****



If you want to get a feel for it, grab darcs and run

  darcs init
  echo hello > hello
  darcs add
  darcs record
  

For a really neat implementation of per-hunk commits, try running
darcsum in Emacs


> done < <(git ls-files --modified -z)

> 	done < <(git diff "$filename")

> 	done < <(echo ${hunks[$index]} | tr , '\n')

am I running the wrong bash? it barf on this. Don't you mean $(echo ... )

Frankly, I am amazed that people write things in bash at all--I vowed never
to write bash again a couple of years ago.  If you start doing arrays and
counting, wouldn't a more high-level language be suitable?

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
