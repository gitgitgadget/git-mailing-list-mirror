From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 00/21] replacement for dt/refs-backend-lmdb v7 patch
 04/33
Date: Tue, 29 Mar 2016 16:12:50 -0400
Organization: Twitter
Message-ID: <1459282370.2976.7.camel@twopensource.com>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
	 <1458802034.28595.8.camel@twopensource.com> <56F76E2C.5030700@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:21:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al00m-0006bQ-T8
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbcC2UNC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 16:13:02 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33486 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbcC2UMx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 16:12:53 -0400
Received: by mail-qk0-f176.google.com with SMTP id s5so11167953qkd.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=nbGPcxn7VxUbINntwfZCxUL2bQalf+Bv0IVELmyTHnE=;
        b=ZSZ0Jd+ugrzsRwZEHZUErOUi7HATx+JIHiKOe6qkdNpL6gz3s1ggpLNWZj2q873RD9
         a4PNEl4W94w8nMa6t7o6+/SzOsBzYSi/O8vlxN97vcLX0ge/M/bMv299P483nEAG0YFF
         LddAphKn4qqm9a3zXy8IrB5bp6kBPDzQ9rjz5oT/xh+tQeDIv41zK4fuWSnR56wJqCCC
         e1gzBwmwidMAOCn5OJgImGc/0+Tmxyj153znRjkO6DC9KnKdYv+m6WCkY0CJrUo28V/M
         4F+ErDJ0PnTVZHTjSHc//QdajKs47t9zVr4uZ6TiYVLoPFyujt1aR8o2K2N2jvxn4Tfq
         TPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=nbGPcxn7VxUbINntwfZCxUL2bQalf+Bv0IVELmyTHnE=;
        b=AzFqG8pWBYcr9suvIPwEaqWyGPujmM0l4gQ/kYBXKDct8eki2709mJiiBVoZ9HPoq8
         0w/AzfEM5ggHg9BM9hRiAiUclAiFYwutyHRJmVjJ5ecvsq3CMt8B6R73KqYtKTrDeGkR
         A0P2ee3X47g82i3d+qOW1+k8hZ0H8e/FJgKc25lWtQXOMwt5fH5vKdfI9YxjHLIWLSq+
         39S2VqeCdaMVtgjDLF/IuNtlnOtYdaB16cng+jYnz0tm1pQlZ8UrYkS2ce41Q38Rwx6x
         7NDrqaByRe6h6AbS5+LaS24clK3IGGxPGnRe2wU3aAnKJKyG49xCdShwFIwqP4TDh3xh
         gBIQ==
X-Gm-Message-State: AD7BkJLMlPvdZge0K9DJk0okMvKPtxfvU7014WJFICNKeOyqZ2QP9i+Yn++8F9q3EuGEow==
X-Received: by 10.55.77.12 with SMTP id a12mr5307024qkb.44.1459282372582;
        Tue, 29 Mar 2016 13:12:52 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id z65sm196405qhz.9.2016.03.29.13.12.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2016 13:12:51 -0700 (PDT)
In-Reply-To: <56F76E2C.5030700@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290184>

On Sun, 2016-03-27 at 07:22 +0200, Michael Haggerty wrote:
> On 03/24/2016 07:47 AM, David Turner wrote:
> > [...]
> > I incorporated your changes into the lmdb backend.  To make merging
> > later more convenient, I rebased on top of pu -- I think this
> > mainly
> > depends on jk/check-repository-format, but I also included some
> > fixes
> > for a couple of tests that had been changed by other patches.
> 
> I think rebasing changes on top of pu is counterproductive. I believe
> that Junio had extra work rebasing your earlier series onto a merge
> of
> the minimum number of topics that it really depended on. There is no
> way
> that he could merge the branch in this form because it would imply
> merging all of pu.
> 
> See the zeroth section of SubmittingPatches [1] for the guidelines.

I'm a bit confused because 
[PATCH 18/21] get_default_remote(): remove unneeded flag variable

doesn't do anything on master -- it depends on some patch in pu.  And
we definitely want to pick up jk/check-repository-format (which doesn't
include whatever 18/21 depends on).

So what do you think our base should be?
