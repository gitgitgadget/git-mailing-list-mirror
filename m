From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Sat, 24 Sep 2005 03:18:33 +0200
Message-ID: <20050924011833.GJ10255@pasky.or.cz>
References: <43348086.2040006@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 03:20:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIygZ-00070Y-Cb
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 03:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVIXBSg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 21:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVIXBSg
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 21:18:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51109 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751356AbVIXBSf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 21:18:35 -0400
Received: (qmail 23465 invoked by uid 2001); 24 Sep 2005 03:18:33 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43348086.2040006@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9220>

Dear diary, on Sat, Sep 24, 2005 at 12:24:06AM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> Packed tag objects breaks Cogito when using git+ssh:// transport.
> 
> Example:
> 
> cg-clone -s git+ssh://master.kernel.org/pub/scm/libs/klibc/klibc.git

I changed the code to use the git-*-fetch tools to fetch the objects
referenced by tags, so this works properly now. Thanks for the report.

It takes loooong time, unfortunately - scp -r takes its time itself on
many small files, and then we have to make a separate call to
git-ssh-fetch for each tag. Isn't that braindamaged... :/

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
