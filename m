From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: tracking a file from another project in my own project
Date: Tue, 22 Jan 2008 07:23:28 -0800 (PST)
Message-ID: <m3fxwplw1i.fsf@roke.D-201>
References: <20080122093546.72db8da0@synchrotron-soleil.Fr>
	<7v7ii2rzbq.fsf@gitster.siamese.dyndns.org>
	<20080122145658.18b6ef89@synchrotron-soleil.Fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: picca <picca@synchrotron-soleil.Fr>
X-From: git-owner@vger.kernel.org Tue Jan 22 16:24:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHKyt-000351-9L
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 16:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbYAVPXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 10:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbYAVPXd
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 10:23:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:48134 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbYAVPXc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 10:23:32 -0500
Received: by nf-out-0910.google.com with SMTP id g13so430049nfb.21
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 07:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=TWGhtC+thRAvyuPYDcq8eS3JNW+iVsvyD/uvpNrBU5g=;
        b=k5LVCXYokhk1l3Cwxq0o4LHvy2kJAchXDfYxyIRQrc8r1UK7I4KGdVX1Y19ICA0Wr2ZLvLm2hKXzA0XCLmwoA2iqn6OqOP/yYOODn/YeqcgaNyNrveRmWcX7mFmWzJHZExQF5K2nNtf0UxdgwSTfIUCVqxvkkvXt7ZLX2qbXYps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=yHQ2KKmqa8RHptif9N5P8lcAbFtjsx5H7nRLnT8lKxH1Ba1RtrG3TLYDDpGllFVWWD3gWS4VGy/ob++izPQ982a1Bdhhk4nSit7EwKbJHLwWH1LiO+cCL6tL0gG4JFbnobzYPzkdAyscks7Gf1ikkE7oZaJl/YMLJ+lBwlRBf58=
Received: by 10.78.134.2 with SMTP id h2mr11276405hud.77.1201015410224;
        Tue, 22 Jan 2008 07:23:30 -0800 (PST)
Received: from roke.D-201 ( [83.8.211.135])
        by mx.google.com with ESMTPS id z30sm2945242hub.19.2008.01.22.07.23.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Jan 2008 07:23:28 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0MFSVcI002091;
	Tue, 22 Jan 2008 16:28:31 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0MFS974002086;
	Tue, 22 Jan 2008 16:28:09 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20080122145658.18b6ef89@synchrotron-soleil.Fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71455>

picca <picca@synchrotron-soleil.Fr> writes:

> On Tue, 22 Jan 2008 01:20:41 -0800
> Junio C Hamano <gitster@pobox.com> wrote:
> 
> > If I were you I'd probably just keep git.git as a submodule in
> > your project and have two symlinks from your toplevel pointing
> > at git.git/strbuf.[ch] (or from src/ to ../git.git/strbuf.[ch]).
> 
> So submodule is a requirement to achieved this comportment ?

If you want to have strbuf.[ch] automatically tracked from git.git
the you would have to have git.git project somehow embedded in your
repository.  Using submodules is one solution.

Currently there is no way to do "sparse checkout", i.e. automatically
checkout only needed files (even if git.git clone has all the
objects), but feel free to implement it... ;-) (just kidding).

Or you can try to convince strbuf authors to make it into separate
project, which would be fetched into git.git like gitk was.  And you
could then pull from this project directly or indirectly (submodule)
into your project.
  
> If someone want to clone my project.git, must he also clone the
> git.git project or he loose the ability to follow by it's own the
> strbuf.[ch] file ?

True.

> > Or "merge -s subtree".
> 
> I read the git help merge -s explanation but I do not understand how
> it can help in my case.

Using subtree merge strategy you can join histories of your project
and git.git, embedding git.git as a subdirectory like gitk and git-gui
are now in git.git.  It is an alternative to using submodules.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
