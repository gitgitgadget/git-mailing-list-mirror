From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2013, #04; Wed, 13)
Date: Fri, 15 Nov 2013 01:48:30 -0500
Message-ID: <20131115064830.GA30234@sigill.intra.peff.net>
References: <xmqqob5ndho5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 15 07:48:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhDCm-0001hJ-On
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 07:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065Ab3KOGsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 01:48:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:39624 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751664Ab3KOGsc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 01:48:32 -0500
Received: (qmail 1336 invoked by uid 102); 15 Nov 2013 06:48:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Nov 2013 00:48:32 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Nov 2013 01:48:30 -0500
Content-Disposition: inline
In-Reply-To: <xmqqob5ndho5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237889>

On Wed, Nov 13, 2013 at 03:07:54PM -0800, Junio C Hamano wrote:

> * nd/liteal-pathspecs (2013-10-28) 1 commit
>   (merged to 'next' on 2013-11-01 at 1a91775)
>  + pathspec: stop --*-pathspecs impact on internal parse_pathspec() uses
> 
>  Will cook in 'next'.

I think we want this to be part of v1.8.5. It is a fix for a regression
that appeared in master post-1.8.4:

  $ git.v1.8.4 --literal-pathspecs blame Makefile | wc -l
  2596

  $ git.v1.8.5-rc2 --literal-pathspecs blame Makefile | wc -l
  fatal: Makefile: pathspec magic not supported by this command: 'literal'
  0

Sorry to mention it so late into the -rc cycle, but I just noticed that
the patch hadn't graduated.

-Peff
