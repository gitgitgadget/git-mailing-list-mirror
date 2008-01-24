From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Multiple working trees with GIT ?
Date: Thu, 24 Jan 2008 09:51:28 -0500
Message-ID: <20080124145128.GA26164@fieldses.org>
References: <20080124074952.GA8793@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
X-From: git-owner@vger.kernel.org Thu Jan 24 15:52:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI3Qv-0001r8-AF
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 15:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbYAXOva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 09:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbYAXOva
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 09:51:30 -0500
Received: from mail.fieldses.org ([66.93.2.214]:36222 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153AbYAXOv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 09:51:29 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1JI3QO-0006wp-Du; Thu, 24 Jan 2008 09:51:28 -0500
Content-Disposition: inline
In-Reply-To: <20080124074952.GA8793@1wt.eu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71621>

On Thu, Jan 24, 2008 at 08:49:52AM +0100, Willy Tarreau wrote:
> Hi all,
> 
> I'm having long thoughts about how to use GIT to manage a distro. One of
> the aspects which comes very often is the notion of "variant" for a
> packaging. For instance, the whole project could consist in a list of packages
> with their branches, but this list may vary depending on the platform, the
> medium, etc... I was searching how to propagate common changes withing variants
> with the least hassle.
> 
> I figured out that having one file list per variant will be very annoying. In
> another project, that's already what I have and frankly, applying the same
> change to 10 files is counter-productive. Since the lists will often be the
> sames except for a few entries, and since most updates will be relevant to
> all variants, I thought branches will be my best friends.
> 
> But I would like to be able to always access file lists, without having to
> constantly git-checkout <variant-X>.

Could just read-only access with git-show be enough for your purposes?:

	git show <branch-name>:		# show top-level directory,
	git show <branch-name>:lib/	# show lib/ directory, etc....
	git show <branch-name>:lib/Makefile

--b.
