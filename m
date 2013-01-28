From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Mon, 28 Jan 2013 21:01:36 +0000
Message-ID: <20130128210136.GC7498@serenity.lan>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <7v38xm12kk.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7sQKDNPpaFJi+en479TF=aLXL2pvXODeo6CC3xD1KMGw@mail.gmail.com>
 <7vr4l6yrd3.fsf@alter.siamese.dyndns.org>
 <CAJDDKr75K3RGgU79nrznbpjQMLQGkDs=W8XEofURNsS1X1bvjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 22:02:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzvq9-0004lR-V9
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 22:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877Ab3A1VBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 16:01:45 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:58610 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab3A1VBo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 16:01:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 9475160654A;
	Mon, 28 Jan 2013 21:01:43 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zWpT6wgilQ3P; Mon, 28 Jan 2013 21:01:43 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 9CC64606528;
	Mon, 28 Jan 2013 21:01:38 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr75K3RGgU79nrznbpjQMLQGkDs=W8XEofURNsS1X1bvjg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214874>

On Sun, Jan 27, 2013 at 06:41:04PM -0800, David Aguilar wrote:
> John, I didn't completely address your question about keeping
> the sort and prefix in show_tool_help() but I can stop poking at
> it now in case you want to start looking at what it would take
> to get custom tools listed in the --tool-help output.

I've had a quick look and it's quite straightforward to build on top of
this to get an output format like this:

    'git mergetool --tool-<tool>' may be set to one of the following:
                    araxis
                    gvimdiff
                    gvimdiff2
                    vimdiff
                    vimdiff2

            user-defined:
                    mytool

    The following tools are valid, but not currently available:
                    bc3
                    codecompare
                    deltawalker
                    diffuse
                    ecmerge
                    emerge
                    kdiff3
                    meld
                    opendiff
                    p4merge
                    tkdiff
                    tortoisemerge
                    xxdiff

            user-defined:
                    mybrokentool

    Some of the tools listed above only work in a windowed
    environment. If run in a terminal-only session, they will fail.


I don't think the suffix form would be too hard either - it just
requires moving an explicit sort into the top-level shot_tool_help
function.

I'm going to hold off doing any more on this until da/mergetool-docs has
graduated to next since I think it will be easier to just build on that
rather than trying to put all the necessary pieces into place now.


John
