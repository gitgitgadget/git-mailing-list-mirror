From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] compat: Add another rudimentary poll() emulation
Date: Mon, 31 May 2010 07:46:15 -0500
Message-ID: <20100531124615.GA2864@progeny.tock>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
 <1274948384-167-2-git-send-email-abcd@gentoo.org>
 <20100527101043.GA4390@progeny.tock>
 <AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
 <AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
 <20100530003718.GA27024@progeny.tock>
 <AANLkTinNHDZD-9uQjWr8N97tgP1SP9angXlXMUUc673x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Jonathan Callen <abcd@gentoo.org>,
	git@vger.kernel.org, mduft@gentoo.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>,
	Marko Kreen <markokr@gmail.com>
To: Albert Dvornik <dvornik+git@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 14:46:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ4O0-0000br-Ql
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 14:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066Ab0EaMq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 08:46:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52120 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab0EaMq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 08:46:26 -0400
Received: by iwn6 with SMTP id 6so482469iwn.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3ew1vrHUVtMQlCw/imVWEdyQQUSMT7dd0lpxHgWJSLA=;
        b=xC02iu1GthQcFlgi36x00h3A2uvmg72NgT/+PwYEunUSyk6Sxg3o/k/dZUDxYanqrE
         9o2MoVKSwaEol4Y5Yl9edSUaxmw63QHFBzL2l2OAlpWjhIHQQuzTX1kHs+7zdjiH0yvG
         W/ce57eM/JwX+PWA7j6tzlGAZY3dpTt6dSgxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sQv1enddhuTOp0HD3UMBB23Te071d8ZN1HStshByEfgD5c0cgYxroygMckhQYLI7Uo
         +JzhEk85/kTfYZBvj7twt8WVI3ZbP7QsyTXEl8rOfC/CsG7JVZn9sjxTjJOs7qfmyUue
         nU9UWcBHvtjnbRecv+29oBkbilfRggOUNq2/c=
Received: by 10.231.169.145 with SMTP id z17mr5806386iby.3.1275309984664;
        Mon, 31 May 2010 05:46:24 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm26122710ibl.10.2010.05.31.05.46.22
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 31 May 2010 05:46:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinNHDZD-9uQjWr8N97tgP1SP9angXlXMUUc673x@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148042>

Albert Dvornik wrote:

> For the general case, you'd want
>        tv.tv_sec = timeout / 1000;
>        tv.tv_usec = 1000 * (timeout % 1000);

Thanks for the catch.  Actually, it is not so unlikely that someone
would ask the autocorrect to wait longer than a second.

On Linux this is not an issue, but maybe Interix cares.  Posix is
vague and only says "the timeout period is given in seconds and
microseconds", staying silent on what the range of valid values is.

Jonathan
