From: Fengguang Wu <wfg@linux.intel.com>
Subject: Re: =?utf-8?Q?drivers=2Fblock=2Fcpqarray?=
 =?utf-8?Q?=2Ec=3A938=3A2=3A_error=3A_too_many_arguments_to_function_?=
 =?utf-8?B?5oW0bGtfcnFfbWFwX3Nn77+9?=
Date: Thu, 14 Jun 2012 17:25:19 +0800
Message-ID: <20120614092519.GA12482@localhost>
References: <4fd91c3f.KAwMcygw9fFGn9Cx%wfg@linux.intel.com>
 <4FD984F3.3070502@kernel.dk>
 <20120614090151.GA12013@localhost>
 <4FD9A95D.40903@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-scsi@vger.kernel.org, linux-raid@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
X-From: linux-raid-owner@vger.kernel.org Thu Jun 14 11:25:37 2012
Return-path: <linux-raid-owner@vger.kernel.org>
Envelope-to: linux-raid@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-raid-owner@vger.kernel.org>)
	id 1Sf6J1-0007By-SW
	for linux-raid@plane.gmane.org; Thu, 14 Jun 2012 11:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482Ab2FNJZ3 (ORCPT <rfc822;linux-raid@m.gmane.org>);
	Thu, 14 Jun 2012 05:25:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:53924 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400Ab2FNJZ2 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
	Thu, 14 Jun 2012 05:25:28 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 14 Jun 2012 02:25:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; 
   d="scan'208";a="165536088"
Received: from unknown (HELO wfg-t420.sh.intel.com) ([10.255.20.59])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2012 02:25:22 -0700
Received: from wfg by wfg-t420.sh.intel.com with local (Exim 4.77)
	(envelope-from <wfg@linux.intel.com>)
	id 1Sf6Ip-0003Gz-1y; Thu, 14 Jun 2012 17:25:19 +0800
Content-Disposition: inline
In-Reply-To: <4FD9A95D.40903@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199989>

On Thu, Jun 14, 2012 at 11:05:33AM +0200, Jens Axboe wrote:
> On 06/14/2012 11:01 AM, Fengguang Wu wrote:
> > Hi Jens,
> > 
> > On Thu, Jun 14, 2012 at 08:30:11AM +0200, Jens Axboe wrote:
> >> On 06/14/2012 01:03 AM, wfg@linux.intel.com wrote:
> >>> FYI, kernel build failed on
> >>>
> >>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git multiqueue
> >>> head:   e9a6aa8a0b7b93195774a9fcf551632bf3abcd97
> >>> commit: 67db7275fa4325d46853a4bfcb79acf32e48eca8 [1/3] multiqueue: a hodge podge of things
> >>
> >> The multiqueue branch is a private branch, it's known broken on many
> >> configs at the moment.
> > 
> > OK. Sorry my script just blindly build tests every new/updated branches
> > in the tree. It does try to reduce noise level by remembering all warned
> > error messages. However if it still presents a problem to the private
> > branches, I can either explicitly blacklist "multiqueue", or let the
> > script automatically skip commits whose "^Signed-off-by:" is still missing.
> 
> It's not a problem that you're building various branches, as long as you
> are expecting a bit of noise :-). In fact I applaud your effort on
> expanding the scope of building others branches.

Thank you :-)

> But it does raise the question of how do we best signal intermediate
> branches like this, so they can be avoided until they are ready. The
> blacklist doesn't seem like a great choice, since then I have to
> remember to remind you when it _is_ ok to build it.
> 
> How about some arbitrary tag? Instead of checking a Signed-off-by, I
> could just add a Dont-Auto-Build or something like that. What do you
> think?

Anything convenient to you would be fine.

If we can somehow tag the whole branch, it would be most convenient.
Git can add description to a branch with

        git branch --edit-description [branch name]

However I don't know how to retrieve that description on a remote
branch..

Thanks,
Fengguang
