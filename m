From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSOC 09/11] gitweb: Create Gitweb::Util module
Date: Sun, 18 Jul 2010 19:45:45 +0200
Message-ID: <201007181945.46117.jnareb@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com> <1279178951-23712-10-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 19:46:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaXwH-0006WT-Mv
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 19:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756795Ab0GRRpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 13:45:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45565 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756789Ab0GRRpx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 13:45:53 -0400
Received: by fxm14 with SMTP id 14so1810193fxm.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LvfLsMvzrCiwq+kXpRlhp3TBUfyz4oo4KuMUfIfcqyM=;
        b=t5PgDPA1GlvJQ6MSVqS3lGYWqvBfBFTquPYIHN8dY9bWUhsNUpK9cZaSgoZ0NmcQZ7
         cmPm4lyQc6s2rKXei7d+VDigr/QSsCV8wLEheau4edFcmlv+Rk+crRLNPXY76JwlmUWl
         etv1cCw/9qwchzWSjfcHZMTO/R+Q66jt3pRI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=F6uwwjVZoyIHVDmOnfw12KyJBSlifZPU+uSsQTKVHhrblzaPT/PhawHhkHjGhQnzrc
         3F1UWu6xAUG+vH/D8AC7qzHL2SwXQ+YORYnEuJ5ptlV08xxO6TzfVWuioNUPhjXYETO3
         bXtefHMxBa+5j09ZEsDa53JT57ZaSlRV3W63E=
Received: by 10.86.57.19 with SMTP id f19mr2070391fga.78.1279475151809;
        Sun, 18 Jul 2010 10:45:51 -0700 (PDT)
Received: from [192.168.1.13] (abwa30.neoplus.adsl.tpnet.pl [83.8.224.30])
        by mx.google.com with ESMTPS id y2sm1670742fau.12.2010.07.18.10.45.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 10:45:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279178951-23712-10-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151222>

On Thu, 15 Jul 2010, Pavan Kumar Sunkara wrote:

> Create Gitweb::Util module in 'gitweb/lib/Gitweb/Util.pm'
> to store the git utility subroutines related to gitweb.
> 
> This module include subroutines in various categories
> such as git utility subs invoking git commands, git
> utility subs accessing git repository, mimetype related
> subs and HTML output utility subs.

O.K. so the theme is small helper subroutines, isn't it?

> 
> Subroutines moved:
> 	git_get_head_hash
> 	git_get_full_hash
> 	git_get_short_hash
> 	git_get_hash
> 	git_get_type
> 	git_get_hash_by_path
> 	git_get_path_by_hash
> 	git_get_last_activity
> 	git_get_references
> 	git_get_rev_name_tags
> 	git_get_heads_list
> 	git_get_tags_list
> 	mimetype_guess_file
> 	mimetype_guess
> 	blob_mimetype
> 	blob_contenttype
> 	guess_file_syntax
> 	run_highlighter
> 	fill_from_file_info
> 	is_deleted
> 	is_patch_split

Just a question: shouldn't git_get_last_activity subroutine be in
Gitweb::RepoConfig module?  Or is Gitweb::RepoConfig only about "static"
properties of a repository?

>
> Update 'gitweb/Makefile' to install Gitweb::Util alongside gitweb.
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---

I have not checked the patch, but is should be mainly straightforward
code movement plus some boilerplate.

-- 
Jakub Narebski
Poland
