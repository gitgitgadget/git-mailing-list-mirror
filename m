From: Andreas Ericsson <ae@op5.se>
Subject: Re: gc --aggressive
Date: Wed, 18 Apr 2012 10:49:07 +0200
Message-ID: <4F8E8003.6000206@op5.se>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com> <20120417220838.GB10797@sigill.intra.peff.net> <7vr4vmm29z.fsf@alter.siamese.dyndns.org> <20120417221849.GA11936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 10:49:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKQZr-0005FD-2U
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 10:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab2DRItS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 04:49:18 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50438 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751086Ab2DRItP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 04:49:15 -0400
Received: by lahj13 with SMTP id j13so5523553lah.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 01:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=sOj3QOekDGUVzdXDcF4L/RGRTR5XcNm0XrGaRlG8NZY=;
        b=WCNLQVKO9gRvGoyAo8yCEwAlg89GcacAFHBjmwW5tllE1zbQGibCHKEnUnTIKhDd/K
         G/v9/LupRieLgDeCAEbLM8oxN9CUHF1G7I4hkgylw02PwGkA8tB77Q3mB+NOWXuuxeoM
         asKCJzeUVibXUov6q0yXD/JQBliK2RTLdwG+har6vlUna+/wc1QcXiYpPNMWoBFenhsl
         tq6/Nxp1iMGajHH7KgNpZKIn+ETiOfo0TAoTaVyGZIKEHCInlIscwqoHPKz88MHKzohs
         x1lhKNxbkYwnVjkLEK2V3m/otAgm2dt7rFIulbXob9eSQJN/Kg2NHl7gnGEBy87+Z5CM
         /GEA==
Received: by 10.152.104.109 with SMTP id gd13mr1363810lab.9.1334738954067;
        Wed, 18 Apr 2012 01:49:14 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id f4sm17688232lbk.15.2012.04.18.01.49.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 01:49:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <20120417221849.GA11936@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQnELjL0dazvwNxGZIfv1JP8qTNru0DilT8tu2g471XklqTkILm2tH27uYk9LruvkU+HmpDd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195848>

On 04/18/2012 12:18 AM, Jeff King wrote:
> On Tue, Apr 17, 2012 at 03:17:28PM -0700, Junio C Hamano wrote:
> 
>>> How many cores are there on this box? Have you tried setting
>>> pack.windowMemory to (12 / # of cores) or thereabouts?
>>
>> Hrm, from the end-user's point of view, it appears that pack.windowMemory
>> ought to mean the total without having to worry about the division of it
>> across threads (which the implementation should be responsible for).
> 
> Agreed. I had to look in the code to check which it meant. I'm not sure
> we can change it without regressing existing users, though.
> 

Introduce a new one.

core.maxmemoryusage = <something>, which acts as an upper bound in all
codepaths where we actually keep track.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
