From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] git-format-patch: Make the second and subsequent mails replies to the first
Date: Fri, 14 Jul 2006 11:23:38 -0700
Message-ID: <7v4pxkoxjp.fsf@assigned-by-dhcp.cox.net>
References: <20060710162920.GR20191@harddisk-recovery.com>
	<1152556878.8890.45.camel@josh-work.beaverton.ibm.com>
	<7vwtal9lu1.fsf@assigned-by-dhcp.cox.net>
	<1152897407.5177.8.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 20:23:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1SKE-0005l3-VV
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 20:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWGNSXk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 14:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWGNSXk
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 14:23:40 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62595 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1422701AbWGNSXj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 14:23:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060714182338.GSIS554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Jul 2006 14:23:38 -0400
To: Josh Triplett <josht@us.ibm.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23907>

Josh Triplett <josht@us.ibm.com> writes:

>> While I understand what you said about imap-send, I really would
>> feel better if this was optional.  Do not change the default
>> output format, please.
>
> So rather than the --no-thread option provided in the second patch of
> this series, you'd prefer a --thread option to enable setting the
> In-Reply-To/References headers?

Eh, that's not what I meant.

I do not mind the code you added to log-tree.c and revision.h,
and honestly I do not care which of threading or non-threading
mode is the default, although I think your explanation that it
parallels what send-email does makes a lot of sense.

But I do mind that the code added by the first patch to
cmd_format_patch runs by default, and worse yet, there is no
option turn it off.  Setting message_id and ref_message_id in
rev_info struct should be something the end user should ask for
explicitly by invoking the command with an option, perhaps
--with-message-id, which you probably would also want to turn on
when any of --no-thread, --thread or --initial-reply-to options
are given.
-
