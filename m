From: Jeff King <peff@peff.net>
Subject: Re: Fsck message override issue
Date: Wed, 6 Apr 2016 02:19:10 -0400
Message-ID: <20160406061910.GB18208@sigill.intra.peff.net>
References: <32B1B2EC-C1DD-4662-92F1-6A7A9099E110@mindtouch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Seren Thompson <serent@mindtouch.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 08:19:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1angoC-0005xS-6m
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 08:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbcDFGTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 02:19:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:44981 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752763AbcDFGTO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 02:19:14 -0400
Received: (qmail 30691 invoked by uid 102); 6 Apr 2016 06:19:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Apr 2016 02:19:14 -0400
Received: (qmail 12928 invoked by uid 107); 6 Apr 2016 06:19:15 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Apr 2016 02:19:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2016 02:19:10 -0400
Content-Disposition: inline
In-Reply-To: <32B1B2EC-C1DD-4662-92F1-6A7A9099E110@mindtouch.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290825>

On Tue, Apr 05, 2016 at 12:58:38PM -0700, Seren Thompson wrote:

> I'm not having luck with overriding the fsck message types (zeroPaddedFilemode specifically). I've tried adding
>  [fsck]
>     zeroPaddedFilemode = ignore
> to both global and local configs, but it seems to have no effect:
> 
>   $ git --version
>   git version 2.8.0
>   $ git config --get fetch.fsckobjects
>   true
>   $ git config --get fsck.zeroPaddedFilemode
>   ignore
>   $ git pull
>   remote: Counting objects: 14777, done.
>   remote: Compressing objects: 100% (5495/5495), done.
>   error: object 2b7227859263b6aabcc28355b0b994995b7148b6: zeroPaddedFilemode: contains zero-padded file modes
>   fatal: Error in object
>   fatal: index-pack failed
> 
> Is this expected behavior and I'm doing something wrong? Thanks.

I think this is the same issue as

  http://article.gmane.org/gmane.comp.version-control.git/288341

Perhaps some interested person could clean up the patch there (add some
tests) to make it more likely to get merged.

-Peff
