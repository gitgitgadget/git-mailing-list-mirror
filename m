From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] update-index: Add a --refresh-only option to refresh specified files.
Date: Sat, 04 Aug 2007 11:34:34 -0700
Message-ID: <7vlkcrgnd1.fsf@assigned-by-dhcp.cox.net>
References: <87odhnk4cb.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 20:34:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHOSf-0008DK-5m
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 20:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbXHDSei (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 14:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933022AbXHDSei
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 14:34:38 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51557 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933000AbXHDSeg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 14:34:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070804183435.CSMF11888.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 4 Aug 2007 14:34:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Xuaa1X00B1kojtg0000000; Sat, 04 Aug 2007 14:34:35 -0400
In-Reply-To: <87odhnk4cb.fsf@wine.dyndns.org> (Alexandre Julliard's message of
	"Sat, 04 Aug 2007 11:59:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54895>

Alexandre Julliard <julliard@winehq.org> writes:

> This allows to quickly refresh a file that has been touched without
> having to stat all the files of the project.
>
> Signed-off-by: Alexandre Julliard <julliard@winehq.org>
> ---
>
> Does this look reasonable?  The refresh_index_path() function is a
> copy/paste of refresh_index(), I'm not sure all of it is really
> needed, but I don't claim to understand all the subtleties of the
> index management...

Makes me wonder why it is not like:

	$ git update-index --refresh Documentation/

That is:

 - why a new option?
 - why not a pathspec or glob, similar to what ls-files gets?
