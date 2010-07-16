From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSOC 07/11] gitweb: Create Gitweb::RepoConfig module
Date: Fri, 16 Jul 2010 14:11:59 +0200
Message-ID: <201007161412.01931.jnareb@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com> <1279178951-23712-8-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 14:12:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZjm8-0004sS-Hs
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 14:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965277Ab0GPMMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 08:12:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57850 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965245Ab0GPMMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 08:12:14 -0400
Received: by bwz1 with SMTP id 1so1179255bwz.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 05:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=05awj6rU9h0IGnhkaqDLEUcSJTN+X33+zD5QzXA+oqM=;
        b=inWcUJyF6pHIt5gzuGENsmq4Jn1zWaGnAi+mzGCYQ2JDTrYRtIb5OnNWtcRMKvLr3F
         voEnjA6YkBBL16R6ZbZsoI8uSmffDsdrkLDF1Snj/Uv4ZAQxfNCJ99QLLPjwZlUJWMUP
         rUa7m4gT2OKlccCRis7rhiJad1D2ohggMkaPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=n4vbHDV/12xGPPZ5K+NhBPLQ71+bWBM6eFnlziyBTJpHVvxrhRSTFMEuwj42bEAoYf
         Ss/fvTG+JaQSh5wbs0oTlrxC0hxgFfR4Cd3tBLNxhovxPh+jHwVEtPtniUmBM3M/IDAg
         gUQmROJQDFnzcOmKfdakDqXtGTq22I5J7bGxo=
Received: by 10.204.6.75 with SMTP id 11mr884339bky.95.1279282332078;
        Fri, 16 Jul 2010 05:12:12 -0700 (PDT)
Received: from [192.168.1.13] (abvo176.neoplus.adsl.tpnet.pl [83.8.212.176])
        by mx.google.com with ESMTPS id a9sm10697113bky.11.2010.07.16.05.12.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Jul 2010 05:12:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279178951-23712-8-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151147>

On Thu, 15 Jul 2010, Pavan Kumar Sunkara wrote:

> Create a Gitweb::RepoConfig module in 'gitweb/lib/Gitweb/RepoConfig.pm'
> to store and handle all the configuration and subroutines
> related to a single repository regarding the gitweb.perl script.

The above sentence is hard to parse (hard to understand).  Please try
to be more clear.  I guess that you wanted to say that this module
is about checking repositories and repository parameters, and about
per-repository configuration.

> 
> This module depend on several other modules like Git.pm,
> Config.pm, Request.pm and Escape.pm.

Nitpick: the names of those modules are Gitweb::Git, Gitweb::Config,
Gitweb::Request and Gitweb::Escape.

> 
> It also include subroutines regarding project_list and
> it's handling.
> 
> Subroutines moved:
> 	check_head_link
> 	check_export_ok
> 	hash_set_multi
> 	git_parse_project_config
> 	config_to_bool
> 	config_to_int
> 	config_to_multi
> 	feature_bool
> 	feature_snapshot
> 	feature_patches
> 	feature_avatar
> 	git_get_project_config
> 	git_get_project_description
> 	git_get_project_ctags
> 	git_populate_project_tagcloud
> 	git_show_project_tagcloud
> 	git_get_project_url_list
> 	git_get_projects_list
> 	git_get_project_list_from_file
> 	git_get_project_owner
> 	get_file_owner
> 	project_in_list

In the future we might want to separate handling of per-repository
overriding of features in a separae module.

> 
> Update gitweb/Makefile to install Gitweb::RepoConfig module
> alongside gitweb
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

Other than those minor issues it seems all right.


P.S. I'm sorry, but I wouldn't be able to examine the rest of series
before this Sunday at earliest.

-- 
Jakub Narebski
Poland
