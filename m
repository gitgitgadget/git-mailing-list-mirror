From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: suggest name for OPML view
Date: Sat, 10 Jan 2009 15:10:20 +0100
Message-ID: <200901101510.20918.jnareb@gmail.com>
References: <1230900570-25324-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 15:12:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLeZ8-00047c-BX
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 15:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbZAJOK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 09:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbZAJOK1
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 09:10:27 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:41834 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbZAJOK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 09:10:26 -0500
Received: by ewy10 with SMTP id 10so10707069ewy.13
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 06:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=mL5mHo9iDxOuDs0+U4xNc4A0QO/4OySGuyyEgSZAGMA=;
        b=Bh2WBLiVG9c8scT0r8u756Wn+UqSlX+DT+YPq/RiKQpbQuHM4NN/tgyaVo/HMFd96m
         63TTTkxhw80B1LJaK2oB9KO6nU/VJKSbipEoG7hlfSbNism0PHVHr5Kbwd/so+vKD0WE
         HH12Cc1+l6ccZ4+KGr6LpuqyxLytWk91t6ibY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=sDGM9LR2E3dGlKNBwev+ubimKd/E1E/lIyQclxEVhkRnkuUirlhBSfICDK4BsSt6u5
         1ToLqrQowxZsUX5k4bsjq5NajSBmS3OxrejXdX4FwGtx5Q0pEoOke6VFhHtz62tjNkQ8
         omrSNGyW6FU7eskSztG8BzvXJmrGBtoNwmJQQ=
Received: by 10.210.78.7 with SMTP id a7mr31570088ebb.13.1231596624302;
        Sat, 10 Jan 2009 06:10:24 -0800 (PST)
Received: from ?192.168.1.11? (abve97.neoplus.adsl.tpnet.pl [83.8.202.97])
        by mx.google.com with ESMTPS id 28sm2741217eyg.4.2009.01.10.06.10.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jan 2009 06:10:22 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1230900570-25324-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105112>

On Fri, 2 Jan 2009, Giuseppe Bilotta wrote:

> Suggest opml.xml as name for OPML view by providing the appropriate
> header, consistently with similar usage in project_index view.

It is not name for a view, but more of default filename when saving
it. While it is good idea to have consistency, I guess that while
'project_index' view and other non-HTML views are meant to be 
downloaded and saved (snapshots, patches, patchsets), OPML view
is meant to be used on-line, just like web feeds in RSS and Atom
formats which are non-HTML too but do not have Content-Disposition
header set. 

But I do not use OPML. Anyone?

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index b164001..995bc1a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6122,7 +6122,11 @@ sub git_atom {
>  sub git_opml {
>  	my @list = git_get_projects_list();
>  
> -	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
> +	print $cgi->header(
> +		-type => 'text/xml',
> +		-charset => 'utf-8',
> +		-content_disposition => 'inline; filename="opml.xml"');
> +
>  	print <<XML;
>  <?xml version="1.0" encoding="utf-8"?>
>  <opml version="1.0">
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
