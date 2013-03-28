From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Thu, 28 Mar 2013 12:25:07 -0700
Message-ID: <20130328192507.GS28148@google.com>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com>
 <20130327211554.GH28148@google.com>
 <7vsj3gjy3t.fsf@alter.siamese.dyndns.org>
 <20130327174845.5e3081d1@hoelz.ro>
 <20130327230943.GA5204@jtriplet-mobl1>
 <7vfvzfwn55.fsf@alter.siamese.dyndns.org>
 <20130328160937.GD16034@leaf>
 <7vr4iztl3z.fsf@alter.siamese.dyndns.org>
 <20130328190344.GA5361@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Rob Hoelz <rob@hoelz.ro>,
	git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 20:25:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULISI-0004DL-7M
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 20:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668Ab3C1TZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 15:25:13 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:43086 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab3C1TZM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 15:25:12 -0400
Received: by mail-pd0-f172.google.com with SMTP id w10so4248459pde.3
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YO/uXw4c2txrKxq71noNw/ecYY0rLqgbGdyWk5rXhMw=;
        b=mGkyBMD3gj/XfgXsbVHE3q7iWx+KoiRybr/GPFf+ha+yNX66NiI4h1Ps5LSCVuOhK0
         Lm4HiLmH787mXUqcqWfaYrjN9pY9krJjtbTy5wlfR4/Wy6IFRicltOd/ETLAaGjkTn8F
         8FFmH7sONVxOCryTjvMlnxESJ4VvRuXprKAtx1crXu9iL32rQUthN2K4psNp/Ho/rZ4R
         LLFrt5ww0j2BMNpkGGhQoquUV2Z2H4MC8QKSVcOevPjMHSvSVK4hvhOcme97m26/RvhW
         9BnN9CfJxkywGUXiPg26VgvkYqJ7Y/xE5BMsjmIwXq5F17HaLYnB5cZAM5gkWK/YqCc/
         0KsA==
X-Received: by 10.66.150.198 with SMTP id uk6mr539144pab.57.1364498711511;
        Thu, 28 Mar 2013 12:25:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id qe3sm9475878pbb.0.2013.03.28.12.25.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 12:25:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130328190344.GA5361@jtriplet-mobl1>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219450>

Josh Triplett wrote:

> Related to this, as a path forward, I do think it makes sense to have a
> setting usable as an insteadOf that only applies to pushurl, even though
> pushInsteadOf won't end up serving that purpose.  That way,
> pushInsteadOf covers the "map read-only repo url to pushable repo url"
> case, and insteadOfPushOnly covers the "construct a magic prefix that
> maps to different urls when used in url or pushurl" case.

I hope not.  That would be making configuration even more complicated.

I hope that we can fix the documentation, tests, and change
description in the commit message enough to make Rob's patch a
no-brainer.  If that's not possible, I think the current state is
livable, just confusing.

I was happy to see Rob's patch because it brings git's behavior closer
to following the principle of least surprise.  I am not actually that
excited by the use case, except the "avoiding surprise" part of it.

Hope that helps,
Jonathan
