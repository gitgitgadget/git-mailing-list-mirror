From: Josh Triplett <josht@us.ibm.com>
Subject: Re: [PATCH 1/3] git-format-patch: Make the second and subsequent
	mails replies to the first
Date: Fri, 14 Jul 2006 12:20:28 -0700
Message-ID: <1152904829.5177.19.camel@josh-work.beaverton.ibm.com>
References: <20060710162920.GR20191@harddisk-recovery.com>
	 <1152556878.8890.45.camel@josh-work.beaverton.ibm.com>
	 <7vwtal9lu1.fsf@assigned-by-dhcp.cox.net>
	 <1152897407.5177.8.camel@josh-work.beaverton.ibm.com>
	 <7v4pxkoxjp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 21:20:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1TDF-00062v-Sm
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 21:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbWGNTUa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 15:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161294AbWGNTUa
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 15:20:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:34478 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161292AbWGNTU3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 15:20:29 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6EJKTrF023129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 15:20:29 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6EJKSQx041208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 13:20:28 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6EJKSiN030970
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 13:20:28 -0600
Received: from dyn9047018143.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6EJKREf030964;
	Fri, 14 Jul 2006 13:20:28 -0600
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pxkoxjp.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23909>

On Fri, 2006-07-14 at 11:23 -0700, Junio C Hamano wrote:
> Josh Triplett <josht@us.ibm.com> writes:
> 
> >> While I understand what you said about imap-send, I really would
> >> feel better if this was optional.  Do not change the default
> >> output format, please.
> >
> > So rather than the --no-thread option provided in the second patch of
> > this series, you'd prefer a --thread option to enable setting the
> > In-Reply-To/References headers?
> 
> Eh, that's not what I meant.
> 
> I do not mind the code you added to log-tree.c and revision.h,
> and honestly I do not care which of threading or non-threading
> mode is the default, although I think your explanation that it
> parallels what send-email does makes a lot of sense.
> 
> But I do mind that the code added by the first patch to
> cmd_format_patch runs by default, and worse yet, there is no
> option turn it off.  Setting message_id and ref_message_id in
> rev_info struct should be something the end user should ask for
> explicitly by invoking the command with an option, perhaps
> --with-message-id, which you probably would also want to turn on
> when any of --no-thread, --thread or --initial-reply-to options
> are given.

How would that work though?  Threading requires a Message-Id on at least
the first message, so to avoid Message-IDs by default would require
turning off threading by default; I can do that if you like, but you
suggested that you didn't mind having threading as the default.  I
could, however, avoid generating Message-Id on the subsequent messages,
and avoid generating that Message-Id if you give --no-thread.  Would
that work?

- Josh Triplett
