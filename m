From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 9/10] Remove cmd_usage() routine and re-organize the help/usage code.
Date: Wed, 02 Aug 2006 11:18:11 -0700
Message-ID: <7v4pwvuhlo.fsf@assigned-by-dhcp.cox.net>
References: <00c201c6b5cf$8089a580$c47eedc1@ramsay1.demon.co.uk>
	<20060802132149.GG16364@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 20:18:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8LIN-0002ta-Uq
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 20:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWHBSSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 14:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWHBSSN
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 14:18:13 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:26032 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932123AbWHBSSM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 14:18:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060802181812.ZKFU18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Aug 2006 14:18:12 -0400
To: Martin Waitz <tali@admingilde.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24663>

Martin Waitz <tali@admingilde.org> writes:

> On Wed, Aug 02, 2006 at 02:03:44AM +0100, Ramsay Jones wrote:
>>  builtin-help.c |   54
>> +++++++++++++++++++++++-------------------------------
>>  builtin.h      |    7 ++-----
>>  git.c          |    7 +++++--
>>  3 files changed, 30 insertions(+), 38 deletions(-)
>
> this patch is at the tip of "master" now, but with one more change:
>...
> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index bf1d638..34a3ccd 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
>...
> this looks strange.

Ramsay's patch to cmd_help() broke this test because the test
relied on the details of output from "git help", which the patch
subtly changed.

I considered making the fix for broken test a separate commit,
but the fix for the test was simple enough, so I rolled it in,
with the additional comment in the log to explain what was going
on -- I suspect the explanation was not clear enough.

I could have committed the fix for the test first and then this
one.
