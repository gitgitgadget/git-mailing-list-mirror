From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] remove inline iteration variable
Date: Wed, 16 Aug 2006 14:41:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608161441070.29566@chino.corp.google.com>
References: <Pine.LNX.4.63.0608151022340.26891@chino.corp.google.com>
 <81b0412b0608160027l2ac53c10gd9a75525ca144f1d@mail.gmail.com>
 <Pine.LNX.4.63.0608161011100.20470@chino.corp.google.com>
 <20060816201019.GA6083@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 23:42:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDT9O-0007Ai-Pg
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 23:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWHPVmH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 17:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWHPVmH
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 17:42:07 -0400
Received: from smtp-out.google.com ([216.239.45.12]:5546 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932241AbWHPVmG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 17:42:06 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id k7GLftDb001242;
	Wed, 16 Aug 2006 14:41:56 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=IRjlWjPJlPne+BPKUxBQEmqNsuDcU4tbpgJMi5XU50FEYFMm9H5cEdw+ErlHPXcuJ
	rZ5wP3zxeIwMK8H/nGacA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps75.corp.google.com with ESMTP id k7GLfooQ020421;
	Wed, 16 Aug 2006 14:41:50 -0700
Received: by localhost (Postfix, from userid 24081)
	id E4B4587D71; Wed, 16 Aug 2006 14:41:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 9663D87D70;
	Wed, 16 Aug 2006 14:41:50 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060816201019.GA6083@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25531>

On Wed, 16 Aug 2006, Alex Riesen wrote:

> David Rientjes, Wed, Aug 16, 2006 19:14:44 +0200:
> > > > Remove unnecessary iteration variable in inline.
> > > > -       for (i = 0; i < in; i++) putchar(' ');
> > > > +       for (; in > 0; in--)
> > > 
> > > while(in--) putchar(' ');
> > > 
> > 
> > That goes into an infinite loop if the argument is negative because
> > it emits a cmpl $0, x(%ebp).  Should never happen, but there's no
> > reason not to prevent it with a for loop.
> 
> while (in-- > 0) putchar(' ');
> 
> still shorter :)
> 

It emits a slightly rearranged assembly with the same number of instructions.

		David
