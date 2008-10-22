From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git performance
Date: Wed, 22 Oct 2008 15:42:51 -0700 (PDT)
Message-ID: <m3d4hsi708.fsf@localhost.localdomain>
References: <000801c93483$2fdad340$8f9079c0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Edward Ned Harvey" <git@nedharvey.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 00:44:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsmQu-0007AT-Bi
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 00:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758127AbYJVWmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 18:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758122AbYJVWmz
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 18:42:55 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:30917 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbYJVWmy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 18:42:54 -0400
Received: by ey-out-2122.google.com with SMTP id 6so14371eyi.37
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=X3FW/kmyskELBBPimnJYzSFO0bp8h+Cy4jF+/x1wNQ0=;
        b=NxjQHE5vB8xLP01fEPh/nEphybk/rlZl/UJYkTZwTEcn/91dx1IACPEln5DiNhhmDI
         cgGOI+7+mu7mzxF6JkZWPOdade8WW2fxefe4WETCqc0t9GCxKtwXP3QKkbn4A3/tQo3u
         RPARd1XmiCDapTb+wzCMC0SVKvwAoLJU5mZmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=ufvZBOuMDf4Qiw+qhqUaI7RW/A+ZW15pintMfjTdwDJqa+REuoxNAd+/t1jv3e9Bde
         Uy1gzK4WnMKa7yGTSQACSbxTKQ+hyMMgSKXUwWWg3n5DL0M8liYtr6GBqmlxXJYi8QE+
         hQYMBR2At7Wl0axa5ksBnv4RDYltZ65KOD8uw=
Received: by 10.210.73.12 with SMTP id v12mr6075737eba.33.1224715372325;
        Wed, 22 Oct 2008 15:42:52 -0700 (PDT)
Received: from localhost.localdomain (abxd135.neoplus.adsl.tpnet.pl [83.8.253.135])
        by mx.google.com with ESMTPS id y34sm9488325iky.2.2008.10.22.15.42.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Oct 2008 15:42:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9MMjdnr012537;
	Thu, 23 Oct 2008 00:45:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9MMjRU5012534;
	Thu, 23 Oct 2008 00:45:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <000801c93483$2fdad340$8f9079c0$@com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98924>

"Edward Ned Harvey" <git@nedharvey.com> writes:

> I see things all over the Internet saying git is fast.  I'm
> currently struggling with poor svn performance and poor attitude of
> svn developers, so I'd like to consider switching to git.  A quick
> question first.
> 
> The core of the performance problem I'm facing is the need to "walk
> the tree" for many thousand files.  Every time I do "svn update" or
> "svn status" the svn client must stat every file to check for local
> modifications (a coffee cup or a beer worth of stats).  In essence,
> this is unavoidable if there is no mechanism to constantly monitor
> filesystem activity during normal operations.  Analogous to
> filesystem journaling.
> 
> So - I didn't see anything out there saying "git is fast because it
> uses inotify" or anything like that.  Perhaps git would not help me
> at all?  Because git still needs to stat all the files in the tree?

http://git.or.cz/gitwiki/GitBenchmarks

While it should be possible to use 'assume unchanged' bit together
with inotify / icron, it is not something tha is done; IIRC Mercurial
had Linux-only InotifyPlugin...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
