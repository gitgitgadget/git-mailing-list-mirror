From: David Turner <dturner@twopensource.com>
Subject: Re: ag, **, and the GPL
Date: Tue, 18 Nov 2014 20:51:10 -0500
Organization: Twitter
Message-ID: <1416361870.30428.5.camel@leckie>
References: <CACr0F2iGY_vxWzsNaPQNJ2cLUDRZPS70i79EhyA9OkA7qLaUQQ@mail.gmail.com>
	 <1416333456.27401.1.camel@leckie>
	 <CACsJy8BYBKMqWiNQ=xFjS8s_6GCeoA+UZ-HQ_V1qnsvQG6jOKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Matthew Kaniaris <mkaniaris@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:51:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XquQQ-0005cX-Or
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbaKSBvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:51:15 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64448 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbaKSBvO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 20:51:14 -0500
Received: by mail-qc0-f174.google.com with SMTP id c9so8657001qcz.5
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 17:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Qyp05yR6Er110TRaSToNZ0Uw2whQe5q7oKRmTATv1OI=;
        b=iSMqytvGeRYdD0AXoSN/VssrEHMLwaTgzwIGLvC6o2A9wylfNRazJLnP47N/2A243M
         D8mvqtImtck7Z+YJHUZKPYL+VmIvGQ6bJak6ppjRfzrk55OResdbhj/hCJEZlLGJ1VeJ
         08MklK5gpXMaipe0lw6GsQC9CUYeJF5MGdMN6jxSsBEB93PxnkFyL5OFyoSNW7n1mboI
         D1vb9YmMcZX53Qi9ofboa7RgYa4UH2iXaZ+dp4DIS43HuQHhxQ5/sVuBdtxw9M98QE4F
         piK802zAU45+JKx67WnZUr13q+Qc7mTmtp7EOPwAQGavubXgGpdMODNrB0jr6EsqSYSn
         uXFQ==
X-Gm-Message-State: ALoCoQl7E5YARR4chnh1SmUWAJPjrQZZyD1kzJLgR6IfWTEmLKwwPVmSkp3RgEmtDjShlan46XjD
X-Received: by 10.224.123.132 with SMTP id p4mr40402816qar.3.1416361873656;
        Tue, 18 Nov 2014 17:51:13 -0800 (PST)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id m8sm224805qag.25.2014.11.18.17.51.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Nov 2014 17:51:12 -0800 (PST)
In-Reply-To: <CACsJy8BYBKMqWiNQ=xFjS8s_6GCeoA+UZ-HQ_V1qnsvQG6jOKA@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2014-11-19 at 07:48 +0700, Duy Nguyen wrote:
> On Wed, Nov 19, 2014 at 12:57 AM, David Turner <dturner@twopensource.com> wrote:
> > On Mon, 2014-11-17 at 20:50 -0800, Matthew Kaniaris wrote:
> >> The Silver Search (https://github.com/ggreer/the_silver_searcher), is
> >> a small, open source, cross platform searching utility written as a
> >> replacement for ack.  One of the major benefits of Ag (and a source
> >> for much of its speed) is that it obeys .gitignore.  However, Ag
> >> currently treats gitignores as regexs which produces incorrect results
> >> for e.g. **.  I'd like to add support to ag to obey the .gitignore
> >> spec but I'm not keen on implementing yet another fnmatch clone.  Ag
> >> is licensed under the Apache License Version 2.0 which to the best of
> >> my understanding is incompatible with the GPLv2.  Would you grant me
> >> permission to reuse wildmatch.c (and necessary includes) for use in
> >> Ag?
> >
> > I already implemented this without using any git code at
> > https://github.com/novalis/the_silver_searcher.  The patch was rejected
> > because it slowed down ag slightly (or perhaps because it was overly
> > complex).
> 
> Interesting. Do you have a direct link to that discussion (I don't
> know how to navigate that novalis link). Generally you (or ag) should
> avoid fnmatch/wildmatch whenever possible. Hitting those *match()
> _will_ slow things down (and git tries hard to avoid it). I had some
> optimizations on top of rsync wildmatch to handle "*" case better, but
> I don't think it'll make big difference in practice.

I did sort of a massive pull request here:
https://github.com/ggreer/the_silver_searcher/pull/222 
Here's the main commit:
https://github.com/novalis/the_silver_searcher/commit/50d125647d7b91af08ad43b4b1b977b7e23e0cfa 

I think there as more discussion on some of the other tickets, but it
was over a year ago so I don't recall the details.

Really the thing that ag needs is (a) indexing and (b) to be hooked up
to watchman to update the index.  
