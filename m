From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/23] expire_reflog(): exit early if the reference has
 no reflog
Date: Thu, 4 Dec 2014 15:53:23 -0800
Message-ID: <20141204235323.GI16345@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:53:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwgDK-00025P-DH
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933473AbaLDXxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:53:35 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:55116 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933476AbaLDXx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 18:53:28 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so17136879ieb.35
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 15:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uSQpbaDk6dbStO5gR5B4a9F/LeOiMmnbW00X1s6hqKM=;
        b=bvK6JkwOXV+QNswcgYmsiDiEh389za33XUbUn2X/seW4CxQi6TetGwh1BhvrxYiDsH
         dQR1/mbsV0asyQcJJd+rz4sdTbHzWUo+hfoffYU+OdHSQgms4MGk5lQMxkFXwZIJ445/
         WtQHZbFl44Hpw2T/OFQI02OyaKb8hcxAjxb8qKJZr43eLGXEbSaaXV8ORZ9SDWAG0rsc
         NyRUMln1ALrbWbZ6DEFxR8yELr8hLVf+DYIfZD57v0MQA3qCFoGcKTs114im2lDL94a1
         Fq15PbGgZ87/XTr9ahnBgSEy1NmBD51b+SzyU/mnrGMlHFPKdqotIMBwDzswyuCUAno7
         1Bbw==
X-Received: by 10.43.73.71 with SMTP id yr7mr14119173icb.32.1417737206048;
        Thu, 04 Dec 2014 15:53:26 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5da0:cb9e:66b:e537])
        by mx.google.com with ESMTPSA id jg3sm12558688igb.12.2014.12.04.15.53.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 15:53:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-7-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260845>

Michael Haggerty wrote:

> [Subject: expire_reflog(): exit early if the reference has no reflog]

The caller moves on to expire other reflogs, so it's not exiting.
"return early", maybe?

Except the function already returned early.  I think the purpose of
this patch is to simplify the no-reflog case by handling it separately.

Anyway, that's just nitpicking about the subject line.  With
s/exit/return/ it should be clear that this is a refactoring change,
which for someone looking at the shortlog is the important thing.

Thanks,
Jonathan
