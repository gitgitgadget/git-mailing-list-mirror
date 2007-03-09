From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in
 bundle
Date: Thu, 08 Mar 2007 22:17:07 -0500
Message-ID: <45F0D1B3.9020204@gmail.com>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 09 04:17:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPVbT-0005Ew-EO
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 04:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992914AbXCIDRH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 22:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992917AbXCIDRH
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 22:17:07 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:23041 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992914AbXCIDRE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 22:17:04 -0500
Received: by an-out-0708.google.com with SMTP id b33so667347ana
        for <git@vger.kernel.org>; Thu, 08 Mar 2007 19:17:03 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SBbyC9fH+XEQKCIIr9U8WuIhImmkJUnse2vbqw/f6x2SIfLL7H6/gjEIN8CBVrKqi+j11B1QyhVKAZVlMmx16IQTr/+L+bYzK9BMWDaS43cjqaiwttVQ7pD7JB3bgNga/DiJAtPHIf0Asr30G2ECnMJTJigNTL61Mr+kB4rZWOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AV3kwArGdoI7GPB0BnoAv3/2jM5q/pysUrtDW7Q9l+uFeDT1Qy36xI5Cm6N6+gWFRC7xnDRr5NdHYETE/iPfwuKJ4qeMOBX7k9peiLR23u+ms4wYFXXSbd9NrCkg2PJJwkdWqYGGzQd3D4OSiYWAx7WrmGqfVuvXmncrAS3QPas=
Received: by 10.100.10.20 with SMTP id 20mr908376anj.1173410223847;
        Thu, 08 Mar 2007 19:17:03 -0800 (PST)
Received: from ?10.1.5.213? ( [206.166.206.34])
        by mx.google.com with ESMTP id c13sm4317238anc.2007.03.08.19.17.02;
        Thu, 08 Mar 2007 19:17:03 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41785>

Johannes Schindelin wrote:
> The earlier patch tried to be nice by just warning, but it seems
> more likely that the user wants to adjust the parameters.
>
> Also, it prevents a bundle containing _all_ revisions in the case
> when the user only gave one ref, but also rev-list options which
> excluded the ref.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
>   
This patch makes git-bundle greatly complicates one of my primary uses: 
a nightly update generated and emailed to other users. With this, I need 
to write code to separately explore each branch in the repository to 
find what changed, then include only those. Without, I can just do git 
bundle ... <list of refs> and those which have been updated get included.

So, I would really like an option to error out only if the bundle would 
be empty.

Mark
