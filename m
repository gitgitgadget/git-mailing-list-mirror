From: Pazu <pazu@pazu.com.br>
Subject: Re: git-rm'ing all dead files
Date: Wed, 24 Jan 2007 14:51:24 -0200
Message-ID: <9e7ab7380701240851u1249b46ch36450fcf91bf7986@mail.gmail.com>
References: <loom.20070124T171435-429@post.gmane.org>
	 <Pine.LNX.4.63.0701241723560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 24 17:51:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9lLP-0004cN-Kv
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 17:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbXAXQv1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 11:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbXAXQv1
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 11:51:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:3332 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbXAXQv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 11:51:26 -0500
Received: by nf-out-0910.google.com with SMTP id o25so625648nfa
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 08:51:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=qnNIQ2XkFGhrQydp5o69jch8U1/ktjLddqJ2cF9xdG0a93nngLQjaPF7T10l3/Y4O1gddylla68+V7ojnTxJ4iNVII76DbUA+GmpOCHCY96zBfF7aRv+ogcASOeF6f/T/gdad97jxvkvJdxKCDEM4GWkaSZeWR54As8TT4A1meA=
Received: by 10.49.28.3 with SMTP id f3mr3041824nfj.1169657484922;
        Wed, 24 Jan 2007 08:51:24 -0800 (PST)
Received: by 10.48.216.13 with HTTP; Wed, 24 Jan 2007 08:51:24 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0701241723560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Google-Sender-Auth: 2b5363456eeade36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37654>

2007/1/24, Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> How about
>
>         git ls-files -z --deleted | git update-index -z --remove --stdin

Aha. I was trying

    git-ls-files -d | xargs git rm --cached

but most removed files contains spaces in their names, and that
screwed git-rm up. I've even noticed the -z option on git-ls-files,
but couldn't find one on git-rm, and I completely forgot about
git-update-index.

Thanks, Johannes. This should do the trick.

-- Pazu
