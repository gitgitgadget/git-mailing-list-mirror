From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Ensure __BYTE_ORDER is always set
Date: Thu, 30 Jan 2014 14:12:05 -0800
Message-ID: <20140130221205.GI27577@google.com>
References: <1391111741-28994-1-git-send-email-brian@gernhardtsoftware.com>
 <20140130204538.GA1130@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 30 23:12:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8zqJ-0000FF-DF
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 23:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbaA3WML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 17:12:11 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:36591 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbaA3WMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 17:12:09 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so3658465pbb.31
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 14:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=p4+5dPjBv7nhPP0MvWLdBiG8iThW54TTvmuwDTmBCJ4=;
        b=uNiC5QXDco+ylkueHgixZ2JXXUUbYaQNSvK+I9Rz6EJ9UlgPS36y18Jzj2Cox8nMAw
         T7P3EjrdtGxZpjnaCMj0PK1Ukgbn/YEx2jBsfTutorQ9KCKV6IYiONfup9GcNT5TsM3l
         zDfn/LtT+xfSubRWz5MNJkKRRgVM7Bnv59MT5Ufi+nazw5Jvu1PDLpOjZnBXjk6FC+vB
         kKSVI/FvuvGY+U6LeMImmbBvmP3kG+A8BkHdcqv0aarvqDsTMg8F+w+c8e/wGezGx/A1
         n2xpnAlNd3v0xd0AKl7tRZDnIy4h0+qOzyRThodpGAg5FXhceKWuhwQLujcmeAuqx7c6
         rFIw==
X-Received: by 10.66.142.233 with SMTP id rz9mr17041375pab.71.1391119929328;
        Thu, 30 Jan 2014 14:12:09 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id nm5sm20846925pbc.29.2014.01.30.14.12.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jan 2014 14:12:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140130204538.GA1130@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241283>

Hi,

Jeff King wrote:

> I do find the failure mode interesting. The endian-swapping code kicked
> in when it did not

Odd --- wouldn't the #if condition expand to '0 != 0'?
