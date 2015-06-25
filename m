From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 5/6] git-reflog: add create and exists functions
Date: Thu, 25 Jun 2015 17:51:45 -0400
Organization: Twitter
Message-ID: <1435269105.7900.9.camel@twopensource.com>
References: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
	 <1435265110-6414-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 23:51:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8F3o-0003eq-Vc
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 23:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbbFYVvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 17:51:50 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35405 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbbFYVvs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 17:51:48 -0400
Received: by igblr2 with SMTP id lr2so1572428igb.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 14:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=4HaaN6FEwWj1q5vC1JtawqA0CVRrTlKtJ4Q2FMWSDWc=;
        b=S+1OVdp8RyWpRfUeXa0H7UpFezZmT1Oh5zueIx2h9RRPFb10mKh7D1MbfhdIkthCml
         WJasEq9iKhNcDCdov+XJIo1ev7qqpbGZLOjS4Kkp0LCn6HvVCyueMXliGAxVVQyldv4W
         NJ6lUy43fMQufHnQRP3Rz0McFDxV6OS78IEf5UZNVCuQJPgA26BbhgbJsOBE7VUzjCE2
         c/eadywQWBLP36Wpuo5tLe18RT5bclXADwM+4vLIMRGdgQclCAPbAuJkONZoN1JLxFEz
         +QWM8lDJXg4jMM+6s2d4g+tJW143MdI606CHxJDoilytcfDtiovKiPRvw5dVuuYVt9ft
         gDKQ==
X-Gm-Message-State: ALoCoQmabQuq+UELPs478erY47VFnnKAW/p1/x2nfMNN3c+HaYMA+GIe+9XNGc9jlpFQXrvM+qqR
X-Received: by 10.42.206.9 with SMTP id fs9mr44848804icb.19.1435269107919;
        Thu, 25 Jun 2015 14:51:47 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id h11sm14509515iod.44.2015.06.25.14.51.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 14:51:46 -0700 (PDT)
In-Reply-To: <1435265110-6414-5-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272740>

On Thu, 2015-06-25 at 16:45 -0400, David Turner wrote:
> +static int cmd_reflog_create(int argc, const char **argv, const char *prefix)
> +{

While revising this patch, I noticed that safe_create_reflog (and this
cmd_reflog_create) only creates reflogs for refs of the form that git
itself would autocreate reflogs for.  In other words, it won't create a
reflog for foo, but will create a reflog for refs/heads/foo (even though
that is very likely to already exist).

So I'll fix that when I re-roll.
