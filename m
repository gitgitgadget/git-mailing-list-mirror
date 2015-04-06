From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 2/2] gitk: Show the rev(s) the user specified on the
 command line in the window title.
Date: Mon, 6 Apr 2015 14:37:11 +1000
Message-ID: <20150406043711.GC31463@iris.ozlabs.ibm.com>
References: <1420566720-25238-1-git-send-email-marcnarc@xiplink.com>
 <1420566720-25238-3-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 06:39:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yeyoe-0003Yt-DE
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 06:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbbDFEi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 00:38:58 -0400
Received: from ozlabs.org ([103.22.144.67]:57968 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbbDFEiy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 00:38:54 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8B77D140218; Mon,  6 Apr 2015 14:38:52 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <1420566720-25238-3-git-send-email-marcnarc@xiplink.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266834>

On Tue, Jan 06, 2015 at 12:52:00PM -0500, Marc Branchaud wrote:
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
> 
> I often open multiple gitk windows in the same working directory to examine
> other branches or refs in the repo.  This change allows me to distinguish
> which window is showing what.
> 
> This is an RFC because it doesn't behave great with views.  I don't use views
> at all, so this doesn't bother me.  I'm not too sure what should be displayed
> if the user changes views -- probably the view name, but I'm not sure how to
> get a that in the code.

The view name is in $viewname($curview).  If that is "Command line"
you probably want to show some selected command line arguments.

Using $vrevs($curview) seems about right, though it will contain
"--gitk-symmetric-diff-marker" in some situations, which is an
internal thing that we don't want to show externally.  You should
probably filter it out.

The patch will need a proper description before I can apply it, of
course.

Paul.
