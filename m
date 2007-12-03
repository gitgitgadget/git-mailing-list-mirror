From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Simplify crud() in ident.c
Date: Mon, 03 Dec 2007 23:52:05 +0100
Message-ID: <85zlwre6i2.fsf@lola.goethe.zz>
References: <20071203191143.GB17671@steel.home>
	<Pine.LNX.4.64.0712032046480.27959@racer.site>
	<20071203213702.GD17671@steel.home>
	<Pine.LNX.4.64.0712032247140.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 03 23:52:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzK8y-0001oF-Cy
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 23:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbXLCWvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 17:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbXLCWvo
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 17:51:44 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:51610 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbXLCWvo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 17:51:44 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IzK8d-0006DS-23; Mon, 03 Dec 2007 17:51:43 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id DD6EC1C4D3AA; Mon,  3 Dec 2007 23:52:05 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0712032247140.27959@racer.site> (Johannes
	Schindelin's message of "Mon, 3 Dec 2007 22:48:19 +0000 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66969>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 3 Dec 2007, Alex Riesen wrote:
>
>> Johannes Schindelin, Mon, Dec 03, 2007 21:47:09 +0100:
>> > On Mon, 3 Dec 2007, Alex Riesen wrote:
>> > > +	return  c <= 32  ||
>> > > +		c == '.' ||
>> > > +		c == ',' ||
>> > > +		c == ':' ||
>> > > +		c == ';' ||
>> > > +		c == '<' ||
>> > > +		c == '>' ||
>> > > +		c == '"' ||
>> > > +		c == '\'';
>> > 
>> > Or enhance ctype.c.
>> > 
>> 
>> That's be nice, but the "crud" conflicts with existing classification,
>> so I'd have to change the is*-macros as well. Don't feel like it.
>> 
>> I believe the code is never in hotpath anyway so the shorter the
>> better.
>
> Really?
>
> 	return !!strchr(".,:;<>\"\\", c);

What happened to c <= 32?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
