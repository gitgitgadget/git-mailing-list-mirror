From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 16/16] p0002-index.sh: add perf test for the index formats
Date: Thu, 2 Aug 2012 15:56:47 +0200
Message-ID: <20120802135647.GB1000@tgummerer.unibz.it>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
 <1343905326-23790-17-git-send-email-t.gummerer@gmail.com>
 <CACsJy8AG_dbqentgM+Y9pE=y0bGs2u57sBTF0oG5rNP4HSqY_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 15:56:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwvtY-0007gW-DQ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 15:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711Ab2HBN4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 09:56:51 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50822 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab2HBN4v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 09:56:51 -0400
Received: by wibhm11 with SMTP id hm11so5088736wib.1
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZHnaqSuhmQBIiMLU4DS1JJbekr007Z2V8mIewuE7ppI=;
        b=gg79neG3LarcN+7EV1hzfOsQDIWQJq6DZfTV70r2Qr581ButvaDfHT7ITP9H6Gn2c3
         adOZMdi/woCjUkZwFXhUgkBHV9ylAX/QOP9cCni9ZIMM41cRQiwCPPMV31bPB5o7ZFR+
         F34BUcTF5dQ6s2WVYFARZyD1weVB/tn8OcwRApXsVu7yIahfsDVzIyrsMBQy6X7NY2MG
         78ApLj2wfiSP1AONvRo9IXPBIQF1syAZltFXzpcnCknTd1VNX7BWRGE63clSCKvaHvFh
         PUZdvvqQwLno9ESeUgVCC9slVX99HeZfEWPgECr+MafJBV1KmOCngiE53FvzTUmHLhzv
         GFwg==
Received: by 10.180.84.164 with SMTP id a4mr4968862wiz.12.1343915809917;
        Thu, 02 Aug 2012 06:56:49 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id t7sm17433360wix.6.2012.08.02.06.56.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 06:56:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8AG_dbqentgM+Y9pE=y0bGs2u57sBTF0oG5rNP4HSqY_A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202777>

On 08/02, Nguyen Thai Ngoc Duy wrote:
> On Thu, Aug 2, 2012 at 6:02 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Add a performance test for index version [23]/4/5 by using
> > git update-index --force-rewrite, thus testing both the reader
> > and the writer speed of all index formats.
> 
> On the testing side, it may be an interesting idea to force the whole
> test suite to use v5 by default. There are a few test cases that
> require a specific index version. We can identify and rule them out.
> That'll give v5 a lot more exercises.

The test suite already works with index v5. Patch 5 and 6 fix the only
cases where index-v5 would fail. To make it use index-v5 you can just
set the INDEX_VERSION_DEFAULT to 5 in read-cache.c

I've never used it for performance testing yet, I'll try to run it with
both versions and post the results. I don't think the results will be
a lot different thought, since the test-suite usually uses small
repositories.
