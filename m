From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Print diffs of UTF-16 to console / patches to email as UTF-8...?
Date: Fri, 22 Oct 2010 21:18:06 +0200
Message-ID: <201010222118.09212.jnareb@gmail.com>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu> <m31v7iktkn.fsf@localhost.localdomain> <1287770805.819.7.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Oct 22 21:18:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9N8K-0006N8-4W
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 21:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186Ab0JVTSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 15:18:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39645 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759306Ab0JVTSW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 15:18:22 -0400
Received: by bwz11 with SMTP id 11so863250bwz.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 12:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dr4h9Amf8YbX6mbd0agYcrvvvxQtNrJlksZedoMpz0g=;
        b=tYEjq4V+TJcr7upxY4ZGJGQINe/n25idXWk/XjyT8lkJvKlXOW3uP7+h0VEbZVeHYi
         To1pXGicklJjNIpcOwZJwDFTyAcdEwzB29fc8i1DaPoMKbjwswU53JDohcQ26cCBnEY+
         8PwHcreCGcl1/Q8Gs4Ie3H0DjYQzk+sAER64k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oGdH+P+XHDTtCmdzdWTHXD1irHTbOYKuHw30OMciplAk8LddLvwcuEPib8wVPAP3eq
         AjcHsdPj8lxlMI78YYlhkAghCNGIry35Qw+3cFNYDiscLWjhUnPwTnU3Z5UNTY0Xq194
         JzkOf81aOkTW9DN1z4rCkmJZqkDQzPA9XQny0=
Received: by 10.204.104.5 with SMTP id m5mr2561741bko.73.1287775101229;
        Fri, 22 Oct 2010 12:18:21 -0700 (PDT)
Received: from [192.168.1.13] (abwn200.neoplus.adsl.tpnet.pl [83.8.237.200])
        by mx.google.com with ESMTPS id t10sm2381589bkj.16.2010.10.22.12.18.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 12:18:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1287770805.819.7.camel@drew-northup.unet.maine.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159735>

On Fri, 22 Oct 2010, Drew Northup wrote:
> On Fri, 2010-10-22 at 10:48 -0700, Jakub Narebski wrote:
> > Drew Northup <drew.northup@maine.edu> writes:
> 
> > > Well I shall plumb the documentation again.... just in case. I'm not
> > > holding my breath that it will do what I (and frankly a fair number of
> > > other people) want. We just want version control that treats text like
> > > text. FULL STOP. Why isn't UTF-16 text???????
> > 
> > If you are asking why Git detects files with text in UTF-16 / USC-2 as
> > binary, it is because Git (re)uses the same heuristic that e.g. GNU
> > diff (and probably also -T file test in Perl), and one of heuristics
> > is that if file contains NUL ("\0") character, then it is most
> > porbably binary (because legacy C programs for text would have
> > troubles with NUL characters).
> > 
> > That probably doesn't help you any...
> 
> I did find that already. I still have not decided that correct place to
> shoehorn in Unicode detection, but I'll be sure to do that before I
> bother anybody else with it. I already wrote code to detect (reasonably)
> valid UTF-16 (if it isn't obviously valid then I'll just as soon deal
> with it as binary data, so as to avoid a foot-shooting exercise).
> My main motivation here has been to get some feedback as I write stuff
> so as to not waste a lot of time during writing something that could be
> done better. 
>
> (As opposed to not done at all, which is the feeling I'm getting from a
> few people around here...)

Git supports well different encoding used in commit message (which is
always text, as opposed to file contents which might be binary or text).

You specify what encoding you use to format commit messages with
i18n.commitEncoding (defaults to 'utf-8'); if it is different than utf-8
it gets saved in 'encoding' header.  You can even specify that encoding
that your terminal uses is different from i18n.commitEncoding with
i18n.logOutputEncoding

The only support for different encoding of file contents is used by
git-gui.  You provide encoding that a file uses via .gitattributes
(the `encoding` attribute).  You specify what output encoding git-gui
(Tcl/Tk) uses with `gui.encoding` config variable.

I guess that what you need to support for diffs and 'git show <file>'
etc. is respecting `encoding` .gitattribute, and providing encoding
that console uses with e.g. i18n.blobOutputEncoding (or something like
that).

HTH
-- 
Jakub Narebski
Poland
