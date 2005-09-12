From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: hmm, can't we give the "root" a parent?
Date: Tue, 13 Sep 2005 01:51:49 +0200
Message-ID: <20050912235149.GA10513@vrfy.org>
References: <20050912181101.GA22221@vrfy.org> <Pine.LNX.4.58.0509121123280.3242@g5.osdl.org> <20050912195947.GA28502@vrfy.org> <Pine.LNX.4.58.0509121316030.3266@g5.osdl.org> <20050912210006.GA32211@vrfy.org> <Pine.LNX.4.58.0509121438150.3266@g5.osdl.org> <20050912225032.GA8360@vrfy.org> <Pine.LNX.4.58.0509121608130.3266@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:53:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEy61-0005be-1s
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 01:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVILXvx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 19:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVILXvx
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 19:51:53 -0400
Received: from soundwarez.org ([217.160.171.123]:40590 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932364AbVILXvw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 19:51:52 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 96D5959180; Tue, 13 Sep 2005 01:51:49 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509121608130.3266@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8453>

On Mon, Sep 12, 2005 at 04:09:58PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 13 Sep 2005, Kay Sievers wrote:
> > 
> > And I would prefer --pretty=raw with '\0' termination instead of '\n' so I can
> > replace the output from --header with --pretty=raw and can still use the same
> > parsing routine.
> 
> It struck me that "--header" works fine with "--parents".
> 
> So if you're currently already using "git-rev-list --header" and parsing 
> that, just add "--parents" and off you go. That's basically the same as 
> --pretty=raw + zero-termination.

Yeah, got the same idea. :) Have it already working. With the history tree
plugged in after "Linux 2.6.12-rc2":
   http://ehlo.org/~kay/?p=linux/kernel/git/torvalds/linux-2.6.git;a=shortlog;h=2d137c24e9f433e37ffd10b3d5f418157589a8d2

Grafting worked pretty nice by just doing:
  echo "8d38eadb7a97f265f7b3a9e8a30df358c3a546c8 e7e173af42dbf37b1d946f9ee00219cb3b2bea6a" > $LOCALROOT/linux/kernel/git/torvalds/linux-2.6.git/info/grafts
  echo $LOCALROOT/linux/kernel/git/tglx/history.git/objects > $LOCALROOT/linux/kernel/git/torvalds/linux-2.6.git/objects/info/alternates

Thanks,
Kay
