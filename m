From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/3] mailinfo: allow -u to fall back on latin1 to utf8
 conversion.
Date: Sun, 27 Nov 2005 22:32:43 -0800
Message-ID: <438AA48B.8000808@zytor.com>
References: <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>	<20051118205513.GA3168@vrfy.org>	<Pine.LNX.4.64.0511181314470.13959@g5.osdl.org>	<Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>	<437E51EB.7050100@zytor.com>	<Pine.LNX.4.64.0511181520390.13959@g5.osdl.org>	<7vek5deam6.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0511181653191.13959@g5.osdl.org>	<7v7jb57wud.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0511190950161.13959@g5.osdl.org>	<20051127025249.GA12286@vrfy.org>	<7vfypioi83.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0511262006350.13959@g5.osdl.org> <7v7jat61xq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 07:52:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egca7-0000HA-U2
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 07:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVK1Gc6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 01:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVK1Gc6
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 01:32:58 -0500
Received: from terminus.zytor.com ([192.83.249.54]:48580 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932099AbVK1Gc6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 01:32:58 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAS6Wh9s031772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 Nov 2005 22:32:45 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jat61xq.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12852>

Junio C Hamano wrote:
> When the message body does not identify what encoding it is in,
> -u assumes it is in latin-1 and converts it to utf8, which is
> the recommended encoding for git commit log messages.
> 
> With -u=<encoding>, the conversion is made into the specified
> one, instead of utf8, to allow project-local policies.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 

-u= is very odd syntax.  Typically you see "-u argument" (sometimes you 
have "-u" and "-U argument" as a pair); --foo=argument is used for long 
options, although even there "--foo argument" tends to be used at least 
when the argument is required.

Incidentally, any reason we're not using getopt_long() for command-line 
parsing?

	-hpa
