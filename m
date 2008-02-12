From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email:  checks for gitweb.description
Date: Tue, 12 Feb 2008 00:17:57 -0800 (PST)
Message-ID: <m3wspad1xd.fsf@localhost.localdomain>
References: <1202786746-12890-1-git-send-email-ribas@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Bruno Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Tue Feb 12 09:18:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOqLd-0002CA-Si
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 09:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbYBLISD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 03:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbYBLISB
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 03:18:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:8434 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbYBLISA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 03:18:00 -0500
Received: by ug-out-1314.google.com with SMTP id z38so443588ugc.16
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 00:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=Jyv8FojhkS689bi7JDfFN0E6anV2A41zaLcyQDqdQDk=;
        b=JUG1l3jgBZCjv4wN9lJtADK2DGXkWXuIs6EzdStP6qrU/eBHRoqWMlVg5P9nPBwnoHfdNPPs1ZuIGmcnDizSW2dCODORFA4Fvl+yp/sqsf13mx/iNKoiTTEa13yj33ZyeqWyhz2SqMHMPzP7rzWmVJpkm+ioWxV62SBPYTLvzq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=rWe0oMDLfK3vkDga6aaqBPhnpRu10tyceFZt6rxcfh3BUvhHedRaiQf+jXIEwhfXqyYP+ykRV7nXeJE97Wr10JftjoOtPcZQbL0nYhKq6a6IN80wX9ThaiZGGnil/CaOdLLSUQJ6JTx6xkDaiBls7ntudAhboRPKSF1zL5kxAXs=
Received: by 10.67.122.10 with SMTP id z10mr268655ugm.44.1202804278804;
        Tue, 12 Feb 2008 00:17:58 -0800 (PST)
Received: from localhost.localdomain ( [83.8.220.23])
        by mx.google.com with ESMTPS id u1sm9290543uge.14.2008.02.12.00.17.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Feb 2008 00:17:57 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1C8HOHd022832;
	Tue, 12 Feb 2008 09:17:34 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1C8H2lH022828;
	Tue, 12 Feb 2008 09:17:02 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1202786746-12890-1-git-send-email-ribas@c3sl.ufpr.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73636>

Bruno Ribas <ribas@c3sl.ufpr.br> writes:

> -projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
> +if [ -f "$GIT_DIR/description" ]; then
> +	projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
> +else
> +	projectdesc=$(git-config gitweb.description)

  +	projectdesc=$(git config gitweb.description)

> +fi
>  # Check if the description is unchanged from it's default, and shorten it to
>  # a more manageable length if it is
>  if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
> -- 
> 1.5.4.24.gce08d

(but this can be fixed when applying).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
