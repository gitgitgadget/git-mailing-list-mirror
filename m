From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 01/16] Implement a remote helper for svn in C.
Date: Thu, 26 Jul 2012 02:46:07 -0500
Message-ID: <20120726074607.GA4455@burratino>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 09:46:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIm4-0005Q7-NY
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639Ab2GZHqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:46:15 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:40767 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab2GZHqP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:46:15 -0400
Received: by gglu4 with SMTP id u4so1634288ggl.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yxFE0tQjQ6jRrJuIyL1FROcRahvkWEipZoCMrEEN++Y=;
        b=F+lXokEZSi57Tt3FtaUHdXSEG9UgUwHptjIDj8OheV2Hl1wT5rObAOi4QFBMEM6yuR
         Wgi3BcPl01O00rWzIrp7sspWVXKPh1kl8XBnf9PN+ZmO2U4f+XnMqmQROXWu8bnWRohJ
         plpDbrFHKPAYeR8JRvd2yFtAALotAmEBWhMeu4XUGB0glXeNpY96V2jL+IfarR+TA7fo
         XbCembayLBlETkhKS/RSzTeJO3v3dHlA6wM9IaHuAjLOW4YHC3DJV5rq5KXhB1Ej3VCv
         P5a09uxuICjlK2q+eIp5jMz3Sr6vvjlXTlA/a0PbBuiIV0yO2N7FKyoSeL2NWnVWTer0
         tVNg==
Received: by 10.50.188.131 with SMTP id ga3mr901597igc.54.1343288774400;
        Thu, 26 Jul 2012 00:46:14 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id pp4sm6284727igb.5.2012.07.26.00.46.13
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:46:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202247>

Hi,

Florian Achleitner wrote:

> --- /dev/null
> +++ b/contrib/svn-fe/remote-svn.c
> @@ -0,0 +1,219 @@
> +
> +#include "cache.h"
> +#include "remote.h"
> +#include "strbuf.h"
> +#include "url.h"
> +#include "exec_cmd.h"
> +#include "run-command.h"
> +#include "svndump.h"
> +#include "argv-array.h"
> +
> +static int debug;
> +
> +static inline void printd(const char *fmt, ...)

I remember reviewing this before, and mentioning that this could be
replaced with trace_printf() and that would simplify some code and
improve the functionality.  I think I also remember giving some other
suggestions, but I don't have it in front of me so I can't be sure
(should have more time this weekend).

Did you look over that review?  Did you have any questions about it,
or was it just full of bad ideas, or something else?

It's silly and vain of me, but I'm not motivated by the idea of
spending more time looking over this without anything coming of it.
(Rejecting suggestions is fine, but sending feedback when doing so is
important because otherwise reviewers get demotivated.)

Hope that helps,
Jonathan
