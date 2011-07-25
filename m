From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Is there a quick way to identify commits that reference missing
 trees or blobs?
Date: Tue, 26 Jul 2011 00:44:08 +0200
Message-ID: <20110725224408.GA26057@toss.lan>
References: <CAH3AnroyfeGOo_23nHKhLjxEnP_qEMi7as1UjXEFjjuVOckBjw@mail.gmail.com>
 <20110725223449.GA25560@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 00:44:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlTsm-0004Sw-D7
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 00:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726Ab1GYWoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 18:44:12 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:35109 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751392Ab1GYWoK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 18:44:10 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id DE550CDF82;
	Tue, 26 Jul 2011 00:44:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110725223449.GA25560@toss.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177831>

On Tue, Jul 26, 2011 at 12:34:50AM +0200, Clemens Buchacher wrote:
> On Sun, Jul 24, 2011 at 02:48:20AM +1000, Jon Seymour wrote:
> >
> > I was wondering if there is a quick way to identify commits that
> > reference missing trees or blobs as identified by git fsck?
> 
> The following command has served me well for this purpose. I apply
> it to each ref in git-for-each-ref:
> 
> $ git rev-list --objects $ref | git cat-file --batch-check

Oh, and here is the output you get for different situations. Exit
status is always 0 unfortunately.

 - missing blob

fatal: missing blob object '78981922613b2afb6025042ff6bd878ac1994e85'
d165426eba5cb4c125bd6e100d1b5de7298eb601 commit 168
848740929e99bda0e1a9783e7daa314c5a9732d5  missing

 - missing tree

error: Could not read 84bf061d017459b4be45a49b8d8dc945e7a7fdf5
fatal: bad tree object 84bf061d017459b4be45a49b8d8dc945e7a7fdf5
abce3ad54002628ab74d72b7e2baa687abcb77f9 commit 168

 - missing parent commit

error: Could not read 3aa66f30aa9799ac38a53b551ac4faca9cbd400b
fatal: Failed to traverse parents of commit 3cfb98a3cbd3f42852e20bd011c7b835b8750df7

Clemens
