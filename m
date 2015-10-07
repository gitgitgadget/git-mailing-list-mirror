From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] log: Update log.follow doc and add to config.txt
Date: Tue, 06 Oct 2015 21:20:16 -0400
Organization: Twitter
Message-ID: <1444180816.7739.65.camel@twopensource.com>
References: <1444180473-8518-1-git-send-email-ericvw@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Eric N. Vander Weele" <ericvw@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 03:20:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjdP6-0001bl-EO
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 03:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbbJGBUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 21:20:20 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35359 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbbJGBUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 21:20:19 -0400
Received: by qkap81 with SMTP id p81so1227733qka.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 18:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=vsH4PVBZtMqHGeYSW5MpZlavzi/SPsN7jYU6YpQZqxk=;
        b=Fuvw7UhaYnsB3WVET41NYTTSFiB0ooFHG+AJt26Cjo80ya/wMBlhB8LNUfk3u6gGRY
         wbWdOBPX2CrA9lOFWiWcTwJYOQK5LyWzBcSB9eblZMozoMaDzV8u+Vvy/cOw2DBX5hlB
         xoFtFhJvSZV8uGBhtz8m8c3XE3+geyW++WytsPa2UiLr3S7GVE5Fs50ZKNxtfwTyfXh5
         VNrKWZVoSlKlpsUHIqlSg7VIIlY94X8hJ73Hz4iH/Dyw5H5attZdT8H7CDgyAUgcIl4A
         nqz/j1Y1NhAhUYpRE8/AhG+BXnXM7n4zVcjlPmXSvw/qTZk1HmoLinW0gm3tj4J1lk+s
         Hbjw==
X-Gm-Message-State: ALoCoQlgzOjrU1tBp7frVNJPl80dNhU0UsjIBXHxTjazMouK22NISEBrE8y3z2I6TkxatB5KsWeK
X-Received: by 10.55.33.35 with SMTP id h35mr40472784qkh.71.1444180819006;
        Tue, 06 Oct 2015 18:20:19 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 105sm1506335qgl.13.2015.10.06.18.20.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2015 18:20:18 -0700 (PDT)
In-Reply-To: <1444180473-8518-1-git-send-email-ericvw@gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279170>

On Tue, 2015-10-06 at 21:14 -0400, Eric N. Vander Weele wrote:
> Documentation/config.txt does not include the documentation for
> log.follow that is in Documentation/git-log.txt.  This commit adds the
> log.follow documentation to config.txt and also updates the wording to
> be consistent with the format that is followed by other boolean
> configuration variables.
> 
> Signed-off-by: Eric N. Vander Weele <ericvw@gmail.com>
> ---
>  Documentation/config.txt  | 6 ++++++
>  Documentation/git-log.txt | 8 ++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4d3cb10..391a0c3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1838,6 +1838,12 @@ log.decorate::
>  	specified, the full ref name (including prefix) will be printed.
>  	This is the same as the log commands '--decorate' option.
>  
> +log.follow::
> +	If `true`, `git log` will act as if the `--follow` option was used when
> +	a single <path> is given.  This has the same limitations as `--follow`,
> +	i.e. it cannot be used to follow multiple files and does not work well
> +	on non-linear history.
> +
>  log.showRoot::
>  	If true, the initial commit will be shown as a big creation event.
>  	This is equivalent to a diff against an empty tree.
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 97b9993..03f9580 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -185,10 +185,10 @@ log.date::
>  	dates like `Sat May 8 19:35:34 2010 -0500`.
>  
>  log.follow::
> -	If a single <path> is given to git log, it will act as
> -	if the `--follow` option was also used.  This has the same
> -	limitations as `--follow`, i.e. it cannot be used to follow
> -	multiple files and does not work well on non-linear history.
> +	If `true`, `git log` will act as if the `--follow` option was used when
> +	a single <path> is given.  This has the same limitations as `--follow`,
> +	i.e. it cannot be used to follow multiple files and does not work well
> +	on non-linear history.
>  
>  log.showRoot::
>  	If `false`, `git log` and related commands will not treat the


LGTM.
