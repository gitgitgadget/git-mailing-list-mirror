From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Tue, 09 Nov 2010 13:38:49 -0800 (PST)
Message-ID: <m3iq06fa9i.fsf@localhost.localdomain>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 22:39:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFvu6-0002lR-Nq
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 22:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634Ab0KIVix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 16:38:53 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54031 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab0KIViw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 16:38:52 -0500
Received: by ywc21 with SMTP id 21so4726947ywc.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 13:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=9FrjF2Fl59fEjL1Wqzq/3B0I/m4z5N517JvYMPvDl1M=;
        b=SxnqX3CtQ0J9BSVvQNF5U9VmqXxo2lc13Y9/q40vcP1G1Q60sT+GGRhOtQZcYoHsly
         pkKXrZaVNSXjby270Lb4TDNfzQTIdIMVbMaweI6n8FoKj9I0OCKbJ5Q++Sj/85sVQG+x
         Pxssxp/l1RPXdLCu8co0X6yUxvrkeIwZyJNq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ce7v29WCNThP72rpmUN8tsRXiIu4k+X/zt5+tc/2pf30mimlWWHmvaobH4xZF8tXcT
         rWq0BUl9M+f1mXbkLl9gcWlHKNY6wdvgKFFJWzQq0qigPRHHj4tttweZSgVplae7V9+v
         p+fvwJ5HVDrROEvS4hDGWBoJO1d7JFZXiYeyA=
Received: by 10.216.171.75 with SMTP id q53mr7407918wel.74.1289338731173;
        Tue, 09 Nov 2010 13:38:51 -0800 (PST)
Received: from localhost.localdomain (abwj130.neoplus.adsl.tpnet.pl [83.8.233.130])
        by mx.google.com with ESMTPS id x15sm1222328weq.31.2010.11.09.13.38.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 13:38:49 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oA9LcUGV017457;
	Tue, 9 Nov 2010 22:38:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oA9LcJPd017453;
	Tue, 9 Nov 2010 22:38:19 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161074>

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
> marked with '.' do not appear in any of the integration branches, but I am
> still holding onto them.

> * tr/config-doc (2010-10-24) 2 commits
>  . Documentation: complete config list from other manpages
>  . Documentation: Move variables from config.txt to separate file
> 
> This unfortunately heavily conflicts with patches in flight...

The first patch in series is trivial to re-create: just put
description of variables into separate file, and replace it with
include.  Probably could even be scripted.

Which version of "complete config list" script did you pick?  There
was some unresolved discussion about how best to proceed (following
versus not-following includes, limiting to "Config.*" sections, etc.)

BTW., IMHO not following includes would be better solution.

> * jh/gitweb-caching (2010-11-01) 4 commits
>  - gitweb: Minimal testing of gitweb caching
>  - gitweb: File based caching layer (from git.kernel.org)
>  - gitweb: add output buffering and associated functions
>  - gitweb: Prepare for splitting gitweb
>  (this branch uses jn/gitweb-test.)

> * jn/gitweb-test (2010-09-26) 4 commits
>   (merged to 'next' on 2010-11-05 at 90b3adf)
>  + gitweb/Makefile: Include gitweb/config.mak
>  + gitweb/Makefile: Add 'test' and 'test-installed' targets
>  + t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
>  + gitweb: Move call to evaluate_git_version after evaluate_gitweb_config
>  (this branch is used by jh/gitweb-caching.)

These two branches have simple to resolve but non-trivial conflict.
Should I rebase 'jh/gitweb-caching' on top of 'jn/gitweb-test' then,
resolving this conflict?

BTW. this would allow me to improve 'gitweb: Minimal testing of gitweb
caching'.

> * yd/dir-rename (2010-10-29) 5 commits
>  - Allow hiding renames of individual files involved in a directory rename.
>  - Unified diff output format for bulk moves.
>  - Add testcases for the --detect-bulk-moves diffcore flag.
>  - Raw diff output format for bulk moves.
>  - Introduce bulk-move detection in diffcore.

Very interesting!

-- 
Jakub Narebski
Poland
ShadeHawk on #git
