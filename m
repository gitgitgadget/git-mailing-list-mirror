From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Add git svn gc command
Date: Mon, 20 Jul 2009 20:25:15 -0700
Message-ID: <20090721032515.GA4636@dcvr.yhbt.net>
References: <8E0EFA3B-E8C0-4030-8BAE-E8EF65694031@gmail.com> <20090720075929.GA5591@dcvr.yhbt.net> <1030C457-44CB-4D78-A692-8F3B34A3E9BD@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Zeh <robert.a.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 05:25:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MT5yv-0008DB-JW
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 05:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765AbZGUDZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 23:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762AbZGUDZR
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 23:25:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37859 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754655AbZGUDZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 23:25:16 -0400
Received: from localhost (unknown [12.186.229.34])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 97C6B1F585;
	Tue, 21 Jul 2009 03:25:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1030C457-44CB-4D78-A692-8F3B34A3E9BD@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123643>

Robert Zeh <robert.a.zeh@gmail.com> wrote:
> Hi Eric,
>
> Thanks for all of the suggestions.  I've attached a patch that takes all 
> of the list suggestions into account.  I hope I've implemented the  
> can_compress changes properly.

Hi Robert, that looks fine to me.

> I believe I've fixed the white space issues; I tried a round trip and my 
> tabs were preserved.  The getcwd stuff was indeed leftover code from 
> testing; I found another left over debug statement.

The tabs seem alright, but spaces are still mangled.  Perhaps
Documentation/SubmittingPatches has tips for your mailer? (or check out
git send-email)

> I have one remaining question ---  does git svn gc need to avoid  
> removing index files if --no-metadata was set?  If it does, I'd  
> appreciate a tip on how to see if it was set.

Nope, not at all, index files are very safely removable unless there's a
clone/fetch actively running.  The rev_map files on the other hand are
not removable iff --no-metadata or --use-svm-props is used.

-- 
Eric Wong
