From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitk: UTF-8 support
Date: Wed, 23 Nov 2005 16:47:43 -0800
Message-ID: <7v64qi50sw.fsf@assigned-by-dhcp.cox.net>
References: <1132719301.12227.5.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 01:48:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef5HB-0003Yg-Du
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 01:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030546AbVKXArq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 19:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVKXArq
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 19:47:46 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35571 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932535AbVKXArp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 19:47:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124004636.DGK26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 19:46:36 -0500
To: Pavel Roskin <proski@gnu.org>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <1132719301.12227.5.camel@dv> (Pavel Roskin's message of "Tue, 22
	Nov 2005 23:15:01 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12666>

Pavel Roskin <proski@gnu.org> writes:

> Add gitencoding variable and set it to "utf-8".  Use it for converting
> git-rev-list output.

Sounds good, but is it necessary?  Unless I am grossly mistaken,
I am opposed to this patch.

When I run gitk with LANG and/or LC_CTYPE set to ja_JP.utf8 (I
suspect *whatever*.utf8 would work the same way) on git.git
repository, I see Lukas's name (originally in iso8859-1 but my
commit objects have it in utf8) and Yoshifuji-san's name
(iso2022 converted to utf8) just fine.

And when I run gitk with LANG and/or LC_CTYPE set to ja_JP.ujis
(that is another name for EUC-JP) on a toy repository I have
commit log messages in EUC-JP (I am not recommending that, just
pointing out a possibility), I can see them just fine.  In that
test repository, setting locale to *.utf8 would not work.

So I suspect your change breaks projects that use local
encodings, without fixing or adding anything new.
