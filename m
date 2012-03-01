From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 1/5] t6300 (for-each-ref): modernize style
Date: Thu, 1 Mar 2012 07:58:07 -0800
Message-ID: <20120301155807.GH2572@tgrennan-laptop>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
 <1330566326-26075-2-git-send-email-tmgrennan@gmail.com>
 <4F4F1CD7.4060403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 16:58:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S38Oz-00026D-0o
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 16:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767Ab2CAP6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 10:58:14 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57552 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab2CAP6O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 10:58:14 -0500
Received: by vbbff1 with SMTP id ff1so572972vbb.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 07:58:13 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.99.169 as permitted sender) client-ip=10.52.99.169;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.99.169 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.99.169])
        by 10.52.99.169 with SMTP id er9mr8621462vdb.126.1330617493317 (num_hops = 1);
        Thu, 01 Mar 2012 07:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lGB9TxmNkrNwXa4APbxDUHmnOlSJLlV5ucqAo9K4MqY=;
        b=n6KU5o6i2/Z7LSL3nW7VIZqBi0XS+jihf9TFIq9U9I9/BqVlHPWwbk6WsTmZbOH0Cm
         pSGnCHrEfQkgM2eQK27/QSUKfPA7msSmVtZt/2MAGPOddaVtAazg0GzJ3CCiATaiyi89
         ZF/SEYkrbEiNzY5ruszUXE829vfRda8SuMYRk=
Received: by 10.52.99.169 with SMTP id er9mr7300050vdb.126.1330617493146;
        Thu, 01 Mar 2012 07:58:13 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id gz4sm3665406vdb.19.2012.03.01.07.58.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Mar 2012 07:58:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F4F1CD7.4060403@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191939>

On Thu, Mar 01, 2012 at 07:53:11AM +0100, Johannes Sixt wrote:
>Am 3/1/2012 2:45, schrieb Tom Grennan:
>> +	git for-each-ref --format="%(refname)" --sort=refname |
>> +		test_cmp expect -
>
>DON'T DO THIS. It loses the exit code of the git invocation.
>
>(And it is contrary to my effort to move all test_cmp away from being used
>in a pipeline because I want to use a comparator tool that does not
>understand '-' as stdin.)

OK, with bash, one could get that from PIPESTATUS, but that doesn't help if
you're not using bash or desire a different comparator.

Thanks,
TomG
