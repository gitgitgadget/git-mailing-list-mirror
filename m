From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-svn: fix signed commit parsing
Date: Mon, 30 Sep 2013 12:04:04 -0700
Message-ID: <20130930190404.GU9464@google.com>
References: <1380552374-26103-1-git-send-email-boklm@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Mon Sep 30 21:09:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQiqm-0000Ip-Ky
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 21:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098Ab3I3TJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 15:09:34 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:38652 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab3I3TJd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 15:09:33 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so6283993pab.22
        for <git@vger.kernel.org>; Mon, 30 Sep 2013 12:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CE01ZG2FvkiyT+dH/CvFO5Ar37yazJO5+bIp6KikByw=;
        b=PZVuBKa+nFu1Il6FoORbrKzjGJz+Io+38GPV15Z17MDug52RQ9wEEb/Q/PB5PvOir4
         n4/lPKyj2Wjzl9NYW/muUsWmwM669xoidYw1gJ+IT+XCidILqXBuO6DiPqWl/FDcSY1C
         v+57b4nF/NC+E6l/ikdBMxaCcNrEY0ogW0TQ3gqAE9FLFgNvqN90cMb/2xZfF5gTA8w0
         KF2mxjMHtrhBXmzC74vs7eHQh7Pf3MbiJLZ2oD+MpK+J/zvQnkwxt6e59VHmeoCXzlLZ
         4dIZ3RYpBvOxfxhqKddSPmRVVre0txAfbgEUfYE0noaThReHn79LIeQew+Vydk3BeScf
         Ugtg==
X-Received: by 10.68.11.41 with SMTP id n9mr4390501pbb.164.1380567848805;
        Mon, 30 Sep 2013 12:04:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qn1sm2214966pbc.34.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Sep 2013 12:04:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1380552374-26103-1-git-send-email-boklm@mars-attacks.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235620>

Nicolas Vigier wrote:

> When parsing a commit object, git-svn wrongly think that a line
> containing spaces means the end of headers and the start of the commit
> message. In case of signed commit, the gpgsig entry contains a line with
> one space, so "git svn dcommit" will include part of the signature in
> the commit message.
>
> An example of such problem :
> http://svnweb.mageia.org/treasurer?view=revision&revision=86
>
> This commit changes the regex to only match an empty line as separator
> between the headers and the commit message.
>
> Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>

Good catch.  For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
