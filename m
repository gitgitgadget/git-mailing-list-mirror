From: John Keeping <john@keeping.me.uk>
Subject: Re: Followup: Managing EXCEL with git - diff problem.
Date: Tue, 7 Apr 2015 14:26:28 +0100
Message-ID: <20150407132628.GI21452@serenity.lan>
References: <02d801d07132$159f76a0$40de63e0$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 15:42:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfTd7-0007EZ-Lq
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 15:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbbDGNdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 09:33:10 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:50052 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbbDGNdG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 09:33:06 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Apr 2015 09:33:06 EDT
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C4AAECDA549;
	Tue,  7 Apr 2015 14:26:36 +0100 (BST)
X-Quarantine-ID: <sI8yCuRlEEWF>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_20=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sI8yCuRlEEWF; Tue,  7 Apr 2015 14:26:35 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id F1A9D86600C;
	Tue,  7 Apr 2015 14:26:30 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <02d801d07132$159f76a0$40de63e0$@nexbridge.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266911>

On Tue, Apr 07, 2015 at 08:55:11AM -0400, Randall S. Becker wrote:
> There was a discussion a while back on how to manage EXCEL content in git.
> This involved a simple trick of modifying the file extension from .xlsx to
> .zip and unpacking the file - resulting in a whole bunch of XML files. Git
> is happy with that part and the content can be managed - slightly.
> 
> Unfortunately, EXCEL stores its XML content in single lines. Git has no
> problem with that either, as far as managing the content, but the lines can
> be really long. However, after about 20K in size, while the config:
> 
> 	alias.wdiff=diff --color-words
> 
> The ability of git to report differences goes away - as in no output from
> git diff. This occurs on Windows and Linux under git 2.3.3 and git 2.3.0.
> I'm not sure whether this is a user error, a usage error, or an actual
> problem.
> 
> I had originally raised this as a SourceTree problem figuring it might be
> there: https://jira.atlassian.com/browse/SRCTREEWIN-3145
> 
> Any advice (preferably no teasing - :-) - I am considering smudging but
> would rather avoid that)?

Perhaps try defining a specific diff driver for these files (see
git-attributes(5)).  There is an xmldiff program [0] that might be able
to generate more useful diffs.

[0] http://www.logilab.org/project/xmldiff
