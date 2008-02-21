From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix amending of a commit with an empty message
Date: Thu, 21 Feb 2008 22:32:04 +0100
Message-ID: <20080221213204.GC20143@steel.home>
References: <20080221195438.GA6973@steel.home> <7vwsoyt5xt.fsf@gitster.siamese.dyndns.org> <20080221203506.GA20143@steel.home> <20080221203802.GB20143@steel.home> <7vmyput4dn.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 22:32:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSJ25-0004nk-RC
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 22:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbYBUVcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 16:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbYBUVcJ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 16:32:09 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:17319 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbYBUVcI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 16:32:08 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFhynk=
Received: from tigra.home (Fad6a.f.strato-dslnet.de [195.4.173.106])
	by post.webmailer.de (mrclete mo55) (RZmta 16.8)
	with ESMTP id y04847k1LJc8xn ; Thu, 21 Feb 2008 22:32:05 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2C2A9277BD;
	Thu, 21 Feb 2008 22:32:05 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 95A5356D24; Thu, 21 Feb 2008 22:32:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vmyput4dn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74661>

Junio C Hamano, Thu, Feb 21, 2008 21:56:52 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > In this one. I am a bit unsure regarding the change (it looks a little
> > too strong), even though it passes the test suite.
> 
> I think that is because your new test is faulty.
> 
> Instead of ':' I complained about, try having "echo foo" there.
> I think it will still fail.

Oh, indeed. The commit to amend does not introduce any changes.

> Having said that, here is a quiz.  When the user says "git
> commit --amend", what are the valid reasons not to allow it,
> other than:
> 
>  - the index is unmerged.
>  - the branch is yet to be born.

There are no tree changes in the commit to be amended.
And if there is a strong wish to do just the amendment,
there is always --allow-empty.

Ok, it must have been the amount of err... tee I just had.
