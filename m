From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] mailinfo: allow -u to fall back on latin1 to utf8 conversion.
Date: Mon, 28 Nov 2005 01:21:26 -0800
Message-ID: <7virudxh49.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
	<20051118205513.GA3168@vrfy.org>
	<Pine.LNX.4.64.0511181314470.13959@g5.osdl.org>
	<Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
	<437E51EB.7050100@zytor.com>
	<Pine.LNX.4.64.0511181520390.13959@g5.osdl.org>
	<7vek5deam6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511181653191.13959@g5.osdl.org>
	<7v7jb57wud.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511190950161.13959@g5.osdl.org>
	<20051127025249.GA12286@vrfy.org>
	<7vfypioi83.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511262006350.13959@g5.osdl.org>
	<7v7jat61xq.fsf@assigned-by-dhcp.cox.net> <438AA48B.8000808@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 10:22:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgfCf-00022b-PP
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 10:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVK1JV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 04:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVK1JV2
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 04:21:28 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:4086 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751037AbVK1JV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 04:21:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128092022.DMYG17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 04:20:22 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <438AA48B.8000808@zytor.com> (H. Peter Anvin's message of "Sun,
	27 Nov 2005 22:32:43 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12865>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Junio C Hamano wrote:
>> When the message body does not identify what encoding it is in,
>> -u assumes it is in latin-1 and converts it to utf8, which is
>> the recommended encoding for git commit log messages.
>> With -u=<encoding>, the conversion is made into the specified
>> one, instead of utf8, to allow project-local policies.
>> Signed-off-by: Junio C Hamano <junkio@cox.net>
>
> -u= is very odd syntax.

Fair enough.  "--encoding=<encoding>" then.

> Incidentally, any reason we're not using getopt_long() for command-line 
> parsing?

There was a talk about using popt a while back but we never got
around to it, primarily because we were running too fast for
parties interested in command line parsing clean-ups to catch
up.  I think we are almost done and immediately post 1.0 when
things stabilize may be a good time to do it if somebody wants
to go wild, but not before please.
