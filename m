From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 11:47:32 -0600
Message-ID: <20120112174731.GA6038@burratino>
References: <20120111173101.GQ30469@goldbirke>
 <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke>
 <20120112165329.GA17173@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 12 18:47:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlOkc-0008WP-AR
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 18:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab2ALRrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 12:47:42 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46043 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab2ALRrl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 12:47:41 -0500
Received: by yenm10 with SMTP id m10so1079043yen.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 09:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=14HuuZN9jr12uDEcIp0egSkEwYak8xoTpPibqa+gIXE=;
        b=gB2U9QetCXjrgxAl29Sh3D7vSZT5R2CGZzWnUGepwCgttO3JevIk/18m7e6GI51xLP
         iMLrAjJxrv3mJwYrdOUFObWQawCdJv7qXYfZvxO1QHd6DIFhPpmWvJ6OoFsXNWsTMedX
         rzbxxfWncnmsWFMlD9X3zUEJxR7Ro77J8Nc4I=
Received: by 10.236.9.106 with SMTP id 70mr7113073yhs.118.1326390461067;
        Thu, 12 Jan 2012 09:47:41 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a7sm15389478ana.5.2012.01.12.09.47.39
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 09:47:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120112165329.GA17173@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188462>

Jeff King wrote:

> I agree it would be nice to make:
>
>   git cherry-pick commit1 commit3 commit2
>
> work in the order specified, but how does that interact with existing
> cases that provide more traditional revision arguments?

Yes, exactly.  Another question: what should

	git cherry-pick master..next maint..master

do?
