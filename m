From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_file.c: make sure open_sha1_file does not open a
 directory
Date: Sun, 8 Feb 2015 20:12:00 -0500
Message-ID: <20150209011159.GA21072@peff.net>
References: <b0993cc1fcac290d7506b24942af300@74d39fa044aa309eaea14b9f57fe79c>
 <20150209005444.GA16827@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathon Mah <me@jonathonmah.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 02:12:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKctZ-0000Ks-Kg
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 02:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557AbbBIBME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 20:12:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:46600 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754359AbbBIBMD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 20:12:03 -0500
Received: (qmail 16177 invoked by uid 102); 9 Feb 2015 01:12:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Feb 2015 19:12:02 -0600
Received: (qmail 26811 invoked by uid 107); 9 Feb 2015 01:12:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Feb 2015 20:12:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Feb 2015 20:12:00 -0500
Content-Disposition: inline
In-Reply-To: <20150209005444.GA16827@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263538>

On Sun, Feb 08, 2015 at 07:54:44PM -0500, Jeff King wrote:

> However, the first thing for_each_loose_file_in_objdir is going to do is
> stick the path into a strbuf. So perhaps the most sensible thing is to
> just teach it to take a strbuf from the caller. I'll work up a patch.
> 
> It looks like a1b47246 isn't even in "next" yet, so I'll build it
> directly on what is already in master, dropping Jonathan's patch.

Here it is. The first patch is a refactoring to allow this,
and the second is the moral equivalent of Jonathon's patch.
These replace a1b47246 on the tip of jk/prune-mtime.

  [1/2]: for_each_loose_file_in_objdir: take an optional strbuf path
  [2/2]: sha1_file: fix iterating loose alternate objects

-Peff
