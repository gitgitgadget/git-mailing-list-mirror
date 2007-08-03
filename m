From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Help a sed noob
Date: Fri, 03 Aug 2007 16:38:35 -0700
Message-ID: <7vhcngkx38.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0708031622w25ab6e9ev61372169cfc0bd98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 01:38:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH6jB-0004Ia-2r
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 01:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551AbXHCXii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 19:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755242AbXHCXii
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 19:38:38 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:36162 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbXHCXii (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 19:38:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803233839.FSGW7193.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 3 Aug 2007 19:38:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Xbec1X00S1kojtg0000000; Fri, 03 Aug 2007 19:38:37 -0400
In-Reply-To: <fcaeb9bf0708031622w25ab6e9ev61372169cfc0bd98@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Fri, 3 Aug 2007 19:22:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54771>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> There is a construct like this in git-parse-remote.sh which makes
> busybox ash unhappy:
>
>                 sed -ne '/^URL: */{
>                         s///p
>                         q
>                 }' "$GIT_DIR/remotes/$1"
>
> It complains about "no previous regexp" while gnu sed is ok. Can
> anyone explain to me what does "s///p" do? GNU Sed info page says
> nothing about empty regexp. If I replace it with "s/\(.*\)/\1/p" then
> I get "URL: " along with the remote path.

Traditionally empty LHS regexp means "the same as last match".
Replace it with "s/^URL: *//p" and you would be Ok.
