From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] completion: __git_config_get_set_variables() handle values
 with spaces
Date: Wed, 01 Jul 2009 23:04:07 -0700
Message-ID: <4A4C4DD7.7030801@gmail.com>
References: <1246338518-9030-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 08:05:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMFPz-0003P1-3N
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 08:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbZGBGEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 02:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZGBGEa
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 02:04:30 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:37341 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbZGBGE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 02:04:29 -0400
Received: by pxi28 with SMTP id 28so1313575pxi.33
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 23:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=zyPGaCchr1Oa37sRkaPjMnsGZmHkgFH+hVWXFXd4xx4=;
        b=fy3OFBf8CJ9G0wVtJoCx4nm/bugrVcORmOBBeEKYBn5eqR59Inpj+iFppf5Qa4gDpv
         i0UBSD7jbf29fDQ0+lBN+56Qv0TVNYeLaeWALAkvY6G0slKDmCKaGaTwF6jaUA93agy+
         iKcjxyBwRFfUE7XNJQBUfc9fF+b6KbrqnRBaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=D739zec11vn0gpkMWFxl32KCoyFRkOV5jIC2ai1tTJ5lHC3Zl7oJ2QHr1TWgHdAwpx
         3Ud3Hv2HDViDR0WmUH4hFroW0/dtqLR1hJqK5NRAVBgZA2woLvdEyHO7z4AEnpdbvV/R
         s9B/tfrNsU+kXv2qzU9DcjTe1nj1zRH7rI8do=
Received: by 10.114.24.6 with SMTP id 6mr16562471wax.79.1246514650107;
        Wed, 01 Jul 2009 23:04:10 -0700 (PDT)
Received: from ?10.10.0.2? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id l28sm3509521waf.54.2009.07.01.23.04.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Jul 2009 23:04:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090629)
In-Reply-To: <1246338518-9030-1-git-send-email-bebarino@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122622>

Stephen Boyd wrote:
> For example
>
>  $ cat .git/config
>    format.cc = Junio C Hamano <gitster@pobox.com>
>   

Sorry this is inaccurate. Something more like
$ cat .git/config
[format]
        cc = Junio C Hamano <gitster@pobox.com>

would be correct, but I think you got the point.
