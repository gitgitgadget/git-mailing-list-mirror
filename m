From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Thu, 25 Aug 2011 22:39:51 -0400
Message-ID: <20110826023951.GA17625@sigill.intra.peff.net>
References: <20110825200001.GA6165@sigill.intra.peff.net>
 <20110825204047.GA9948@sigill.intra.peff.net>
 <CAPig+cQ33PESWC5fzN8enLFRwNPx8o+PgRUTeCva4dSJ_EdwOw@mail.gmail.com>
 <20110825210654.GA11077@sigill.intra.peff.net>
 <4E56DE59.5050601@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 04:40:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwmKu-0004Sj-UI
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 04:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963Ab1HZCjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 22:39:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41786
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754866Ab1HZCjz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 22:39:55 -0400
Received: (qmail 22477 invoked by uid 107); 26 Aug 2011 02:40:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 22:40:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 22:39:51 -0400
Content-Disposition: inline
In-Reply-To: <4E56DE59.5050601@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180147>

On Thu, Aug 25, 2011 at 07:44:25PM -0400, Eric Sunshine wrote:

> >How well do our cpp patterns do with header files? I imagine they're
> >better than the default, but I don't think I've ever really tried
> >anything tricky.
> 
> I scanned through a number of revisions for one of my long-running
> C++ projects comparing the diff of header files with and without "*.h
> diff=cpp". In some header files in this project, the oft-used C++
> keywords public:, protected:, and private: appear at start-of-line.
> In such cases, the default diff emits a less-than-useful hunk header:
> 
>     @@ -19,8 +19,8 @@ public:
> 
> whereas, "diff=cpp" emits:
> 
>     @@ -19,8 +19,8 @@ class Foobar

Thanks. My C++ is so rusty that I didn't think immediately of how often
those keywords appear in header files. Also, code in inline
functions in either C or C++ will be found in header files. So I think
defaulting *.h and *.hpp to cpp is sensible.

-Peff
