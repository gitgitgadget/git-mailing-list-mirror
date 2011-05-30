From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Non-error messages appears in STDERR
Date: Mon, 30 May 2011 15:29:42 -0500
Message-ID: <20110530202942.GA14913@elie>
References: <86adad09-bba9-4415-834c-c004071fd9c2@l14g2000pro.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Pok Man Lau <pokman.pml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 22:29:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR964-0002M6-0R
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 22:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906Ab1E3U3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 16:29:51 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60476 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab1E3U3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 16:29:50 -0400
Received: by gxk21 with SMTP id 21so1530672gxk.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=AtR0kfZfj8Tjgg4p+eE+4L2gvm9eELv/VhYMyknOmXU=;
        b=jtkrlCN9hqZWjHKR34E6z230iWRWqpVZ4N4New/PD6UqGlzMfnNObYEnyPvhp9BxkU
         kLO4eVWcz/WjxC3t2UAYWpKbdBl87NUjbQTDZkzYXqMiidHV/9PaDhE7d1s1usHDaXJD
         fAXt4T6+riZr/vUCC7UXY7j5KBhWrAT5YhqgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pgAt1iHFyz/QQsbsnCB/tc6ozgSza4DqIyAhET6drmbto6MvHmOlLAZXwGgxlYxUhS
         rit3Y1fqjfEhS9+yVtB/hJWJUM2A2lO1l6/ryheyO5gmMTRHO7jqAdG0XQq3DxJDBV0l
         S8Bacl9zSioK62sj111XU+8GQPLR220KTH6o0=
Received: by 10.150.240.6 with SMTP id n6mr1630565ybh.397.1306787390120;
        Mon, 30 May 2011 13:29:50 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.ameritech.net [69.209.65.98])
        by mx.google.com with ESMTPS id s9sm854249ybm.23.2011.05.30.13.29.48
        (version=SSLv3 cipher=OTHER);
        Mon, 30 May 2011 13:29:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <86adad09-bba9-4415-834c-c004071fd9c2@l14g2000pro.googlegroups.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174777>

Hi,

Pok Man Lau wrote:

> I am writing a class library to wrap bin\git.exe and trying to be a
> bit more accurate on error handling. Here are something interesting I
> found so far with git version 1.7.2.3.msysgit.0
>
> Some of the command output returned by git.exe appeared to be STDERR
> instead of STDOUT even they are not error message.
>
> For example:
> checkout <branch_name>
>
> I would expected the message "Switched to branch '<branch_name>'" to
> be a STDOUT, but it appears to be STDERR.

Yes, generally speaking the intent is the "result" or output that
could be conceivably parsed will go to stdout, while progress
information goes to stderr.

I think it would make sense to document this somewhere, e.g., in the
"git help cli" text.  Do you think that's the right place?  Any ideas
for wording?

Thanks much,
Jonathan
