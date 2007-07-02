From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [RFC] Update on builtin-commit
Date: Mon, 02 Jul 2007 13:57:30 -0400
Message-ID: <1183399050.30611.25.camel@hinata.boston.redhat.com>
References: <11833861634103-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0707021709120.4071@racer.site>
	 <1183395082.30611.16.camel@hinata.boston.redhat.com>
	 <Pine.LNX.4.64.0707021758090.4071@racer.site>
	 <1183397689.10996.11.camel@lt21223.campus.dmacc.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jeffrey C. Ollie" <jeff@ocjtech.us>
X-From: git-owner@vger.kernel.org Mon Jul 02 19:57:46 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Q9h-0003po-0O
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 19:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbXGBR5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 13:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752438AbXGBR5n
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 13:57:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36012 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbXGBR5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 13:57:42 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l62Hvb7P021203;
	Mon, 2 Jul 2007 13:57:37 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l62HvbJZ029223;
	Mon, 2 Jul 2007 13:57:37 -0400
Received: from [192.168.1.102] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l62HvZEb005340;
	Mon, 2 Jul 2007 13:57:36 -0400
In-Reply-To: <1183397689.10996.11.camel@lt21223.campus.dmacc.edu>
X-Mailer: Evolution 2.11.4 (2.11.4-1.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51389>

On Mon, 2007-07-02 at 12:34 -0500, Jeffrey C. Ollie wrote:
> On Mon, 2007-07-02 at 18:02 +0100, Johannes Schindelin wrote:
> >
> > Hmm. Somehow I think that the getopt solution is not so bad at all. We'd 
> > need some code in compat/, but since we're GPL, and there are so many 
> > GPLed getopt versions out there, I don't see any obstacle there.
> 
> If we are going to make this option parser into some complex
> general-purpose option parsing library let's not re-invent the wheel.
> Let's pick one of the GPL'd option parsing libraries and make it a
> dependency of Git.

I don't have much of an opinion here; as I've said before, my goal here
is to get commit ported to C, and I specifically don't want to block on
the option parser discussion reaching consensus.  One thing I do not
want to do, though, is to explode the current table driven approach into
a gazillion strcmps.  Other than that I'm open to porting it to an
external getopt dependency, adding the couple of missing features
Johannes mentioned (bundling and ordering), or just keeping it local to
builtin-commit.c as is.

That said, we're debating less than 100 lines of code.  Adding the
bundling of short options and some kind of ordering mechanism would add
at most 20 more lines.  Is it worth taking a getopt dependency for that?

Kristian
