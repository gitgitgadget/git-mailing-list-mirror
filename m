From: Brian Gesiak <modocache@gmail.com>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 15:17:28 +0900
Message-ID: <CAN7MxmWP9N==0DnoE-0=Xr7NWkNMSGBC+yiz1a3wS5EbHigvKg@mail.gmail.com>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
	<20140228053703.GA32556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 07:17:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJGlN-0000Wn-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 07:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbaB1GRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 01:17:32 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:42796 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaB1GRb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 01:17:31 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so1177552iec.29
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 22:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qsLELvsJ4A2ffFixX3MHMRl3TAposkjgKeHf29r29Zk=;
        b=YYN5Dqdnm5dzPXyK+sfbXqq9/2BeErfGYpZ21+EtFgOYVDhUXC5U5lL8pUX0j/Kegs
         pj9jZsfJ4PIjBBEjjQAEPW6+w8ymkn1mYer0Rir9GGsu6r14aBECAK/X6scjrJoF3x4j
         udn7qtt38ubABiV6Y8rox6RScEut1HXbD9XBEeRJAyFpzMaq+vl/C1HFVaJB/E8yFCJW
         S1jcdNID8Xwj9r+/7IMkECwTJePO5tseSDF9XF5P/m+jXPqCVPS7oY4kD6PvFQED3Ecc
         VpVcYsiseO4wqTS+D7uagLJxJF4X4wnFJGIETlG80oiONexjkqqJDFbNWioW2g+QvQiQ
         mP8Q==
X-Received: by 10.50.111.79 with SMTP id ig15mr2185369igb.14.1393568248640;
 Thu, 27 Feb 2014 22:17:28 -0800 (PST)
Received: by 10.64.55.161 with HTTP; Thu, 27 Feb 2014 22:17:28 -0800 (PST)
In-Reply-To: <20140228053703.GA32556@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242889>

> For an operation like "git branch foo origin" where setting up the
> tracking is a side effect, a warning makes sense. But the sole purpose
> of the command above is to set the upstream, and we didn't do it; should
> this warning actually be upgraded to an error?

I agree. I originally wrote the test using test_expect_failure--imagine my
surprise when the exit status was 0, despite the fact that the upstream wasn't
set!

> This should use test_i18ncmp, as the string you are matching is
> internationalized.

Patch is on the way, just waiting for the tests to complete. Thanks for pointing
that out! Also, sorry if it's in the Makefile somewhere, but is there
an easy way
to run just a single test file in the t directory?

- Brian Gesiak
