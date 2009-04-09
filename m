From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [PATCH] graph API: Added logic for colored edges
Date: Thu, 9 Apr 2009 18:08:16 -0400
Message-ID: <20090409220816.GA8234@linux.vnet>
References: <20090331235922.GA7411@linux.vnet> <20090407185724.GA9996@linux.vnet> <87hc0x7lpg.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Fri Apr 10 00:10:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls2Rn-0005Lb-HF
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 00:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760467AbZDIWIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 18:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758038AbZDIWIY
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 18:08:24 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:9925 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479AbZDIWIX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 18:08:23 -0400
Received: by wf-out-1314.google.com with SMTP id 29so817933wff.4
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 15:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=UnJmpV9WWj/+uLHlbvGKYV4giwYjY2VIt8hsAJqGMXs=;
        b=bKxJScOUZM0/x1bQ3Atz1LTZfH2p/e2neIThw2p7CyTK8mY2MlOg/cq8Q3ooXgdN/Y
         kQ/aymtyZ1+4CLPSwdQxQaVAhbbN19DoQ61eMV8sz/AG+Ij6KTYQYv+V2qWmwflpbf1g
         rXKNnV77nIqwbXgOWyUQYD/t7uLszcfGuQL2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=xi9P9DawqS74udApguX/iu+l47EEzF8q3YRD4bKXnAJTxlVUgXOqNVW/LTUCo2RSGV
         4J5UVMilzoKXe7bixKFlBk66qM55zvt1u5mN7UWz2akNOi07GobUxXtwm803r7cbn2v1
         OL/psy4UNQx1gg9rQ+bqKKFW2dPFxqpT8j46o=
Received: by 10.142.186.9 with SMTP id j9mr1034216wff.5.1239314902372;
        Thu, 09 Apr 2009 15:08:22 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 22sm1120649wfg.23.2009.04.09.15.08.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 15:08:21 -0700 (PDT)
Mail-Followup-To: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>
Content-Disposition: inline
In-Reply-To: <87hc0x7lpg.fsf@iki.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116210>

On Thu, 09 Apr 2009, Teemu Likonen wrote:
> On 2009-04-07 14:57 (-0400), Allan Caffee wrote:
> 
> > Modified the graph drawing logic to colorize edges based on
> > parent-child relationships similiarly to gitk.
> 
> I like the colored graph very much, thanks. Unfortunately there are some
> problems with aligning of log messages and headers. For example, try
> this in git.git repository:
> 
> 
> $ git log -1 --graph 796b137
> 
> *   commit 796b13781aecce551b8f92049a66646e60f31dce
> |\ Merge: 6da14ee db12d97
> | | Author: Junio C Hamano <gitster@pobox.com>
> | | Date:   2009-04-08 23:41:27 -0700
> 
> 
> Without colors or without your patch the alignment is correct:
> 
> $ git log -1 --graph --no-color 796b137
> 
> *   commit 796b13781aecce551b8f92049a66646e60f31dce
> |\  Merge: 6da14ee db12d97
> | | Author: Junio C Hamano <gitster@pobox.com>
> | | Date:   2009-04-08 23:41:27 -0700
> 
> 
> (Perhaps the "Merge:" header could have two spaces befor the data, but
> this is  unrelated to --graph.)

Thanks for the feedback!  The problem here is that
graph_horizontal_padding was counting the number of characters in the
strbuf in order to decide how much whitespace to pad the row with.  The
ANSI escape sequences for colors and attributes are not printable
characters but do contribute to the length of the strbuf.  This can be
fixed by adding a new function that counts only printing
characters/spaces.  I'll include this in my next round.  
