From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [BUG?] Fresh clone of jquery.git shows modifications?
Date: Wed, 18 Aug 2010 21:19:19 +0200
Message-ID: <200088BC-F39D-407B-97ED-A771AA05E89D@gmail.com>
References: <1282135226.24584.92.camel@wpalmer.simply-domain> <2F030CF4-995A-4BA2-9D79-DA2A71F9FF79@gmail.com> <1282140854.24584.112.camel@wpalmer.simply-domain> <AANLkTik8RGR4OTeZYsttyBtiywGU7Wtz3gQsTjoqAQPD@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 21:19:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OloAb-0003zv-3X
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 21:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab0HRTTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 15:19:24 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44705 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab0HRTTX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 15:19:23 -0400
Received: by ewy23 with SMTP id 23so665295ewy.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=XuGKHND18nRKkne3AZGrgSTwuElNW8wJITUvUklKC/A=;
        b=UXG4ZLAg25NCLOSe+FF1pcnyd09E9WPYaltYYXdPRLSdTj1aqsOOHcQAlvJ3/w3XK0
         KEm+cvhm8hOhp+9TAkQ2/R9GlubxCd2WnjMAvwon5v8qkbDqHOXMPN6pBdzVsgYnxbaC
         L8OFf48DjJBNmjFZq5On9KXpmrXNnIonD4ePM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=s4azAY+E8j53XJ+llHyDXY5c0p+TnitrEVGBYtNOThFIoGSqBDO+ChVurqaWYtJGaU
         8s4Y5udtEBA8s5DyCiZ88UAInnCb98vBqetKClw+E1htuq9oitbvRlhpiKSOtTBZKci4
         63bGb8rlLUYteDM9h1m+hmT1yObsoAyDQRTtc=
Received: by 10.213.105.194 with SMTP id u2mr2481798ebo.42.1282159162264;
        Wed, 18 Aug 2010 12:19:22 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id v8sm1059451eeh.2.2010.08.18.12.19.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 12:19:21 -0700 (PDT)
In-Reply-To: <AANLkTik8RGR4OTeZYsttyBtiywGU7Wtz3gQsTjoqAQPD@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153878>

On 18. aug. 2010, at 17.50, Thomas Berg wrote:

> Hi,
> 
> On Wed, 2010-08-18 at 15:18 +0200, Eyvind Bernhardsen wrote:
>> Git _is_ giving you a real pristine copy, it's just informing you that your repository is not consistent with the attributes you have set.
> 
> Marking the files as modified is sometimes a very user-unfriendly way
> of informing the user, at least if just want to work with something
> unrelated, and not actually fix those issues. Maybe there is a better
> way?

There may be, but I'm not sure it would be worth the effort.  The reason I started working on CRLF normalization in the first place was because I got tired of seeing spuriously modified files everywhere when using core.autocrlf, so I know how annoying it is.  The difference now is that only people using "mis-attributed" repositories are annoyed, instead of anyone who uses core.autocrlf, and as I wrote elsewhere, I don't expect there to be many repositories where this is a problem.

To be clear: triggering the problem not only requires that a crlf attribute is set to something other than "false", but also that the corresponding file actually contains CRs.

- Eyvind
