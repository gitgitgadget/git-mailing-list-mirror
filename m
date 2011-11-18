From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/8] Enable GIT_DEBUG_MEMCHECK on git_pathname()
Date: Thu, 17 Nov 2011 19:36:13 -0600
Message-ID: <20111118013613.GB22485@elie.hsd1.il.comcast.net>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
 <1321522335-24193-9-git-send-email-pclouds@gmail.com>
 <CALkWK0ndE1Q_jNSV7CBB5W2NyVhcy7kgNO5woWWOw6CXx3cxcA@mail.gmail.com>
 <20111117134201.GA30718@sigill.intra.peff.net>
 <CACsJy8A25SyLVKv8GwkYaHBJwU5tHqgdJK6L-upF9HWseFzCtQ@mail.gmail.com>
 <20111118012715.GA7826@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 18 02:38:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRDPr-0005lH-N9
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 02:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab1KRBgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 20:36:23 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57277 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938Ab1KRBgW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 20:36:22 -0500
Received: by iage36 with SMTP id e36so2970431iag.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 17:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7DL76fpjMRaHKpmG41/ftV/cSj7xuifScinrhzxZcQY=;
        b=v6gj3BG9kMXJ48BchIwWIH+uJQkaE7aSqRfw9bLhBn1/ObStuK0XRawYQQCgnghZ1D
         UObtikxEitshJoeuTefhq/GDqBl/71XTGrWpH7TSUpOyiTn6S6OYYLTlTmIdPsBNV9uO
         jNhIzwxCz2wdoZUJnhczAgmmTubU35Ygkd854=
Received: by 10.43.131.196 with SMTP id hr4mr450506icc.55.1321580181530;
        Thu, 17 Nov 2011 17:36:21 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a2sm35451764igj.7.2011.11.17.17.36.20
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 17:36:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111118012715.GA7826@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185620>

Jeff King wrote:
> On Fri, Nov 18, 2011 at 08:12:27AM +0700, Nguyen Thai Ngoc Duy wrote:

>> notes-merge.c introduces __VA_ARGS__ since v1.7.4 so we may want to do
>> something there too.
>
> I hadn't noticed. That definitely violates our usual rules about
> portability.  That usage can easily be turned into an inline function.
> However, since nobody has complained in the past year, it makes me
> wonder if we are overly conservative (my guess is that people on crazy
> old compilers just don't keep up with git. Which maybe means they aren't
> worth worrying about. But who knows).

I suspect we didn't notice because MSVC 2005 and later have some
(limited, as far as I can tell from web searches) support for
__VA_ARGS__.
