From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: FFmpeg considering GIT
Date: Fri, 4 May 2007 16:53:47 +0100
Message-ID: <200705041653.49486.andyparkins@gmail.com>
References: <loom.20070502T111026-882@post.gmane.org> <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael Niedermayer <michaelni@gmx.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 17:54:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk06s-0006pu-7i
	for gcvg-git@gmane.org; Fri, 04 May 2007 17:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030878AbXEDPyP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 11:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030951AbXEDPyP
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 11:54:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:64208 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030878AbXEDPyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 11:54:13 -0400
Received: by ug-out-1314.google.com with SMTP id 44so672591uga
        for <git@vger.kernel.org>; Fri, 04 May 2007 08:54:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SaeiJYVXw/UcTbmX5MD8hNgGtdSDlMUA1zdLOA+2lbd9QMios5BjEDU9FPXOuzCB0SJ4K3V8uedoZU1Yu9jp0PbSZERmBGmS+jYBckIK3XM8PvUdSx6BGn4Ig3PQ/zk/A9cN77VWGvpf9b72xE6DSzHemszhgiL5/B2fQ1aEDyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tXZkl5COTJqAaLMH0aSq3ZQZv2A2+AwuX5EL44BrZqVbpSoPV/65WB6OXpL2V+HpD+EdSeOBosdHPigwVWekXCpToUY1pQJiFZtuVtD/nat10GWElvqUSUevxmKSG1zuLcquVpCivqJh4yTdC05xkbVT+fCGh6ocbCnyhcYbFKI=
Received: by 10.82.187.16 with SMTP id k16mr6825505buf.1178294051526;
        Fri, 04 May 2007 08:54:11 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm102847ikz.2007.05.04.08.54.00;
        Fri, 04 May 2007 08:54:04 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <loom.20070504T143538-533@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46185>

On Friday 2007 May 04, Michael Niedermayer wrote:

> well, my example above was exagerated, noone ever reindented the whole
> ffmpeg or checked in a old version over HEAD. what did and does
> occasionally happen is that people check in several things at once (like a
> 100k reindenton mixed with various functional changes)
> for these we currently copy the last good version of the affected files
> over the current one with svn cp and then apply the changes in nicely
> split manner. (possibly without the reindention if its uneeded ...)

I might be misunderstanding, but doesn't that leave the "bad" commit in the 
history?

 * -- * -- G -- B -- !B -- 1 -- 2 -- 3

B is the bad commit; !B would be the result of the svn cp from the previous 
known-good revision, "G"; then 1, 2, and 3 would be the correctly split 
version of "B".

Have I correctly understood?  If so - git would have no trouble at all 
emulating that.  !B would actually be easier to create because you could use 
git-revert to automatically create the inverse of B.  If you wanted to only 
revert a single file, well you could use

  git-checkout G-REVISION -- file

To pull only that file out of G, and then commit that back, before starting 
the tidy up.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
