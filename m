From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH 2/2] diff: add custom regular expressions for function names
Date: Thu, 05 Jul 2007 10:24:58 +0200
Message-ID: <87644zcl5x.fsf@mid.deneb.enyo.de>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
	<alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
	<7vejjnhpap.fsf@assigned-by-dhcp.cox.net>
	<7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 10:25:36 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Mec-0008PH-M6
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 10:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbXGEIZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 04:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757494AbXGEIZD
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 04:25:03 -0400
Received: from mail.enyo.de ([212.9.189.167]:2126 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419AbXGEIZA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 04:25:00 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1I6Me3-0007cx-EW
	for git@vger.kernel.org; Thu, 05 Jul 2007 10:24:59 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1I6Me2-00024p-Eb
	for git@vger.kernel.org; Thu, 05 Jul 2007 10:24:58 +0200
In-Reply-To: <7vwsxfe96i.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 04 Jul 2007 22:00:53 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51663>

* Junio C. Hamano:

> I think using multiple regexp is cute, but if we do that, it
> should allow people to pick from:
>
> 	public class Beer
> 	{
> 		int special;
> 		public static void main(String args[])
>                 {
>                 	... modified part is here ...
>
> with two regexp matches, say:
>
> 	/^(public|private|protectd) class (.*)/ then
>         /^	+.* (\w*\(.*)$/
>
> and define the hunk_header format as something like:
>
> 	"\[1,2]::\[2,1]"

Even that doesn't work for C++ namespaces, or nested Java classes. 8-(
If you want to do it right, you need to spawn some helper program.
