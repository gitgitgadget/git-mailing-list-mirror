From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH/RFC v2] Squashed changes for multiple worktrees vs.
 submodules
Date: Wed, 3 Dec 2014 00:16:11 +0200
Message-ID: <20141202221611.GB9128@wheezy.local>
References: <1417390076-2953-1-git-send-email-max@max630.net>
 <547E24E4.7050100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 02 23:16:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvvk7-00078a-97
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 23:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933022AbaLBWQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 17:16:19 -0500
Received: from p3plsmtpa12-07.prod.phx3.secureserver.net ([68.178.252.236]:41149
	"EHLO p3plsmtpa12-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932832AbaLBWQS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 17:16:18 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-07.prod.phx3.secureserver.net with 
	id NmG81p00W5B68XE01mGBly; Tue, 02 Dec 2014 15:16:18 -0700
Content-Disposition: inline
In-Reply-To: <547E24E4.7050100@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260599>

On Tue, Dec 02, 2014 at 09:45:24PM +0100, Jens Lehmann wrote:
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
> If I understand you correctly you want to put the
> submodule's common git dir under the superproject's common
> git dir. I agree that that makes most sense as the
> default, but having the possibility to use a common git
> dir for submodule's of different superprojects would be
> nice to have for some setups, e.g. CI-servers. But that
> can be added later.

So far there is no separation of .git/config for different
worktrees. As submodules rely on the config their separation
cannot be done fully without changing that. So this should
be really left for some later improvements.

As a user I am currently perfectly satisfied with manually
checking out or even cloning submodules inplace, I don't do
it often.

> Thanks. I just didn't quite understand why you had to do so many
> changes to git-submodule.sh. Wouldn't it be sufficient to just
> update module_clone()?

Thanks, I should try it.

Probably I had the opposite idea in mind - keep module_clone
as untouched as possible. Maybe I should see how it's going
to look if I move all worktrees logic there.

-- 
Max
