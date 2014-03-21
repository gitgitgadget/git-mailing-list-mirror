From: Jeff King <peff@peff.net>
Subject: Re: [GSoC]  Inquiry about writing config file to disk
Date: Fri, 21 Mar 2014 01:19:41 -0400
Message-ID: <20140321051941.GA31161@sigill.intra.peff.net>
References: <loom.20140320T181941-0@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 06:19:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQrs2-0005po-NL
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 06:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbaCUFTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 01:19:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:43792 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754519AbaCUFTn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 01:19:43 -0400
Received: (qmail 13957 invoked by uid 102); 21 Mar 2014 05:19:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Mar 2014 00:19:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Mar 2014 01:19:41 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140320T181941-0@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244638>

On Thu, Mar 20, 2014 at 05:25:22PM +0000, Tanay Abhra wrote:

> I have gone through commit.c, builtin/commit.c and api-config.txt but one
> thing I cannot find is which functions handle writing config file to disk
> after adding a new variable,value pair(for example git config my.option
> true) . It is also marked TODO on the api-config.txt file. Can somebody help
> me , I just want the starting function and will trace the function calls
> after that.

Try starting in cmd_config (in builtin/config.c), the main entry point
for running "git config", and you should be able to trace it from there.

The main logic ends up in the git_config_set_* functions.

-Peff
