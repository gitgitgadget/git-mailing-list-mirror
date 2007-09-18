From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 1/3] git-apply: fix whitespace stripping
Date: Tue, 18 Sep 2007 09:12:37 -0400
Message-ID: <20070918131237.GA12120@fieldses.org>
References: <11899829424040-git-send-email-bfields@citi.umich.edu> <11899829424173-git-send-email-bfields@citi.umich.edu> <86r6kw4aki.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 15:12:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXcsf-00054E-7O
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 15:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbXIRNMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 09:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbXIRNMj
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 09:12:39 -0400
Received: from mail.fieldses.org ([66.93.2.214]:39051 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754533AbXIRNMj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 09:12:39 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IXcsX-0003Qv-PC; Tue, 18 Sep 2007 09:12:37 -0400
Content-Disposition: inline
In-Reply-To: <86r6kw4aki.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58601>

On Tue, Sep 18, 2007 at 10:55:25AM +0200, David Kastrup wrote:
> As far as I can see, this does not really work since it does not
> maintain an idea of a current column.
> 
> If you have
> 
> abcd<four spaces><tab><four spaces><tab>
> 
> then indeed the resulting conversion needs to be <tab><tab><tab>
> whereas with
> 
> abc<four spaces><tab><four spaces><tab>
> 
> the resulting conversion needs to be just <tab><tab>

Note that this code *only* handles whitespace in the initial indent;
processing stops as soon as it hits anything other than a tab or an
indent.

Given that, I believe the proposed patch is correct.  Am I missing
something else?

--b.
