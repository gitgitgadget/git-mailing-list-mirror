From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] tcl/tk8.5: fix changing colors through
	Edit->Preferences
Date: Sat, 5 Apr 2008 16:38:42 +0000
Message-ID: <20080405163842.29563.qmail@4e504c5c8f9cc2.315fe32.mid.smarden.org>
References: <20080326184526.2240.qmail@b31b9595cabb35.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 18:39:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiBQ0-0007HE-9F
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 18:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbYDEQiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 12:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbYDEQiV
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 12:38:21 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:47672 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752485AbYDEQiU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 12:38:20 -0400
Received: (qmail 29564 invoked by uid 1000); 5 Apr 2008 16:38:42 -0000
Content-Disposition: inline
In-Reply-To: <20080326184526.2240.qmail@b31b9595cabb35.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78851>

On Wed, Mar 26, 2008 at 06:45:26PM +0000, Gerrit Pape wrote:
> With tcl/tk8.5 the lset command seems to behave differently.  When
> changing the background color through Edit->Preferences, the changes
> are applied, but new dialogs, such as View->New view... barf with
> 
>  Error: unknown color name "{#ffffff}"
> 
> Additionally when closing gitk, and starting it up again, a bad value
> has been saved to ~/.gitk, preventing gitk from running properly; it
> fails with
> 
>  Error in startup script: unknown color name "{#ffffff}"
>  ...
> 
> This commit changes the color dialogs to not handle variables containing
> just a single color value as tcl lists, which fixes the issue.  Tested
> with tcl/tk8.4 and 8.5.
> 
> Dmitry Potapov reported this problem through
>  http://bugs.debian.org/472615

Hi, any comments on this patch?  I can reproduce the problem on Debian
with tcl/tk 8.5.1 and git 1.5.5.rc3.

Thanks, Gerrit.
