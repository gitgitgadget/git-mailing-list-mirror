From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] submodule: preserve all arguments exactly when
 recursing
Date: Tue, 2 Nov 2010 23:37:25 -0500
Message-ID: <20101103043725.GA10311@burratino>
References: <1288758882-77286-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Nov 03 05:37:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDV6e-0003nP-Ix
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 05:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab0KCEhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 00:37:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55790 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab0KCEhq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 00:37:46 -0400
Received: by gyh4 with SMTP id 4so176165gyh.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 21:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UFjQIIxbQrWRLbsrJB16rHpsvQ21zaK5ZZhXV0/uQks=;
        b=Vq4WUU+W6qEKS1G+e4J38UMrF5jyYAF1PUepIpQYrd9EDpFNUitVwbbS1Cdb0X3f75
         98XM+Mt/nI0P8ZFFGcAVxdf8+5r+uHyunSvKu++gABoibVD5cHz78qIVzoG49ib8gdna
         WQbAuGZThhrtcxgUvqHIna8I2Mrgwm05NL2+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HdJ+jLNy2YefTvfCYm14L06ZgCxy6HWQ+96MeZJ350Jxz8VF3sKGgUGWxEyjorNQHZ
         xKXzJqrlGXbtHsCBCKQkcp0QJ6VDN/p76/lAY7mNx4kiG58R2AEekRY3nR2Db3b/z5e9
         nDe0dxEmkA0ipKl8/bfXGEvMinb6xmj3GJFzo=
Received: by 10.91.10.27 with SMTP id n27mr326171agi.204.1288759065907;
        Tue, 02 Nov 2010 21:37:45 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id j26sm936477yha.36.2010.11.02.21.37.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 21:37:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288758882-77286-1-git-send-email-kevin@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160574>

Hi Kevin,

Kevin Ballard wrote:

>            It's also a reasonable model for how to handle this problem
> in other shell commands.

This caught my attention. :)

> +# Emit a quoted version of the all argument suitable for passing to `eval`
> +# $@ = words to quote
> +#
> +# This is intended to be used like the following:
> +#   orig_args="$(quote_words "$@")"
> +#   # do some work that includes calling shift
> +#   eval "set - $orig_args"
> +#   # now $@ has been restored, suitable for passing to another command
> +#
> +# Note that you cannot simply save off $@ into another variable because
> +# the shell gives $@ and $* special handling in parameter expansion
> +#
> +quote_words ()

Have you looked into "git rev-parse --sq-quote"?

Hope that helps,
Jonathan
