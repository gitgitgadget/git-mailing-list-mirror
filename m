From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: git-clean and empty pathspec
Date: Fri, 7 Dec 2007 00:14:02 -0600
Message-ID: <20071207061402.GB21347@mediacenter.austin.rr.com>
References: <fcaeb9bf0712061021o5383f538h3a086a913ac1b05d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 07:14:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0WTP-0002VA-MC
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 07:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbXLGGNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 01:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbXLGGNr
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 01:13:47 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:63740 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbXLGGNq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 01:13:46 -0500
Received: by an-out-0708.google.com with SMTP id d31so138466and
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 22:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=C5zZNUVB9vLHp0I1qabIFvAQFyHEUt+B3ickWqemI5c=;
        b=hROMI043FXm35adNHlJ9M/bW/vPC2l0rjPpqdHwUntaJKwUC2p65ZzRlsG9a2teotSMjmGPdKM0lPlN9opUG05ly67zXhk/M0xs1tNqNXDo8zs/roruiCEtcJeSx9GtOo9XWy94gSHRJ1Zip5BqLBXPPLY4d3jGMkS7+FcIINYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=vZ+zM0q0cpkIqN5Iu0fd+Ecczu+gDa52wrJu/rv/VUtd6lc5EoFR8Noqugm+Hw6xFdxARCjOnf0B4s4PYJpGW5IjvaEPWljaKX0clBR2RewsrjHk9h08bXbs0oKd1ufiNO4zaCY9+wV7s2E7MGC5Es/5LOc5/1PczJXeS2pxoWY=
Received: by 10.100.210.9 with SMTP id i9mr8500449ang.1197008024902;
        Thu, 06 Dec 2007 22:13:44 -0800 (PST)
Received: from mediacenter.austin.rr.com ( [70.112.149.232])
        by mx.google.com with ESMTPS id n5sm3991026rnf.2007.12.06.22.13.43
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Dec 2007 22:13:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0712061021o5383f538h3a086a913ac1b05d@mail.gmail.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67384>

On Fri, Dec 07, 2007 at 01:21:10AM +0700, Nguyen Thai Ngoc Duy wrote:
> "git clean -n" would not remove directories while "git clean -n -- ''"
> (two single quotes) would. Is there anything wrong with it?

It appears that match_pathspec views this as a recursive match to
everything, so git clean thinks that you provided the pathspec for all
files and directories and thus will remove them.

Without the '' there is no provided pathspec so git clean will not
remove the directories without -d.

Note this is different behavior from the old git-clean.sh.
