From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 04 Aug 2007 14:19:48 +0200
Message-ID: <85zm17h4pn.fsf@lola.goethe.zz>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
	<200708040341.36147.ismail@pardus.org.tr>
	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
	<46B3F762.1050306@midwinter.com>
	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
	<46B418AA.4070701@midwinter.com>
	<20070804091249.GA17821@uranus.ravnborg.org>
	<46B45B1E.5020104@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 14:19:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHIbt-0004EZ-2i
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 14:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760653AbXHDMTx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 08:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756385AbXHDMTx
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 08:19:53 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:48129 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760454AbXHDMTw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 08:19:52 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 359FF24B5BD;
	Sat,  4 Aug 2007 14:19:51 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 2280312DF50;
	Sat,  4 Aug 2007 14:19:51 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id C3C9C8C464;
	Sat,  4 Aug 2007 14:19:50 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 1DA881C4F932; Sat,  4 Aug 2007 14:19:48 +0200 (CEST)
In-Reply-To: <46B45B1E.5020104@midwinter.com> (Steven Grimm's message of "Sat\, 04 Aug 2007 18\:55\:26 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3854/Sat Aug  4 06:49:48 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54836>

Steven Grimm <koreth@midwinter.com> writes:

> Sam Ravnborg wrote:
>> Never looked at Ascii-doc... but how about finding the loopholes
>> in Ascii-doc to make it 10x faster?
>> That would benefit a larger user-base than just doing-it-ourself.
>>   
>
> Because AsciiDoc is only half of the toolchain we use. (Though in your
> defense, I made the mistake of only mentioning AsciiDoc by name,
> rather than "the AsciiDoc toolchain.") We run asciidoc's output
> through xmlto, which is just as slow and is a highly general piece of
> software for doing arbitrary transformations of XML documents. I won't
> say it's impossible to speed up xmlto as well, of course, but it's
> probably an order of magnitude more work than implementing a new
> parser/renderer for our .txt files.

Personally, I think it would make sense to move to a different
documentation system, or at least a different organization.  The
problem with the current layout is that it is basically flat.

A system such as info, in contrast, is hierarchical, and organized
with indexes and cross references making it much easier to find
things.  More importantly, it makes it possible to put things into
perspective: which commands are porcelain, which are plumbing?  What
do you do in a typical workflow?  What are the related internal data
structures?  Where are they documented?  Can I print or navigate a
complete PDF document explaining the whole system?

The manual pages of git have a high quality, but they remain manual
pages: they are all standalone, not putting the tool into a context or
hierarchy.  While the user manual is a place to start, it is more or
less added as an afterthought: it does not structure the available
documentation.

For Texinfo there is a large number of backends, and there are also
usable reader plugins (Tkinfo, and the presumably embeddable GNOME
"yelp" also displays info files and the embedded links, and of course
the wonderful Emacs info browser) for things like git-gui.

It may be that the asciidoc/Docbook workflow also contains ways to get
similarly useful stuff out: comments welcome.  I am just more
acquainted with Texinfo myself.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
