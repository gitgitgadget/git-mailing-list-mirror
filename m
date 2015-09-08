From: Jeff King <peff@peff.net>
Subject: Re: [Feature request] help.autocorrect suggestion with Y/N
Date: Tue, 8 Sep 2015 04:40:35 -0400
Message-ID: <20150908084035.GC2991@sigill.intra.peff.net>
References: <55EE9828.106@spacetrace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "rubenkram@spacetrace.org" <rubenkram@spacetrace.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 10:40:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZESK-0008Vq-JN
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 10:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbbIHIkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 04:40:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:56181 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753044AbbIHIkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 04:40:39 -0400
Received: (qmail 681 invoked by uid 102); 8 Sep 2015 08:40:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 03:40:39 -0500
Received: (qmail 20634 invoked by uid 107); 8 Sep 2015 08:40:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 04:40:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 04:40:35 -0400
Content-Disposition: inline
In-Reply-To: <55EE9828.106@spacetrace.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277499>

On Tue, Sep 08, 2015 at 10:11:20AM +0200, rubenkram@spacetrace.org wrote:

>  git: 'glone' is not a git command. See 'git --help'.
> 
>  Did you mean this?
> 	clone
> 
> It would be handsome if you could say "Yes" to this question so you
> don't have to manually correct your last command like:
> 
>  Did you mean this?
>         clone
>  [Y/n]

There is currently no way to ask, but you might want to check out
help.autoCorrect:

  $ git config --global help.autoCorrect 10
  $ git glone ...
  WARNING: You called a Git command named 'gclone', which does not exist.
  Continuing under the assumption that you meant 'clone'
  in 1.0 seconds automatically...

You can set it to "-1" if you want no delay at all.

If you (or someone) wanted to add an interactive version, it would
probably make sense to trigger it by setting help.autoCorrect to "ask".

-Peff
