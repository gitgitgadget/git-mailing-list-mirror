From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 2/2 v2] git-gui - provide commit base to the hooks/pre-commit
 script
Date: Mon, 21 Jun 2010 21:07:57 -0400
Message-ID: <4C200CED.7090402@gmail.com>
References: <1275965763-18940-1-git-send-email-mlevedahl@gmail.com> <1275965763-18940-2-git-send-email-mlevedahl@gmail.com> <4C1C3288.5000308@gmail.com> <7vvd9drnn4.fsf@alter.siamese.dyndns.org> <20100621050012.GA13043@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jsixt@viscovery.net, spearce@spearce.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 22 03:08:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQryD-0007ax-GE
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 03:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758734Ab0FVBID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 21:08:03 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59581 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758708Ab0FVBIA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 21:08:00 -0400
Received: by vws9 with SMTP id 9so206443vws.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 18:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=u0HNP1WzfbYNBoVAgrJQFTQS7x6wE3uu6xASbz80q6o=;
        b=GFs6zMH4FPk33S+EIwHoilRQKeXkZpxp+dQ26X2Ix1iQnMlB2yxFJ+ggqxTioL+qzz
         SmS49T1gqMb1I4CKtKtIbS5FToK5sfTLZb6wTQL0xL5CAVIDsAjPHavu21lIe7pvAYW4
         EYHrtwJ+6Ty918rPYsc5nj2g6phZEohwXZ4bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=sF6PFe+dUmDJtIoEZvNCQ7lstLNDZo6vWq9HuSR9MwFlPkWXwvMmRRFDLcGfsBReV4
         JdZffXGbOe3EV8AVUcYHpNF14QVwu/lmgbUuPhIo+r+iiKZtg6fwYlJbY40StGEN+n8g
         yLQnGu0woC76yv6LcoHakWPMby+RHkTlG+gmM=
Received: by 10.220.62.206 with SMTP id y14mr2607933vch.241.1277168879375;
        Mon, 21 Jun 2010 18:07:59 -0700 (PDT)
Received: from mark-laptop.lan (pool-71-191-167-79.washdc.fios.verizon.net [71.191.167.79])
        by mx.google.com with ESMTPS id n1sm15181580vcf.40.2010.06.21.18.07.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 18:07:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
In-Reply-To: <20100621050012.GA13043@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149462>

On 06/21/2010 01:00 AM, Jeff King wrote:
> On Sun, Jun 20, 2010 at 09:54:39PM -0700, Junio C Hamano wrote:
>
>    
>> I generally take absense of responses as absense of interest and/or
>> support, not absense of objection.
>>
>> For this particular patch, I am mostly indifferent (i.e. no objection, but
>> no strong support neither).
>>      
> Ditto. I don't personally have a use, but all of my concerns were
> answered.
>
> -Peff
>    
Well, I have a use else I wouldn't have written this :^).

Absent this patch, the default commit hook is always computing a diff 
against HEAD and that is wrong when amending a commit. Folks may not 
care, but that is an error so this patch fixes an existing bug. I'll 
leave it at that.

Mark
