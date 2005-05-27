From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: [PATCH] Fix ptrdiff_t vs. int
Date: Fri, 27 May 2005 10:02:56 -0400
Message-ID: <118833cc05052707026a3dfedd@mail.gmail.com>
References: <42971EB4.2050403@oberhumer.com>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 16:07:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbfQO-0000fz-HZ
	for gcvg-git@gmane.org; Fri, 27 May 2005 16:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVE0OEO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 10:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVE0OEO
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 10:04:14 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:24626 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261449AbVE0OC6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 10:02:58 -0400
Received: by rproxy.gmail.com with SMTP id a41so383963rng
        for <git@vger.kernel.org>; Fri, 27 May 2005 07:02:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m9aqlNzhh2arhTt7oRbYBe9Z8eeJIEPxR0JJ6sFanDAD26ldrybFK8RCFMu9XMZ65tEyGzpBMP+gImIw5LCgWbeowEL7+GfIy03PsEvRwg250cGIKkydpioWlfvJ6V3a/RnrYDb9LeI9DYk33qn/rQvkGEFxJEWYgcBEZ5W3xrc=
Received: by 10.38.153.45 with SMTP id a45mr3640540rne;
        Fri, 27 May 2005 07:02:57 -0700 (PDT)
Received: by 10.38.76.22 with HTTP; Fri, 27 May 2005 07:02:56 -0700 (PDT)
To: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
In-Reply-To: <42971EB4.2050403@oberhumer.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/27/05, Markus F.X.J. Oberhumer <markus@oberhumer.com> wrote:
> This trivial patch fixes an obvious ptrdiff_t vs. int mismatch. Which
> makes we wonder why Linus isn't hitting this on his ppc64 - maybe it's
> time to start using -Werror...

The best time to start using -Werror is "never".  Different compilers
(and versions)
warn about different things, often affected by, say, optimization
switches.  Different
system headers contain things that one compiler or another will issue a warning
over.

Thus -Werror is solely for code that needs to work on one compiler, with one set
of switches, with one libc version, and specific versions of included libraries.

It is tempting to submit a patch to the gcc people making -Werror issue a
warning about the trouble using -Werror.

Morten
