From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 3 Aug 2010 15:19:09 +0200
Message-ID: <201008031519.11012.jnareb@gmail.com>
References: <i372v0$3np$1@dough.gmane.org> <201008031202.53804.jnareb@gmail.com> <20100803124831.GB11608@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 03 15:19:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgHOk-00046L-Ow
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 15:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135Ab0HCNS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 09:18:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45456 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083Ab0HCNS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 09:18:58 -0400
Received: by fxm14 with SMTP id 14so1975839fxm.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 06:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=srvMhmOuIF4F975wHGgF+X9CJPfoKQIqTOgwoWAxEa4=;
        b=AfY9yKL5JQrez/awBdYcpjYGDRKJAOZF+S3dTVVbwU1CaFkcpm+1O7cR8KYyELlaSv
         VFgHx0fOBcY2x8E0m4lkW1X/RSpL6a/5ZICB3JcHG9gxIFi1cZFCNGxo31zSMi1HTALd
         tZfzr1D6gk6IZ2SQhNogDB/AingCug7RoQffU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MXBNtvEZ5US/J0JzMmCgl6u9EcYHbwHluaBah0C3PrNcsXne5Xx3BRVfpUrm9Lq7tF
         c/438WX9mY4D+EnZmkdLJlvG2ro4zJOyLyIAXddCC4O3+6B++UWY4Ga4sEvxaYbXFrZz
         oSDkbjBKpLyGyQZmsAoiZ1j6tzyuzdU1fxjA0=
Received: by 10.223.115.200 with SMTP id j8mr7229656faq.107.1280841536841;
        Tue, 03 Aug 2010 06:18:56 -0700 (PDT)
Received: from [192.168.1.13] (abws244.neoplus.adsl.tpnet.pl [83.8.242.244])
        by mx.google.com with ESMTPS id y2sm2460871fau.12.2010.08.03.06.18.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 06:18:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100803124831.GB11608@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152515>

On Tue, 3 Aug 2010, Jeff King wrote:
> On Tue, Aug 03, 2010 at 12:02:52PM +0200, Jakub Narebski wrote:
> 
> > > Hmm, sizeof(time_t) == 8 for my x86_64 Fedora, but committing ancient
> > > times fails.
> > 
> > That's because git *porcelain* either does not use time_t consistently,
> > or has some sanity checks that are good heuristic for ordinary use (like
> > e.g. commit time not too far in past where git didn't even exists),
> > or both.
> > 
> > It is not a problem on lowest level, i.e. repository format and plumbing.
> > I was able to create a commit that had author time before Unix epoch 
> > using plumbing:
> 
> I am not sure there isn't some unportability at the lowest level. We
> freely interchange between time_t and unsigned long in the low-level
> date code. It probably happens to work because casting the bits back and
> forth between signed and unsigned types generally works, as long as you
> end up with the type that you want. But it isn't necessarily portable,
> and there can be subtle bugs. See, for example, my recent 9ba0f033.

Well, at least there is not a problem at lowest of low, i.e. repository
format level, thanks to the use of textual representation for epoch.

-- 
Jakub Narebski
Poland
