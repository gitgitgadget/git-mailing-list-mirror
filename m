From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Mon, 4 Apr 2011 10:24:41 +0530
Message-ID: <20110404045437.GA2208@kytes>
References: <20110403172054.GA10220@kytes>
 <alpine.LNX.2.00.1104031407480.14365@iabervon.org>
 <20110404040610.GA30737@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Stephen Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Apr 04 06:56:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6bpd-0001x3-R3
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 06:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab1DDEzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 00:55:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34282 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab1DDEzs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 00:55:48 -0400
Received: by iwn34 with SMTP id 34so5392341iwn.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 21:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bnEXe+dfh5Og41G7PlOqB7A7KifGAFKOXO2MooDzzRA=;
        b=sWVF2rrwZJa2if0oHpPY1I7glgm05Hlq2RhQimCx4/+EbjbQRGYtQUsBO/LWDLESSY
         byt8Rw6KwyWVrliX8OZk/PTiJsz52uE96Eo7g4L76/ZfDWswOuGA5tnntA9MDKvrPxpa
         zTzFW3F4nPFXIrtwDYR1NS2FKfpCFjGSo+frM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CgIvBTf2PaIwzwboMOmRCr9qSSvVZRsJCefY7nOF8COlavhz9DYkr+RspNU9dXKgl0
         YvkxlVgco2zxXN1otJ2W0lo/L1VUSSAY9a3FCJ00rRiOgn73fHnyz1iobIT+OxzgQYku
         zG+RR9BGaksYutbvXUDBsUX8DSpw/om0pQy1I=
Received: by 10.231.39.130 with SMTP id g2mr6882427ibe.118.1301892947651;
        Sun, 03 Apr 2011 21:55:47 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id e9sm178411ibb.66.2011.04.03.21.55.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 21:55:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110404040610.GA30737@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170787>

Hi Daniel,

Ramkumar Ramachandra writes:
> Daniel Barkalow writes:
> > I actually think that it would be a worthwhile feature for git's library 
> > code to have a uniform mechanism for communicating that it is requesting 
> > human intervention in the middle of a particular operation, where library 
> > operations which conflict with being able to continue this operation are 
> > either blocked or abort the operation, and the library is able to be told 
> > in general that the human intervention is done and the library operation 
> > should be finished now (or produce complaints about the user's work). That 
> > is, a library-level, single-interrupted-step "sequencer". For that matter, 
> > it should also apply to the common '"git merge" gets a conflict' case, and 
> > it would be useful to get some representational uniformity between that 
> > and cherry-pick getting a conflict.

[...]

> int sequencer_handle_conflict(); /* Returns ABORT (1) or RESOLVED (0) */
> 
> /**
>  * The sequencer_handle_conflict function essentially starts with a
>  * working tree with unmerged files and results in either a working
>  * tree without unmerged files (in which case it returns 0), or simply
>  * returns 1.  Advantage: Consistency. Each individual script will not
>  * have to maintain its own temporary files.
>  */

Uh, no.  I wrote this part in too quickly.  Clearly needs more
thought.

-- Ram
