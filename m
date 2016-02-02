From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v3 6/6] worktree add: switch to worktree version 1
Date: Tue, 2 Feb 2016 07:35:47 +0200
Message-ID: <20160202053547.GF4978@wheezy.local>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-7-git-send-email-pclouds@gmail.com>
 <20160201053333.GE4978@wheezy.local>
 <CACsJy8Am7rQ=pm0C7bw0gQ=aic3opmBos+3+1Awrko8TT2uHrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 06:35:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQTd5-00052r-Rs
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 06:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbcBBFfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 00:35:52 -0500
Received: from p3plsmtpa11-02.prod.phx3.secureserver.net ([68.178.252.103]:35572
	"EHLO p3plsmtpa11-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750958AbcBBFfv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 00:35:51 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-02.prod.phx3.secureserver.net with 
	id DHbm1s00D5B68XE01HbpLR; Mon, 01 Feb 2016 22:35:50 -0700
Content-Disposition: inline
In-Reply-To: <CACsJy8Am7rQ=pm0C7bw0gQ=aic3opmBos+3+1Awrko8TT2uHrg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285239>

On Mon, Feb 01, 2016 at 01:05:05PM +0700, Duy Nguyen wrote:
> On Mon, Feb 1, 2016 at 12:33 PM, Max Kirillov <max@max630.net> wrote:
>> 1. For submodules (which must be left per-worktree) this
>> approach is not going to work, because you don't know all
>> variables in advance. You could scan the config file and
>> match those actual keys which are there with patterns.

> Hmm.. we could keep existing submodule.* per-worktree. New variables
> are per-worktree by default, unless you do "git config --repo" in
> git-submodule.sh. Am I missing something?

Submodules in new worktree should be not initialized, and as
far as I understand this means that submodule variables
should be removed from common config.

I used test from
http://article.gmane.org/gmane.comp.version-control.git/266621
to verify expectations for submodules.

>> 2. This migrates variables to the default (or current?)
>> worktree, what about others existing?
> 
> In v0, $C/config contains all shared variables, once we move these
> shared vars to $C/common/config, they will be visible to all other
> worktrees. Or do you replicate per-worktree vars in $C/config to all
> worktrees ?

If would make sense for some variables definitely. For
example, the submodule related variables.

-- 
Max
