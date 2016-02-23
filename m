From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 23/27] svn: learn ref-storage argument
Date: Tue, 23 Feb 2016 13:08:23 -0500
Organization: Twitter
Message-ID: <1456250903.7528.105.camel@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
	 <1455772670-21142-24-git-send-email-dturner@twopensource.com>
	 <20160220235514.GA2311@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 19:08:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYHNv-0003Oy-93
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 19:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbcBWSI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 13:08:27 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34152 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbcBWSI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 13:08:26 -0500
Received: by mail-qg0-f46.google.com with SMTP id b67so142874205qgb.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 10:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=4TwifuZczJ4dw6ZZEVZ3RGYviCttxlyBtgzuqBpglno=;
        b=ogdkMvs6gIUcGqlnNzGzJE4miDN2mH3RFVZtRPiFuo9IclqGiMEDP5BMBMOKY8+EZr
         qHTRR7Q8H8xt0IBwsuxdX3Tt/FsT/oWd6xfTyzpduMMJs8BZW8KIN52PdSdMdJAWtdxF
         7FLi7FosvVOwm3rVKCzf89Wm7gCYTzHXbZ6fLnFM2dLI+XtgWcsYpnZMIHoQxhtgyDlw
         +tw1PapMq8BuaPm+45GxdAsHBRVgQhj7N6Jrtyf9GmcBGZZi+3x/lCMZBNwXcmDtZGDz
         ZX9qEPGEroCVvgjxR4TFIWjs68MgvKotAF5hG5q4a0Npyo3G9U+eTyPFg46zwQSJAI3D
         mwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=4TwifuZczJ4dw6ZZEVZ3RGYviCttxlyBtgzuqBpglno=;
        b=lgfHFFdl5pXbH/WCRFa31++CEWiQsebvmcARrsQgGwnFjUKWDgXoLQ1wI6BjmI5nZT
         HELFIcAQQWHDx3rRiLVNMxdafxCfI2RyxnG6upMbB/DilPrShcJw2SRVjCXQ9cK+zDcA
         xT/CytUPop9gkV2nUT80NwrDmp7NN7wGmIty7cPoUy34PWklZ/7wsK/k9gmsE7mxrkR2
         DuGRa4NeFHnsbxHLxDfjNMEHsLd/Ajtzb7zIMCprVJOIpRn8W4J3jT8s5IJXAAIv993B
         v8854Hsf+t7Rure46qKZb1ZJAqbZwU7dCFb0ZT0ZK+vj7GiWTDJAruHkWsl2LXPKRb6f
         yQEw==
X-Gm-Message-State: AG10YOSv3LwBwCnEsJc5kCJiSB2hxi2aGj3L9oBOasEN4HNtre4MqsglW3NJviw5JNV6Qw==
X-Received: by 10.140.146.143 with SMTP id 137mr45496338qhs.15.1456250905590;
        Tue, 23 Feb 2016 10:08:25 -0800 (PST)
Received: from ubuntu ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id d188sm12615950qkb.9.2016.02.23.10.08.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Feb 2016 10:08:24 -0800 (PST)
In-Reply-To: <20160220235514.GA2311@dcvr.yhbt.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287098>

On Sat, 2016-02-20 at 23:55 +0000, Eric Wong wrote:
> David Turner <dturner@twopensource.com> wrote:
> > +++ b/git-svn.perl
> 
> > +		if (defined $_ref_storage) {
> > +		    push @init_db, "--ref-storage=" .
> > $_ref_storage;
> > +		}
> 
> Minor nit: git-svn uses tabs for indentation.
> Otherwise, if we go this route, consider it:

Got it, thanks.

> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> 
> Thanks.
> 
> I would favor Shawn's RefTree or similar to reuse existing
> code + commands and avoid the external dependency, though.

It's an interesting idea. I'm not sure how good the performance would
be in the case where there are a large number of refs in a single
directory, but it would be worth a try.
