From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Switch from svn to git and modify repo completely
Date: Mon, 21 Nov 2011 01:02:47 -0600
Message-ID: <20111121070247.GA16708@elie.hsd1.il.comcast.net>
References: <4EC7E32A.9040903@fechner.net>
 <20111119225048.384189bc@zappedws>
 <4EC97D52.1010308@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexey Shumkin <alex.crezoff@gmail.com>
To: Matthias Fechner <idefix@fechner.net>
X-From: git-owner@vger.kernel.org Mon Nov 21 08:03:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSNuW-00017W-LQ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 08:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607Ab1KUHDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 02:03:07 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56925 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab1KUHDD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 02:03:03 -0500
Received: by ywt32 with SMTP id 32so4350932ywt.19
        for <git@vger.kernel.org>; Sun, 20 Nov 2011 23:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1C2euCtOK2vknvw50NFzZ0rCP2guQiAmLt2cjSFDB8E=;
        b=RNpoF/OL9meJbOUdtttbcd0g1XxqUiERN4zMYf6InwpCvv0iHcLCWqb0q8U0cF2VgW
         GuRP9qDdiGZuLdV3daEu6uNDt81BxAcTVequZSFYr64C3V93+OWzfpSdNK8ChY9i23k9
         dCjsmy6BXs3YW6+PzQ70LrCN9nQ+r7ccCEVhY=
Received: by 10.236.179.2 with SMTP id g2mr17260007yhm.27.1321858983394;
        Sun, 20 Nov 2011 23:03:03 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 22sm26938295anp.12.2011.11.20.23.03.01
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Nov 2011 23:03:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4EC97D52.1010308@fechner.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185732>

(re-populating cc list)
Hi Matthias,

Matthias Fechner wrote:

> git told me:
> Ref 'refs/heads/master' was rewritten
> Ref 'refs/remotes/origin/master' was rewritten
> WARNING: Ref 'refs/remotes/origin/master' is unchanged
>
> 3. I cloned the repository with:
> git clone --no-hardlinks repo-orig.git repo-filtered.git
>
> 4. After this I verified in the repo-filtered.git that the file was
> really completely removed, but it was not the case.

The section "CHECKLIST FOR SHRINKING A REPOSITORY" from the
git-filter-branch(1) manual page has some hints.  In particular, "git
clone --no-hardlinks" still _copies_ all objects --- you probably
would want "git clone file://$(pwd)/repo-orig" to make sure the
ordinary transfer negotiation kicks in.

It's very important that the documentation not be misleading, so if
you can point to places where the wording can be less confusing, that
would be very welcome.

Thanks and hope that helps,
Jonathan
