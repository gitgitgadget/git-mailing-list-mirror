From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH/RFC v2] Squashed changes for multiple worktrees vs.
 submodules
Date: Mon, 1 Dec 2014 16:47:31 +0200
Message-ID: <20141201144731.GA9128@wheezy.local>
References: <1417390076-2953-1-git-send-email-max@max630.net>
 <CACsJy8C1968-NJAxvxnwXAOZTofedpAe+Rmg4OYJA4E3t9Ao+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 15:47:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvSGO-000384-Ob
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 15:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbaLAOrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 09:47:41 -0500
Received: from p3plsmtpa07-02.prod.phx3.secureserver.net ([173.201.192.231]:33889
	"EHLO p3plsmtpa07-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932067AbaLAOrk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2014 09:47:40 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-02.prod.phx3.secureserver.net with 
	id NEnV1p00F5B68XE01Enbo5; Mon, 01 Dec 2014 07:47:40 -0700
Content-Disposition: inline
In-Reply-To: <CACsJy8C1968-NJAxvxnwXAOZTofedpAe+Rmg4OYJA4E3t9Ao+g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260485>

On Mon, Dec 01, 2014 at 05:43:16PM +0700, Duy Nguyen wrote:
> On Mon, Dec 1, 2014 at 6:27 AM, Max Kirillov <max@max630.net> wrote:
>> But, while hacking the submodule init I became more
>> convinced that the modules directory should be common and
>> submodules in checkout should be a checkouts of the
>> submodule. Because this is looks like concept of
>> submodules, that they are unique for the lifetime of
>> repository, even if they do not exist in all revisions.
>> And if anybody want to use fully independent checkout
>> they can be always checked out manually. Actually, after
>> a submodule is initialized and have a proper gitlink, it
>> can be updated and inquired regardless of where it points
>> to.
> 
> Just throw something in for discussion. What about keeping
> $GIT_DIR/modules like it is now (i.e. not shared) and add
> $GIT_DIR/shared-modules, which is the same for all
> checkouts? That would keep current submodule code happy
> (no name collision or anything). New submodule code can
> start using $GIT_DIR/shared-modules while still keeping an
> eye on $GIT_DIR/modules for old setups.

I think it would be too complicated. To make fancy think
user can always manually initialize a repository or a
checkout. And all sumbodule functionality except
adding/removing/(de)initialization should work with any
repository or gitlink, regardless of where it points to.
