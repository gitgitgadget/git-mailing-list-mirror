From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Tue, 25 Aug 2009 17:57:26 -0400
Message-ID: <20090825215726.GA30981@coredump.intra.peff.net>
References: <1251228341-29434-1-git-send-email-catap@catap.ru>
 <1251228467-29638-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Tue Aug 25 23:57:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg41e-00067X-Pw
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 23:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbZHYV51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 17:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756175AbZHYV51
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 17:57:27 -0400
Received: from peff.net ([208.65.91.99]:37272 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756005AbZHYV51 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 17:57:27 -0400
Received: (qmail 19095 invoked by uid 107); 25 Aug 2009 21:57:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 Aug 2009 17:57:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2009 17:57:26 -0400
Content-Disposition: inline
In-Reply-To: <1251228467-29638-1-git-send-email-catap@catap.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127051>

On Tue, Aug 25, 2009 at 11:27:47PM +0400, Kirill A. Korinskiy wrote:

> +test_expect_success 'clone' '
> +
> +	git clone parent clone &&
> +	(cd clone && git rev-parse --verify refs/remotes/origin/master)
> +
> +'
> +
> +test_expect_success 'clone -b' '
> +
> +	git clone -b two parent clone-b &&
> +	(cd clone-b && test $(git rev-parse --verify HEAD) = $(git rev-parse --verify refs/remotes/origin/two))
> +
> +'

OK, I think that second test makes sense (though please wrap the very
long line), but now what is the first one doing? Shouldn't it be:

  (cd clone &&
   test $(git rev-parse --verify HEAD) = \
        $(git rev-parse --verify refs/remotes/origin/master)
  )

also?

-Peff
