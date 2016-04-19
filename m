From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 1/6] http-backend: use argv_array functions
Date: Tue, 19 Apr 2016 15:11:24 -0400
Organization: Twitter
Message-ID: <1461093084.5540.109.camel@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	 <1460747949-3514-2-git-send-email-dturner@twopensource.com>
	 <xmqqinze6a1h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 21:11:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asb3b-0003vs-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 21:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933665AbcDSTL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 15:11:27 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33276 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932687AbcDSTL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 15:11:26 -0400
Received: by mail-qg0-f51.google.com with SMTP id v14so15437290qge.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 12:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=yk8z0QHnev2aqbVaq9wvJIhZmDJOYkMFv5LWSe+2Iqs=;
        b=r+29q2/u0urlZ6WPljQpE+PeqOyyRFIxyz57mQAO6N0LMEMmBk/rH1p4Sba1XrUAhl
         5pzW3qZxYWTpoM/SOxdbWpKXIWHGQITKioQsmghnV6p0bTpTYKpx9EuYwf+Sl+SwIxI5
         8cm0qnCB42617fNifVk+B520xkBUkExNkRTpyaUxpUgtjuSO4f7pvpqc/ZQajAq4pJb4
         l9ZZRwS2ShhnYe2yf0YyYuUPMhqM4m0tt3wOrEX1pkLh+rrch/H3gGcRQhFQZk0i7Hca
         5nBLAkycXMaB3Z0/Mrp/LE02NKY2PIkMDJJAxTz6A+3ATqcJV5xLngF6tAJKhYQGsW9F
         NiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=yk8z0QHnev2aqbVaq9wvJIhZmDJOYkMFv5LWSe+2Iqs=;
        b=dxWSY/YY21E1jTu2dMJg6h62CR+8vMky6Q136Xgu7eSUAzjt7yF4JztJQah1TJGRDp
         IgcfiQUnq+osxvygDFHdYuQqTtmCSVx6MTa83WNuJjoUjw/LPrSci/8LFvdH5sQn43Di
         egnzfa+FHcr2ImlwTkMK/OzhtDRtvV59wG1qt2tf31BH4M4685dbrdNPfJ0SJ8JrG6yR
         ZuCJbznhZouJZQOh8K9i8BqTHBS7xhiLqyrFUOYVFUqQsTEGIB0L8F3Tvg28iRChSX5b
         fHhmmKdKQ0gIDEO2YMj6hfwmnp9MIfEamcmEzdaDRTWQWpjAx6jrXd6lcqMZDqgm/Fui
         Ncmw==
X-Gm-Message-State: AOPr4FWCJhu0uo1WKmZ4HWmr51RJSOLR39SegIskZQJ7Ha4oAjnHF8+qJ6u5sgH9UMfQDQ==
X-Received: by 10.140.195.210 with SMTP id q201mr6169435qha.68.1461093085823;
        Tue, 19 Apr 2016 12:11:25 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id j67sm29394242qgj.35.2016.04.19.12.11.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 12:11:25 -0700 (PDT)
In-Reply-To: <xmqqinze6a1h.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291910>

On Mon, 2016-04-18 at 11:34 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> 
> OK (it might be easier to read if you used the pushl form for the
> "fixed initial segment" like these calls, though).

Good idea.
