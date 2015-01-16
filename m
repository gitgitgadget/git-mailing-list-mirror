From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Proper plumbing for porcelain gpg formats on git show?
Date: Fri, 16 Jan 2015 11:29:47 -0800
Message-ID: <20150116192947.GD29365@google.com>
References: <EB979B4B153D49909C78239A333869FB@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Fri Jan 16 20:29:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCCai-0001V5-8X
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 20:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757159AbbAPT3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 14:29:51 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:53466 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480AbbAPT3u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 14:29:50 -0500
Received: by mail-ie0-f173.google.com with SMTP id ar1so141320iec.4
        for <git@vger.kernel.org>; Fri, 16 Jan 2015 11:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CaAf2tza3DDkaKLkW72b6tO8/NU4anKQ9U4zxpM7zOg=;
        b=ugIFM2pGZQf024xZ4xkGj8gY/oKCufOrDbG35YGdwfxIN6ZqJrdoR+sb42LtDMxjO3
         8NLn7YEe0IhtlAd36ayOFeg/5g3VZWMtWOjmxPUVG5JqMO1EGuVTzp0uieH+ue6Uam+N
         sLOYvA+LhO7JcUrQfBbN1VtUqB/eIj0u9SoUhlft49J4nUvSadEo+B6oN/hoqHsExmd6
         73EmxHsaAJsqdFr+xGwPH+VFm7+NoJpmkd5t7Oi1IQ1Bkxn4vHxU6BviDV+wzigC0hns
         HW6OTtxCBrOOrtI3qWtW96qI7AuQuc3KRCZmFIKCl4CR3r02JrLrNW6YhRwdE/bsWESC
         TfaQ==
X-Received: by 10.42.199.211 with SMTP id et19mr16799805icb.9.1421436590091;
        Fri, 16 Jan 2015 11:29:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:3039:952d:fad8:b5af])
        by mx.google.com with ESMTPSA id ao5sm1894105igc.3.2015.01.16.11.29.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Jan 2015 11:29:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <EB979B4B153D49909C78239A333869FB@black>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262563>

Hi,

Jason Pyeron wrote:

> COMMITID=ef8df950c8d16dace62e55d18b26617b1268f1bc; \
>  git show $COMMITID --pretty=format:%GK -s
>
> do the same thing.
>
> Is there a way to properly extract the GPG signature object, such
> that GPG operations may be done on it?
>
> Are the git log formats safe to use in scripts (asking because it
> was said not to use at
> http://git.661346.n2.nabble.com/show-pretty-B-without-a-diff-td5852061.html#a5853270)?

Better to use

	git diff-tree -s --always --format=%GK $COMMITID

[...]
> would there be interest in accepting a patch for 
>
> %Gs - the raw GPG text from the commit
> %Gf - the key fingerprint

There may be bikeshedding on the exact format specifier, but aside
from that I don't see why not. ;-)

Thanks,
Jonathan
