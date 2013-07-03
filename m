From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Change "remote tracking" to "remote-tracking"
Date: Wed, 3 Jul 2013 11:38:51 -0700
Message-ID: <20130703183851.GR408@google.com>
References: <1372842754-13366-1-git-send-email-mschub@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Pete Wyckoff <pw@padd.com>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 20:39:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuRxE-00034m-81
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 20:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932857Ab3GCSi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 14:38:56 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:46335 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab3GCSiz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 14:38:55 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so348565pdj.3
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=imaf1F6N5cPrNzLhMIDRRIDPqzyNDVHhbaf/09O2VlY=;
        b=WcOPRjrVdzEF0dpZNtQ+EGpTa0iPBmSmHdZv/umdp0y0YBHBkjE+RvTqQ9gCp8deeP
         dkzYUXAMIgfQg1tnLEfMUD/onyvZHNxofvB4JhWsao1MmSRbAgKNLRTL08NWFpIbGf2E
         sisBv9scpdks+UPY70bk2cqwaRucG3Qrjc9OOmjSMP3VUx7fcVmlbP+26mwHbKshbDEe
         4kc6sMT1oYzYOaAp/DevofyhSHwA7PSXHd1S4517riR8FfXtdxunCbek8Ejpn5wErpe8
         y5YirFqyiZOhc5WkHweMP7VQzSkU1sNeDF7o+vK74yKlXODz2RoJvKLwQ/AT7lT0lDdy
         Fv1w==
X-Received: by 10.66.228.72 with SMTP id sg8mr3672283pac.45.1372876735350;
        Wed, 03 Jul 2013 11:38:55 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id y6sm27122991pbl.23.2013.07.03.11.38.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 11:38:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1372842754-13366-1-git-send-email-mschub@elegosoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229508>

Michael Schubert wrote:

> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -180,7 +180,7 @@ subsequent 'sync' operations.
>  	Import changes into given branch.  If the branch starts with
>  	'refs/', it will be used as is.  Otherwise if it does not start
>  	with 'p4/', that prefix is added.  The branch is assumed to
> -	name a remote tracking, but this can be modified using
> +	name a remote-tracking, but this can be modified using
>  	'--import-local', or by giving a full ref name.  The default
>  	branch is 'master'.

This is confusing both before and after the patch.  What is "a remote
tracking"?

Perhaps:

	--branch <ref>::
		Import changes into <ref> instead of refs/remotes/p4/master.
		If <ref> starts with refs/, it is used as is.  Otherwise, if
		it does not start with p4/, that prefix is added.
	+
	By default a <ref> not starting with refs/ is treated as the
	name of a remote-tracking branch (under refs/remotes/).  This
	behavior can be modified using the --import-local option.
	+
	The default <ref> is "master".

The rest of the patch looks good.

Thanks,
Jonathan
