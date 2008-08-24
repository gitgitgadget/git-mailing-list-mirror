From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5] gitweb: ref markers link to named shortlogs
Date: Mon, 25 Aug 2008 01:53:30 +0200
Message-ID: <200808250153.31697.jnareb@gmail.com>
References: <200808221501.54908.jnareb@gmail.com> <1219411786-14073-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 01:54:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXPPv-00085x-7u
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 01:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYHXXxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 19:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbYHXXxj
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 19:53:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:63453 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbYHXXxi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 19:53:38 -0400
Received: by nf-out-0910.google.com with SMTP id d3so620394nfc.21
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 16:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kcekgpNW/vqf+yUIvvIIP4H04RbnfQ1hnocWN9zJJq0=;
        b=FKRQQjCUf669HtFV+zXdS7rLT/v+jvzc6DlxRILbvo2z15FkArhGSLxIYWNd1U5Puy
         f8YC1WCfiTRUNEyZ8foSKWGZep2h628U1snLLMy3RuzwTJc/9Bkj5jR1fDAVA3RAB9ck
         y0MYnp1OWBhBaxlJUPGcbDHJIiAlu0D5TBTWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tCZYCJqfaV/KWrQet91ABUaMidrqsjXSePaaO65pZTsm57bZqPeTnU6+4ZslyjS7Po
         ppYDJTbftH6S2oYRjCVBG0erMtzaoLvstt7Ls6X54Msa+BmnYlOMHadnva+t4zYjXdPM
         aUdPUuU8TrlN74eSCfJraPGkPeQDfnpKkVQaU=
Received: by 10.210.27.20 with SMTP id a20mr5642779eba.157.1219622017268;
        Sun, 24 Aug 2008 16:53:37 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.185])
        by mx.google.com with ESMTPS id 3sm4334473eyi.5.2008.08.24.16.53.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 16:53:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1219411786-14073-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93577>

On Fri, 22 Aug 2008, Giuseppe Bilotta wrote:

> This patch turns ref markers for tags and heads into links to
> appropriate views for the ref name. For annotated tags, we link to the
> tag view, while shortlog is used for anything else.
> 
> Appropriate changes are made in the CSS to prevent ref markers from
> being annoyingly blue and underlined, unless hovered. A visual
> indication of the target view difference is also implemented by making
> annotated tags show up in italic.

Nice. I like it (read: Ack), with the following caveat

> +			$markers .= " <span class=\"$class\" title=\"$ref\">" .
> +				$cgi->a({-href => href(action=>( $indirect ? "tag" : "shortlog"), hash=>$ref)}, $name) .
> +				"</span>";

We strip leading "refs/" in git_get_references(), so $ref does not
contain it. I'm not sure of one has to use refs/heads/aaa and refs/tags/aaa
to distinguish between tag and head with the same name, or heads/aaa and
tags/aaa is enough.

Also, the above line is bit long.
-- 
Jakub Narebski
Poland
