From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: non-empty index with git commit -a
Date: Tue, 15 Feb 2011 21:20:47 -0600
Message-ID: <20110216032047.GA2858@elie>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 04:22:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpXyW-0007b6-I9
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 04:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008Ab1BPDWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 22:22:38 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59651 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750Ab1BPDWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 22:22:36 -0500
Received: by qwa26 with SMTP id 26so796100qwa.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 19:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=C0w1fC7ZPxHdzJ2H0rLbMw9D0vm+NZnD25Dvp1gXCbw=;
        b=qI6qazNSG9NuZw2KiiZCk5dQAK6yMaE8wgVTNdT5WtdfcntKXnYnybcmisYdwSPj7v
         ysf09+x0aspc65DqsK9e5JRGpo7vK0LAiyCkKXUYG/y5kiOefFIFKg17L6PiseYHgotH
         GIHjbxkQjiPSLoBv7EvHrojCQRwLG1mcIUzn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aSHNyN+DRiEGE6TKmHs6DKNdFU5ntwqpym23aeX3e4LBoYT2pE3gdromVBtJL2O8hB
         gffeDvTgo2pI6kW+GnneHKpOEtpP86Nho6bFU9PfhjOD5SVJ86SiTfoafgQTQwZfcRQu
         /ZhuQZXgKC50kiUpqP8G7g8AQcnUm3Bi6pLhs=
Received: by 10.229.91.211 with SMTP id o19mr42631qcm.286.1297826454907;
        Tue, 15 Feb 2011 19:20:54 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id t7sm3202700qcs.4.2011.02.15.19.20.52
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 19:20:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110216023645.GA7085@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166919>

Jeff King wrote:
> On Tue, Feb 15, 2011 at 10:43:53PM +0000, Sverre Rabbelier wrote:

>> Can we please fix this?
>>
>> $ hack hack hack
>> $ git add -p # carefully add my changes
>> $ git commit -am "Add feature foo"
>> $ DAAAMN YOUUU FINGERS!!
>>
>> I remember bringing this up before, but I can't remember what the
>> discussion ended up coming to.
>
> How do you differentiate this from:
>
>   $ hack hack hack
>   $ git add -p ;# carefully add my changes
>   $ hack hack hack
>   $ git diff ;# ok, everything looks good
>   $ git commit -am "Add feature foo"
>
> ?

If I remember the discussion[1] correctly, by requiring a separate
add -u step (or commit -f -a) if the "I don't trust my fingers"
configuration is enabled.

[1] http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/698001/focus=145662
