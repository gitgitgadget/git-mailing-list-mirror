From: Adam Spiers <git@adamspiers.org>
Subject: Re: Re* [PATCH 2/2] check-ignore.c: fix segfault with '.' argument
 from repo root
Date: Wed, 20 Feb 2013 10:47:20 +0000
Message-ID: <20130220104720.GD7860@pacific.linksys.moosehall>
References: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
 <1361282783-1413-1-git-send-email-git@adamspiers.org>
 <1361282783-1413-2-git-send-email-git@adamspiers.org>
 <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
 <20130220020046.GC7860@pacific.linksys.moosehall>
 <7vppzv3dd8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 11:47:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U87DH-0001Yo-NZ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 11:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933940Ab3BTKrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 05:47:23 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:34122 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933252Ab3BTKrW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 05:47:22 -0500
Received: from localhost (c.2.7.1.0.6.0.3.6.a.7.2.5.6.9.7.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:7965:27a6:3060:172c])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 2E3292E339;
	Wed, 20 Feb 2013 10:47:21 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vppzv3dd8.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216702>

On Tue, Feb 19, 2013 at 06:53:07PM -0800, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> > OK, thanks for the information.  IMHO it would be nice if 'git
> > format-patch' and 'git am' supported this style of inline patch
> > inclusion, but maybe there are good reasons to discourage it?
> 
> "git am --scissors" is a way to process such e-mail where the patch
> submitter continues discussion in the top part of a message,
> concludes the message with:
> 
> 	A patch to do so is attached.
> 	-- >8 --
> 
> and then tells the MUA to read in an output from format-patch into
> the e-mail buffer.

Ah, nice!  I didn't know about that.

>  You still need to strip out unneeded headers
> like the "From ", "From: " and "Date: " lines when you add the
> scissors anyway, and this is applicable only for a single-patch
> series, so the "feature" does not fit well as a format-patch option.

Rather than requiring the user to manually strip out unneeded headers,
wouldn't it be friendlier and less error-prone to add a new --inline
option to format-patch which omitted them in the first place?  It
should be easy to make it bail with an error when multiple revisions
are requested.
