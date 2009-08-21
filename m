From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 0/6 RFC] Series to correct xutils incomplete line 
	handling.
Date: Sat, 22 Aug 2009 00:16:38 +0200
Message-ID: <81b0412b0908211516l4db79249h180e50ffb8e2c1ab@mail.gmail.com>
References: <1249428804.2774.52.camel@GWPortableVCS>
	 <alpine.DEB.2.00.0908191713070.2012@GWPortableVCS>
	 <alpine.DEB.2.00.0908211228000.2012@GWPortableVCS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thell Fowler <git@tbfowler.name>
X-From: git-owner@vger.kernel.org Sat Aug 22 00:16:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MecPf-0003Xu-9c
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 00:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbZHUWQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 18:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbZHUWQi
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 18:16:38 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:58233 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbZHUWQh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 18:16:37 -0400
Received: by ewy3 with SMTP id 3so1009841ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 15:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jmxuVM20ZUADUibCBd0Rzhjl/L/fdCFuwirt4R+hlQk=;
        b=AGa69saR1jQIdrtivQXdJE02iv8MTejgfxJ+IXs6ZrS57JgP00gVijHoseH1bFhqEv
         DvxQVrnMLwRW2MsXus6gLfJJUCVysR8xbHr1XVtWllow9kwzhRnSNx86QjzMpPvw+n2b
         ZiujN38EhiYynxWBusb0DbuifwqI0PEscJrJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TYA23zdcGQwispYVlxFZ9yF8AlhPY0pGXD/Elw6dCEpA1pO7f4pUyxanlBw4CaPkLo
         l9Ym3Q1fCD/lAFJW9SzgwpryrTN+ZKbHveklE7I+aL/WyOeL13USADdmhJzbUhZEcBc0
         erJrdULp97vNqc1ZecBYr2KnFFtIndQNnKVSY=
Received: by 10.210.43.10 with SMTP id q10mr1788488ebq.23.1250892998254; Fri, 
	21 Aug 2009 15:16:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0908211228000.2012@GWPortableVCS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126765>

On Fri, Aug 21, 2009 at 19:39, Thell Fowler<git@tbfowler.name> wrote:
> What is _REALLY_ odd is that it didn't make any tests fail in the test
> dir using master, next, and pu.

The test suite has a very good coverage, but it surely is not complete.

> Perhaps someone can explain what I did wrong when testing?
>
> git checkout master
> make -s clean && make -s all && make -s install && cd t && make

This should have worked. Although I prefer just:

  $ make -j4 && make test -j16
