From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] clone: Make use of the strip_suffix() helper method
Date: Thu, 9 Jul 2015 19:16:33 +0200
Message-ID: <CAHGBnuPkia6UYeN4jekfGzypV2MpyiMs2W+O=SSJR3hR=K3g0A@mail.gmail.com>
References: <0000014e73738297-cce3a38b-a85d-40be-b501-354686c25eee-000000@eu-west-1.amazonses.com>
	<20150709170054.GA15820@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 19:16:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDFR9-00049A-Kf
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 19:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203AbbGIRQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 13:16:34 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33775 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbbGIRQe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 13:16:34 -0400
Received: by ietj16 with SMTP id j16so7845810iet.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SqAgl9AmG5fq57nf7AESoPtIKkkzVCCRH9M1CjOtVqA=;
        b=yEUbgRhUJgChWYBNtwiX33Ay+h5TiSP9+LSAZgTy20u+/Ax+KqjGxuze3YEjG5i7zs
         gmnqAzsVngNHhdqJ5Thp1A0Zi2eCO5G93DiFSrERw+Xeu8DiBzS1dvUEYBmi7oEIjAfc
         0KhfoagNcdZNuC4lFrsp4KylDkaurFDY1dWRaYU53GLzVbnYdO74wGGjJX3ry2cPuEv2
         tNmKPengd3NNNfmz+N/vU2MGk+jVv+Nge3hfuGcSNI/PUBGVurHuWTGlKoh04F+rsY7P
         WXGOsFrMnKcsdyPMn+W8AxXcXN5tRDy+Gt7uSKVi7NBOjQMqJjzlD46rXDUMQ/7VPHUj
         Jt3Q==
X-Received: by 10.50.43.227 with SMTP id z3mr69969759igl.12.1436462193707;
 Thu, 09 Jul 2015 10:16:33 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Thu, 9 Jul 2015 10:16:33 -0700 (PDT)
In-Reply-To: <20150709170054.GA15820@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273760>

On Thu, Jul 9, 2015 at 7:00 PM, Jeff King <peff@peff.net> wrote:

> If you wanted to get really fancy, I think you could put a ternary
> operator in the middle of the strip_suffix call. That makes it clear
> that "len" is set in all code paths, but I think some people find
> ternary operators unreadable. :)

I like the idea about the ternary operator, will do.

> This one can also be simplified using xstrfmt to:

Nice, will also do.

> Do we still need to cast "len" to an int to use it with "%.*" (it is
> defined by the standard as an int, not a size_t)?

I think we're more on the safe side by keeping the cast, so I'll do that, too.

-- 
Sebastian Schuberth
