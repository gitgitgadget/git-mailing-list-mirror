From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v5 2/6] t7030-verify-tag: Adds validation for multiple
 tags
Date: Sun, 17 Apr 2016 13:31:56 -0400
Message-ID: <20160417173155.GA1014@LykOS>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
 <1459872449-7537-3-git-send-email-santiago@nyu.edu>
 <CAPig+cSOLnCoX77O7khEX1cTh0Hu29d6MRdcpfN8ytTkUSVU=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 19:32:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arqYF-0004zv-AZ
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 19:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbcDQRb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 13:31:59 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36560 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbcDQRb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 13:31:58 -0400
Received: by mail-qg0-f52.google.com with SMTP id f52so105468711qga.3
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wRFUIYrFao/TapJg+LlW37rWDUaHE7iUW33c643lvcc=;
        b=Hz8LYDvLwGjcqTwCNOe7ujhbf2tPqdz5ygh+g3MrYU34/lT3BGPq8k4zqNCiWc8wI5
         4H4o9l3s2BxioEmE6WCc2R1UdPBzgvg17/0D/LflVc9w0qOZGEMXPmuzJTgd/dd2hYwn
         vhIHzAJL7c8hnJfacAeUE2Y6Wei0Gmbs9aOSuYihjDOn2CSrV3WAvgUeTbL24OTZQ5/W
         sXZzHiuXQgCMNC4n1CKo0bdNj0lTdWDl9OehrHvH3Gno+XuxN+bByDeXGmaPKthkOi2i
         vGznTGMXlJprTLAfRuquajYrL7fT8R9vWFFx7o0hSSXYNvP6NLpNCpC3rzsvtclku7GS
         ZE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wRFUIYrFao/TapJg+LlW37rWDUaHE7iUW33c643lvcc=;
        b=a0hPQtutwPFho7Qlw6+wZJV5eLfWkIw7GtWj3gV4jKFAlSE4uawqUvxCLUo6z4FaM0
         7GFOTpPwAPZ13M1Jqld9utm5F8t0BCNq2wg10uIEX6C5cVN+A9yBHdJDRob5b5Tfx3ov
         KC+Np9zYvRyeFg4CKDdRZVCGnqeVulCZp0d0AF8blt1TMyrR8kyR3dRaWp5oqKSkgIEt
         AMR7Zq7qODMroo8//jdBdxrAAe/aghxL3jK1u9i+HxLKi9oTdB4jl4+FI/Y/SD/MW4sS
         sZIljS37brYl0ohMd5y25vIknRAHulcWmC8BdN+O86G5hDR3OLH0U2QGmYDv0bOyFR4m
         NSTA==
X-Gm-Message-State: AOPr4FWQHyfBcbqH5eNTFLmyCbSbB9ZiwssxaKMSowBGsRXyCeXtmhXtnnYkB5C1KnoYd1ed
X-Received: by 10.140.164.71 with SMTP id k68mr39773932qhk.97.1460914317050;
        Sun, 17 Apr 2016 10:31:57 -0700 (PDT)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id c2sm24975665qkb.41.2016.04.17.10.31.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Apr 2016 10:31:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cSOLnCoX77O7khEX1cTh0Hu29d6MRdcpfN8ytTkUSVU=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291766>

Sorry for the delay! I just realized I had missed the second comment.

> +       grep "^.GNUPG" <expect.stderr.1 >expect.stderr &&
> 
> Hmm, is there a reason you didn't stick with the more strict regex
> Peff suggested?
> 
>     ^.GNUPG:.
> 
> (Genuine question: I'm not saying your choice is wrong, I'm just
> interested in the reasoning behind the decision.)
> 
I actually had missed the ":". I read the email and tried to internalize
what the new test was actually doing, then I rewrote the test. 

I think I could add it for completeness though.

Thanks again for the reviews!
-Santiago.
