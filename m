From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/6] remote.c: introduce a way to have different remotes
 for fetch/push
Date: Wed, 20 Mar 2013 11:30:15 -0700
Message-ID: <20130320183015.GK3655@google.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:30:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINmi-0002ux-8d
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167Ab3CTSaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:30:21 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:33680 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab3CTSaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:30:20 -0400
Received: by mail-pb0-f48.google.com with SMTP id wy12so1562553pbc.21
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=I4ZOWkFXs6HtVU5hTxXnBdoY5M0jM2GTnZa6kuuDIUo=;
        b=QQHyD7qURXTwYPQku1CEXCATNYvxEfOsLTWPwqeIUxbKvgj+Ns6zMX88Yjv3RujB0v
         n5Vf3ibaVNm+uAT4DqXnemZZkw/19ZOIA/ukM4GXA5h0fQc8DHBQl1qHFv7lDfJXMEr3
         J2kQvWawAdD4IwVuuGzfR5dBg7j62lrXc/wemE1YOT3vTScqYZj+v34tSVeEimqDdOPy
         nR0GDqjvEgowlOSCHwUqIkYCFv0HWJB6i1OGw5uawnZDcr2tPlrb6dPxmGMMQ4n4jPuq
         MI9LTz2B91mgw54AnexX8iXcNCKiEnYXPXdCZHFeh192zGPjMXmWF+qHEgPPiWqbadzu
         h/9w==
X-Received: by 10.66.164.198 with SMTP id ys6mr10714726pab.77.1363804220136;
        Wed, 20 Mar 2013 11:30:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id zv3sm3172707pab.0.2013.03.20.11.30.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 11:30:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363783501-27981-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218640>

Ramkumar Ramachandra wrote:

> Currently, do_push() in push.c calls remote_get(), which gets the
> configured remote for fetching and pushing.  Replace this call with a
> call to pushremote_get() instead, a new function that will return the
> remote configured specifically for pushing.  This function tries to
> work with the string pushremote_name, before falling back to the
> codepath of remote_get().  This patch has no visible impact, but
> serves to enable future patches to introduce configuration variables
> to set this variable.

The above description does not make the impact of this change clear to
me.  Could you give a before-and-after example?  How will this
internal API change make my life easier as a developer?

Hope that helps,
Jonathan
