From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: "log --pretty=format:" language
Date: Sun, 24 Aug 2008 11:30:38 -0700 (PDT)
Message-ID: <m33akus1tj.fsf@localhost.localdomain>
References: <20080820175325.GD27773@sigill.intra.peff.net>
	<20080820180034.GB32005@sigill.intra.peff.net>
	<20080821050223.GA3295@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, MichaelTiloDressel@t-online.de,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sun Aug 24 20:31:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXKNX-00052f-KG
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 20:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbYHXSam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 14:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbYHXSam
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 14:30:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:29716 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbYHXSal (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 14:30:41 -0400
Received: by nf-out-0910.google.com with SMTP id d3so584082nfc.21
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 11:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=5xZKcKk6OR5BCM9mdpDVcxJS6LmKHMcmKSf2RTFJLKQ=;
        b=ne2XM+YJiETns5gbZBAr4YC3eyQ2OpxIwrWjOUVqogu3Q4Snw96edO4Ma4T8CbwVgh
         wWx/7ld6w8VWT9DHp3PhNdHSMkPMh4xyMCaBfgjR/DRB2LKVvl0TnUuZ3jp1FaSzm/Dc
         iFT++dCyw/KYTLbRJ7hfsXqXjxhee9RsBGeKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=O+mtWIj9HmI07lsiVc9MSlA9rpT7qIePbHlT4+nBiajUu9G99Jc19TIoNpuj3GdXUL
         NPvrSrz5scA8kTa+wT/yGO1NXCi3bCztuOnNqldv1b3/yXirbjGiqr4+6iugOqmc+Bgo
         pEXPGSzkbgCUiC+Y7uIlV3fHgiM6dx8oETKjQ=
Received: by 10.210.28.6 with SMTP id b6mr5294944ebb.60.1219602639631;
        Sun, 24 Aug 2008 11:30:39 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.234.185])
        by mx.google.com with ESMTPS id b36sm3396856ika.5.2008.08.24.11.30.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 11:30:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7OIUZU6021951;
	Sun, 24 Aug 2008 20:30:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7OIUX8P021948;
	Sun, 24 Aug 2008 20:30:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080821050223.GA3295@mithlond.arda.local>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93544>

Teemu Likonen <tlikonen@iki.fi> writes:

> Jeff King wrote (2008-08-20 14:00 -0400):
> 
> > There is a lot of room for discussion here.
> > 
> > For example:
> > 
> >   - what should %d show? Right now it shows each decoration, split by
> >     commas. It doesn't show the enclosing parentheses automatically.
> > 
> >     Is this too strict? Should there be some way of pulling out
> >     individual decorations from the list, or specifying a different
> >     delimiter? If so, probably that should be part of a general
> >     improvement in the format expansion macro language.
> 
> If such "general improvement" takes place I'd like to point out (most 
> likely old news, but anyway) that %b can't be indented in practical 
> sense. For example [...]

We can take a look how rpm handling of --queryformat option handles
it.  

First, it uses %{NAME} notation instead of %X shorthand for writing
single header (git-for-each-ref uses %(name) instead, so we might want
to use %(...) instead of %{...}, or use both).  It allows use of
printf(3) type formatters, which include field width and align, for
example "%-30{NAME} %10{SIZE}\n".

Second, for displaying arrays (like list of files, or list of
dependencies) or multi line output like package description it prints
each item in the array, or each line in multi-line field within qeuare
brackets, e.g. "[%-50{FILENAMES} %10{FILESIZES}\n]".  If one want to
repeat single-valued field one should use %{=NAME} syntax (actually it
simply takes first line/first element of array), e.g. 
"[%{=NAME}: %{FILENAMES}\n]"

Queryformat minilanguage is more reach, see /usr/share/doc/rpm-*/queryformat
or http://rpm5.org/docs/api/queryformat.html

-- 
Jakub Narebski
Poland
ShadeHawk on #git
