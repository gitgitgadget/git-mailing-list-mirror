From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: autocrlf=input and safecrlf (was Re: CVS import [SOLVED])
Date: Mon, 23 Feb 2009 08:09:03 +0100 (CET)
Message-ID: <1570.77.61.241.211.1235372943.squirrel@hupie.xs4all.nl>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl>
    <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl>
    <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl>
    <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302>
    <20090220152849.GA3826@coredump.intra.peff.net>
    <32886.77.61.241.211.1235147143.squirrel@hupie.xs4all.nl>
    <20090220172918.GB4636@coredump.intra.peff.net>
    <499F3B9B.3020709@pelagic.nl>
    <20090223000840.GA20392@coredump.intra.peff.net>
    <2944.77.61.241.211.1235371848.squirrel@hupie.xs4all.nl>
    <20090223065615.GA24807@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Ferry Huberts" <ferry.huberts@pelagic.nl>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 08:10:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbUxY-0005VY-MM
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 08:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbZBWHJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 02:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbZBWHJI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 02:09:08 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:60199 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751525AbZBWHJH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 02:09:07 -0500
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id 738F758BDCE; Mon, 23 Feb 2009 08:09:03 +0100 (CET)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Mon, 23 Feb 2009 08:09:03 +0100 (CET)
In-Reply-To: <20090223065615.GA24807@coredump.intra.peff.net>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111110>

On Mon, February 23, 2009 07:56, Jeff King wrote:
> [Can you please wrap your lines? They seem to be about 200 characters,
>  and then rewrap the quoted text, but without putting a '>' marker.
>  I had a very hard time figuring out what was quoted and what was not.]
>
> On Mon, Feb 23, 2009 at 07:50:48AM +0100, Ferry Huberts (Pelagic) wrote:
>
>> > I am a bit concerned about a proposal to set safecrlf=false in all
>> > cvsimported repositories.  You are turning off the protection
>> > against corrupting binary files.  _Even if_ the person has put
>> > safecrlf=true into their ~/.gitconfig and thinks they are safe.
>>
>> Ok.  I follow and agree. Full circle :-) We're back to Johannes'
>> proposal: make sure that autocrlf is set to false. Agree? If so, then
>> I'll try to whip up a patch.
>
> But won't that now import CRLF's into your new git repo? Especially on
> Windows, where (IIRC) cvs gives you files with CRLF by default?
>
> -Peff
>

Yes it would. But sadly that's the only way to make sure that the import
will work (without serious manual intervention).
I found this out the hard way.

I started these discussions to narrow down on what we should actually patch.
Now it appears that we should do what Johannes originally proposed. Always
nice to be right, isn't it Johannes? :-)

Ferry
