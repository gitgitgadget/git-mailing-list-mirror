From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] refs.c: add a function to append a reflog entry to a fd
Date: Wed, 19 Nov 2014 17:42:49 -0800
Message-ID: <20141120014249.GE6527@google.com>
References: <1416444142-28042-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sahlberg@google.com, gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 02:42:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrGlq-0005vj-4c
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 02:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755666AbaKTBms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 20:42:48 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:40636 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbaKTBmr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 20:42:47 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so4264638iga.15
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 17:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6cR8L70WT+ci5cXKY18q+Zbu1l85SFRJ0mvOzx2GTV8=;
        b=D8e10a9Yp2jFKJtabt36HBQ31KITKxFgzmO+eMcT/ZegV+2/zf+f9teG2cmhd7rtwN
         EssIILKyr67GHG86VAqkj8iinoWOsd4oC6Dnz4SAwcAkRKFNJTo+yPrflg6Mh3B63nl5
         UTTit91fg3bLGoSTDadfSUJYXcgXV0tM7m9NeEd84iaCbaqApjzgnUvuRkBIB8+N9/vd
         QKk/gIxbEvpJkmnGiAP3n0xr0kE3up+/JjXymBBOq2xfOscWcyTdRmdhwQQy1j23LXF5
         anhXXDBpFk+YmphwyATq/F04ckVBSotjOHhResKKeElyqAr3trU7koxZw9LfR3efbP/o
         dgJA==
X-Received: by 10.107.133.17 with SMTP id h17mr28599959iod.47.1416447766785;
        Wed, 19 Nov 2014 17:42:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id kk2sm1765896igb.14.2014.11.19.17.42.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 17:42:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416444142-28042-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Compared to the last send of this patch[1], there was one change in the print
> function. Replaced sprintf by snprintf for security reasons.

I prefer the version that didn't change the code while we are
extracting it into a new function.  A separate patch on top can switch
it to use strbuf_addf or xstrfmt if we want that.

My two cents,
Jonathan
