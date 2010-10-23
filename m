From: Rico Secada <coolzone@it.dk>
Subject: Re: Git pull doesn't get the tags
Date: Sat, 23 Oct 2010 18:34:12 +0200
Message-ID: <20101023183412.709c1790.coolzone@it.dk>
References: <20101022053747.a5427cad.coolzone@it.dk>
	<4CC153A0.7080605@debugon.org>
	<20101022142308.f275aefe.coolzone@it.dk>
	<7vy69pkgpb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 23 18:36:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9h59-0006es-0f
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 18:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034Ab0JWQga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 12:36:30 -0400
Received: from smtp.fullrate.dk ([90.185.1.42]:63721 "EHLO smtp.fullrate.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757366Ab0JWQg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 12:36:29 -0400
Received: from workp4 (4304ds5-ynoe.0.fullrate.dk [90.185.142.211])
	by smtp.fullrate.dk (Postfix) with SMTP id 4297E9D03E
	for <git@vger.kernel.org>; Sat, 23 Oct 2010 18:36:28 +0200 (CEST)
In-Reply-To: <7vy69pkgpb.fsf@alter.siamese.dyndns.org>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159801>

On Fri, 22 Oct 2010 15:25:52 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> The above passage in the manual page may be stated rather poorly.
> 
> When "git fetch" is run, unless told otherwise by an explicit
> --no-tags, it automatically fetches tags that point at new commits on
> branches you fetch.  For example, I just tagged v1.7.3.2 last night,
> so if you fetch from me to get 'maint', 'master' or other integration
> branches of mine that includes 8a90438 (Git 1.7.3.2, 2010-10-21),
> "git fetch" would also copy v1.7.3.2 tag from me to your repository.
> 
> In the above example, 'maint', 'master', etc. are the branch heads
> that are being tracked (i.e. you will copy them to the
> refs/remotes/origin hierarchy in your repository) and v1.7.3.2 is a
> tag that does point at an object 8a90438 reachable from these branch
> heads.  So you will get the tag without giving the --tags option from
> the command line.
> 
> If you were fetching only 'html' or 'man' branches from me, on the
> other hand, you would not have gotten v1.7.3.2 tag, as they are
> separate histories and that particular tag does not live in their
> ancestry.
> 
> Also tags that point at non-commits (e.g. in git.git, junio-gpg-pub
> and spearce-gpg-pub are pointing at blob objects, and v2.6.11 and
> v2.6.11-tree tags in the kernel repository are pointing at tree
> objects) will not be fetched automatically either.  You would need to
> explicitly ask for them if you want them by either (1) find them via
> ls-remote and name them on the command line, or (2) use --tags option

A nice and meaningful explanation. Thanks for the details!
