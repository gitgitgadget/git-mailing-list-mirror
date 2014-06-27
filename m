From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] gitk: catch mkdtemp errors
Date: Thu, 26 Jun 2014 20:05:40 -0700
Message-ID: <20140627030540.GB50083@gmail.com>
References: <1403146394-9589-1-git-send-email-davvid@gmail.com>
 <xmqq8uoj4d43.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 05:05:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0MU1-0007jf-9R
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 05:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbaF0DFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 23:05:42 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:55776 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbaF0DFk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 23:05:40 -0400
Received: by mail-pd0-f176.google.com with SMTP id ft15so3833149pdb.21
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 20:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UD0WRq0ClpwpuO9cmYR3K43LfxBxAhieoxXCbCIdemc=;
        b=lnuTW73XmL65rScpuJ6F0VNW61pCLZcDmf9ui09TRlKCs+ZuXmt/NZhRzwlUxzumbb
         /Pi08j3PQiQatXKvr9g/7gPfaqu+idbh5mhefYu8nVp094vC0RnQL0L2QW/eWBa9f8Qc
         T0Pw258HujzMKMiHbSliVxUDdWZ6htKwhhtZq9I35Bxh0E6edD5DMjzj1zhrWRL4HvHH
         Wuj7ZxGkkyTSLrXzPT+7JnR2+Zy40Et58+UUaqiT+5SeTRyrEeQyks68xO45Jv9rJEEe
         nO7f+9T0MVxkk8f3MSU+MQjfLJmQD6SNe3FwIzUCXxgKtHSphVliokdkFnUqHJeFB7VP
         RJWQ==
X-Received: by 10.66.150.228 with SMTP id ul4mr27607563pab.16.1403838340081;
        Thu, 26 Jun 2014 20:05:40 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id gu1sm12226292pbd.0.2014.06.26.20.05.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 20:05:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq8uoj4d43.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252531>

On Thu, Jun 26, 2014 at 01:42:04PM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > 105b5d3fbb1c00bb0aeaf9d3e0fbe26a7b1993fc introduced a dependency
> > on mkdtemp, which is not available on Windows.
> >
> > Use the original temporary directory behavior when mkdtemp fails.
> > This makes the code use mkdtemp when available and gracefully
> > fallback to the existing behavior when it is not available.
> >
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> 
> Does this still need to be applied before I can pull from Paulus?

Yes, it would be nice to have this, especially for Windows users.
-- 
David
