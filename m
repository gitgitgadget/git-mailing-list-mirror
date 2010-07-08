From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb.css
Date: Thu, 08 Jul 2010 09:07:00 -0700 (PDT)
Message-ID: <m3y6dmklg0.fsf@localhost.localdomain>
References: <19509.15171.909921.769184@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 18:07:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWtd4-0001WY-Jt
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 18:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758026Ab0GHQHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 12:07:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53857 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758021Ab0GHQHF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 12:07:05 -0400
Received: by fxm14 with SMTP id 14so512315fxm.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=CfTWT/+VBB3Oti68ClR0g9lUTHtuaLQbTFovtIvxbWY=;
        b=S11iTHo/GFCcXZoUzbVN0GJXHGS5t+1UEij2AYarCAplMLLf5aifiFAo1u9RWetNzz
         YF9MfLoVurrv9NaQJKsrgT54UGMzEK+G7AVFbV4kSqBHbSHzVZx1HizzVtmkUYU3jn8x
         n4+Z4bP2Ia+WCrWeTgmD9MvgEVzQ90lKAi2mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Gviz8JS2THx8uBii6W9JJ+sA+tXnqi1DXsucTvYrD8U9K9KSVDKVmAQOdL+mRek1UM
         2t+JK0pJFfCcrgSNlkiDz/YO9CUSoH6CvUCQ6gNLuMzb8TNEHusmCwptn76hxKd5QYos
         sjOnYzVIdTP0ZSR2n70IXNErIjDM+/de/39jc=
Received: by 10.223.119.202 with SMTP id a10mr7303703far.51.1278605221374;
        Thu, 08 Jul 2010 09:07:01 -0700 (PDT)
Received: from localhost.localdomain (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id b14sm17262801fab.19.2010.07.08.09.06.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 09:07:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o68G6RCY018012;
	Thu, 8 Jul 2010 18:06:38 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o68G69LY018004;
	Thu, 8 Jul 2010 18:06:09 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <19509.15171.909921.769184@winooski.ccs.neu.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150585>

Eli Barzilay <eli@barzilay.org> writes:

> I've been customizing a gitweb server to fit with the rest of our
> project pages (the result is http://git.racket-lang.org/).  This was
> relatively easy to do except for a few places where gitweb.css
> specifies formatting for generic tags like `body', `table', and `td',
> which messed up our header.
> 
> Maybe it makes sense to localize these styles to to gitweb specific
> classes?  (I know that I can just use my own css, but the file is big
> enough that I prefer avoiding manually merging in updates.)

Can't you just override gitweb's CSS by your own CSS?  Later CSS wins.
You can have more than one stylesheet in gitweb (@stylesheets).

We could give class to `body' element, and the use it for other
class-less selectors (`'table', `'td', `a'), but I don't know if this
solution would be enought for you.  It means replacing 'body' selector
by e.g. '.gitweb_body' selector, and e.g. 'a' selector by
'.gitweb_body a' selector.


I'd rather not add 'gitweb' class (or similar) to every element just
to have common style for all links, tables, table header cells, table
cells.


P.S. while changing static/gitweb.css we could optimize it by removing
unnecessary parts of selector.  Contrary to what I thought more
detailed selector decreases rather than improves performance.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
