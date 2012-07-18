From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Find .pm files automatically (was Re: Fix git-svn tests for SVN
 1.7.5.)
Date: Tue, 17 Jul 2012 21:14:43 -0500
Message-ID: <20120718021442.GA10180@burratino>
References: <5004B772.3090806@pobox.com>
 <20120717174446.GA14244@burratino>
 <5005EFC5.8060105@pobox.com>
 <20120718000120.GG25325@burratino>
 <50061435.1090900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 04:14:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrJmz-0004Mg-G3
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 04:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479Ab2GRCOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 22:14:53 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:49644 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab2GRCOv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 22:14:51 -0400
Received: by gglu4 with SMTP id u4so1108595ggl.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 19:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6cyu+1gSRaeCVDUW8ZhVQEI35MmGycev0H399LtrJsc=;
        b=aCD3JobD3JxY3nHsFZ6+k9WgLA5SN9IdnNL5YZ0PYfj6ETF0Zono7DGjkz3LyYzq1T
         WdmdLtMoz1YSbU7Gjvw6xQCbeYct/MQ/tTR5DHfXO8lP7C4VneRnT6lf3nUUSRfsDWM5
         p1s8/xS6jPMpG+ZqgKUtfUHAVVFadtYD0P2MBrShztLnOEbVA8A6Rrww7wvc827QFuxN
         8+YjOWG1nU5Ks6dwvYNK4hU9+yziqgo7aAF8v+QDdH6NhikJzEBjOFR3ouezhrIA7tGa
         QglGMWJAtqIJhhyxrA6F1rvO9BCGQbRsyO4UAWm0gq0teavXdnleqFbpr6dft2EUIg36
         T0PQ==
Received: by 10.50.173.69 with SMTP id bi5mr583086igc.38.1342577691015;
        Tue, 17 Jul 2012 19:14:51 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id qo3sm27297681igc.8.2012.07.17.19.14.49
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 19:14:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50061435.1090900@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201643>

Thanks for the reply.  Quick clarifications:

Michael G Schwern wrote:

> The man page is now man3/bundles::Error::Error.3 which is equally as incorrect
> as man3/private-Error.3.  It is possible to correct that so it's man3/Error.3,
> but that's going to require some effort.  Basically its in the same boat as
> PM.  Once you have to change one you have to change them all.
>
> Why do install scripts have specific code to look for that man page?

To delete it. :)

[...]
> Ideally, that second Makefile would go away.  Parallel build systems are extra
> work and generate bugs.

Agreed --- I'd love to see the NO_PERL_MAKEMAKER option go away.

> The log suggests it might have something to do with people wanting to build
> with an ActiveState Perl on Cygwin or something?  MakeMaker builds different
> Makefiles depending on the OS, so it may be as simple as telling Makefile.PL
> what flavor of make you're using.

I think the main user is the ordinary Git for Windows build (which
uses perl 5.8.8, from mingw or msys I imagine).  If you have the
Windows expertise to help them or know someone who could, I'm sure
they'd be happy to switch their git build to use MakeMaker.

Website: http://msysgit.github.com/

Thanks,
Jonathan
