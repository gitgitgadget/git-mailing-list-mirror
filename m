From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Limit git-gui to display a maximum number of files
Date: Tue, 11 Aug 2009 13:29:27 -0700
Message-ID: <20090811202927.GZ1033@spearce.org>
References: <4A4A77A6.1020905@lawrence.edu> <20090810153859.GT1033@spearce.org> <4A81B738.7090507@zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, raa.lkml@gmail.com
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 22:29:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaxyS-0005Tj-2K
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 22:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbZHKU30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 16:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbZHKU30
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 16:29:26 -0400
Received: from george.spearce.org ([209.20.77.23]:43804 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbZHKU30 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 16:29:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 46ECD381FD; Tue, 11 Aug 2009 20:29:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A81B738.7090507@zwell.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125590>

Dan Zwell <dzwell@zwell.net> wrote:
> When there is a large number of new or modified files,
> "display_all_files" takes a long time, and git-gui appears to
> hang. This change limits the number of files that are displayed.
> This limit can be set as gui.maxfilesdisplayed, and is
> 5000 by default.
>
> A warning is shown when the list of files is truncated.
>
> Signed-off-by: Dan Zwell <dzwell@zwell.net>
> ---
> By the way, is the right way to deal with strings to be
> translated? See the end of the patch.

No.

> +			set warning "Displaying only $display_limit of "
> +			append warning "[llength $to_display] files."
> +			info_popup [mc $warning]

This should be:

info_popup [mc "Displaying only %s of %s files." $display_limit [llength $to_display]]

> +msgid "Displaying only %s of %s files."
> +msgstr ""

So that then the placeholders are available here...

-- 
Shawn.
