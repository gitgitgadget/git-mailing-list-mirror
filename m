From: Jeff King <peff@peff.net>
Subject: Re: How to install and use a custom merge driver
Date: Thu, 29 Jan 2009 02:11:58 -0500
Message-ID: <20090129071158.GA554@coredump.intra.peff.net>
References: <497FCC9A.9080008@gmail.com> <20090128061848.GA19165@coredump.intra.peff.net> <loom.20090128T230123-889@post.gmane.org> <20090129032531.GA11836@coredump.intra.peff.net> <loom.20090129T044425-689@post.gmane.org> <20090129050348.GA31202@coredump.intra.peff.net> <49815423.8000902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alec Clews <alec.clews@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 08:13:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSR5f-00021u-Gm
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 08:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbZA2HMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 02:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbZA2HMD
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 02:12:03 -0500
Received: from peff.net ([208.65.91.99]:43055 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbZA2HMB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 02:12:01 -0500
Received: (qmail 29511 invoked by uid 107); 29 Jan 2009 07:12:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 02:12:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 02:11:58 -0500
Content-Disposition: inline
In-Reply-To: <49815423.8000902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107639>

On Thu, Jan 29, 2009 at 06:00:51PM +1100, Alec Clews wrote:

> The problem appears to be spaces around '=' in the attributes file. This  
> fails for me
> [...]
> echo '* merge = overwrite' >.git/info/attributes

Ah, OK. That isn't supposed to work. The attributes are whitespace
separated, and some don't even have an equals at all (e.g., "merge",
"-merge", and "merge=foo" are all valid). So that parses to "please use
the ordinary text merge driver", and some attributes that nobody uses
called "=" and "overwrite".

-Peff
