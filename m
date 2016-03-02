From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 10/10] setup: drop GIT_REPO_VERSION constants
Date: Tue, 01 Mar 2016 19:13:02 -0500
Organization: Twitter
Message-ID: <1456877582.5981.6.camel@twopensource.com>
References: <20160301143546.GA30806@sigill.intra.peff.net>
	 <20160301144538.GJ12887@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: mhagger@alum.mit.edu, pclouds@gmail.com
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 01:13:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aauPn-0005P4-3W
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 01:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbcCBANN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 19:13:13 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34317 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbcCBANK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 19:13:10 -0500
Received: by mail-qk0-f170.google.com with SMTP id x1so76494744qkc.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 16:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=QFS1UZP41aZQBurySuz8pMtj/xRmBspslEd4XQDtV/A=;
        b=eBO7zRbWeOAbQO+ARjFen7sBmyLiYKTTqY2wJ9grbIMkJr9cDjQQa3As2ZvA06Wxqh
         yF/vCOxFABE5x2f3MiGxIHHnCrD+LsljNA4io4CNFIAvP5WieYmRj9ZqAatgf8r4yug2
         5oXRBT5fGurkPJHO8K/+8T3mCkNoKveC2BuxG4KN5F6c+EgRVysAQLkg4Es3baC3PjKU
         nRwbAle0osq94/CHm5dUZWVmfPynFvkvN4pi6IiILnTAdo1TgvHZsCOPE/DvFTG1zcAA
         iUplXsvC83XmgGzCOrXDgJdF7HuyyXELUD98K26RfFe0KOpv2//5Iu6wVbvfPmdYpRqa
         VJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=QFS1UZP41aZQBurySuz8pMtj/xRmBspslEd4XQDtV/A=;
        b=ATIIIrya1DawltdhDmm0bWC4PUSWzjFLl7VkOdfjVNwq1M34LBcyl38ImJ3zAiEdBZ
         wLuRS+biigTz05dNNv82OyV0qUKkpbxt22DSH3q2n8vgRmkTqCm+dH5XxuWl5c8HugBf
         LeSmEnYtezLxji91Anm5WtWDmMPt5JAS95u1SMT0ngXqgPAs8AcM3gHlWKPOoZsuaxWF
         PNRjbXMNYWx/k/wFWw/NBycfLD7WdbdzYaqIqG5gmbPuP8iQKZ37/4tfy9TXqQPBJF1m
         8eJqKIB+UVSSf8p2KnC3Y5qYH/QcGBcXkZSS8R36PavcjOUIvdw5aI0f6ZawQMwOSre8
         JMAQ==
X-Gm-Message-State: AD7BkJJd0v9OnIvsNxkrg2P6hZIg6/vYzGLE3bx1DYT2924D4BY7YbJli9goWV6ZpFvDgQ==
X-Received: by 10.55.77.206 with SMTP id a197mr29830438qkb.43.1456877584511;
        Tue, 01 Mar 2016 16:13:04 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id q198sm13911762qhb.16.2016.03.01.16.13.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 16:13:03 -0800 (PST)
In-Reply-To: <20160301144538.GJ12887@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288084>

On Tue, 2016-03-01 at 09:45 -0500, Jeff King wrote:
> -	char repo_version_string[10];
>  
>  	/* This forces creation of new config file */
> -	xsnprintf(repo_version_string, sizeof(repo_version_string),
> -		  "%d", GIT_REPO_VERSION);
> -	git_config_set("core.repositoryformatversion",
> repo_version_string);
> +	git_config_set("core.repositoryformatversion", "0");

I'm about to use that in my series, so let's not get rid of it here.
