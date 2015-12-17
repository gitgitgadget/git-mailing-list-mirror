From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 15/16] refs: add LMDB refs backend
Date: Wed, 16 Dec 2015 17:00:13 -0800
Message-ID: <20151217010013.GC6594@google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-16-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 02:00:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Mvh-0001LH-8Q
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 02:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966440AbbLQBAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 20:00:19 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36707 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966342AbbLQBAR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 20:00:17 -0500
Received: by mail-pa0-f44.google.com with SMTP id q3so12385776pav.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 17:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5DTBW+Fyms3U7lPnFPVDKbpJQGGHxdurzWObmN66m74=;
        b=oQ5rSFa2bIDr/Ghrw8sciVlOcK26E2SlPD4wyOb+t7kC3Fsquceb5D55WMF1a2Ch6Y
         ylo+p07k2cJY9mOLr8kAXDN39uMsd/Z9KpTHz6EtC1zJGOaGVuGxy+V9wXFr3WC+/hqO
         W2zftd/M6yldjgu00fldXaODMwbc4t0PrGwK7T/e2vIbbKlfP09LhkvOShu2I2eW0Enb
         9K5T/6ycmytvTuHazZ/GWZa6wJp9Wm8gswyvoc1lS8hPMIN1Z9flgpf6DfsOhH5ydXln
         jKxLm7256R09vGONly6OOMdF3SDMQHk+dhu3UqsKnkFI7VcAO4c5A029MFZrjYK2V7ER
         J11g==
X-Received: by 10.66.102.97 with SMTP id fn1mr68768897pab.131.1450314016875;
        Wed, 16 Dec 2015 17:00:16 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d1e2:fc78:1215:988f])
        by smtp.gmail.com with ESMTPSA id 21sm7242132pfs.42.2015.12.16.17.00.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Dec 2015 17:00:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449102921-7707-16-git-send-email-dturner@twopensource.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282630>

David Turner wrote:

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -496,6 +496,13 @@ core.repositoryFormatVersion::
>  	Internal variable identifying the repository format and layout
>  	version.
>  
> +core.refsBackendType::
> +	Type of refs backend. Default is to use the original files
> +	based backend. Set to 'lmdb' to activate the lmdb database
> +	backend.  If you use the lmdb backend,
> +	core.repositoryFormatVersion must be set to 1, and
> +	extensions.refBackend must be set to 'lmdb'.

If core.refsBackendType names one backend and extensions.refBackend
names another, which wins?

Thanks,
Jonathan
