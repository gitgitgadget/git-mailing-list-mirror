From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Paginate project list
Date: Sun, 11 May 2008 00:32:37 +0200
Message-ID: <200805110032.39729.jnareb@gmail.com>
References: <200805011220.58871.jnareb@gmail.com> <200805101128.59313.jnareb@gmail.com> <1210444108.11526.139.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sun May 11 00:33:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuxdN-0001w3-4b
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 00:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbYEJWcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 18:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754652AbYEJWcv
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 18:32:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:32904 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbYEJWcu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 18:32:50 -0400
Received: by ug-out-1314.google.com with SMTP id h2so428884ugf.16
        for <git@vger.kernel.org>; Sat, 10 May 2008 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=V5j6XMGLsw6UMEEvHxqTTzxUbD1QSTcH1n2/vuafwRE=;
        b=AMk2E7h5nEx/+6j0VOy0gUFRParoUp4X9QGc8SpnFje2VwMqJf9jzNulif8dRMaFqixt0eoN+coCxP4RECnDwqvxCY/KoHpfZdc6tzNwo9idrimWUdnuY7pHw+qDcDZdCS5GTaMLqf5FwV6o85ggZFj/ZELQRt274qR4cBv2940=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZqpF468UVF3bQVOFisBZHXh/NP7DWXtw9zduwWFT4FDGsGIdgMowOfAOJFD7B/UpUIeA0R3MYu6EW5yV+Pb5HxEaGuU0YGHT66fGR+KpNngjaw96/AW4vOyh614DpiSib4rctVwG2fxIFBkLEJGdxZmd8L9tAkOWhgYvIWtxk+0=
Received: by 10.66.221.5 with SMTP id t5mr3132562ugg.83.1210458768763;
        Sat, 10 May 2008 15:32:48 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.226.146])
        by mx.google.com with ESMTPS id b35sm6611932ugd.51.2008.05.10.15.32.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 10 May 2008 15:32:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1210444108.11526.139.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81709>

On Sun, 10 May 2008, J.H. <warthog19@eaglescrag.net> wrote:

> $page_size should be moved to a configuration directive, with a possible
> default of 100, and there should be an option to turn it off completely
> (I.E. kernel.org will likely have it turned off).

If it would be configurable (and I agree that it is probably a good
idea), it should be per gitweb instance (i.e. global variable), and
should perhaps be named $project_list_page_size to distinguish it from
number of items shown (page size) for 'shortlog', 'log' and 'history'
views.

I guess that value of 0, or perhaps of undef would mean to not divide
projects list, or project search results, into pages.

BTW. why do you think that kernel.org would be better to have project
list pagination turned off?
 
> It might also be advantageous to generate the entire list and stash that
> somewhere, (session on the host side?) and run the pagination out of
> that.

First, when using $projectslist file with new (second patch in series,
"gitweb: Allow project description in project_index file" most of data
(well, all except age) would be filled by parsing single file.

Second, the idea is to cache results of filled in @$projlist e.g. using
Storable, i.e. cache Perl data and not final HTML output.

> Would even allow the user to choose how many items they wish to 
> see from a drop down maybe?

I think it is also a good idea, at least for search results.


NOTE that this was an RFC patch, meant mainly to provide comments on
what to improve...

-- 
Jakub Narebski
Poland
