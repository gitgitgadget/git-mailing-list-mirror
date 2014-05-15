From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 08/44] update-ref.c: log transaction error from the
 update_ref
Date: Thu, 15 May 2014 12:23:15 -0700
Message-ID: <20140515192315.GG26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-9-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 21:23:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl1FT-0008UN-5s
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 21:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbaEOTXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 15:23:19 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:62845 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbaEOTXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 15:23:19 -0400
Received: by mail-pa0-f41.google.com with SMTP id lj1so1461061pab.14
        for <git@vger.kernel.org>; Thu, 15 May 2014 12:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=x0TMhf1DAsLsZ9k5ozLfwJtvrrXewXiWOkiA7jm8zD8=;
        b=hNGCyTsSfmWvftFICeo1hIeYuK/SvmmjjTjRNte+K8WT1IeDS+emdOTrK/2+qorqof
         FQNJCny0RcWRTkjsMAXODP/4TJAYKhZ2xy6gH1ku+nIlvlMp/9MHMdpWdF2NG5Ta3F0g
         +zM99n2SO6Jz4I5nL97DGUjTqTMtOM+Dpgcn9xK9Hh6SKGnj4txSkOFIcATofqrzHPch
         nZxfem3icaVURvWvQMkk4TJzkO7PQPcHTVs3ZMAQ7w1QERUTB5CS3uKSFA0LPNEGt0vz
         TtIox+uth39innA8wIF93dI4H8KoNGOSCREQaRUZT3y8+YFRv1xcOatvuCC8byIpYDNx
         TF8A==
X-Received: by 10.66.251.136 with SMTP id zk8mr14835799pac.137.1400181798580;
        Thu, 15 May 2014 12:23:18 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id se3sm10449121pbb.80.2014.05.15.12.23.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 12:23:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-9-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249189>

Ronnie Sahlberg wrote:

> Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
> returned to print a log message if/after the transaction fails.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>

All error paths in _commit add to the error string now, so the only
effect should be to add the missing error message when commiting
packed-refs fails (thanks for fixing that) and to change some one-line
errors to two-line.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
