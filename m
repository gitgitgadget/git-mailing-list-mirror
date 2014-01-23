From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] compat: move unaligned helpers to bswap.h
Date: Thu, 23 Jan 2014 11:41:18 -0800
Message-ID: <20140123194118.GT18964@google.com>
References: <20140123183320.GA22995@sigill.intra.peff.net>
 <20140123183522.GA26447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 20:41:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Q9p-00083l-5W
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 20:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755645AbaAWTl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 14:41:26 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:39961 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755586AbaAWTlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 14:41:25 -0500
Received: by mail-bk0-f49.google.com with SMTP id v15so601401bkz.22
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 11:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5XaerfsEMHqlPXxlK1sP5Ytl8NNAHVB4/yt7yX/2Hj8=;
        b=lLkZSBy263xw88Tq51O8zNqakNmarOgvsVRHf/+W9mVFlI+oyvguHSEFn0biNSSgf2
         /tLjB6jaEAVbrK71aXmTtjg9DAVa9QpF4pk9SC3uhEXhtOopuGP0vR1jX7CiRB3Iib0d
         o5C0t9Rj7ugbPnyKGHPwge7e2Thk+FFma4bwMGLKLOQXxW5/LnuzC8Q0CIkNmyZ0fmbh
         u4UV0QI2EGV7bGhpiqphSC7rqmy91rQvaa5SoIzN30PnhwtIv9J8IFPjiAPxR1dE4hki
         v1aLbLOO7LB0Kdl7O90lk9D+I4Eu8AoG2KGWMHd4FkS4Tq4AixvtypdbjMp51dG8GQru
         3kKg==
X-Received: by 10.205.64.136 with SMTP id xi8mr1498615bkb.143.1390506083828;
        Thu, 23 Jan 2014 11:41:23 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id rf10sm80214bkb.3.2014.01.23.11.41.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 11:41:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123183522.GA26447@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240928>

Jeff King wrote:

> Commit d60c49c (read-cache.c: allow unaligned mapping of the
> index file, 2012-04-03) introduced helpers to access
> unaligned data. Let's factor them out to make them more
> widely available.
>
> While we're at it, we'll give the helpers more readable
> names, add a helper for the "ntohll" form, and add the
> appropriate Makefile knob.

Weird.  Why wasn't git broken on the relevant platforms before (given
that no one has been setting NEEDS_ALIGNED_ACCESS for them)?

Puzzled,
Jonathan
