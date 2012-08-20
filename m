From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: read-cache-v5.c: compiler warnings
Date: Mon, 20 Aug 2012 10:29:34 +0200
Message-ID: <20120820082854.GA10909@tommy-fedora>
References: <50313AEC.1060700@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Aug 20 10:29:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3NMn-0006gn-Gm
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 10:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612Ab2HTI3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 04:29:40 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39540 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906Ab2HTI3i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 04:29:38 -0400
Received: by wgbdr13 with SMTP id dr13so5109459wgb.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=c1bCjkRPLXOFSwc03mx9HC89u5u+WSgGiIZyw+XKvWE=;
        b=kIhrdhF7we57aackkxgcMr6qn9OlxRu8bmtwHzQ1ohl4Pe2rQB4qOgSSJePzBOoxzY
         9fIBqU4QY8X3E4iTBv62QvbbN5dNDWAcZumK/cJnHr/68hiXufEGteABYnW/yAcgjuvx
         qDO9Hz0gFpJO5HEoz2nGz3M71B1Ee0bhKyAicecet4w99Qz1iNmGJmpHqw7KJcDiIDDx
         Kho5L6yBqYvi1Cf0yN0DJ0dlnS0tQg4bTnJwcWFpNC2Y1WMhj8lmkD5Xh/yaT1PYFT6u
         HlARvd8eCwlcD32EzADzla2HhT9fytr8jLykQ9YKqWIOm2BvmqFcZ/GU873p54jN93ta
         NYqg==
Received: by 10.180.14.8 with SMTP id l8mr27062092wic.6.1345451377461;
        Mon, 20 Aug 2012 01:29:37 -0700 (PDT)
Received: from localhost (host53-193-dynamic.14-87-r.retail.telecomitalia.it. [87.14.193.53])
        by mx.google.com with ESMTPS id w7sm26920363wiz.0.2012.08.20.01.29.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 01:29:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50313AEC.1060700@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203765>

On 08/19, Ramsay Jones wrote:
> Hi Thomas,
> 
> Just an FYI; two out of the three gcc compilers I use (Linux, cygwin
> but not MingW), issue the following warnings:
> 
>         CC read-cache-v5.o
>     read-cache-v5.c: In function `write_index_v5':
>     read-cache-v5.c:1011: warning: 'dir' might be used uninitialized in this function
>     read-cache-v5.c:1012: warning: 'search' might be used uninitialized in this function
>     read-cache-v5.c:1012: warning: 'found' might be used uninitialized in this function
> 
> [commit d2537158 ("Write index-v5", 16-08-2012)]
> 
> Normally I would take a look and offer a patch, but I haven't found time
> to do so in the last 10 days. So, I'm just giving you a heads up ... ;-P

Thanks for noticing.  This warnings only seem to be issued by older
versions of gcc, which is probably why two compilers give the warnings
while one doesn't.

The variables can never be uninitialized, because they are guarded by
ifs and older versions don't seem to recognize that.  I'll fix them
in a re-roll though (or a separate patch if that's preferred), just
waiting for some feedback for v4 of my series.

> 
> HTH
> 
> ATB,
> Ramsay Jones
> 

Thomas
