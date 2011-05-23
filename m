From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] compat: add a getpass() compatibility function
Date: Mon, 23 May 2011 10:59:49 -0700 (PDT)
Message-ID: <m3fwo5z4bi.fsf@localhost.localdomain>
References: <0301451F-9998-4208-8CE0-82B095DD5D32@gieschke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Mon May 23 20:00:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOZQG-0008F4-Ue
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 20:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185Ab1EWR7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 13:59:55 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60189 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756923Ab1EWR7x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 13:59:53 -0400
Received: by bwz15 with SMTP id 15so4929788bwz.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=aPaqbtaYqO40YHvqgpcOVH9oD8Ms0cCrlPiAWh2CMRw=;
        b=GiJawu9gx0HrhLbTwJq16fn/Zmh9n1gu8/iplv7vBky4s06u1yCkH9PMEgOAUiu5b1
         KqLxBxAINA9dvjsZADWuTy4tkWzJaBRULB8sWfNjiDNtbjFCMJzPT5u9F6DgdoIMvGsf
         F6XGMi1weL465sqkpkFh0laJQmgacuBira1RM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=QNBFe25K4NAmj18RpfMqBx7Dy72JgYvSX3cRA89CBTvoc2dn80pXVJ5agaoOPAPc+V
         CRVLwhBB13gIgtP2uJnAOjFdx9Ynhspfp9IzpmRlt1bxlv+L+f4VzfZmpXkInbfekLQ7
         vAtXw9cTGcTTKvwomPV78nLSwlcw5YTJ0SJVo=
Received: by 10.204.84.137 with SMTP id j9mr2421453bkl.120.1306173591918;
        Mon, 23 May 2011 10:59:51 -0700 (PDT)
Received: from localhost.localdomain (abvw40.neoplus.adsl.tpnet.pl [83.8.220.40])
        by mx.google.com with ESMTPS id q18sm4061801bka.15.2011.05.23.10.59.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 May 2011 10:59:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p4NHxIGt006750;
	Mon, 23 May 2011 19:59:24 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p4NHwvJZ006739;
	Mon, 23 May 2011 19:58:57 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <0301451F-9998-4208-8CE0-82B095DD5D32@gieschke.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174258>

Rafael Gieschke <rafael@gieschke.de> writes:

> If NO_GETPASS is set, getpass is provided in compat/getpass.c from
> http://git.uclibc.org/uClibc/plain/libc/unistd/getpass.c
> (getpass() was renamed to gitgetpass()).
> 
> Signed-off-by: Rafael Gieschke <rafael@gieschke.de>
> ---
>  Makefile          |    6 +++
>  compat/getpass.c  |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  git-compat-util.h |    5 +++
>  3 files changed, 109 insertions(+), 0 deletions(-)
>  create mode 100644 compat/getpass.c

Thanks.  What is missing is optional automatic detection of this case,
which means changes to configure.ac and config.mak.in; see e.g. how it
is done for NO_STRLCPY.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
