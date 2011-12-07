From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] revert: simplify getting commit subject in
 format_todo()
Date: Wed, 7 Dec 2011 01:06:27 -0600
Message-ID: <20111207070627.GD11737@elie.hsd1.il.comcast.net>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <1323239877-24101-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 08:06:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYBaQ-0006ag-TS
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 08:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab1LGHGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 02:06:34 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46683 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab1LGHGd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 02:06:33 -0500
Received: by yenm1 with SMTP id m1so217792yen.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 23:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=J+FbJtyH1fstPnXLYKkSvCYxI2h4mICf1Vk+dFVxhUo=;
        b=a/RXmhT1GYPPeJ/yfq8k0WNGbtiLEXAdgpZen6r+WcfIIBGgfsYn+MZysnCAm5aV4C
         OBq49No9Eg4nfwcVMf7jMDw8pch+SWLR5kiNxaYs4H9WyjEhfk4cMECFsVVEOSqvLHOA
         Kc95jHEMN00GuB2o/5JmceIZNWFhf2f4ButKE=
Received: by 10.236.92.168 with SMTP id j28mr24102542yhf.59.1323241592620;
        Tue, 06 Dec 2011 23:06:32 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d6sm2529132anm.16.2011.12.06.23.06.31
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 23:06:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323239877-24101-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186434>

Ramkumar Ramachandra wrote:

> format_todo() calls get_message(), but uses only the subject line of
> the commit message.  Save work and unnecessary memory allocations by
> using find_commit_subject() instead.  Also, remove the spurious check
> on cur->item: the previous patch makes sure that instruction sheets
> with missing commit subjects are parsable.

So, what effect will this patch actually have?  Is it an optimization
with no other observable effect?
