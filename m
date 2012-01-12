From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 13:34:26 -0600
Message-ID: <20120112193426.GD6038@burratino>
References: <20120111173101.GQ30469@goldbirke>
 <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke>
 <20120112165329.GA17173@sigill.intra.peff.net>
 <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
 <4F0F32CC.8040404@kdbg.org>
 <CALkWK0=NVUd629FgkPfgi8ZgTuO+a10t+iwbSrAvONCSmeq2rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 20:34:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlQQ0-0001jt-TB
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 20:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab2ALTed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 14:34:33 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61182 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031Ab2ALTec (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 14:34:32 -0500
Received: by iabz25 with SMTP id z25so3147760iab.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 11:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9j+g9sQEs/g+BmXOb9GTg3iKNxjzgIthMKuv8fpHras=;
        b=UIl2ZNRP1dvhcxd1S5MxwqrYIksRoEPhJSF1bMSDcUDtrJJY4zcHh45Ga8pAo4BvVW
         Jr0XRtlFYTJZAZ3erDTjkN3ffFnRgpIvlBucua0st8TfS9eAoJurBlsEHiKV5G8LL9Fw
         /+Nz0L+jY86ORqgU9JLOT+cl6CVCJQfSuB5qk=
Received: by 10.43.47.135 with SMTP id us7mr4820979icb.31.1326396871733;
        Thu, 12 Jan 2012 11:34:31 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id r18sm20350880ibh.4.2012.01.12.11.34.30
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 11:34:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=NVUd629FgkPfgi8ZgTuO+a10t+iwbSrAvONCSmeq2rQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188477>

Ramkumar Ramachandra wrote:

> That was my first reaction too -- then I saw builtin/push.c (the
> builtin show is quite similar), and found out that it doesn't use the
> revision walker at all.

"git push", unlike "git show", does not accept arguments like
maint..master.
