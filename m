From: Jeff King <peff@peff.net>
Subject: Re: Improving auto conflict resolving while merge
Date: Tue, 8 Sep 2015 18:03:57 -0400
Message-ID: <20150908220357.GD24159@sigill.intra.peff.net>
References: <856611441646146@web13j.yandex.ru>
 <20150908070645.GH26331@sigill.intra.peff.net>
 <1059528292.20150908210809@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: KES <kes-kes@yandex.ua>, git <git@vger.kernel.org>
To: Eugen Konkov <kes-kes@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Sep 09 00:04:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZQzl-0005B7-BF
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 00:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbbIHWEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 18:04:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:56480 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752021AbbIHWEA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 18:04:00 -0400
Received: (qmail 19420 invoked by uid 102); 8 Sep 2015 22:04:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 17:04:00 -0500
Received: (qmail 25952 invoked by uid 107); 8 Sep 2015 22:04:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 18:04:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 18:03:57 -0400
Content-Disposition: inline
In-Reply-To: <1059528292.20150908210809@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277527>

On Tue, Sep 08, 2015 at 09:08:09PM -0300, Eugen Konkov wrote:

> JK> you _could_ argue that those changes are independent But it's close 
> JK> enough that there's a good chance the two need to be reconciled, 
> JK> and a human should at least take a look.
> 
> You are right and your words make sense. But this thought may apply
> for this: We have one method/function about 200 lines. One author make
> change at line 1 of this method and other on 199 line. Both changes
> are done in one method so **human should at least take a look**

Right, there is definitely a concept of "close enough" here, and git
cannot catch everything. Semantic changes may even happen across files
(e.g., function interface changes). So you do need to rely on things
like testing and compilation to verify a merge result.

But I would agree there is room for being able to tune the "closeness"
of changes that cause a conflict. Right now that isn't implemented, and
I'm not familiar enough with the xdiff merge code to even point you in
the right direction.

-Peff
