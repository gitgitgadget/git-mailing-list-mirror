From: Brandon Casey <drafnel@gmail.com>
Subject: Re: t/t1304: avoid -d option to setfacl (db82657)
Date: Thu, 17 Nov 2011 23:37:06 -0600
Message-ID: <CA+sFfMc6BCPvk1FCjZwyY_pWqXBut3D--OfrFEcfK5p97D-KHQ@mail.gmail.com>
References: <gitster/git/commit/db826571e4099066fe44233d95642591016c831b@github.com>
	<gitster/git/commit/db826571e4099066fe44233d95642591016c831b/729354@github.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: wsp 
	<reply+c-729354-3460aca0fa61e627f9d1a271cf70a99d5c1e7e4e-921167@reply.github.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 06:37:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRH8U-0004rp-NX
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 06:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab1KRFhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 00:37:08 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45810 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab1KRFhH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 00:37:07 -0500
Received: by ghbz2 with SMTP id z2so150860ghb.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 21:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VfjzaFOJQwX2xVJiIGmwYvjie3WkpoCsegdy9iRQRNc=;
        b=MB/3r34wAX7E8aXnnGR2e6AUrkWdsNsL4VQOn3RPPKEL51tCKzSlTpClSvWwSxx2A7
         wTKrHBFLHdk7o2yqynrCJlpEOhJvh6a5XJIXiBcqtJmkUtonpvRGvfrg7DYsGfhHrtbX
         pVjUh+nEgdySs16La2mRkL7EnBVomh8/u//kM=
Received: by 10.182.50.65 with SMTP id a1mr407094obo.17.1321594626679; Thu, 17
 Nov 2011 21:37:06 -0800 (PST)
Received: by 10.182.188.104 with HTTP; Thu, 17 Nov 2011 21:37:06 -0800 (PST)
In-Reply-To: <gitster/git/commit/db826571e4099066fe44233d95642591016c831b/729354@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185634>

[cc git@vger.kernel.org since that is the appropriate place for this discusion]

On Thu, Nov 17, 2011 at 8:59 PM, wsp
<reply+c-729354-3460aca0fa61e627f9d1a271cf70a99d5c1e7e4e-921167@reply.github.com>
wrote:
> Could this test case be reviewed again? It fails on FreeBSD where the appropriate way to specify default ACL's is with the "-d" option. The "d[efault]:" syntax is invalid on FreeBSD.

Well, I'm not sure there is a right answer here.

   Linux accepts -d or "d[efault]"
   Solaris only accepts "d[efault]"
   FreeBSD only accepts -d
   a quick search shows z/OS only accepts "d[efault]"
   other?

I think most everything else rolls their own implementation into chmod
or chacl or something like that.

The abandoned POSIX draft does actually specify the FreeBSD behavior.

So I think it's kind of a toss-up.  Which option we choose should
probably depend on whether we get more test coverage by using the
"d[efault]" notation or by using the -d option.  That depends on
whether there are more Solaris users compiling git or whether there
are more FreeBSD users.  I don't know the answer to that either.  I
tend to think there are very few of either.

-Brandon
