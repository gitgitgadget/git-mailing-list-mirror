From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: b5227d8 changes meaning of "ls-files -x 'pattern'"
Date: Mon, 14 Dec 2009 17:15:38 +0100
Message-ID: <4B2664AA.4050204@drmicha.warpmail.net>
References: <2e24e5b90912140751y5d769f15pa6782914bdb04dbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 17:21:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKDbj-0000GG-QW
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 17:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757707AbZLNQRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 11:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757695AbZLNQRF
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 11:17:05 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41542 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757693AbZLNQRE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 11:17:04 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 377B2C6301;
	Mon, 14 Dec 2009 11:16:59 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 14 Dec 2009 11:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=cPLkI95obSfitwm9B7elm5Ye8sU=; b=s7AXHze16Zi+MrfZz2koKEuGh7seqzCVKipjnxl7IEJVesDUmbdg0BTYtgPHr+DvRqoSAJj2j2hHuAukOQXLH96/8hehxAzEp2nu8ph/WCSJaIEx7n7kOWtW+secLnOsPHZ5FJdzzEAHIghTR6bWqMyCU7oD82yj0iZgDOzYKdM=
X-Sasl-enc: 2aOjL0SUvDjVPkEiD561XAr1aHOmtCfg89QjTU5iTdEt 1260807419
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 611944AE61B;
	Mon, 14 Dec 2009 11:16:59 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <2e24e5b90912140751y5d769f15pa6782914bdb04dbd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135223>

Sitaram Chamarty venit, vidit, dixit 14.12.2009 16:51:
> Hello,
> 
> Before b5227d8, the following two commands would produce different
> outputs (say on git.git):
> 
>     git ls-files
>     git ls-files -x '*.c'
> 
> From b5227d8 onward, they produce the same output.  The second command
> no longer excludes *.c files.
> 
> I was unable to understand the commit message completely but it sounds
> like this was intentionally changed to do this.

Yes. Generally, git commands never ignore tracked files, and this patch
reintroduces this for git ls-files

> I've never been real clear on ls-files, and was wondering if someone
> would be able to clarify the various ways of using it, including why
> this change was made and is there a way (using some other combination of
> flags perhaps) to get a list of files without *.c (to continue this
> example).

You can still use file glob patterns as the file argument, such as

git ls-files '*.[^c]'


Michael
