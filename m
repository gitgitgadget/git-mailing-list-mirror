From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Sat, 14 Apr 2012 14:21:27 +0200
Message-ID: <20120414122127.GA31220@ecki>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
 <20120414121358.GA26372@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Sat Apr 14 14:22:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ209-0004iH-1k
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 14:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab2DNMWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 08:22:42 -0400
Received: from smtpout13.highway.telekom.at ([195.3.96.75]:10108 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751893Ab2DNMWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 08:22:42 -0400
Received: (qmail 24844 invoked from network); 14 Apr 2012 12:22:40 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL605.highway.telekom.at
X-Spam-Level: 
Received: from p5b22caa4.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.202.164])
          (envelope-sender <drizzd@aon.at>)
          by smarthub79.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <zbyszek@in.waw.pl>; 14 Apr 2012 12:22:39 -0000
Content-Disposition: inline
In-Reply-To: <20120414121358.GA26372@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195487>

On Sat, Apr 14, 2012 at 02:13:58PM +0200, Clemens Buchacher wrote:
> 
> In order to better understand the problem on your side, can you execute
> this script and tell me what it does for you?

Oops, this is what I really wanted:

#!/bin/sh

mkfifo fd
yes >fd &
pid=$!
{
	read line
	echo $line
	cat <fd &
} <fd
sleep 1
kill $pid
wait $pid
rm -f fd
