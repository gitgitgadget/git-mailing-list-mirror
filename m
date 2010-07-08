From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb.css
Date: Thu, 8 Jul 2010 20:49:22 +0200
Message-ID: <201007082049.23550.jnareb@gmail.com>
References: <19509.15171.909921.769184@winooski.ccs.neu.edu> <m3y6dmklg0.fsf@localhost.localdomain> <19510.3565.336183.72646@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 20:49:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwAD-0005yE-NT
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 20:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002Ab0GHStd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 14:49:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38177 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab0GHStc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 14:49:32 -0400
Received: by bwz1 with SMTP id 1so615491bwz.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TNJYPg5qtd90FM6+jNMISxkLDibV/jj1T0eJTBAs4XQ=;
        b=vdLwmuvU58MhkT2lNBXZdGpIA0SEfJWIwjmf6hi4Bh+UGL0wcFJGU8GvX2hBn9fx8Q
         +UEELJssbFXcjnwF7/kKXWZNhfw0EoZgArmrbRDYLzii/ZtOlvMIh4osL1m3mMSYFqJ4
         PCOwaEN0/9B4EYz3VLK/HjuNh40nMgKeFOIdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Y+cqfcePnjKqFv24zo34GD8xJrOezuU9v2YytDdCufn9if8Tak4LgOLuGme/6lhXR+
         ZdelW5cxy7L5GBLLTlGbpXfSiU+HLOS+38j9PrJUpijp0/oQ+XWfGMwv7BEFhk7Umh3w
         UA0FFLLpc9m/aCk31dA7tvfAWan5VQnzSFoME=
Received: by 10.204.80.98 with SMTP id s34mr6526257bkk.211.1278614970665;
        Thu, 08 Jul 2010 11:49:30 -0700 (PDT)
Received: from [192.168.1.15] (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id o20sm34144706bkw.15.2010.07.08.11.49.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 11:49:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <19510.3565.336183.72646@winooski.ccs.neu.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150591>

On Thu, 8 Jul 2010, Eli Barzilay wrote:
> On Jul 8 Jakub Narebski wrote:
>> Eli Barzilay <eli@barzilay.org> writes:
>> 
>>> I've been customizing a gitweb server to fit with the rest of our
>>> project pages (the result is http://git.racket-lang.org/). This was
>>> relatively easy to do except for a few places where gitweb.css
>>> specifies formatting for generic tags like `body' `table' and `td' 
>>> which messed up our header.
>>> 
>>> Maybe it makes sense to localize these styles to to gitweb specific
>>> classes? (I know that I can just use my own css but the file is big
>>> enough that I prefer avoiding manually merging in updates.)
>> 
>> Can't you just override gitweb's CSS by your own CSS? Later CSS
>> wins. You can have more than one stylesheet in gitweb
>> (@stylesheets).
> 
> I know -- and I'm using that. The problem is if there's a property
> that we're not defining then it won't get overridden -- and doing so
> requires knowing what the default value is and keeping our css
> updated for future extensions (eg if tomorrow you make add
> `font-family' to the `table' entry we'll need to add one too etc).
> And still this means overriding your settings which were probably
> done for a reason...

Ah, all right.  I think I understand your problem, then.
 
The problem is that in included GITWEB_SITE_HEADER, GITWEB_HOMETEXT
and GITWEB_SITE_FOOTER gitweb style applies to links and tables, and
you want to have own style based on default HTML style values, isn't
it?
 
>> [...]
>> I'd rather not add 'gitweb' class (or similar) to every element just
>> to have common style for all links tables table header cells 
>> table cells.
> 
> Why not add just a <div class=".gitweb"> container for all gitweb
> content then have css for ".gitweb foo" for anything you want?

First, I dislike this solution.

Second, similar solution would be beter, namely consistent division of
page into gitweb_header, gitweb_body and gitweb_footer, moving style
of 'body' to gitweb_*, and 'table' etc. to '.gitweb_body table'.  The
problem is with the way CSS is structured currently: I had problems
with some elements losing their margin, and some elements having double
margin.

-- 
Jakub Narebski
Poland
