From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Use SHELL_PATH to fork commands in
 run_command.c:prepare_shell_cmd
Date: Tue, 27 Mar 2012 00:53:48 -0500
Message-ID: <20120327055348.GA23186@burratino>
References: <20120326182427.GA10333@sigill.intra.peff.net>
 <1332816078-26829-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120327032917.GB17338@sigill.intra.peff.net>
 <20120327050109.GC22547@burratino>
 <20120327051200.GA20897@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 07:54:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPM9-0001Vu-Cc
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 07:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019Ab2C0FyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 01:54:05 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37957 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777Ab2C0FyD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 01:54:03 -0400
Received: by iagz16 with SMTP id z16so9339896iag.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 22:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9Wid6yvw0Qrx+aMnNcEdLLp1SIE4NVTqYQjnbGRC7/k=;
        b=hxXX1lFx3FkqUbZgR9gnl/9fXnEmLuzt8wrdAHBH9D0QXbf64mUHViiqwpOvehgk9N
         5fI/0J2zui3g/UPIoRmoRz+4VSyyb1gVV1f3j2Rg5DmCl4u67Vny2JFnRiPobxXCc9bB
         Tt7xgjKvnE6UI6AbU/+NM4VoJweTjIubuORhBenAXnmOZyLVVdud+C6qeG1uKupCoDTs
         rIAd4JO03GTRWkSrUbejQ4FuFgZ2RnPf+8c4tRRWgHSWnxydRB+GXzm4OwJ4cy6TdUiJ
         xRcb2vdNfrCVJMvWialxuEy/fCDqrJE+jng1G9/9QOWWstIV4qmvuIWvcHJT8VH3awxo
         Y8KA==
Received: by 10.50.188.134 with SMTP id ga6mr7552968igc.20.1332827642147;
        Mon, 26 Mar 2012 22:54:02 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k8sm16941589igz.4.2012.03.26.22.54.00
        (version=SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 22:54:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120327051200.GA20897@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194014>

Jeff King wrote:
> On Tue, Mar 27, 2012 at 12:01:10AM -0500, Jonathan Nieder wrote:

>> I noticed the Makefile already doesn't do this sort of thing for
>> mandir and htmldir, but do you think changes to SHELL_PATH should be
>> tracked to force a rebuild when it changes?
>
> Yeah, that would be nice.

Thanks.  On second thought, without the corresponding tracking for
PERL_PATH, USE_GETTEXT_SCHEME, localedir, etc, it doesn't seem worth
it.

> In general, I wish adding these sorts of dependencies wasn't so manual
> and painful. I'm not sure of a good solution short of totally retooling
> our build system, though.

The Linux kernel build system has an interesting solution to this.  It
keeps track of the command line used to build each file and forces a
rebuild when that command changes.

Ciao,
Jonathan
