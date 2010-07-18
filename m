From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSOC 08/11] gitweb: Create Gitweb::View module
Date: Sun, 18 Jul 2010 17:10:22 +0200
Message-ID: <201007181710.23105.jnareb@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com> <1279178951-23712-9-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 17:10:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaVVm-0006JJ-DI
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 17:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402Ab0GRPKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 11:10:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46718 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756337Ab0GRPKc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 11:10:32 -0400
Received: by bwz1 with SMTP id 1so1893984bwz.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=p/ohCUjbU1yRifRQD+SG0R/D76wf4YJv4UOFKr+jNak=;
        b=NpjrjN/NC5gk8vqE3w3RL87j8SzezEiq7th106YN4inX6XOI+kvfdLFRHJfUZ6q90M
         5B2B33BiyP73RnoXV7yRfUvOnqr/ZzhNk3mWcnSkN8BaMnwlUo5tsAdOrYz5STM7HiH8
         pzQ+AITyg5/8UNDNPlBx96Ocw4ZrmQuPVd5yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=G+0NttDkJ7Spug7TyzC+FjQKQ17bGD2atrufLO/kBJvt8UBuEyHC5j7D+4p9qne0OV
         5g4J01fVN0nXl/Kdf01q2UnRSK/Lt4Slb1zthzx7rEHVa1WkAqXiVL4CG2wBggaMzy1E
         oO0BDJ1cH5gZwzCL6i4AZmzC7LT/9LKlKgiZA=
Received: by 10.204.162.136 with SMTP id v8mr2934335bkx.168.1279465830406;
        Sun, 18 Jul 2010 08:10:30 -0700 (PDT)
Received: from [192.168.1.13] (abwa30.neoplus.adsl.tpnet.pl [83.8.224.30])
        by mx.google.com with ESMTPS id 24sm21195717bkr.7.2010.07.18.08.10.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 08:10:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279178951-23712-9-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151216>

On Thu, 15 Jul 2010, Pavan Kumar Sunkara wrote:

> Create Gitweb::View module in 'gitweb/lib/Gitweb/View.pm'
> to store the subroutines related to the HTML output
> for gitweb.

If it contains subroutines related only to HTML output, why isn't it
called Gitweb::HTML then?  If it contains some subroutines which are
not strictly about HTML, please state it in the commit message.

> 
> This module depends on Git.pm, Config.pm, Request.pm,
> Escape.pm and RepoConfig.pm. Action specific HTML div
> subroutines are not included in this module due to
> unmet dependencies of Gitweb::Parse and Gitweb::Format.

Whether you use Gitweb::Git or Git.pm, you should be consistent in the
naming you use: either Git.pm, or Gitweb::Parse.

Do I understand correctly trhat Gitweb::Parse and Gitweb::Format are to
be added in subsequent patches?  Please state this fact in the commit
message.

> 
> Subroutines moved:
> 	*href
> 	 get_feed_info
> 	*chop_str
> 	 chop_and_escape_str
> 	*age_class
> 	 age_string
> 	*S_ISGITLINK
> 	 mode_str
> 	 file_type
> 	 file_type_long
> 	*get_page_title
> 	 git_header_html
> 	 git_footer_html
> 	 die_error
> 	*git_print_page_nav
> 	 format_paging_nav
> 	 git_print_header_div
> 	 git_print_page_path
> 	*print_local_time
> 	 format_local_time
> 	*insert_file
> 	*git_get_link_target
> 	 normalize_link_target
> 	 git_print_tree_entry
> 	*print_sort_th
> 	 format_sort_th

Nitpick: my first thought was "why some of those subroutines are marked
with a star?".  If you want to divide this list of subroutines into
groups by function, you should leave a space between '*' and name of
subroutine (i.e. '* href'), and perhaps also leave empty lines between
groups, though this might make commit this list overly long.

I guess that this separation of subroutines into Gitweb::View module 
was a matter of some compromise: between having too large modules
(containing only barely related subroutines) and having too many
modules.

> 
> Update 'gitweb/Makefile' to install Gitweb::View alongside gitweb.
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

I have not checked the diff itself...

-- 
Jakub Narebski
Poland
