From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] t/t7502: compare entire commit message with what was
 expected
Date: Mon, 18 Feb 2013 21:10:59 -0800
Message-ID: <20130219051059.GD19757@elie.Belkin>
References: <1361247427-438-1-git-send-email-drafnel@gmail.com>
 <20130219050813.GC19757@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 06:11:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7fUV-00076R-GZ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 06:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab3BSFLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 00:11:12 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:63496 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab3BSFLL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 00:11:11 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so2046829pbc.10
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 21:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OlELE0Nigea1Ajn+AVnQCxUFk0ucUxMIbRZulrsH7xE=;
        b=u7HzwfMVk1x8DNN0rObc8Q7qsKAgxLbVDN5VfzgFJBdovi626Kp7lK1i0voH3aT7aY
         yzlZBJEHCOeltd0mvWYFI1HkJPf8cvlgEPy8ANvINg4RWNLaDQBPmm0PeBfeED6m8w5m
         uW+WmiXAxxxyuN1N9yVusnzB7eQyOlBfZCb8PsjcGEueaXjwfWZL5pd60987xnCL0D83
         geDa/EZz/0qsyPspdoMPcxotV14uD/ooSY1SQQ78jp/AKBbkqfvLPrZQ/LqfLZW2k/ZW
         EHiqJ7TBY8lvVlEiNEaTdHYrZIGO+YaImveXJOO4Y/q8SjjtYtgnH4VE3p+o8HcHHqLw
         XxXg==
X-Received: by 10.68.211.103 with SMTP id nb7mr25638682pbc.140.1361250670831;
        Mon, 18 Feb 2013 21:11:10 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id q4sm106114512paz.20.2013.02.18.21.11.08
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 21:11:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130219050813.GC19757@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216561>

Jonathan Nieder wrote:

> +++ w/t/t7502-commit.sh
[...]
> +		# Please enter the commit message for your changes. Lines starting
> +		# with '\''#'\'' will be kept; you may remove them yourself if you want to.
> +		# An empty message aborts the commit.
> +		#
> +		# Author:    A U Thor <author@example.com>
> +		#
> +		EOF
> +		git commit -a --dry-run
> +	} >expect &&
> +	git commit --cleanup=verbatim -t template -a &&
> -	git cat-file -p HEAD |sed -e "1,/^\$/d" |head -n 3 >actual &&
> +	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
>  	test_cmp expect actual

Quick correction: this would use test_i18ncmp instead of test_cmp if
it ends up being a good idea.
