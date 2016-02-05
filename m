From: Dan Aloni <alonid@gmail.com>
Subject: Re: [PATCH v7 2/2] ident: add user.useConfigOnly boolean for when
 ident shouldn't be guessed
Date: Sat, 6 Feb 2016 00:18:11 +0200
Message-ID: <20160205221811.GB19465@gmail.com>
References: <1454707746-18672-1-git-send-email-alonid@gmail.com>
 <1454707746-18672-3-git-send-email-alonid@gmail.com>
 <20160205215952.GA4901@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 23:18:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRoho-0003WV-7n
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 23:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbcBEWSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 17:18:15 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35309 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbcBEWSO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 17:18:14 -0500
Received: by mail-wm0-f51.google.com with SMTP id r129so45342037wmr.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 14:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7D8SxkwbbFozGI6sWlsf1Yr5Xt52qZdRJ5MfqNqQ6tc=;
        b=eJ0Vbhil5ZFNHgCgBVMqTOxVlgg/mt0kG6erMKhWHWAyWlYEq0csi9MKfNzGtQjYUh
         GTkWPUVPclMu7lbn6cfysN97jMyKtlmNd/2oV7HgaKFx6zjQVbkxW+m3Ab95BUTrPGgW
         w+zAAo0WQGqW2KBv5BW+3g9O4mX3OEAMKxMY6UnsI+F+Gh+Ow5r3BekEpyCy+O+Ku0Pv
         A1lK5imOQcYm3ISGoIj2F4RMuj49fKmErn+nH9P4Dw3M2FZ9nzb59KzYFpWOj10rzShe
         VMJWRjMv+BFLikNazf3W6jV/CGYrtgZkd5rTVQTkj3lhQrnP6LM9t9zENAlZuvEBvD4T
         rblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7D8SxkwbbFozGI6sWlsf1Yr5Xt52qZdRJ5MfqNqQ6tc=;
        b=aVBAoCmgngrE9qFNIEo3UbimxDDnY44hiPFMKUxmEAn9VaPHAcgBqso7f33jEw4W1p
         1t8EPsCa7NRb0A2zq560DAsG8kGG3mckwQDi9WG200skhl5ijIFTCJEHPvq3whgzrmEq
         CICoy9ToyXyBhnNYG8/vRHx/qgrY+lBB/Sl2W7bNRDUmIdG9xKIODANTDKNBqIv9JGgI
         1qURpl5K16U01LTUt+Xkn+KPYGUBmbDbSc3uKo8YCDyjXKTYffNTK7MB+tCb154Pxof/
         HL1omERhWSjIATy706As3+0aryZvUCIk/JPYsxEFBICTV4awDHKNK0fldylPDb6oZqQA
         IiIg==
X-Gm-Message-State: AG10YOTSrudzz4TeiEdjQXDV/fNxrvjBJE+1GLUUzITC/8GlliZjp4DWkSofl2SROdMOaA==
X-Received: by 10.28.12.9 with SMTP id 9mr40255839wmm.76.1454710693491;
        Fri, 05 Feb 2016 14:18:13 -0800 (PST)
Received: from localhost ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id gt7sm17745536wjc.1.2016.02.05.14.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 14:18:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160205215952.GA4901@flurp.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285644>

On Fri, Feb 05, 2016 at 04:59:52PM -0500, Eric Sunshine wrote:
> On Fri, Feb 05, 2016 at 11:29:06PM +0200, Dan Aloni wrote:
> > It used to be that:
> > 
> >    git config --global user.email "(none)"
> > 
> > was a viable way for people to force themselves to set user.email in
> > each repository.  This was helpful for people with more than one
> > email address, targeting different email addresses for different
> > clones, as it barred git from creating commit unless the user.email
> 
> Either: s/commit/a commit/ or s/commit/commits/

Thanks for all the proofing in your reply.

>[..]
> > config was set in the per-repo config to the correct email address.
> > 
> > A recent change, 19ce497c (ident: keep a flag for bogus
> > default_email, 2015-12-10), however declared that an explicitly
> 
> s/however/&,/
> 
> > configured user.email is not bogus, no matter what its value is, so
> > this hack no longer works.
> > 
> > Provide the same functionality by adding a new configuration
> > variable user.useConfigOnly; when this variable is set, the
> > user must explicitly set user.email configuration.
> > 
> > Signed-off-by: Dan Aloni <alonid@gmail.com>
> > Helped-by: Jeff King <peff@peff.net>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > Cc: Eric Sunshine <sunshine@sunshineco.com>
> 
> You'd generally place your sign-off last.
> [..]

Good to know :)

> This test script still has a fair amount of unnecessary cruft in it
> which obscures the important bits showing what you are really
> testing. Below is a more concise version with the unnecessary stuff
> removed:

Thanks, though I'll stick to what Jeff suggested. Also, perhaps better
to keep 'test_config' as it is instead of using '-c', to better mimick
the tested use case.

-- 
Dan Aloni
