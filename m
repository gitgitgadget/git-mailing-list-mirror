From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rev-parse --show-prefix: add in trailing newline
Date: Tue, 10 Apr 2012 12:36:16 -0500
Message-ID: <20120410173616.GA4300@burratino>
References: <1333978076-29968-1-git-send-email-rosslagerwall@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Ross Lagerwall <rosslagerwall@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 19:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHezt-0007hh-0v
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 19:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758123Ab2DJRg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 13:36:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62586 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758114Ab2DJRg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 13:36:27 -0400
Received: by iagz16 with SMTP id z16so51376iag.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WYqeoFGsfE254n3besDNRyifcLzI5HUgx6JNTQ1GJQc=;
        b=iyAqlw743a+NKNJYZR82ZbWDVoERCdBd+SM4k9WBanFoir7beevgzWpfz/6x098GFl
         c+hxkf2NhZkFtXx1I3u5Nt3SlTZ36be/YjLmhJceZPF/p8pfW5xKcvNIBx2CYWOv9QUs
         8dTlBf7EqpvqfGfhLHu2tZASGSYblsStyafdONWnUIiWgGeaiQo5pJonTML3CVUp2ITq
         YNLiWNz8RKU62B503ScJ3wljKURdS1zSlpf/a5VVkW304P70MGmpwxCT1UtPq1djSzkd
         P/RGAhMxnXCpi5O0mD0yExRX3/0uAmwd/MJiuK0zwUhvkROoNQwp6dGDHJkZV0ptj/b3
         JFUQ==
Received: by 10.50.47.230 with SMTP id g6mr3716334ign.74.1334079386865;
        Tue, 10 Apr 2012 10:36:26 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id m4sm42481151igw.1.2012.04.10.10.36.21
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 10:36:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1333978076-29968-1-git-send-email-rosslagerwall@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195109>

(cc-ing Duy)
Hi,

Ross Lagerwall wrote:

> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -634,6 +634,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  			if (!strcmp(arg, "--show-prefix")) {
>  				if (prefix)
>  					puts(prefix);
> +				else
> +					putchar('\n');
>  				continue;

This makes the output more consistent but it is a little puzzling how
it does that.  Why is prefix NULL instead of "" when we are at the
toplevel of the worktree?

Thanks,
Jonathan
