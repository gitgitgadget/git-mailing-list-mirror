From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 6/7] Remove dead code which contains bad gettext block
Date: Tue, 24 Jul 2012 23:30:57 -0500
Message-ID: <20120725043057.GC3055@burratino>
References: <cover.1343188013.git.worldhello.net@gmail.com>
 <6ab33ed2c1f637ecd2dfda411cf25b074b2d17ea.1343188013.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 06:31:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SttFh-0004du-Dv
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 06:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278Ab2GYEbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 00:31:06 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35966 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab2GYEbF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 00:31:05 -0400
Received: by yenl2 with SMTP id l2so300534yen.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 21:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ToRfW4LmpJKZEZpPwl/js1dcvl3ItbSg5bb5JnlzAy0=;
        b=Y7+mX6byhODDKklCjVyp9Ig9xsy1Hhb+/BFEN/uQs6fgIU9aDTvJKVNlUJId7CWU4z
         yHE8DYxX9MSHKv4fj5wWa0Enl8zY+HkRgzGZsnq8WjD5E6LwqNSmFnH0z0Ouvvl1pFFn
         15ROP2IVFe1bs/pjGRsJvuaGfvq+MCmeLExXXzYO9xyQ8JBs8Q3vTIFvF2W33fIyE6PJ
         ldsRWswlVww1dVPeXK6KoUp4xTuPB8sTRyHyll4iwX9Yd077NQ8ufTI/j4r8/WWdYBQG
         64JIGaur3QzP/IdCwM8wmLTGGoSqxgRa2HNcsuUjd+J1Bx8qNaNy3tyCph4vlVSil4zr
         Ve3g==
Received: by 10.42.66.13 with SMTP id n13mr20849064ici.39.1343190662474;
        Tue, 24 Jul 2012 21:31:02 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id va9sm313208igb.17.2012.07.24.21.31.00
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 21:31:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6ab33ed2c1f637ecd2dfda411cf25b074b2d17ea.1343188013.git.worldhello.net@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202119>

Jiang Xin wrote:
> Found this dead code when I examine gettext messages in shell scripts
> start with dash ('-' or '--'). An error will be raised for this case,
> like:
> 
>     $ gettext "-d option is no longer supported.  Do not use."
>     gettext: missing arguments
> 
> Indead, this code has been left as dead for a long time, as Junathan
> points out:

Jonathan, not Junathan. :)

>     The git am -d/--dotest option has errored out with a message
>     since e72c7406 (am: remove support for -d .dotest, 2008-03-04).
>     The error message about lack of support was eliminated along
>     with other cleanups (probably by mistake) a year later by
>     removing the option from the option table in 98ef23b3 (git-am:
>     minor cleanups, 2009-01-28).
>
>     But the code to handle -d and --dotest stayed around even though
>     ever since then it could not be tripped.  Remove this dead code.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

Your explanation is certainly clearer than mine.  So: yes, for what
it's worth this is

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
