From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Wed, 23 Nov 2005 00:05:11 +0100
Message-ID: <200511230005.12957.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de> <200511221831.03954.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 23 00:07:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EehCw-0007Ph-Py
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 00:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbVKVXFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 18:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbVKVXFS
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 18:05:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:4044 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030231AbVKVXFR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 18:05:17 -0500
Received: (qmail invoked by alias); 22 Nov 2005 23:05:15 -0000
Received: from p5496B4E1.dip0.t-ipconnect.de (EHLO linux) [84.150.180.225]
  by mail.gmx.net (mp008) with SMTP; 23 Nov 2005 00:05:15 +0100
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12581>

On Tuesday 22 November 2005 18:56, Johannes Schindelin wrote:
> On Tue, 22 Nov 2005, Josef Weidendorfer wrote:
> >   [remote:origin]
> >     url = master.kernel.org:/pub/scm/git/git.git
> >     pull = master:origin

> I don't know if you missed it, but hierarchical config keys were 
> introduced by b17e659dd4007cb1d3eb5ac32b524c0c5ab59601:
> 
> [remote.origin]
> 	url = master.kernel.org:/pub/scm/git/git.git
> 	pull = master:origin

I know. My suggestion complements hierarchical keys:

 [myporcelain.headproperties: my/head.name]
    merge.candidates = my/other.head
    merge.default = your/master

would be the same as

 [myporcelain.headproperties]
    merge.candidates = my/other.head for my/head.name
    merge.default = your/master for my/head.name

It is about specifying the same " for "-part for multiple keys.
The idea is to use everything after a ":\s*" in a section name
to use as prefix for any " for "-part of keys values given in
this section.

Josef
