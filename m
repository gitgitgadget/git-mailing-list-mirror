From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Fri, 25 Jan 2008 22:48:11 +0100
Message-ID: <200801252248.12682.jnareb@gmail.com>
References: <alpine.LNX.1.00.0801251336080.13593@iabervon.org> <7vir1h64k7.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0801251535380.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 22:49:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIWQ7-0005DF-Ad
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 22:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757641AbYAYVsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 16:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757142AbYAYVsX
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 16:48:23 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:29911 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756804AbYAYVsV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 16:48:21 -0500
Received: by fg-out-1718.google.com with SMTP id e21so786370fga.17
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 13:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=0p9NRF5HQ0N2Zi89L7tXVDEWapPt5ymDK7HakArnDlI=;
        b=Ltm2C5H5zYqhhqmKWMCNgeQIXEFyKVuujI6Ns1llrchMytT3SON/hjPrp2t7lS1AFamNLoG5XH2/CojBX8idrDDuIb2fYKtaU2Fo/9CEPRx54/0moHVhG+AgSd/YYu/uBCXtHChc3s2+gn6tKPChnlTTaDNnOS85XI5GRK+Vgn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rt5ualWh2eeyIRsmn8q+udlxnntqfb6SoSo1mKitZIpnDLxs5FGDE8yCfmL1OU/IujMu+7G0+HMXOdFu2MvvEGgmj0fUVl2CLbGvo3yGCFDv5S6ztKC/EkSKs+TJnxhF/XfQoYQlSMs+hmyoNfLyOapEUG6BBkLcLeCBlEYNfic=
Received: by 10.82.162.14 with SMTP id k14mr4463230bue.32.1201297700164;
        Fri, 25 Jan 2008 13:48:20 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.250.186])
        by mx.google.com with ESMTPS id u14sm3573333gvf.1.2008.01.25.13.48.17
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Jan 2008 13:48:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LNX.1.00.0801251535380.13593@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71741>

Daniel Barkalow wrote:

> So, something like:
> 
> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index 81ac17f..f47b9e0 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -36,6 +36,29 @@ To sync with a local directory, you can use:
>  - file:///path/to/repo.git/
>  ===============================================================
>  
> +If there are a large number of similarly-named remote repositories and
> +you want to use a different format for them (such that the URLs you
> +use will be rewritten into URLs that work), you can create a
> +configuration section of the form:
> +
> +------------
> +	[host "<host>"]
> +		base = <actual url base>
> +		alias = <other url base>
> +------------
> +
> +In particular, if you need to use URLs like
> +git://git.host.xz/repo.git, and you're getting a lot of URLs like
> +host.xz:/path/to/repo.git/, or you'd like to use a URL like
> +"work:repo.git" you can use a section:
> +
> +------------
> +	[host "host.xz"]
> +		base = git://git.host.xz/
> +		alias = host.xz:/path/to/
> +		alias = work:
> +------------
> +

Could you _finish_ that documentation with finished example of command
line example, which gets its URL rewritten? It stops a bit suddenly.

-- 
Jakub Narebski
Poland
