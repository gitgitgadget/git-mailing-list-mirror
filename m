From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Handle invalid regexp in regexp search
Date: Wed, 29 Feb 2012 16:56:35 +0100
Message-ID: <201202291656.36222.jnareb@gmail.com>
References: <20120228183919.26435.86795.stgit@localhost.localdomain> <7vwr76yc6w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 16:56:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2ltX-0004rZ-Ox
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 16:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169Ab2B2P4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 10:56:40 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52027 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884Ab2B2P4j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 10:56:39 -0500
Received: by eaaq12 with SMTP id q12so297309eaa.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 07:56:37 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.28.75 as permitted sender) client-ip=10.14.28.75;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.28.75 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.28.75])
        by 10.14.28.75 with SMTP id f51mr443256eea.118.1330530997731 (num_hops = 1);
        Wed, 29 Feb 2012 07:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=zTlTwASHI7of61qamBfoSuvQ5nz6Jbd3OerzvhXhapM=;
        b=TPhlgAIYwcSDJWyMOuTKnZwm91C6twCNrN66l6wI0yykLoYtiw/8F++WkpK8qJWQWc
         AyFOU1awLuRbNX8dwLH8CkzG8LpVrtipmO9nXH9pZ2LjduKVSplPMRDZHCKnouboWhbB
         Ap4nRSxt1FunN/Ccdcp67uhzqtjLZlNgRUJWw=
Received: by 10.14.28.75 with SMTP id f51mr354203eea.118.1330530997620;
        Wed, 29 Feb 2012 07:56:37 -0800 (PST)
Received: from [192.168.1.13] (abwl41.neoplus.adsl.tpnet.pl. [83.8.235.41])
        by mx.google.com with ESMTPS id n17sm84195463eei.3.2012.02.29.07.56.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 07:56:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwr76yc6w.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191834>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > When using regexp search ('sr' parameter / $search_use_regexp variable
> > is true), check first that regexp is valid.
> 
> Thanks.
> 
> How old is this bug?  Should it go to older maitenance tracks like 1.7.6?

>From what I examined this bug is from the very beginning when gitweb
started to distinguish regexp search and fixed string search in

  0e55991 (gitweb: Clearly distinguish regexp / exact match searches, 2008-02-26)

It was present in 1.5.5 (including beginnings of match highlighting, which
trigger this bug).


This bug was present so long without detection because circumstances must
be quite specific: you have to select regexp search, and to provide invalid
regexp.  If you know what regexp is, you probably write correct ones...
but there always room for mistake.

-- 
Jakub Narebski
Poland
