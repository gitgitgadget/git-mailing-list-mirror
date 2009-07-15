From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn import fails.
Date: Wed, 15 Jul 2009 00:04:44 -0700
Message-ID: <20090715070444.GA22882@dcvr.yhbt.net>
References: <fe66c02a0907131343m5c05af68n88a749c08d3dc70a@mail.gmail.com> <fe66c02a0907131349p708e4a16hde3cd9b9c7a7a9a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: MrUnleaded <mrunleaded@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 09:05:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQyXx-00042I-4a
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 09:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbZGOHEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 03:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbZGOHEs
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 03:04:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59914 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbZGOHEr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 03:04:47 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 3A7C51F5F7;
	Wed, 15 Jul 2009 07:04:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fe66c02a0907131349p708e4a16hde3cd9b9c7a7a9a3@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123287>

MrUnleaded <mrunleaded@gmail.com> wrote:
> Hello, I have been attempting to import a public repo but it seems to
> fail predictably at the same revision with the following error:
> 
> RA layer request failed: REPORT request failed on
> '/svn/!svn/vcc/default': REPORT of '/svn/!svn/vcc/default': 200 OK
> (https://mosa.svn.codeplex.com) at /usr/local/libexec/git-core/git-svn
> line 4505
> 
> I have tried the following:
> git svn clone https://mosa.svn.codeplex.com/svn/trunk
> 
> git svn clone -s https://mosa.svn.codeplex.com/svn
> 
> I have also tried git svn rebase once it fails on the clone.
> 
> Each time it fails on the same revision.
> 
> If anyone has any suggestions I would appreciate it.
> 
> Thanks.

Hi,

This is the weirdest/slowest(?) SVN server I've ever connected to.
svn ls https://mosa.svn.codeplex.com/svn just seems to stall
trying to read something at the end, likewise with "svn co" and
"svn log".

It seems like the server side isn't able to terminate connections
correctly and the SVN client itself is relying on that.


How many revisions did you managed to fetch before it failed?

Do other SVN clients work with this?  If so which client and version are
you able to use with it?  If I can't get the stock `svn' isn't working
right, then I doubt there's much I can do with git svn on this repo...

-- 
Eric Wong
