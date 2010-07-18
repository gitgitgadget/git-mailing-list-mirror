From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSOC 10/11] gitweb: Create Gitweb::Format module
Date: Sun, 18 Jul 2010 22:16:14 +0200
Message-ID: <201007182216.15997.jnareb@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com> <1279178951-23712-11-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 22:16:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaaHu-0005zs-Du
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 22:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757242Ab0GRUQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 16:16:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32988 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226Ab0GRUQY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 16:16:24 -0400
Received: by bwz1 with SMTP id 1so1970148bwz.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=0K1rhviF49C2Y1mU3Df4YNC5YXuPWa9Pz7nrjefFfbM=;
        b=Qaj9zws8T5gV7aYeKdHQIHPe1EQ4cfjte8DgmpDHGqyDPzmaSM+Dmvv3C47BM/rv2W
         E5F4fsBAIV9qxudeoS7H59mMDUSTZMsoKJmOr/hVXwJyrQGec3etOdHDQIC4n1XOsZox
         IsIw1E3X0R+cq7A1I6jjj08H9HNPgwc1VO10c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Mk6HYMQRbTU36KtMTswvyMixZnLWCx+/BB9pXwnO/NlgxTyWyWknjhBQH0EyW71lJB
         2+bQy7piosFuQ6hq3Som2syQcfFe4kOoKHqTG3xmNeVTf4zMfxVjI8Be9O2zSDEaqrY6
         wIzz/zchHV7h8WhUXAiiC+r3fP/tcxVRvPm1E=
Received: by 10.204.16.82 with SMTP id n18mr3236910bka.212.1279484181871;
        Sun, 18 Jul 2010 13:16:21 -0700 (PDT)
Received: from [192.168.1.13] (abwa30.neoplus.adsl.tpnet.pl [83.8.224.30])
        by mx.google.com with ESMTPS id y27sm22252741bkw.2.2010.07.18.13.16.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 13:16:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279178951-23712-11-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151240>

On Thu, 15 Jul 2010, Pavan Kumar Sunkara wrote:

> Create Gitweb::Format module in 'gitweb/lib/Gitweb/Format.pm'
> to store the subroutines related to formatting of HTML
> fragments required for gitweb.

What is the criterion of choosing whether to put given subroutine in
Gitweb::View / Gitweb::HTML and in Gitweb::Format (this module)?

> 
> This module depends on Config.pm, View.pm, Escape.pm,
> Util.pm and Request.pm.

O.K., although we should decide consistently through the series if we
want to use the Config.pm form for describing dependencies in the commit
message, or would it be better to use Gitweb::Config, i.e. the module
name.

>                         It mainly contain functions returning 
> short HTML fragments or transforming HTML fragments. Also
> include subroutines regarding avatar formatting.

I think you should say aomething about _why_ did you pur avatar
formatting in this module; I guess that is because git_get_avatar
returns also short HTML fragment.

> 
> Subroutines moved:
> 	format_log_line_html
> 	format_ref_marker
> 	format_subject_html
> 	picon_url
> 	gravatar_url
> 	git_get_avatar
> 	format_search_author
> 	format_author_html
> 	format_git_diff_header_line
> 	format_extended_diff_header_line
> 	format_diff_from_to_header
> 	format_diff_cc_simplified
> 	format_diff_line
> 	format_snapshot_links
> 
> Update 'gitweb/Makefile' to install Gitweb::Format alongside gitweb.
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---

I have not checked patch itself.

-- 
Jakub Narebski
Poland
