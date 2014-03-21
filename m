From: Jeff King <peff@peff.net>
Subject: Re: Configuring a third-party git hook
Date: Thu, 20 Mar 2014 23:43:34 -0400
Message-ID: <20140321034334.GA29683@sigill.intra.peff.net>
References: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
 <CAO54GHC1B6hj-OvibHn2=-B25Xd5EmfWsphJ1S7vE4bgUUX3Bw@mail.gmail.com>
 <CAPTjJmpAcmVGgJK8iUvFuXJq_ZukisRZ6OD9TM=feuxDYm5iPQ@mail.gmail.com>
 <20140320233816.GC7774@sigill.intra.peff.net>
 <CAPTjJmpYREHy1cufZMuyOoXrO1Oy7QwXR+wBvm9cbgkT7SqC4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin <ikke@ikke.info>, git <git@vger.kernel.org>
To: Chris Angelico <rosuav@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 04:43:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQqMu-0008W5-TX
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 04:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758753AbaCUDng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 23:43:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:43756 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751613AbaCUDng (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 23:43:36 -0400
Received: (qmail 9739 invoked by uid 102); 21 Mar 2014 03:43:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 22:43:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 23:43:34 -0400
Content-Disposition: inline
In-Reply-To: <CAPTjJmpYREHy1cufZMuyOoXrO1Oy7QwXR+wBvm9cbgkT7SqC4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244634>

On Fri, Mar 21, 2014 at 10:46:15AM +1100, Chris Angelico wrote:

> .... oohhhhhh. Heh. I thought the "porcelain" sections of git were the
> lower-level or machine-readable versions of other tools, and didn't
> really think of mine as fitting into that.

The term sometimes gets used confusingly. The "plumbing" is the
low-level stuff that supports the "porcelain", that users interact with.
But sometimes options to produce low-level scriptable output get called
"--porcelain", as in "this is the output to be used when building a
porcelain on top".

Calling a hook script "porcelain" is kind of stretching it, I think, but
it is filling the same role (it is software built on top of git, and
using git to store config options).

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 73c8973..23f0466 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -131,8 +131,9 @@ Variables
>  
>  Note that this list is non-comprehensive and not necessarily complete.
>  For command-specific variables, you will find a more detailed description
> -in the appropriate manual page. You will find a description of non-core
> -porcelain configuration variables in the respective porcelain documentation.
> +in the appropriate manual page. Other git-related tools may define their own
> +variables, which will be defined on their respective manual pages; ideally,
> +these will be named in some way to indicate the project or creator.

Thanks, the new text looks good to me. Please follow SubmittingPatches
(notably, you need to sign-off your work, and please send patches inline
rather than as attachments).

-Peff
