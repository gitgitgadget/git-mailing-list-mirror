From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 05/44] refs.c: move update_ref to refs.c
Date: Tue, 13 Oct 2015 21:01:56 -0400
Organization: Twitter
Message-ID: <1444784516.18742.12.camel@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
	 <1444686725-27660-6-git-send-email-dturner@twopensource.com>
	 <561C7D7B.8020807@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 14 03:02:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmASC-0006tw-R4
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 03:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbbJNBB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 21:01:59 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36202 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbbJNBB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 21:01:59 -0400
Received: by qgx61 with SMTP id 61so30632960qgx.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 18:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=0rZqnkK+TtfuwA73U8O7ScI6u1YW/wvACuvHMQWVPvA=;
        b=aEdrLo7eBfLM9CJFmxwbsomEhZfhgMtjWSYHw1elJ1zVT9QcsYNJqBjw66+h8P4mLG
         KAGw0TrTbB7c041ePShWgZZB/HAABXNggMH87R80veli6RhTScnySaxLUdWOUXrijvjI
         elFsRye8dR45rMcRcSgEWW5kRLFX6j/TnV/ywQzah31ZCfJYaSq94rp+i0UytBKIbRiA
         5AX/y6wB7ZWDbBD7FMhwH6ZQ4oncwEq3o12b7QL+rmHBcYbpoW/cRB2G6bw9GHsFS5HS
         zDggHikwMNp0UKQ9fz/14/IIq1iaPLJHKplV4aa7ovIvYGfRYTSoq/Cd7gcZZgnH6Uey
         hbJQ==
X-Gm-Message-State: ALoCoQmAoeQS7gNotLiCUj8Umqr0oXxdf2+niJGe5fnfPX0Z58OyTI8+VsULc9wPYqWTu0vRYPYY
X-Received: by 10.140.109.6 with SMTP id k6mr490163qgf.28.1444784518255;
        Tue, 13 Oct 2015 18:01:58 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 18sm2363986qgg.39.2015.10.13.18.01.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2015 18:01:57 -0700 (PDT)
In-Reply-To: <561C7D7B.8020807@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279558>

On Tue, 2015-10-13 at 05:41 +0200, Michael Haggerty wrote:

> The original read
> 
> 		if (read_ref(pseudoref, actual_old_sha1))
> 			die("could not read ref '%s'", pseudoref);
> 
> This seems like an important test. What happened to it?
> 
> If its removal was intentional, it deserves a careful explanation (and
> should probably be done as a separate commit). If it was an accident,
> please consider how this accident arose and try to think about whether
> similar accidents might have happened elsewhere in this series.

I went ahead and manually rechecked all of the patches to ensure that
nothing else was screwed up.  While doing so, I found two or three
spurious whitespace changes (moving newlines around), which I fixed (in
refs-backend-pre-vtable, which I'll send to the list tomorrow-ish).
