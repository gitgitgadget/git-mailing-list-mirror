From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v3] Re: git-am: fix maildir support regression: accept
	email file as patch
Date: Thu, 16 Jul 2009 03:00:01 +0200
Message-ID: <20090716010001.GC12971@vidovic>
References: <1654b578a7e045b564c46df4abb6e2196422c2b2.1247696294.git.nicolas.s.dev@gmx.fr> <7v1voheevy.fsf@alter.siamese.dyndns.org> <7vfxcxcxg1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 03:00:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRFKd-0005KB-Hp
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 03:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807AbZGPBAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 21:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756802AbZGPBAJ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 21:00:09 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:38793 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756801AbZGPBAI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 21:00:08 -0400
Received: by ewy26 with SMTP id 26so4487459ewy.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=GN9yAyHd2/WPgE89sdWDttaSZFp0BqxkR/kD1O7y3Gg=;
        b=PnjB4rLd71alEQJyjBOef2A+53YEAnQ+yyNtmbcOms2QDsznbuvhfr4w0PcHjmW3+/
         ZscsYU8JTIS+KW0BydY4LpFXy2saenZkqHvQlC3edPLaeb1Q0m4IC24TgPwReT9F5jdS
         3uvNaTUlP6CWO6MPTxixuVSZSIaHayNLMwNBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=b6VaSxlMaGXNB3v43YZzW3CB2pbe+1/jeJZrdZgrC1BcCmnkOpVpm1gpnbz9RbPA4/
         ZbzFpI4c7px+QN9sBBq5EW4dNEpBvBa5o548XMWaWeQ/tKNtxTAXjQ3EGjL88zjXII70
         rdzWFJj1bqt64571d2UEmLcki/wqsnzQzxonc=
Received: by 10.210.115.17 with SMTP id n17mr5465792ebc.70.1247706006821;
        Wed, 15 Jul 2009 18:00:06 -0700 (PDT)
Received: from @ (91-164-136-30.rev.libertysurf.net [91.164.136.30])
        by mx.google.com with ESMTPS id 28sm840184eyg.42.2009.07.15.18.00.04
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 18:00:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfxcxcxg1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123351>

The 15/07/09, Junio C Hamano wrote:

> We traditionally allowed a mbox file or a directory name of a maildir (but
> never an individual file inside a maildir) to be given to "git am".  Even
> though an individual file in a maildir (or more generally, a piece of
> RFC2822 e-mail) is not a mbox file, it contains enough information to
> create a commit out of it, so there is no reason to reject one.  Running
> mailsplit on such a file feels stupid, but it does not hurt.

Junio, I'm sorry but you missed the point.

It is not about adding a new feature. It's about keeping compatibility
with maildir. The current version _rejects_ good patches.

But, as it's very easy to move emails from a maildir _or_ have a symlink
which links to "maildir/cur" or whatever, we really should rely on the
content of the files.

-- 
Nicolas Sebrecht
