From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Host refs to push are chosen (documentation error)?
Date: Wed, 17 Feb 2010 20:51:27 -0500
Message-ID: <32541b131002171751n454081a9w90f2957d7a40d87@mail.gmail.com>
References: <201002171627.57599.arvidjaar@mail.ru> <be6fef0d1002170539v4384b355lb6be3e2f19b7b87b@mail.gmail.com> 
	<32541b131002170939l261f396cpbee45f652fd96c77@mail.gmail.com> 
	<20100218011620.GA15870@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 02:51:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhvYY-0004lZ-UU
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 02:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab0BRBvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 20:51:49 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:38993 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab0BRBvs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 20:51:48 -0500
Received: by ywh35 with SMTP id 35so557830ywh.4
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 17:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Bi/jhLIxgGPnKlrJqtM0BUD5nKSSbu9Tj6BTqPf50QA=;
        b=b596JggRbU2FYXoCcPexOZhWcZMQbIYNot1lzCG8O92xe4DdtVUnaThYK8tEgGwPfG
         v04z62QIvijYGbfxlgYpbcIQpWtpoZyMzSJLYFDUeOhn3Q8prCx8/o8EM5vh2i4zjnwD
         C4zpfq8dgZmAKjsChXWHUBcYO5Ps0/t4VphmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=unlcb8WGu4R0rNON/9AzVfDNSQyjAynQA0bjGZp4eYx24sQTDWlaZUGGgfg5fc8JdB
         WJzOgocuRcyxIjMSV8Z4mFt21fgxFYrH9/qKeUwj8NJl6RfQJ2YodnbkeFrf9lpaJVC0
         AfxLysPUY1MHk0OQzlCjodcmSYEjGAY71e8zU=
Received: by 10.151.118.2 with SMTP id v2mr2591506ybm.47.1266457907135; Wed, 
	17 Feb 2010 17:51:47 -0800 (PST)
In-Reply-To: <20100218011620.GA15870@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140283>

On Wed, Feb 17, 2010 at 8:16 PM, Jeff King <peff@peff.net> wrote:
> Agreed. It's a minor point, but one that can mislead users who don't
> know about packed refs. Maybe something like this?

Wow, you really go all out.  Looks pretty good to me, except maybe this:

> ++
> +For any of the `$GIT_DIR/refs` cases above, packed refs from
> +`$GIT_DIR/packed-refs` may be substituted (e.g., a line with
> +`refs/heads/master` in the packed-refs file would have the same
> +precedence as the file `$GIT_DIR/refs/heads/master`).

Are they really equal precedence?  How does git decide, when there's
one of each?  I'd guess packed-refs might actually be strictly higher
precedence, but I'm not sure.

Avery
