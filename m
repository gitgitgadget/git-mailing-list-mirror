From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: feature request - implement a "GIT_AUTHOR_EMAIL" equivalent, but
 processed BEFORE .gitconfig
Date: Fri, 30 May 2014 11:27:46 -0700
Message-ID: <20140530182746.GK12314@google.com>
References: <5388CBA5.9030403@neulinger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nathan Neulinger <nneul@neulinger.org>
X-From: git-owner@vger.kernel.org Fri May 30 20:27:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqRX0-0007JL-9R
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 20:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbaE3S1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 14:27:50 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:61304 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbaE3S1t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 14:27:49 -0400
Received: by mail-pd0-f176.google.com with SMTP id p10so1217992pdj.35
        for <git@vger.kernel.org>; Fri, 30 May 2014 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wSv/Y+zvoc7lVoHPBI57oI+NFVIeZPc41PZsTBpwuQY=;
        b=b1p4JofNseL6ddCxtgT7pican+qpHijm++k86Rb4nkcQt6Zlj4VqJ+djWYL5Xvf+wb
         1kc9H9muJeX69q9wAj6pGd5Pf6vyh1mImNkvQHJaYee4KWm/EbCF1hNuFl+WzDToJOnv
         FvTjlVtkzvV+XF2luc24WiBs15Eabc3GHO5oqm480pqk7A44Vr2VbWZJkMcQ2ElqEi9K
         h6hq3A3XoddjNgJsADJ82OG3MBwuJi4ibZz38B5CzuMa9iTburK33jX6bl3Ck8NDzjZs
         w35P12jEpxlb4hJdF5hz88r7KHbwoy0uZUYKvGvGJUsky9hBB+jgfths7ONT4q21A+Mq
         I+4w==
X-Received: by 10.68.99.194 with SMTP id es2mr20720118pbb.100.1401474469175;
        Fri, 30 May 2014 11:27:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id om6sm7537500pbc.43.2014.05.30.11.27.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 May 2014 11:27:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5388CBA5.9030403@neulinger.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250460>

Hi,

Nathan Neulinger wrote:

> Right now, there isn't any way to have a systemwide profile script
> that tries to determine a better default for the user name/email
> values, such as in the case of shared logins. The best I've been
> able to do for now is use the 'EMAIL' var.

I wouldn't mind having a GIT_EMAIL envvar with the semantics you mean,
but can you say more about the use case?  What's wrong with the usual
EMAIL environment variable?

[...]
> [include]
>    path = !/usr/local/bin/gen-git-env

This is scary in terms of privilege escalation attacks.  ("Admin,
could you please take a look at this repo?  When I run 'git status',
...".)

That said, smudge/clean filters may have the same problem already.

Thanks,
Jonathan
