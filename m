From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 19/40] Windows: Change the name of hook scripts to make them not executable.
Date: Thu, 28 Feb 2008 21:48:47 +0100
Message-ID: <200802282148.47485.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-20-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281519300.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 21:49:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUph8-0001s5-0E
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 21:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbYB1Us5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 15:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbYB1Us5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 15:48:57 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:43678 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbYB1Us5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 15:48:57 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id D761813A3F5;
	Thu, 28 Feb 2008 21:48:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A42345B9E3;
	Thu, 28 Feb 2008 21:48:47 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802281519300.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75451>

On Thursday 28 February 2008 16:20, Johannes Schindelin wrote:
> On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > -		*) cp $$boilerplate blt/$$dst ;; \
> > +		*) if test -n "$$(sed -ne '/^#!\//p' -e '1q' < "$$boilerplate")"; then
> > \ +			cp "$$boilerplate" "blt/$${dst}$(NOEXECTEMPL)"; \
> > +		   else \
> > +			cp "$$boilerplate" "blt/$$dst"; \
> > +		   fi ;; \
>
> Why not just append .noexec to all of the hooks?

Because some of the files are not hooks. Or do you mean to check for the files 
hooks--* explicitly?

-- Hannes
