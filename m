From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] An option parser for the sequencer
Date: Sun, 10 Jul 2011 10:15:29 +0200
Message-ID: <201107101015.29762.chriscool@tuxfamily.org>
References: <1310226118-10201-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 10 10:19:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfpF6-00011A-MI
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jul 2011 10:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448Ab1GJIPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jul 2011 04:15:43 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:55140 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755387Ab1GJIPj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2011 04:15:39 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3BD27A61B4;
	Sun, 10 Jul 2011 10:15:31 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1310226118-10201-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176822>

Hi Ram,

On Saturday 09 July 2011 17:41:57 Ramkumar Ramachandra wrote:
> Hi,
> 
> I've decided not to support arbitrary command-line options in the
> instruction sheet.

It may be a good decision, but could you explain why? You could say for 
example that the series would be already an improvement over what we have if 
we don't parse arbitrary command line options.

> A typical instruction sheet will looks like this
> (inspired heavily by the rebase -i instruction sheet format):

> pick 3b36854 t: add tests for cloning remotes with detached HEAD
> pick 61adfd3 consider only branches in guess_remote_head
> pick 8537f0e submodule add: test failure when url is not configured in
> superproject pick 4d68932 submodule add: allow relative repository path
> even when no url is set pick f22a17e submodule add: clean up duplicated
> code
> pick 59a5775 make copy_ref globally available
> pick c1921c1 clone: always fetch remote HEAD

Would it be easy to change the format to support arbitrary command line 
options if we want to do it afterwards, especially after the end of the GSoC?

> For persisting one set of options for every "git cherry-pick"/ "git
> revert" invocation, I've decided to use a simple "key = value" format
> and put it in .git/sequencer/opts (to sit beside .git/sequencer/head
> and .git/sequencer/todo).  For strategy-option, I thought it would be
> cute to separate the various options using ' | '.  So, it'll look
> something like this in the end:
> 
> signoff = true
> mainline = 1
> strategy-option = recursive | ours

Is it the same format as the .git/config file format? Would it be possible to 
reuse some config parsing/writing code?

> The implementation is a little rough around the edges, but I'm pretty
> happy with the overall design: it looks like a scaled-down version of
> parse-options.  Quite a lot of context is missing (where did
> sequencer.h come from?!), but I hope it's clear enough to convey the
> idea.
> 
> Thanks for reading.
> 
> Ramkumar Ramachandra (1):
>   revert: Persist per-session opts
> 
>  builtin/revert.c |  143
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++ sequencer.h      | 
>   8 +++
>  2 files changed, 151 insertions(+), 0 deletions(-)

The subject should have been "[RFC PATCH 0/1] ..." instead of "[RFC PATCH] 
..." because this is just a patch series header.

Thanks,
Christian.
