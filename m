From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v3 2/5] pretty: make %H/%h/etc respect --abbrev[-commit]
Date: Sun, 02 May 2010 08:52:51 +0100
Message-ID: <1272786771.4194.13.camel@walleee>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
	 <1272656128-2002-3-git-send-email-wmpalmer@gmail.com>
	 <7vocgzyp1f.fsf@alter.siamese.dyndns.org>
	 <20100502044506.GA14776@coredump.intra.peff.net>
	 <7v39yazx4i.fsf@alter.siamese.dyndns.org>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, raa.lkml@gmail.com,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 09:53:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Tzi-0004HW-RN
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 09:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719Ab0EBHw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 03:52:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54167 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998Ab0EBHw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 03:52:56 -0400
Received: by wye20 with SMTP id 20so1040306wye.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=nLYHSGpwmcvZf3YyUv/QzSH84oLKBhr8tU88SP6DR4w=;
        b=JvTrbFzl77ccDklpTgGK+8bITF21HMHz86kWsHIN/yGYQX7fLuF+ZzIuybtYREmHRI
         RmLNsP6+KNshBNgvZdl8WMIFZl1NNHvIMFDQpu/G9B0+oVMad4qlOIQgxZz5a445vCoa
         bNea5MaKSaK4T9519462myCjF8vAyi1lfG8uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=XgWqn4uHqzNFKZ0RyUtCr1kUT16Pl55k78QPqiS384leaQruvIJPKefFf0iRASfl40
         QrQMDNvQJx5uSjLvusdSJRFCHQuGPjsvmmhCoM+OErv6IraTCPhTKZYZRZGQQDWSZa61
         CfvxVR1sJDHptS4wF5K+5+8RAsFvCoQCRffS4=
Received: by 10.216.87.9 with SMTP id x9mr657478wee.67.1272786774428;
        Sun, 02 May 2010 00:52:54 -0700 (PDT)
Received: from [192.168.0.4] (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id z3sm31034476wbs.16.2010.05.02.00.52.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 00:52:53 -0700 (PDT)
In-Reply-To: <7v39yazx4i.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146140>

On Sat, 2010-05-01 at 22:33 -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Sat, May 01, 2010 at 08:13:00PM -0700, Junio C Hamano wrote:
> >

Sounds like this one remains controversial. I'll pull the format changes
out of the next pretty-alias series, and submit them as separate patches
later on. I still think the documentation implies that %H should be
abbreviated when --abbrev-commit is passed, but for now I'm going to
focus on cleaning up the pretty.alias code.
The eventual solution, I suspect, will involve a more-generic syntax as
was brought up in the previous discussion. Something like
%(abbrev-commit?%H), which would also be able to play with something
like [but, for obvious reasons, not exactly] %(is-merge?Merge: %p %p)

The %?C syntax seems to be generating less comment this time, and is the
one that I would find the most important to extending the usefulness of
format-aliases (ie: so that I can view a custom log with color in a
terminal, then output it to a text file and have it "do the right
thing"). Still, it would be lonely without %H/%h, so I'll stick it in
its own patch as well (once I fix it up a bit more, as mentioned in the
other thread).

-- 
-- Will
