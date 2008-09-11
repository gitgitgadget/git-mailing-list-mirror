From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset --hard"
Date: Thu, 11 Sep 2008 16:04:19 -0700
Message-ID: <3ab397d0809111604r5d9dda04p32a987208d1fa92d@mail.gmail.com>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
	 <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>
	 <eafc0afe0809101914lff5b23ehaf625d702fbd9b5d@mail.gmail.com>
	 <51419b2c0809101938v30e5a1aflf944027aedc2d900@mail.gmail.com>
	 <loom.20080911T204256-821@post.gmane.org>
	 <7vd4jas6x8.fsf@gitster.siamese.dyndns.org>
	 <279b37b20809111519o76bea81br738983b4cda1978e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 01:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdvEV-0002HM-Uc
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 01:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbYIKXEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 19:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbYIKXEX
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 19:04:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:37627 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbYIKXEU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 19:04:20 -0400
Received: by ug-out-1314.google.com with SMTP id k3so950019ugf.37
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 16:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=y8aGOneRDu99ZsLfj7WCPQlAFDUUv/9xLQgw5WNrI7Q=;
        b=XJgZ0VMiKuQYyt4UHXFka+Szwoo3R0hSshgwC2RtEBqnJma0WOxG8/V2MAX/14V3HF
         EaX4Kf3RJjZzuV40eCJGblpx8pyjKLQ5L8zT5qG6tcY6lbkiegORL3PUhxNNlkmNsWu6
         EielxS/ajgf9WVjUjQbdHv24rwDFLNvqC3zwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=t9E29Avh584X5Ij0mdJffRXBfYxkHLp+7hqmaqC3TWH6NE0KPMLvpFTgpttgc1z6s2
         K7qzaPNPZzdlTAyeI2H+Rr5+7b3lF3ItBBChAz/58I84/xGEoZZoKT5T8EHD2Byfo11a
         NXG6bOHsrhTShjMYFQ7AkCELX2fAYIk/UPuho=
Received: by 10.67.40.6 with SMTP id s6mr8628560ugj.33.1221174259224;
        Thu, 11 Sep 2008 16:04:19 -0700 (PDT)
Received: by 10.67.93.17 with HTTP; Thu, 11 Sep 2008 16:04:19 -0700 (PDT)
In-Reply-To: <279b37b20809111519o76bea81br738983b4cda1978e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95663>

The command is wrapped up in all kinds of semantics at which you have
to guess or read tons of vague or outdated literature.  That's what
makes git's learning curve so retarded.

Why is it not just    git reset --index     or     git reset
--worktree    or   git reset --commitrepo REVISION  or   git reset
--all ?
And if you want to delete all untracked files
     ls | sed s/`git status --index --filenamesonly`//g | rm
     ls | sed s/`git status --commitrepo --filenamesonly`//g | rm
           (I realize those commands don't actually work, but I'm a noob.)

So that 'tracked by git' isn't just another ambiguous semantic.
Instead 'Tracked by index'/'Tracked by commitrepo'.
