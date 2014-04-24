From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 5/9] patch-id: document new behaviour
Date: Thu, 24 Apr 2014 10:33:25 -0700
Message-ID: <20140424173325.GK15516@google.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
 <1398331809-11309-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
	gitster@pobox.com
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 19:33:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdNWj-0007hi-5k
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 19:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758628AbaDXRdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 13:33:31 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:38675 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758534AbaDXRd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 13:33:28 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so2184680pbc.2
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zjlHU2fvClywxoN0J34C3YeqULaqgbg8epXGr7M9SSc=;
        b=YPsWTDxlzUwYzGitEh1B6EeqlaQwf+XwTSFpmSZMiRM42PXYPEATlE2oEDP/jX2gzF
         47IGXMJ89lnBURLjJdR1biPL4isOW7zsN8luSXVo7NS2wCLZaVyK/lEKEzMO94x4Wj1z
         bnO57r5H/8ln7gaLMbTIG/XKohsI8laOO4glmAm8QaC2JUQMugAy23PgczVX7LV1/0VQ
         A/EltbFlMNC9sEizUhJ05a6BTquX1nSCPNN1UDMWyErgV6vTG+k0keLqUXqL+0MwXXNb
         RIErS3Tt2Db09kIhlNY4QRD57gqtWLP7tqAI/rlvqFUQw+JaUxdbUIE7NCEelItHqC1T
         YwdQ==
X-Received: by 10.68.110.129 with SMTP id ia1mr5060484pbb.158.1398360808332;
        Thu, 24 Apr 2014 10:33:28 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id it4sm10334581pbd.48.2014.04.24.10.33.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Apr 2014 10:33:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398331809-11309-5-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246980>

Michael S. Tsirkin wrote:

>  Documentation/git-patch-id.txt | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Ah, there's the documentation.  Please squash this with the patch that
introduces the new behavior so they can be reviewed together more
easily (both now and later when people do archeology).

[...]
> +--stable::
> +	Use a symmetrical sum of hashes as the patch ID.
> +	With this option, reordering file diffs that make up a patch or
> +	splitting a diff up to multiple diffs that touch the same path
> +	does not affect the ID.
> +	This is the default if patchid.stable is set to true.

This doesn't explain to me why I would want to use --stable versus
--unstable.  Maybe an EXAMPLES section would help?

The only reason I can think of to use --unstable is for compatibility
with historical patch-ids.  Is there any other reason?

At this point in the series there is no patchid.stable configuration.

> +--unstable::
> +	Use a non-symmetrical sum of hashes, such that reordering

What is a non-symmetrical sum?

Thanks,
Jonathan
