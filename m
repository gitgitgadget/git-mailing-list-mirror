From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Print diffs of UTF-16 to console / patches to email as UTF-8...?
Date: Fri, 22 Oct 2010 10:48:49 -0700 (PDT)
Message-ID: <m31v7iktkn.fsf@localhost.localdomain>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
	<20101022161851.GH9224@burratino>
	<1287766916.31218.71.camel@drew-northup.unet.maine.edu>
	<20101022171248.GA11794@burratino>
	<1287768426.31218.75.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Oct 22 19:49:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Ljg-0007m7-5r
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 19:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493Ab0JVRsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 13:48:55 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60671 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347Ab0JVRsy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 13:48:54 -0400
Received: by gyg4 with SMTP id 4so842739gyg.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=uy6mN1zwzSdUGqAdBtC5jDNxZ9JqMDS+eXyDcX0qbOE=;
        b=GS8PsQuf8yeKP3ewCE+qLbx4JLPFhH94mz2da2xvSaxGPEfCdTgD0CuehsTKRH6vRv
         o9VpwWOox8NgFUjf2WeG8n72faBB6HJsPv8Dk9vYuiN1SjXMBX5du95wUyQkZJKCgAuq
         je4hKh8jZBexqoJiHozkhGOI/QwNTS6XBsHAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=CWK69EoRHYT1KdW3Jqd52g2CI8MHaDL5i3h1CmwyexaX/hQjnPnAg8eOiYVKB91uxA
         0/Jx9QjKlciWpYWianaqnMgnsazmi/fUuG/J/DnehzCUksH+7Yv9eryZVugaw7pZcCr3
         awFhKaga3DUgw9Nu5Z5Wwf7RcM/OGgH+bELEs=
Received: by 10.103.199.11 with SMTP id b11mr3863613muq.112.1287769732408;
        Fri, 22 Oct 2010 10:48:52 -0700 (PDT)
Received: from localhost.localdomain (abwn200.neoplus.adsl.tpnet.pl [83.8.237.200])
        by mx.google.com with ESMTPS id j8sm1586494fah.30.2010.10.22.10.48.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 10:48:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9MHm7Rb004537;
	Fri, 22 Oct 2010 19:48:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9MHlr9p004533;
	Fri, 22 Oct 2010 19:47:53 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1287768426.31218.75.camel@drew-northup.unet.maine.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159718>

Drew Northup <drew.northup@maine.edu> writes:

> On Fri, 2010-10-22 at 12:12 -0500, Jonathan Nieder wrote:
> > 
> > Drew Northup wrote:
> > 
> > > That still doesn't fix the crlf issue, for starters. Also, I would like
> > > to be able to email patches for files that are in UTF-16 and properly
> > > re-import them. Unless I'm missing something really big there's not much
> > > that a display filter is going to do for me there.
> > 
> > Right, I think you're missing something big.  textconv is a display
> > filter.  clean/smudge convert between internal and external
> > representation (and your clean/smudge scripts could take care of CRLF
> > themselves if desired).
> > 
> > That said, I wouldn't be surprised if clean/smudge filters don't do
> > everything you want.  If you do go that way, please keep the list
> > posted so the mechanism can be improved.
> 
> Well I shall plumb the documentation again.... just in case. I'm not
> holding my breath that it will do what I (and frankly a fair number of
> other people) want. We just want version control that treats text like
> text. FULL STOP. Why isn't UTF-16 text???????

If you are asking why Git detects files with text in UTF-16 / USC-2 as
binary, it is because Git (re)uses the same heuristic that e.g. GNU
diff (and probably also -T file test in Perl), and one of heuristics
is that if file contains NUL ("\0") character, then it is most
porbably binary (because legacy C programs for text would have
troubles with NUL characters).

That probably doesn't help you any...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
