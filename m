From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Thu, 2 Jan 2014 18:18:57 +0000
Message-ID: <20140102181857.GG7608@serenity.lan>
References: <52C5A039.6030408@gmail.com>
 <alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
 <52C5ABDE.1010006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 19:19:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VymrQ-000770-O1
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 19:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbaABSTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 13:19:08 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:44003 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaABSTH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 13:19:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 31AFFCDA57C;
	Thu,  2 Jan 2014 18:19:07 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6URr6TxfAIII; Thu,  2 Jan 2014 18:19:06 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id E0DF0CDA591;
	Thu,  2 Jan 2014 18:19:00 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <52C5ABDE.1010006@gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239864>

On Thu, Jan 02, 2014 at 07:11:42PM +0100, Sebastian Schuberth wrote:
> On 02.01.2014 18:33, Johannes Schindelin wrote:
> 
> > -- snip --
> > On Linux, we can get away with assuming that the directory separator is a
> > forward slash, but that is wrong in general. For that purpose, the
> > is_dir_sep() function was introduced a long time ago. By using it in
> > safe_create_leading_directories(), we proof said function for use on
> > platforms where the directory separator is different from Linux'.
> > -- snap --
> 
> While I'd be fine with this, I do not think we really need it. As you 
> say, is_dir_sep() has been introduced a long time ago, so people should 
> be aware of it, and it should also be immediately clear from the diff 
> why using it is better than hard-coding '/'.
> 
> That said, I see any further explanations on top of the commit message 
> title is an added bonus, and as "just" a bonus a link to a pull request 
> should be fine. You don't need to understand or appreciate the concept 
> of pull requests in order to follow the link and read the text in there.

The commit message serves as an historical record of why a change was
made; depending on an external service to provide this information when
it can quite easily be included in the commit itself lessens the value
of the commit message.

If you look at other commits in git.git you will see that there is a
strong preference for summarising the discussion and rationale for a
commit in its message.
