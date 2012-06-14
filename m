From: Fengguang Wu <wfg@linux.intel.com>
Subject: Re: drivers/block/cpqarray.c:938:2: error: too many arguments to
	function lk_rq_map_sg
Date: Thu, 14 Jun 2012 19:31:42 +0800
Message-ID: <20120614113142.GA13954@localhost>
References: <4fd91c3f.KAwMcygw9fFGn9Cx%wfg@linux.intel.com>
	<4FD984F3.3070502@kernel.dk> <20120614090151.GA12013@localhost>
	<4FD9A95D.40903@kernel.dk> <20120614100205.GA13217@localhost>
	<4FD9C0D2.20500@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-raid@vger.kernel.org, "git@vger.kernel.org" <git@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
	virtualization@lists.linux-foundation.org
To: Jens Axboe <axboe@kernel.dk>
X-From: virtualization-bounces@lists.linux-foundation.org Thu Jun 14 13:31:51 2012
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Envelope-to: glkv-virtualization@gmane.org
Received: from mail.linuxfoundation.org ([140.211.169.12])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <virtualization-bounces@lists.linux-foundation.org>)
	id 1Sf8HG-0005Ej-Un
	for glkv-virtualization@gmane.org; Thu, 14 Jun 2012 13:31:51 +0200
Received: from mail.linux-foundation.org (localhost [IPv6:::1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D2DDB7E5;
	Thu, 14 Jun 2012 11:31:48 +0000 (UTC)
X-Original-To: virtualization@lists.linux-foundation.org
Delivered-To: virtualization@mail.linuxfoundation.org
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 768195A8
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Jun 2012 11:31:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 0FAB61FDBD
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Jun 2012 11:31:46 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 14 Jun 2012 04:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="165581249"
Received: from unknown (HELO wfg-t420.sh.intel.com) ([10.255.20.59])
	by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2012 04:31:45 -0700
Received: from wfg by wfg-t420.sh.intel.com with local (Exim 4.77)
	(envelope-from <wfg@linux.intel.com>)
	id 1Sf8H8-0003eb-8T; Thu, 14 Jun 2012 19:31:42 +0800
Content-Disposition: inline
In-Reply-To: <4FD9C0D2.20500@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199999>

On Thu, Jun 14, 2012 at 12:45:38PM +0200, Jens Axboe wrote:
> On 06/14/2012 12:02 PM, Fengguang Wu wrote:
> > On Thu, Jun 14, 2012 at 11:05:33AM +0200, Jens Axboe wrote:
> >> On 06/14/2012 11:01 AM, Fengguang Wu wrote:
> >>> Hi Jens,
> >>>
> >>> On Thu, Jun 14, 2012 at 08:30:11AM +0200, Jens Axboe wrote:
> >>>> On 06/14/2012 01:03 AM, wfg@linux.intel.com wrote:
> >>>>> FYI, kernel build failed on
> >>>>>
> >>>>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git multiqueue
> >>>>> head:   e9a6aa8a0b7b93195774a9fcf551632bf3abcd97
> >>>>> commit: 67db7275fa4325d46853a4bfcb79acf32e48eca8 [1/3] multiqueue: a hodge podge of things
> >>>>
> >>>> The multiqueue branch is a private branch, it's known broken on many
> >>>> configs at the moment.
> >>>
> >>> OK. Sorry my script just blindly build tests every new/updated branches
> >>> in the tree. It does try to reduce noise level by remembering all warned
> >>> error messages. However if it still presents a problem to the private
> >>> branches, I can either explicitly blacklist "multiqueue", or let the
> >>> script automatically skip commits whose "^Signed-off-by:" is still missing.
> >>
> >> It's not a problem that you're building various branches, as long as you
> >> are expecting a bit of noise :-). In fact I applaud your effort on
> >> expanding the scope of building others branches.
> >>
> >> But it does raise the question of how do we best signal intermediate
> >> branches like this, so they can be avoided until they are ready. The
> >> blacklist doesn't seem like a great choice, since then I have to
> >> remember to remind you when it _is_ ok to build it.
> >>
> >> How about some arbitrary tag? Instead of checking a Signed-off-by, I
> >> could just add a Dont-Auto-Build or something like that. What do you
> >> think?
> > 
> > OK, I'll add a grep for "Dont-Auto-Build". If it's found in *any*
> > commit of the branch, the build script will skip the whole branch.
> > Does this make sense to you?
> 
> Yeah that'll work for me. A description or tag might be more elegant,
> but this is easier...

Great, let's settle with the in-commit tag "Dont-Auto-Build" for now :)

"git branch --edit-description" could potentially be the most elegant
solution, unfortunately for now there seems no way for me to retrieve
the branch description edited by you..

Another alternative, git tag, has the problem that it goes out of sync
every time you do rebase, which will sure happen a lot for early RFC
patches.

Thanks,
Fengguang
