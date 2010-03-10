From: Patrick Higgins <patrick133t@yahoo.com>
Subject: Re: wishlist: git gui not listing untracked files in unstaged list
Date: Wed, 10 Mar 2010 22:00:41 +0000 (UTC)
Message-ID: <loom.20100310T225229-469@post.gmane.org>
References: <loom.20100310T203316-38@post.gmane.org> <7vaaugrlqs.fsf@alter.siamese.dyndns.org> <20100310200728.GD21994@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 10 23:06:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpU1j-0001m1-F3
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 23:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784Ab0CJWFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 17:05:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:48076 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932769Ab0CJWFG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 17:05:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NpU1X-0001i4-Sz
	for git@vger.kernel.org; Wed, 10 Mar 2010 23:05:04 +0100
Received: from clients.cexp.com ([170.131.131.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 23:05:03 +0100
Received: from patrick133t by clients.cexp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 23:05:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 170.131.131.254 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/532.9 (KHTML, like Gecko) Chrome/5.0.307.11 Safari/532.9)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141922>

Shawn O. Pearce <spearce <at> spearce.org> writes:

> Junio C Hamano <gitster <at> pobox.com> wrote:
> I have no idea why the original poster isn't getting his ignore
> list(s) to work.  I also have no idea why dropping the --others
> flag from the ls-files command gets him a useful result.

I'm seeing a similar problem. For me, it's caused by defining
core.excludesfile to "~/.gitexcludes". The git config documentation
says that this will be expanded to my home directory. It appears that
git gui doesn't do this and instead runs "git ls-files --others -z
--exclude-from='~/.gitexcludes'"

That chokes with:

fatal: cannot use ~/.gitexcludes as an exclude file

Changing core.excludesfile to use a fully-qualified path instead of ~/
fixes the problem for me.
