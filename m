From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: [PATCH] gitk: Synchronize highlighting in file view when scrolling
 diff
Date: Wed, 19 Sep 2012 10:28:50 -0400
Message-ID: <5059D6A2.3000401@xiplink.com>
References: <1347947874-38597-1-git-send-email-stefan@haller-berlin.de> <20120918234611.GA5544@bloggs.ozlabs.ibm.com>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stefan Haller <stefan@haller-berlin.de>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 16:36:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TELOX-0006Tu-Lf
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 16:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab2ISOgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 10:36:44 -0400
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:53553 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab2ISOgn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 10:36:43 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Sep 2012 10:36:43 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp52.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 04F82241477
	for <git@vger.kernel.org>; Wed, 19 Sep 2012 10:28:56 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp146.ord.emailsrvr.com (smtp146.ord.emailsrvr.com [173.203.6.146])
	by smtp52.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTPS id E165C2414B4
	for <git@vger.kernel.org>; Wed, 19 Sep 2012 10:28:55 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp23.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id A81871C80DE;
	Wed, 19 Sep 2012 10:28:24 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp23.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 617931C80D2;
	Wed, 19 Sep 2012 10:28:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <20120918234611.GA5544@bloggs.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205926>

On 12-09-18 07:46 PM, Paul Mackerras wrote:
> On Tue, Sep 18, 2012 at 07:57:54AM +0200, Stefan Haller wrote:
>> Whenever the diff pane scrolls, highlight the corresponding file in the
>> file list on the right. For a large commit with many files and long
>> per-file diffs, this makes it easier to keep track of what you're looking
>> at.
> 
> I like this as far as it goes, but the one criticism I would have is
> that when you find a string (using the "Search" button), the filename
> that gets highlighted is often not the file in which the string was
> found (because the highlighting is based on the top line visible in
> the text window), which could be confusing.

Well, gitk currently doesn't highlight the matching file (or files -- there
can be more than one).  Stefan's patch isn't changing anything with how
string matching already works.

> Can you think of a way to solve that too?  Perhaps make the
> highlighting based on the currently highlighted instance of the search
> string, if there is one, otherwise based on the top line visible?

I think you're asking for a new feature.

Highlight-files-with-string-matches is different from Stefan's
consistently-highlight-currently-displayed-file, so it should be done
differently.  Perhaps use a different highlight colour, or overlay the
matching files with an icon.

		M.
