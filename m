From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Print diffs of UTF-16 to console / patches to email as
 UTF-8...?
Date: Fri, 22 Oct 2010 12:30:55 -0500
Message-ID: <20101022173055.GA11923@burratino>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
 <20101022161851.GH9224@burratino>
 <1287766916.31218.71.camel@drew-northup.unet.maine.edu>
 <20101022171248.GA11794@burratino>
 <1287768426.31218.75.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Oct 22 19:34:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9LW0-0002xC-Fu
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 19:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758075Ab0JVRer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 13:34:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59166 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463Ab0JVReq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 13:34:46 -0400
Received: by pvb32 with SMTP id 32so211961pvb.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=s34Hmog9hrRNJlkhGY5KI2dw29uwYQb+NK8iPex7sl8=;
        b=T/Twg1u7WOOOyT6boaYvtr6vk44VDIa9HODqnCf3WGVqIrWemB1fgBiMwKxF5crf3D
         8OK4Vna51VZPjUQ6RGnh0ozqCijfl6JDNS+zFLJLmGn6CR2pRYRyE9eJH3Tp0Pp/o+/R
         B+2EsVoeQ0tQeZFVNe2Ad9Fx6EVS7XczpFKTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hpxtOv36W4Z7mxFH66sM5Al3RObbRMpwd5g3nCfNKcovfSsy/RjX3Gk17TosRRcrd8
         mehk9hKch/eY/O5wmNpgcc0EQy0ShF2i+DdDJ9xp5Tu6Td/YXDkHEje1TXsTwISMxVg4
         gN2nfG48LOLRKWIKCfPDp8EeAGIlxL7Sbpk8E=
Received: by 10.229.234.4 with SMTP id ka4mr2530752qcb.12.1287768885272;
        Fri, 22 Oct 2010 10:34:45 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id nb14sm2817085qcb.36.2010.10.22.10.34.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 10:34:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287768426.31218.75.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159717>

Drew Northup wrote:

> Please forgive me for being offended that UTF-16 text is not "generic"
> enough.

First some words of explanation.

By "generic" I did not mean ubiquitous, unbranded, popular, or some
other almost-synonym.  What I actually meant is that it is not obvious
what to do with UTF-16.  Should it be converted to UTF-8 for output?
Should it always be normalized when added to the index, so that
switching between canonically equivalent sequences does not result
in spurious diffs?  Should the byte-for-byte representation be
faithfully preserved, even when it is not valid UTF-16?

When in such a situation, often a good approach is the following:
take care of mechanism first, then policy.  So the first thing to do
is to make sure that the code is _capable_ of what people are trying
to do; then one can try various configurations and see what is most
convenient; and finally, one can make sure the program behaves in an
intuitive way by setting a reasonable default.

So by "generic" I meant those mechanisms that can be used in the
context of multiple policies.

Apologies; I never meant to offend; please carry on and I will leave
you in peace.

Jonathan
