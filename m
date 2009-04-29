From: Nicolas Sebrecht <nicolas.s.dev@gmail.com>
Subject: [PATCH 5/6] Re: Remove mix of high and low-precedence booleans
Date: Wed, 29 Apr 2009 18:54:07 +0200
Message-ID: <20090429165407.GB12908@vidovic>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu> <1241010743-7020-2-git-send-email-wfp5p@virginia.edu> <1241010743-7020-3-git-send-email-wfp5p@virginia.edu> <1241010743-7020-4-git-send-email-wfp5p@virginia.edu> <1241010743-7020-5-git-send-email-wfp5p@virginia.edu> <1241010743-7020-6-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bill Pemberton <wfp5p@virginia.edu>
X-From: git-owner@vger.kernel.org Wed Apr 29 18:54:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzD38-0004VX-GT
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 18:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbZD2QyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 12:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbZD2QyL
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 12:54:11 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:60726 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbZD2QyL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 12:54:11 -0400
Received: by bwz7 with SMTP id 7so1295541bwz.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=05Y5HvsUtOMc1/G2t7Gu/Vqm2GaaAmYGnTZiLy1IhrY=;
        b=aqhbshOaWeE5LE2lnU7s5N3jJSGrAJb43hdGdm08DYhgSM8DUZAtYajqxkAD0By/hA
         4OryCXKPdLLAE4konGVG6Nd+gPehET2CN5ORnLjtGRmdZcfe68UOmgy01zgLzVFcSfT7
         A16U0xbuki2GbR7J+fFIOhPOxg8W2jD9qQWNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ka2BFEw1DzWoWiM1YWxhcMpUHrUX4uL60PNkKk1MkwaHvCSRmtvIMe3oT7ZyV8S+sA
         8dX/atC4VPyahS4rUCWTWKOc8c5fgMQqG3QQlpQrnhY67AqqKlT6gGRobmug8H8u7iVw
         VDvo6oXkpD5a0SMqaTa2vERahi1VQKCR4kq7A=
Received: by 10.86.65.9 with SMTP id n9mr895909fga.47.1241024049783;
        Wed, 29 Apr 2009 09:54:09 -0700 (PDT)
Received: from @ (91-164-142-73.rev.libertysurf.net [91.164.142.73])
        by mx.google.com with ESMTPS id d6sm1973161fga.12.2009.04.29.09.54.09
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Apr 2009 09:54:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1241010743-7020-6-git-send-email-wfp5p@virginia.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117905>

On Wed, Apr 29, 2009 at 09:12:22AM -0400, Bill Pemberton wrote:

> Booleans such as &&, ||, ! have higher precedence than and, or, not.
> They should not be mixed.

But round brackets have higher precedence than both '&&' and 'and',
right?  If so, why thoses changes?

> -	} elsif (-d $f and !check_file_rev_conflict($f)) {
> +	} elsif (-d $f && !check_file_rev_conflict($f)) {

> -	} elsif ((-f $f or -p $f) and !check_file_rev_conflict($f)) {
> +	} elsif ((-f $f || -p $f) && !check_file_rev_conflict($f)) {

> -		if (!defined $valid_re or $resp =~ /$valid_re/) {
> +		if (!defined $valid_re || $resp =~ /$valid_re/) {

-- 
Nicolas Sebrecht
