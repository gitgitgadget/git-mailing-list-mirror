From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: cgit vs. gitweb
Date: Tue, 26 Dec 2006 00:44:13 +0000
Message-ID: <20061226004413.GA6558@localhost>
References: <8c5c35580612250921o765e141cq27f81b06364d0a4@mail.gmail.com> <empikd$s32$1@sea.gmane.org> <8c5c35580612251604s5e211518yd958fdc2e73232ef@mail.gmail.com> <200612260132.41062.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 26 01:44:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz0Qj-0007Eb-FA
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 01:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbWLZAo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 19:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754614AbWLZAo1
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 19:44:27 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:52197 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608AbWLZAo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 19:44:26 -0500
Received: from a-103-152.cust.iol.ie ([194.125.103.152] helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1Gz0QA-0002do-1O; Tue, 26 Dec 2006 00:43:59 +0000
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200612260132.41062.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35402>

> By the way, which version of gitweb did you use (shortened sha1 of 
> commit, or result of git-describe)? I'm interested if it is before
> or after Robert Fitzsimons patches which replaced 101 forks in
> log-like views with 1 fork, which I think affects gitweb performance
> a lot.

Here are the numbers for a few tests I ran yesterday, this is with
gitweb without mod_perl.

v267,                  1842 38.5 +/- ms (with v1.4.4.3 git tools)
v1.4.4.3,               445  2.5 +/- ms
master,                 445  2.5 +/- ms
master + bulk patches,  340  3.7 +/- ms (--skip patch)

(/usr/sbin/ab -n 20 -k "http://localhost/git/?p=home/bob/src/git/git/.git;a=summary")

Robert
