From: "Adam Brewster" <adambrewster@gmail.com>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Thu, 3 Jul 2008 19:13:09 -0400
Message-ID: <c376da900807031613pc63639du356946f8daeabb29@mail.gmail.com>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com>
	 <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com>
	 <7vzlp1jh1o.fsf@gitster.siamese.dyndns.org>
	 <486AC8E0.60002@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Mark Levedahl" <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Jul 04 01:14:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEY0L-0002vL-8T
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 01:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358AbYGCXNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 19:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756247AbYGCXNX
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 19:13:23 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:16309 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756246AbYGCXNW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 19:13:22 -0400
Received: by yw-out-2324.google.com with SMTP id 9so443870ywe.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 16:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wOvJ5wVbcplZoadXdR4bh5SlkK9D3z1vAxEf5MmjkNY=;
        b=W0JrlFel1kus0IDK8ZPVhFXUvcvJCPUe9Wi0TcLuXKO9KLcJ9pJ+23TufHRWHtx3LG
         aUun87Z7Ts/xGbv2bR7BNt8jKUj8mDA5MBPJ+GsAIYCq+gy+YQbuijVO6oOAazbnfxRr
         d6Cdjkpls7KpJj3h+b0SI6wPFP69Us1yjJfvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oB4jFTT8jlEZgH/PPRqhJ+tWj7pGyG4ridedY+hCuxKClUlRApPxJVE/6H2faZzRe3
         POV6B5XSa+WvRJZE1OcA4sV/Ghkrw6EhJaRMFCDyJL1ab8YNqTYdPdKTu0+mu3Y/M5WW
         DCi8wC8b3WQd9Ukxv1RL0vQXYWDNV37bOe10A=
Received: by 10.151.42.6 with SMTP id u6mr1044508ybj.213.1215126789480;
        Thu, 03 Jul 2008 16:13:09 -0700 (PDT)
Received: by 10.150.205.18 with HTTP; Thu, 3 Jul 2008 16:13:09 -0700 (PDT)
In-Reply-To: <486AC8E0.60002@verizon.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87333>

Hi Mark,

Thank you for your help, and I'm sorry I didn't get back to you sooner.

>
> I have implemented (in script form) a different approach: basically, I just
> keep a local copy of the refs pushed out via bundle in refs/remotes/*, just
> as for any other remote, and then use those as the basis for later bundles.
> My longer term goal is to integrate this into git push, so that with a
> properly configured remote "git push foo" will create a bundle based upon
> the local knowledge of the remote's basis and update the local copy of the
> refs.
>
> [...]

That's a good way to do things.  I tend to like my system better
because it's a little more flexible and it doesn't pollute git-branch
-a and gitk --all, also as I said before I like the bundle creation
and the basis update to be separated.

How do you deal with the case where you want to include remote refs in
the bundle?  Don't they get saved as
refs/remotes/remote/remotes/somewhere-else/master?

Adam
