From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge-recursive: option to specify rename threshold
Date: Mon, 27 Sep 2010 18:53:55 -0500
Message-ID: <20100927235355.GG11957@burratino>
References: <A0604F16-CA84-4A84-B74B-CE8AB455DF77@sb.org>
 <1285202724-52474-1-git-send-email-kevin@sb.org>
 <7vk4m7n7uo.fsf@alter.siamese.dyndns.org>
 <D5046A0E-7A35-421D-856F-5278FBE02914@sb.org>
 <7vocbj3gjk.fsf@alter.siamese.dyndns.org>
 <FFDB2371-6C96-472C-A650-412546636450@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Sep 28 01:57:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0NZ6-0002FI-As
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 01:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726Ab0I0X4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 19:56:55 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56654 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757470Ab0I0X4y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 19:56:54 -0400
Received: by qyk33 with SMTP id 33so8534624qyk.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 16:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8NAQ6VVDLskEHupmWQHLJC+rmqbayup1niahxYo+2g4=;
        b=KzzfwRq9Z39Gc7k3UPNo7xsmCV6tZmTNc0kGiklPwKDxw/v+ckVlYNMyfQG1asQZQC
         DfssYijoB9Qv6ml9VSxz2zdq74X8QUd7ZJuPaqSUnnqjtxDJsG6eGqf7fGM+o+/WIroZ
         54g3x/Zxklkp/8fRBI0tvh3aq888pIR7d+eRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OZhGqC/OISgFXkSCRS9+tRLtpLMrFgm5FTkJ7Y4ZgHywKupcZr+sTvl/WOzOizIn/q
         IHTHrtaE564+sp7UAGojUtBoUCrM5PWayjiTr5L2YUhuvkwML1rYaqZaa2BTLByia2CN
         TN0jq/96JhYqW+QSgtezfg/NM1Lpg7RmxI6Ss=
Received: by 10.224.10.211 with SMTP id q19mr6064726qaq.227.1285631813503;
        Mon, 27 Sep 2010 16:56:53 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u2sm1764230vcr.32.2010.09.27.16.56.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 16:56:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <FFDB2371-6C96-472C-A650-412546636450@sb.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157376>

Kevin Ballard wrote:

> After taking a look at this, it raises another question. -B, -M, and
> -C all have optional arguments, but the long-form names don't seem
> to support that.
[...]
>                       if I make it support `git diff
> --rename-threshold foo` that would also work, but the name doesn't
> seem appropriate without the argument.

Right --- with merge-recursive the argument doesn't need to be
optional, but with git diff it does.

How about

	--detect-renames=<threshold>
	--detect-copies=<threshold>
	--detect-rewrites=<threshold>/<threshold>

?

Ciao,
Jonathan
