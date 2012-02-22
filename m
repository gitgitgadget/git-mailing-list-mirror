From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] cherry-pick: No advice to commit if --no-commit
Date: Tue, 21 Feb 2012 18:51:33 -0600
Message-ID: <20120222005133.GC31934@burratino>
References: <1329871457-12890-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 01:51:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S00Qr-0006KD-BB
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 01:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598Ab2BVAvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 19:51:40 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41737 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab2BVAvk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 19:51:40 -0500
Received: by iacb35 with SMTP id b35so9610971iac.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 16:51:39 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 10.50.95.166 as permitted sender) client-ip=10.50.95.166;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jrnieder@gmail.com designates 10.50.95.166 as permitted sender) smtp.mail=jrnieder@gmail.com; dkim=pass header.i=jrnieder@gmail.com
Received: from mr.google.com ([10.50.95.166])
        by 10.50.95.166 with SMTP id dl6mr23317555igb.27.1329871899601 (num_hops = 1);
        Tue, 21 Feb 2012 16:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pFHXit1uuqH3zevWGU4hN7V4sOtpGYCabdkjLs5UWUE=;
        b=aJfK9Nq60wXMcwKLrejKrS8EIA4cFd74iSlPhVyWyryrZx8aoS6JDGEGujxUU9W8kP
         7zxM94vybcUhKpoJNIUr6A4K05i5rE6p9+C8ENqmqwNxAQbQfwfbqmBpO7E/sYdIDecf
         KTekxvZMHHtPOvIelYH8WjOCUyU+1Fd7D1+DI=
Received: by 10.50.95.166 with SMTP id dl6mr18873866igb.27.1329871899556;
        Tue, 21 Feb 2012 16:51:39 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ak10sm11681233igc.6.2012.02.21.16.51.38
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 16:51:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1329871457-12890-1-git-send-email-hordp@cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191208>

Phil Hord wrote:

>                       In case of cherry-pick --no-commit, the
> hint goes too far. It tells the user to finish up with
> 'git commit'.  That is not what this git-cherry-pick was
> trying to do in the first place.

Especially since if I do try to commit as it says, it will not
reuse the old commit message and timestamp like the advice made me
suspect it would. :)

[...]
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -59,6 +59,20 @@ test_expect_success 'advice from failed cherry-pick' "
>  	test_i18ncmp expected actual
>  "
>  
> +test_expect_success 'advice from failed cherry-pick --no-commit' "
> +	pristine_detach initial &&
> +
> +	picked=\$(git rev-parse --short picked) &&

The escaping here is obnoxiously tricky.  Not your fault, though.

For what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
