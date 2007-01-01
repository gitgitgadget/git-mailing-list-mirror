From: Junio C Hamano <junkio@cox.net>
Subject: Re: http git and curl 7.16.0
Date: Mon, 01 Jan 2007 00:08:02 -0800
Message-ID: <7vbqlj890d.fsf@assigned-by-dhcp.cox.net>
References: <skimo@kotnet.org>
	<200612271457.kBREvkj2011916@laptop13.inf.utfsm.cl>
	<7vlkkt5d49.fsf@assigned-by-dhcp.cox.net>
	<7v8xgt57wu.fsf@assigned-by-dhcp.cox.net>
	<20070101114252.6a76269e@athlon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Nick Hengeveld <nickh@reactrix.com>, skimo@liacs.nl,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 09:08:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1IDS-0000ih-HS
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 09:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932939AbXAAIIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 03:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933249AbXAAIIG
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 03:08:06 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43513 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932939AbXAAIIF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 03:08:05 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070101080803.CNDK19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Mon, 1 Jan 2007 03:08:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5k7G1W00K1kojtg0000000; Mon, 01 Jan 2007 03:07:17 -0500
To: George Sherwood <pilot@beernabeer.com>
In-Reply-To: <20070101114252.6a76269e@athlon> (George Sherwood's message of
	"Mon, 1 Jan 2007 11:42:52 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35732>

George Sherwood <pilot@beernabeer.com> writes:

> I CC'ed the mailing curl mailing list and according to the response
> this problem is fixed in the latest cvs version of curl with this
> commit:
>
> curl_easy_duphandle() sets the magic number in the new handle
>
> I have confirmed this works now git 1.4.4.3

Thanks, so it was a breakage on the .0 release on their side.

I'll leave this in place for now:

    #if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM == 0x071000)
    #define NO_CURL_EASY_DUPHANDLE
    #endif

which specifically marks 7.16.0 as dud.
