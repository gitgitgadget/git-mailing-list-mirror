From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 4/3] gitweb: Always call format_date with timezone parameter
Date: Sun, 20 Mar 2011 11:37:17 +0100
Message-ID: <201103201137.18619.jnareb@gmail.com>
References: <4f21902cf5f72b30a96465cf911d13aa@localhost> <b599dae39131b90d0970a1ef63e6599b@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 11:37:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1G13-0001cd-Si
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 11:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab1CTKhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 06:37:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35648 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab1CTKhe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 06:37:34 -0400
Received: by fxm17 with SMTP id 17so4778838fxm.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 03:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=42vNT9AFyDmyYEpIBRJPQDzu/m5ZhiOk+wmMq6A/ISg=;
        b=BrxbQwve3V4tGRYSU0MrdjhYjtNJeBdkkciTDuZ+Fbtw4DIqzadhgk/8sCyoA0w+Xv
         yPhr8U0B10bJGXlOr5tCo26lNXwMdUgMJWLYOV4fkFQ4G8bL0FKvTXXCmPAM0fF0nKmb
         pMhdFvUCePpaPKNoputtJCCbLgaZNQJSIG6go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WzsoQLjLUsiWmlGQgEqjHX1Gi5+vM9aI8k5Ibjwp96re4z8JbvCYdyVGw0D4q97Hza
         ir4DTuXWFG1GG+K/6fFGeAsUeKnd6zAaGaXwmRdTSSXEv93SBT2F1rtcdMWao1hf0Xxd
         lMgklunzQqhRbNxMbvpFA0+u+HpFyPCgkRgF0=
Received: by 10.223.126.130 with SMTP id c2mr3457660fas.39.1300617453605;
        Sun, 20 Mar 2011 03:37:33 -0700 (PDT)
Received: from [192.168.1.13] (abwj177.neoplus.adsl.tpnet.pl [83.8.233.177])
        by mx.google.com with ESMTPS id o17sm2030090fal.1.2011.03.20.03.37.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 03:37:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <b599dae39131b90d0970a1ef63e6599b@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169497>

On Sun, 20 Mar 2011, Kevin Cernekee wrote:
> From: Jakub Narebski <jnareb@gmail.com>
> 
> Make the timezone parameter mandatory.  This ensures that the *_local
> fields are always populated with accurate information.

That is better commit message that what I came with.
 
> Also, delete an unnecessary call to format_date().
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
> 
> v2: Fix typos.  Remove unnecessary call.

Thanks.

> Remove default "-0000" tz value.

Hmmm... I wonder if default value for timezone might have been intended
to handle case of malformed date, without timezone.

This fragment

        my $epoch = shift;
        my $tz = shift || "-0000";

is from very beginnings of gitweb... and "v042" is a bit uninformative
as a commit message.  991910a (v042, 2005-08-07).

> Rebase on top of my patch 3/3 (as applying -1/3 then 1/3 would create a
> merge conflict).

You are right, that is better solution.

-- 
Jakub Narebski
Poland
