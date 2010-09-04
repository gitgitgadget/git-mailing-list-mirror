From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [bug-patch] Re: [BUG?] rename patch accepted with --dry-run,
	rejected without (Re: [PATCH V3] arm & sh: factorised duplicated
	clkdev.c)
Date: Sat, 4 Sep 2010 22:45:27 +0100
Message-ID: <20100904214527.GA20444@n2100.arm.linux.org.uk>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <20100903193309.GC29821@pengutronix.de> <20100904000348.GA7498@n2100.arm.linux.org.uk> <201009042333.51419.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bug-patch@gnu.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: linux-sh-owner@vger.kernel.org Sat Sep 04 23:46:22 2010
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-sh-owner@vger.kernel.org>)
	id 1Os0Z2-0003CQ-CZ
	for glps-linuxsh-dev@lo.gmane.org; Sat, 04 Sep 2010 23:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580Ab0IDVqQ (ORCPT <rfc822;glps-linuxsh-dev@m.gmane.org>);
	Sat, 4 Sep 2010 17:46:16 -0400
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56902 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab0IDVqP (ORCPT
	<rfc822;linux-sh@vger.kernel.org>); Sat, 4 Sep 2010 17:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arm.linux.org.uk; s=caramon; h=Date:From:To:Cc:Subject:
	Message-ID:References:MIME-Version:Content-Type:In-Reply-To:
	Sender; bh=//V+Ct5Dy7+Y0PnrzGxHFrHATvFWZk4cqrublCIuo8Y=; b=TWwIf
	lekyFsHC+SvZAT+jpgRQPavSXedebJZ6h8/WE1chQUgmXo90KsJ8GZUAHgSw4DsR
	1fkMcdl/PUK7Q47CfYzMa2f+RYmflc2TRvGh3TMd4t3ZSDGvwczsE9eJ0ACBH7iH
	j/Y0XYop4gZHbPV6RZcxOy4z0B13RlgzKhO/wI=
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1Os0YD-0007f5-I6; Sat, 04 Sep 2010 22:45:30 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1Os0YC-0006Ju-0v; Sat, 04 Sep 2010 22:45:28 +0100
Content-Disposition: inline
In-Reply-To: <201009042333.51419.agruen@suse.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155363>

On Sat, Sep 04, 2010 at 11:33:51PM +0200, Andreas Gruenbacher wrote:
> On Saturday 04 September 2010 02:03:48 Russell King - ARM Linux wrote:
> > As I say, it's because GNU patch doesn't (currently) understand GIT
> > patches.  I wouldn't call that a bug in GNU patch.
> 
> GNU patch in the version used does understand GIT patch headers and does 
> support things like renames.
> 
> The --dry-run option often will not work when the same file is modified more 
> than once in the same patch, though.  This is because GNU patch doesn't 
> remember the intermediary states of files.
> 
> In this case, the patch itself is broken.

GIT has many options to control how it produces patches, and -C or -M
allow it to reduce the size of patches making them more reviewable.  It
also makes them incompatible with GNU patch, whether or not GNU patch
understands the GIT headers.

As I've already said - if you want GNU compatible patches, don't generate
GIT patches using -C or -M.

Simples.
