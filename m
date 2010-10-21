From: Stephen Bash <bash@genarts.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Thu, 21 Oct 2010 09:49:29 -0400 (EDT)
Message-ID: <3225966.537036.1287668969593.JavaMail.root@mail.hq.genarts.com>
References: <201010211016.47998.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Will Palmer <wmpalmer@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	mrevilgnome <mrevilgnome@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 15:49:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8vWd-0001TL-9r
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 15:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205Ab0JUNth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 09:49:37 -0400
Received: from hq.genarts.com ([173.9.65.1]:18725 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754954Ab0JUNth (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 09:49:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id AE6961E26377;
	Thu, 21 Oct 2010 09:49:35 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oBaiityBppB0; Thu, 21 Oct 2010 09:49:29 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 9C7861E26376;
	Thu, 21 Oct 2010 09:49:29 -0400 (EDT)
In-Reply-To: <201010211016.47998.jnareb@gmail.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159504>

----- Original Message -----
> From: "Jakub Narebski" <jnareb@gmail.com>
> To: "mrevilgnome" <mrevilgnome@gmail.com>
> Sent: Thursday, October 21, 2010 4:16:46 AM
> Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
>
> > Are copy operations notated in some fashion?

Yes, copies create a special pair of properties in SVN: copyfrom_rev and copyfrom_path.  Unfortunately SVN users use the copy operation for non-branching purposes, so some amount of filtering is required.  I posted a script earlier in this thread that used one set of heuristics based on my local SVN repository, but I'm not claiming it will work for everyone.

> Actually it shouldn't be that hard to implement, if it isn't already
> implemented in svn-fe.

David just brought up teaching svn-fe to emit the copyfrom properties to help git do branch mapping.  I think there's still a lot of effort in creating a good mapping algorithm, but the pieces are coming together.

Stephen
