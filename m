From: Rick Umali <rickumali@gmail.com>
Subject: Re: tag scheme
Date: Wed, 26 Nov 2014 16:13:57 -0500
Message-ID: <20141126211356.GA15127@rick-t60>
References: <CACY+HvouE0GBH=e4iu7hsFfBJmeZiPKgAC0870S5vPADSYXcJg@mail.gmail.com>
 <20141125170941.GA23258@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Carsten Mattner <carstenmattner@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 22:14:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtjua-0007OL-FM
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 22:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbaKZVOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 16:14:04 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:42358 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbaKZVOC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 16:14:02 -0500
Received: by mail-qc0-f171.google.com with SMTP id r5so2764091qcx.30
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 13:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JoaR0SIz5h2MjAnpjp0qI0CB6PcLAROvvb/mV035qcE=;
        b=BGjjzvwvTuiEKUkh4J/4+khAWS37W9IvyVFUrC8f9U8EzGt+yEnDuTndQidCLVh6mB
         yZXnAGl5WXTqYSqWtFa3IBarmRk+oSJMdIIP4/SFa91MTqWraAaWUfKDNLx76Jn8u8Ep
         gE+XJ7yrR6oJ/hlgFPddOaRqMb1UeOKpMbjMRCQB+Oo7ySEnPrxuR1OPlozBI0XsB4cW
         66lVlJDojJ7Odmw8Gxgsuadb+RtRc1ascfYW+bmaccmd+tq4lx9AAxuXZTEfQaPUgCvX
         ybqlOduq8ZZd+EMaYoy8FndA8YDoe4nMifAXZsvsvl1MPsz0Xbt0Y5b+isQTsIe0NV+t
         Fc4g==
X-Received: by 10.224.65.69 with SMTP id h5mr49043960qai.69.1417036441688;
        Wed, 26 Nov 2014 13:14:01 -0800 (PST)
Received: from rick-t60 (c-66-30-196-5.hsd1.ma.comcast.net. [66.30.196.5])
        by mx.google.com with ESMTPSA id j10sm4915585qai.18.2014.11.26.13.13.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Nov 2014 13:14:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141125170941.GA23258@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260306>

On Tue, Nov 25, 2014 at 12:09:42PM -0500, Jeff King wrote:
> On Tue, Nov 25, 2014 at 05:17:52PM +0100, Carsten Mattner wrote:
> > I'm looking for advice on a tagging scheme, especially pros/cons
> > of using a 'v' prefix as in v2.1.0 like git does.
> > 
> > My impression is that using a common prefix for tags makes it
> > simple to distinguish from maintenance branches for past releases
> > but it seems that most repositories use tags without a prefix.
> > Before I settle on using vX.Y.Z (which I favor right now), I'd like to
> > understand why some projects do not prefix tags.
> 
> I cannot speak definitely for people who prefer no prefix, but I imagine
> that they simply see it as useless noise.
> 
> Personally, I like the prefix because it lets me wildcard-match only the
> releases (and not other random tags I might have):
> 
>   git tag -l 'v*'
> 
> Of course I quite often want to drop release-candidate tags from such a
> list, too, and I have to resort to "grep -v -- -rc" to do so. :)

I wanted to second the prefix notation. I have a repository with 
three tag prefixes (namespaces?): SUBMIT, CODE and V. The prefix 
helps me stay organized. I've been adding -n to the git tag command
that Jeff mentioned:

git tag -l -n 'SUBMIT*'
-- 
Rick (www.manning.com/umali) Umali
