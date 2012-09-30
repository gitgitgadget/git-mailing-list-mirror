From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: refresh the index before running diff-files
Date: Sun, 30 Sep 2012 13:34:58 -0700
Message-ID: <20120930203458.GA31365@elie.Belkin>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
 <20120928202330.GA5770@sigill.intra.peff.net>
 <20120928205054.GA5985@sigill.intra.peff.net>
 <20120930000527.GB4852@bloggs.ozlabs.ibm.com>
 <20120930014203.GA10664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Scott Batchelor <scott.batchelor@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 30 22:35:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIQEu-0002Fr-Nv
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 22:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab2I3UfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 16:35:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64532 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab2I3UfF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 16:35:05 -0400
Received: by pbbrr4 with SMTP id rr4so7027018pbb.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 13:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QlRzYpXRG943akTx+ydz2/lQUvlqPCyOUEXUJZb7gQY=;
        b=l4z3whODC4QBfoR6zQu/71v60JRFJnQ5YeH4I5QA2QhMGyImRaYmt6iywI4KAvDtNL
         k20WKNd4DhhCgWGJeJOJf0A8Xp4EzEBILF+Xu4Ew5UGTu/cYgs5qN3vhP0+fwBQlLBeP
         6YyO7xtZDUhFr9eWDq3Qj3dK4J30+p3QxOosN++4QNBXkJXTaL0qUPUXrf0sNG7cFDrc
         QXQa5ZHx7PUMCODh+8Xoo3Cke0MyegfXJwWV+nxAceVegxPQ4zQY1z9y3R7mkps970/1
         kXFt9G62xaNqAq4Wg9GgCOSBexN826E2WsUKCDiAzjHcqUPKdbKeLRNGCVbsSA3UuG9m
         kBEg==
Received: by 10.66.84.229 with SMTP id c5mr3128240paz.76.1349037305528;
        Sun, 30 Sep 2012 13:35:05 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id pa6sm9106705pbc.71.2012.09.30.13.35.04
        (version=SSLv3 cipher=OTHER);
        Sun, 30 Sep 2012 13:35:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120930014203.GA10664@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206696>

Hi Jeff,

Jeff King wrote:
> On Sun, Sep 30, 2012 at 10:05:27AM +1000, Paul Mackerras wrote:

>> Unfortunately this will wait for the git update-index command to
>> complete, making the GUI unresponsive while it executes, and that can
>> take minutes on a large repository (e.g. the linux kernel) on a
>> machine with a slow disk and a cold disk cache.  We will need to make
>> the git update-index execute asynchronously.
>
> Good point. We're getting out of my very limited tcl cargo-culting
> skills now, so I'll let somebody more clueful do that fix.

You might find the following patch and discussion entertaining:

  http://thread.gmane.org/gmane.comp.version-control.git/144182

Not my itch, but it was fun to write back then. ;-)

Hope that helps,
Jonathan
