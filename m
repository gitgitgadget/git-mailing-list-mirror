From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] rebase: new convenient option to edit a single commit
Date: Fri, 28 Feb 2014 01:58:02 -0500
Message-ID: <20140228065802.GB31731@sigill.intra.peff.net>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 07:58:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJHOd-0002Hv-05
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 07:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbaB1G6G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 01:58:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:58512 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750750AbaB1G6F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 01:58:05 -0500
Received: (qmail 11699 invoked by uid 102); 28 Feb 2014 06:58:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 00:58:04 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 01:58:02 -0500
Content-Disposition: inline
In-Reply-To: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242896>

On Thu, Feb 27, 2014 at 08:01:18PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> I find myself often do "git rebase -i xxx" and replace one "pick" lin=
e
> with "edit" to amend just one commit when I see something I don't lik=
e
> in that commit. This happens often while cleaning up a series. This
> automates the "replace" step so it sends me straight to that commit.

Yeah, I do this a lot, too.  The interface you propose makes sense to
me, though I'm not sure how much I would use it, as I often do not know
the specifier of the commit I want to change (was it "HEAD~3 or
HEAD~4?"). I guess using ":/" could make that easier.

One comment on the option name:

> +1,edit-one!        generate todo list to edit this commit

I'd expect "-$n" to mean "rebase the last $n commits" (as opposed to
everything not in the upstream). That does not work currently, of
course, but:

  1. It has the potential to confuse people who read it, since it's
     unlike what "-1" means in most of the rest of git.

  2. It closes the door if we want to support "-$n" in the future.

-Peff
