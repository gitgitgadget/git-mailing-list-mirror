From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Wed, 17 May 2006 11:51:41 -0700
Message-ID: <7vsln8cwn6.fsf@assigned-by-dhcp.cox.net>
References: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605161001190.3866@g5.osdl.org>
	<m1bqtx6el6.fsf@ebiederm.dsl.xmission.com>
	<7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
	<m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
	<7v1wut2p5z.fsf@assigned-by-dhcp.cox.net>
	<m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 20:52:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgR7b-0004s5-NJ
	for gcvg-git@gmane.org; Wed, 17 May 2006 20:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWEQSvn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 14:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWEQSvn
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 14:51:43 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:29089 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750928AbWEQSvn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 14:51:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517185142.FQND27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 14:51:42 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Wed, 17 May 2006 12:44:40 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20223>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Importing a quilt patch series into git is not very difficult
> but parsing the patch descriptions and all of the other
> minutia take a bit of effort to get right, so this automates it.
>
> Since git and quilt complement each other it makes sense
> to make it easy to go back and forth between the two.
>
> If a patch is encountered that it cannot derive the author
> from the user is asked.

What's the expected workflow for you to work on a 1300 patch
series you get from Andrew in the next installment to deal with
88 unattributed patches?  Answer the question 88 times and make
sure you get the answers right every time?  Or abort and
hand-edit them to help mailinfo to notice the correct
attribution and re-run?

I know I am guilty of suggesting "going interactive", but I have
a feeling that having an optional file that maps patch-name to
author might be easier to work with.  If the old patches are
recycled in the updated -mm set, you probably can reuse the
mapping for them, adding entries for newly introduced "unnamed"
patches as needed.
