From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: --find-copies-harder finds fewer copies/renames than -C does
Date: Thu, 6 Jan 2011 17:54:06 +0100
Message-ID: <1juopju.rh4v4z97i9hmM%lists@haller-berlin.de>
References: <7voc7vch35.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com (Junio C Hamano)
X-From: git-owner@vger.kernel.org Thu Jan 06 17:54:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pat6Q-0000s9-LQ
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 17:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab1AFQyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 11:54:13 -0500
Received: from mail.ableton.net ([62.96.12.117]:57264 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557Ab1AFQyM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 11:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=Qb6ijQ2Try0xdKFhycqvSXtt8ia49TfFOnwNNuoYhAY=;
	b=dlJuTDieXmLgTFj+N2k2mUxV+XUM3NU6FiGJ4Pw6EDq4THTlnrTkJDDZbwxSEzIx6MIfYlYhNvX+c69OWtgPHur/HIWlYyRvGQ/x+pXi07VtCjbP178vWiellojhWGJszDDH9cvNYaViAXgozALj0nmlLyGwCmcWg4KCzKyBWSo=;
Received: from macbook-stk.office.ableton.com ([10.1.12.10])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1Pat4f-0002Zj-T1; Thu, 06 Jan 2011 17:52:29 +0100
In-Reply-To: <7voc7vch35.fsf@alter.siamese.dyndns.org>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.5 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164640>

Junio C Hamano <gitster@pobox.com> wrote:

> lists@haller-berlin.de (Stefan Haller) writes:
> 
> > I had expected --find-copies-harder to still do inexact rename detection
> > among the changed files in the commit in this case, and turn it off only
> > for the unmodified files; I'm not familiar enough with the code to tell
> > whether that would be easy to implement though.
> >
> > Any thoughts?
> 
> Two.  When you can spend unlimited amount of resources, it would feel more
> intuitive if -C -C lifted rename-limit altogether.  On the other hand, in
> a project where the difference does matter (i.e. you have far too many
> candidate sources), it is likely that -C -C without rename limit would run
> out of memory and not produce any result, so automatic lifting of rename
> limit is unacceptable as the default.

But what about the suggestion of falling back to -C if
--find-copies-harder exceeds the rename limit, but -C does not?
Wouldn't that be the desired behaviour?


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
