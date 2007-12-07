From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git and GCC
Date: Fri, 07 Dec 2007 14:14:15 -0800 (PST)
Message-ID: <m3hciutaoq.fsf@roke.D-201>
References: <20071206.193121.40404287.davem@davemloft.net>
	<20071207063848.GA13101@coredump.intra.peff.net>
	<9e4733910712062310s30153afibc44a5550fd9ea99@mail.gmail.com>
	<20071207.045329.204650714.davem@davemloft.net>
	<alpine.LFD.0.9999.0712070919590.7274@woody.linux-foundation.org>
	<4759AC8E.3070102@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, jonsmirl@gmail.com,
	peff@peff.net, nico@cam.org, dberlin@dberlin.org,
	harvey.harrison@gmail.com, ismail@pardus.org.tr, gcc@gcc.gnu.org,
	git@vger.kernel.org
To: Giovanni Bajo <rasky@develer.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 23:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0lSz-0000hu-1e
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 23:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbXLGWOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 17:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbXLGWOT
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 17:14:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:3402 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbXLGWOS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 17:14:18 -0500
Received: by nf-out-0910.google.com with SMTP id g13so405749nfb
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 14:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=H0drTO6WCCPvYdkWjXxn1d65ifAkObD0YTLkladP/3w=;
        b=ZJ15f2y8higCFc9xzKjkYx8oYqZcsR8b0gZedcMJvo8SsbiuMdeDo/GhtlCVoYYK56+MSykqnqmtAouSogl4TfixylbwCCPDsFvz4kMpgz4nf0SkKdOR8WvGvZ/gRknc8gfRr6rdt7Oc4SUkojcFxo+0nCMa93svn98PV74UqO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=tl2U2MNTBlS0XnhqgnuMSpRQWOmUsoEE/b+58dwpuypvTpAnh/vLgb79bvE9Hz4iH4Y60G4X4EM/lNl2bGmJXfq2vOsjxxJiSZChIPrNmEwM3SWYvI2QhxjX81eZBAPuHnuaM0NbFHU71umUk3fPtfzu/+zpHwD8dUvLGi/eOc0=
Received: by 10.86.66.1 with SMTP id o1mr2633249fga.1197065656697;
        Fri, 07 Dec 2007 14:14:16 -0800 (PST)
Received: from roke.D-201 ( [83.8.198.153])
        by mx.google.com with ESMTPS id b17sm243604fka.2007.12.07.14.14.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Dec 2007 14:14:15 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB7ME5oU009436;
	Fri, 7 Dec 2007 23:14:08 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB7MDwST009433;
	Fri, 7 Dec 2007 23:13:58 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <4759AC8E.3070102@develer.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67482>

Giovanni Bajo <rasky@develer.com> writes:

> On 12/7/2007 6:23 PM, Linus Torvalds wrote:
> 
> >> Is SHA a significant portion of the compute during these repacks?
> >> I should run oprofile...
> > SHA1 is almost totally insignificant on x86. It hardly shows up. But
> > we have a good optimized version there.
> > zlib tends to be a lot more noticeable (especially the
> > *uncompression*: it may be faster than compression, but it's done _so_
> > much more that it totally dominates).
> 
> Have you considered alternatives, like:
> http://www.oberhumer.com/opensource/ucl/

<quote>
  As compared to LZO, the UCL algorithms achieve a better compression
  ratio but *decompression* is a little bit slower. See below for some
  rough timings.
</quote>

It is uncompression speed that is more important, because it is used
much more often.

-- 
Jakub Narebski
ShadeHawk on #git
