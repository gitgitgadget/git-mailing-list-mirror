From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Fri, 2 Feb 2007 12:02:24 +0100
Message-ID: <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
	 <20070201191323.GA18608@spearce.org>
	 <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net> <epv3r9$4f7$2@sea.gmane.org>
	 <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 12:02:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCwBZ-0007HN-CV
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 12:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbXBBLC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 06:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbXBBLC0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 06:02:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:24408 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbXBBLCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 06:02:25 -0500
Received: by ug-out-1314.google.com with SMTP id 44so727754uga
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 03:02:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rvFtoHbsuShZCwVHJJRJfpfL0OM8Qkd1J9ScXzj74Fxe+yWay3Z4VWUBdOVY/3nfvXyEC3Sik723dychbnq/piVR1naMHTzdkHGNYGrNAT8S7FbAyz6cChutcSB7c5zGJrpx1rrDgNcQ0Ru/626FZ2Ao8J5USQ5wSvW2u19oVxw=
Received: by 10.82.165.1 with SMTP id n1mr1116580bue.1170414144290;
        Fri, 02 Feb 2007 03:02:24 -0800 (PST)
Received: by 10.82.158.7 with HTTP; Fri, 2 Feb 2007 03:02:24 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38491>

On 2/2/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 2 Feb 2007, Jakub Narebski wrote:
>
> > Perhaps we should use @{...} to refer to reflog for HEAD, or use yet
> > another special notation?
>
> No.
>
> IMHO "bla@{yesterday}" should give you what "bla" pointed to, yesterday.
> In that sense, the proposed reflog on "HEAD" makes perfect sense.

Since HEAD is a synonym for "current branch" everywhere else in git,
while .git/logs/HEAD will be a log of detached HEAD (plus branch
switches, I guess), I think the following makes perfect sense:

  "HEAD@{yesterday}" = current branch, yesterday
  "@{yesterday}"     = detached head (no branch), yesterday


Just my 2c

--
larsh
