From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: merge strategy request
Date: Mon, 26 Mar 2007 12:11:59 +1200
Message-ID: <46a038f90703251711x6ecfa3e2k19b7d36717fad44e@mail.gmail.com>
References: <Pine.LNX.4.63.0703241430420.12864@qynat.qvtvafvgr.pbz>
	 <Pine.LNX.4.63.0703250315461.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0703242130050.6730@woody.linux-foundation.org>
	 <7v648paj14.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90703251634t2ab6a455t382ebe29cdb53667@mail.gmail.com>
	 <7vejnc28i3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"David Lang" <david.lang@digitalinsight.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 02:13:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVcpo-0001v8-Rr
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 02:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933045AbXCZANJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 20:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933208AbXCZANJ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 20:13:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:16148 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933045AbXCZANI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 20:13:08 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1947868wxd
        for <git@vger.kernel.org>; Sun, 25 Mar 2007 17:13:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FW1PeTdyMGiNxfCfVPBOXwzH+lcOyphhnx2r4bWljBi8Z1Pp/6HbZ179OM90onnBKkYb+uqofVyQrl8fjRNq+MmQKuZKvSZjnwqu/3fk09r118zXFWarTqGhp46Jf2SliyrwLvD8qjocUqqAXCkdII5kFdg9YHO+V4id1/vKdnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q7ZeaX0y2Xh+yU25NB5g324sf52GvihmXObATUImzVyECMKTKLXMBtLJyJnPlJ6oSv01qOEtd3rw/LsnlED+gPmYw5d1eBwkQVGaLmMW1XRqTwnVEvFke1mwVStFv8DQDWLIqUxoZJLgP/EpY232bIEmfAhBmygfl4MGhhiuB5Y=
Received: by 10.90.87.5 with SMTP id k5mr6264479agb.1174867987381;
        Sun, 25 Mar 2007 17:13:07 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Sun, 25 Mar 2007 17:11:59 -0700 (PDT)
In-Reply-To: <7vejnc28i3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43099>

On 3/26/07, Junio C Hamano <junkio@cox.net> wrote:
> But a more interesting point is "under what condition".  If the
> condition is "when GIT_MERGE environment is defined", it is not
> much better than what Dscho suggested, as the external merger
> would be called for all paths.

Well well... no. Unless you mean all paths that need diff3 merging
(that is, all paths that changed on both sides). And in that case, the
script itself can have the "change policy depending on file extension
or phase of the moon" machinery. I think it makes it more powerful
because it can have specialised logic for this -- where the git
machinery is going to be limited to simpler rules (like file
extension).

In any case, it is a _different_ mechanism to saying "all changed
paths on either side". I don't know if there is even an interesting
case for that.

> it is rather an unfortunate norm.  I am not opposed to give
> git-merge-recursive a command line option to tell it to merge
> ignoring the whitespace-only changes, when it does the 3-way
> file-level merge internally.

That'd be great to have. How about both? ;-)

cheers,


m
