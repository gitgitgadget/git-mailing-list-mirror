From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 07/19] refs.c: remove the onerr argument to
 ref_transaction_commit
Date: Fri, 25 Apr 2014 15:47:14 -0700
Message-ID: <20140425224714.GF9218@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
 <1398442494-23438-8-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 00:47:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdotx-0002cm-5N
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 00:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbaDYWrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 18:47:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45225 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbaDYWrR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 18:47:17 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so3701949pbb.33
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 15:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YM4WHTRUd7fLs+ffinH/1Vyj6KpUjlTZFluqBIgRY0M=;
        b=bskO1zHtmDA+ARj2ytfFH2NWH1uMDhrso+PBNb3owgydgXLsYjXAbHun/BOm5PNhgC
         OPGDp+kXI3+8mlBQ2oRisklfn/i7vcyb9kDVNnw92ptUn8YBq+XEeAtN9iXKlR1zjYvR
         b4ppACTTX1kkcyH0i5SlyLN4X4ZNVARoekDIjGPpTf5G+QH/YTm3Hm4SMPvwTDE+RChb
         kAFh9811tyhhYzGCzrh9jVlYDYV93H0vfVkiPc8Whu9HrweP4KD8E0ktil1SUUPhGPEw
         XiEdCOibLyEA5YouHK4xuScj4wNH2989EmznLmjNh3BJPjiDk7kLA3ePPXXvaC2YSJ/G
         UcZw==
X-Received: by 10.66.161.69 with SMTP id xq5mr10738068pab.62.1398466037283;
        Fri, 25 Apr 2014 15:47:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id zv3sm45208023pab.20.2014.04.25.15.47.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 15:47:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398442494-23438-8-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247123>

Ronnie Sahlberg wrote:

> Since we now pass meaningful error messages back from ref_transaction_commit
> on failures, we no longer need to provide a onerr argument.

Yay!  More precisely, now that all callers use
UPDATE_REFS_QUIET_ON_ERR there's no need to support any other
behavior.

Thanks for cleaning up the error handling here.
