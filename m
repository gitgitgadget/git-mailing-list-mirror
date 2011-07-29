From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: memrchr() implementation
Date: Fri, 29 Jul 2011 06:47:56 +0200
Message-ID: <20110729044756.GA6743@elie>
References: <CALUzUxqNGsThcWem4mj=M3EcFF_N5GpARB+x0qx+Q1Gs76Gzig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 06:48:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmezd-0007ik-VE
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 06:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab1G2EsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 00:48:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61726 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab1G2EsH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 00:48:07 -0400
Received: by fxh19 with SMTP id 19so1921783fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 21:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yFEwMarE/q4z5xdzU2Ciddg/vo6V27tG7J++xJjs/vw=;
        b=D81UUbqwPb6v+z0zDSy4NqTneDL1WScrj7ZPml1NrALYQNrW8WnEMsfvGDtipIsF91
         TdVNeXWgoP/liXJYb95c0jIr8fvqDu0xLc4ICwitt2zpW6lN9rqzXnyIdsRIChPN/xEj
         kM90FCFybC7PzIZMFyuY74knGR1PO2/cTG+ak=
Received: by 10.223.98.17 with SMTP id o17mr537098fan.87.1311914885710;
        Thu, 28 Jul 2011 21:48:05 -0700 (PDT)
Received: from elie (adsl-165-187-2.teol.net [109.165.187.2])
        by mx.google.com with ESMTPS id n27sm853865faa.28.2011.07.28.21.48.03
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 21:48:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALUzUxqNGsThcWem4mj=M3EcFF_N5GpARB+x0qx+Q1Gs76Gzig@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178125>

Hi,

Tay Ray Chuan wrote:

> So what's the best way to get git to use memrchr()?

In my very humble opinion: [1].

> I was thinking of getting git to use glibc's implementation if glibc
> is present, if not, use a naive implementation included in git's code
> base [2].

Sounds reasonable.

> [2] (ISC-style license)
> http://www.sudo.ws/repos/sudo/file/c1ab4b940980/compat/memrchr.c

For something simple as this, I'd prefer to avoid a differently
licensed (even ISC-licensed) file.

It might also be worth convincing the folks at
http://austingroupbugs.net/ to standardize the interface so there
could be optimized implementations of memrchr on more platforms over
time.

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/159081/focus=159121
