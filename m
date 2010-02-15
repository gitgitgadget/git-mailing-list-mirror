From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v2] stash pop: remove 'apply' options during 'drop' invocation
Date: Mon, 15 Feb 2010 10:46:35 -0800
Message-ID: <4B79968B.7060606@gmail.com>
References: <201002151641.19694.trast@student.ethz.ch> <2927b3dc67ab0b9067d4fe849e85654125706b91.1266249586.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steve Folly <steve@spfweb.co.uk>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 15 19:46:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh5y3-0007wn-V2
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 19:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058Ab0BOSqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 13:46:42 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:48222 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836Ab0BOSql (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 13:46:41 -0500
Received: by qw-out-2122.google.com with SMTP id 5so541649qwi.37
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 10:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=/xcaNSEZpnibJtKr/hcHm2CgwmCEh+ipLfhTsfEGNyo=;
        b=QiNqHb97g09b+EkvNcWsE5HERFV6nrhOnBiJ0ed6uVQNf+EalunlxC7PrXZBSLeJQD
         Ny7nSiYB59lEg+ruAGoa742th3IzjdZ/OoE3TiZ34PyixBTMRDy32zvPDbcZ4RQSfdTQ
         rtJvOAHsh12GVeqfwf92DINjQdzY1dbnJzdYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=b8los3NgiCxL/gXKWLzrKy6nb5uS2hmiXyIiD3zq8SbtMkND6OSwenltqnE2aVswXD
         EVqjnCZ1gELsrpw9N/EOdovDXq2Ht3rxZj7ERyAtEgnGD0+6MrfJIWiTf439UeQb3wDc
         CogIIwFp1O6ajIN/rtLoUfuB8zjoSn39yg8PU=
Received: by 10.220.122.24 with SMTP id j24mr85558vcr.28.1266259599495;
        Mon, 15 Feb 2010 10:46:39 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 6sm2447884ywd.37.2010.02.15.10.46.37
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 10:46:38 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <2927b3dc67ab0b9067d4fe849e85654125706b91.1266249586.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140021>

On 02/15/2010 08:05 AM, Thomas Rast wrote:
> The 'git stash pop' option parsing used to remove the first argument
> in --index mode.  At the time this was implemented, this first
> argument was always --index.  However, since the invention of the -q
> option in fcdd0e9 (stash: teach quiet option, 2009-06-17) you can
> cause an internal invocation of
>
>   git stash drop --index
>
> by running
>
>   git stash pop -q --index
>
> which then of course fails because drop doesn't know --index.
>
> To handle this, instead let 'git stash apply' decide what the future
> argument to 'drop' should be.
>
> Warning: this means that 'git stash apply' must parse all options that
> 'drop' can take, and deal with them in the same way.  This is
> currently true for its only option -q.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
>

Acked-by: Stephen Boyd <bebarino@gmail.com>
