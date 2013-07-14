From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/6] Documentation: Update manpage for pre-commit hook
Date: Sun, 14 Jul 2013 11:51:04 -0700
Message-ID: <20130714185104.GB4381@google.com>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
 <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
 <1373818879-1698-5-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 20:51:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyRO6-0002tD-6o
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 20:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab3GNSvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 14:51:09 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:40149 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab3GNSvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 14:51:08 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so9999676pdj.40
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 11:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lZgLN/tE/2u7w4cuUNpfi2rUt61pE8nJB5CEPfjDIq0=;
        b=OYxpi0CGLVA6X1A3uEsNg5M5HE9VMdwq3yKDBVIHvmpgG78WWvUnxftyD7haPnNo95
         XUm6SLje7hH8YYdyoiUsg4uf+QgUFvz9TlUJBS/DRNMxRsfpSlR7sFR7aazHcaRdEeb6
         x95+K1/zP0Kjueib/ehB5wGidtV/8XwJ7Vid1Q27DMM+sOYCs6lFgsdKZMNpJzfRNC7K
         kGQtjvkpmtwJAVQ5jK/1LFZ9OqWzdZJgyCWN/GWmTxqs9pHOTZXx6l4EWMjCu2LbrABL
         qFfRYlq+Yn6rN9yISRvdP5yrKuxSwqHYkz7WDrJCVzCnuT2JlqPGA7EMf0ke2C1igRbh
         E5Jg==
X-Received: by 10.69.0.168 with SMTP id az8mr7426973pbd.51.1373827868150;
        Sun, 14 Jul 2013 11:51:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yj2sm56660616pbb.40.2013.07.14.11.51.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 11:51:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373818879-1698-5-git-send-email-richih.mailinglist@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230380>

Richard Hartmann wrote:

> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -80,7 +80,8 @@ causes the 'git commit' to abort.
>  
>  The default 'pre-commit' hook, when enabled, catches introduction
>  of lines with trailing whitespaces and aborts the commit when
> -such a line is found.
> +such a line is found. It will also prevent addition of non-ASCII
> +file names.

The tenses are inconsistent here ("catches" versus "will also").

It also seems odd to call the sample hooks "default" hooks, but that's
a wider problem and should probably be fixed by one commit all at once
(maybe imitating the wording of the prepare-commit-message
description).  Previously enabling them was a matter of a "chmod +x"
and the wording made more sense.

How about:

	The default 'pre-commit' hook, when enabled, prevents introduction
	of lines with trailing whitespace and prevents introduction of
	files with non-ASCII filenames unless the hooks.allowNonAscii
	configuration variable is true.
