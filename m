From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mergetool: Make default smarter by considering user's desktop environment and editor
Date: Wed, 06 Jun 2007 02:05:10 -0700
Message-ID: <7vabvd5u7t.fsf@assigned-by-dhcp.cox.net>
References: <466637E2.5040303@freedesktop.org>
	<7vabvd7bfg.fsf@assigned-by-dhcp.cox.net>
	<86tztljwgk.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 11:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvrS8-0000ly-Dl
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 11:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbXFFJFN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 05:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbXFFJFN
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 05:05:13 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:49843 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbXFFJFL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 05:05:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606090511.QXVA1540.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 05:05:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 895A1X00J1kojtg0000000; Wed, 06 Jun 2007 05:05:11 -0400
In-Reply-To: <86tztljwgk.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Wed, 06 Jun 2007 10:52:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49273>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> Josh Triplett <josh@freedesktop.org> writes:
>>
>>> Make git-mergetool prefer meld under GNOME, and kdiff3 under KDE.  When
>>> considering emerge and vimdiff, check $VISUAL and $EDITOR to see which the
>>> user might prefer.
>>>
>>> Signed-off-by: Josh Triplett <josh@freedesktop.org>
>>
>> The basic idea is sound.  However...
>>
>>  (1) I wonder if we can get rid of the horribly long if .. elif
>>      chain by using shell function and then iterate a list of them;
>>
>>  (2) echo "${VISUAL-$EDITOR}" | grep '^emacs'???
>>
>>      Some people may have explicit path (/home/me/bin/emacs),
>>      and/or runs a variant of emacs called 'xemacs'.  Same for
>>      vim.
>
> Actually, a lot of people run as editor a program called "emacsclient"
> or "gnuclient": this one connects to an existing Emacs session and
> passes its arguments to it.  And of course, this is what git-mergetool
> should then also do.

I do that too, but that is covered by the prefix rule Josh has,
so it is Ok.
