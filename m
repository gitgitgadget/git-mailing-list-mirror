From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Implement --password option for git svn perl script
Date: Tue, 2 Feb 2010 01:05:38 -0800
Message-ID: <20100202090538.GA28437@dcvr.yhbt.net>
References: <a362e8011001290617n326a9dcx7c345ec31dff4ebe@mail.gmail.com> <001636ed7681994278047e4e4a6f@google.com> <a362e8011001290618g542be5f5y2777a925ba9bd936@mail.gmail.com> <1976ea661001290704h3ed4761dscf95ba848b373555@mail.gmail.com> <be6fef0d1002012015q2a10af1cq4c5e5f968039ee45@mail.gmail.com> <1976ea661002012030h23aa415ek30aa6db23cb88d0e@mail.gmail.com> <a362e8011002012237t640dd8b9sa1da0d221f5d03b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Li <lznuaa@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	git@vger.kernel.org
To: Laszlo Papp <djszapi@archlinux.us>
X-From: git-owner@vger.kernel.org Tue Feb 02 10:05:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcEhf-0005wR-Et
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 10:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074Ab0BBJFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 04:05:42 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:34223 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474Ab0BBJFj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 04:05:39 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1E0A1F488;
	Tue,  2 Feb 2010 09:05:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <a362e8011002012237t640dd8b9sa1da0d221f5d03b6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138703>

Laszlo Papp <djszapi@archlinux.us> wrote:
> > The basic requirement is git svn can provide a way to prompt a dialog
> > box to input passwd.
> 
> Yeah, it's a very basic use case, but I don't know whether there is a
> workaround for it somehow, maybe perl gurus or git svn users could
> help more...
> 
> My company, where there are windows users (95% of the company), would
> like to use TortoiseGIT as a graphical client for SVN server
> repositories as an SVN client, no other way by us, so it'd be high
> priority :) So I've got a beer for any volunteer, thanks :P

Hi, (fixed subject so I don't mistake it for junk again)

I don't know (and have no way to test) how to deal with input dialogs
for reading a password on Windows (nor any sort of IPC).  Somebody else
will have to implement it.

Having a --password option in the command line could work, but it's
painfully insecure if there's any way for another regular user to view
the process table.  Not something I'd like to encourage...

Since SVN already caches passwords in a mostly secure location on disk
(at least on *nix), shouldn't git svn be able to use the password cache
SVN uses?

-- 
Eric Wong
