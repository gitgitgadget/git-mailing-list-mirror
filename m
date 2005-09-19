From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Why does git-core 0.99.7 require python 2.4?
Date: Mon, 19 Sep 2005 22:02:23 +0200
Message-ID: <20050919200222.GA11322@c165.ib.student.liu.se>
References: <432F0C66.7060402@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 19 22:07:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHRqX-0001GN-Mb
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 22:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbVISUCf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 16:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbVISUCf
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 16:02:35 -0400
Received: from [85.8.31.11] ([85.8.31.11]:14496 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932613AbVISUCe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 16:02:34 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id EB6F340FF; Mon, 19 Sep 2005 22:07:50 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EHRqJ-0002wp-00; Mon, 19 Sep 2005 22:02:23 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <432F0C66.7060402@zytor.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8903>

On Mon, Sep 19, 2005 at 12:07:18PM -0700, H. Peter Anvin wrote:
> I just tried to update the kernel.org hosts to git-core 0.99.7, but I 
> got stuck due to the fact that git-core 0.99.7 requires python >= 2.4, 
> which isn't in RHEL4 (python-2.3.2) nor in FC3 (python-2.3.4).
> 
> Updating Python beyond what the distribution provides is a major operation.
> 
> Can it be changed to work with python 2.3, to give a bit of leeway?
> 

It is git-merge-recursive which wants Python 2.4. Unfortunately Python
2.3 do not ship with the 'subprocess' module which is currently used
by the 'recursive' merge strategy. RPMs for Python 2.4 can be
downloaded from http://www.python.org/2.4.1/rpms.html

Python isn't used by the rest of Git so if you don't use the recursive
merge strategy it will work fine without Python.

Not supporting one of the major Linux distributions isn't ideal
though, so maybe we should do something about this. I will have a look
at rewriting the code to not use subprocess.

- Fredrik
