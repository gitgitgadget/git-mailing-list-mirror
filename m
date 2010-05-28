From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/3] Interix support
Date: Thu, 27 May 2010 19:11:42 -0700 (PDT)
Message-ID: <m3mxvkrcyf.fsf@localhost.localdomain>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mduft@gentoo.org, jrnieder@gmail.com
To: Jonathan Callen <abcd@gentoo.org>
X-From: git-owner@vger.kernel.org Fri May 28 04:11:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHp3A-000449-6X
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 04:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902Ab0E1CLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 22:11:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42995 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174Ab0E1CLq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 22:11:46 -0400
Received: by fxm10 with SMTP id 10so367126fxm.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 19:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=wimtRc+r7+WzHcgsxgwNmf6xJkPtyCPvUzQwGWqdk1I=;
        b=bNc2S6vOwDmKYat2Fwih6T9SKusaSQAaadGvkcsgz9qrC7xXgWqwXbWgmHUNlSdM5/
         SnftgXXz9RIRtLvh4hxsmpF0/xD5u2591RgFwSQxjUWUua2wOKpfbUWkQgQO/0W5HBqN
         ckkQ+OxGIkmn5KGpkj0Kpl20j4lfcS7Et9Jd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=rmiaPwBVv7ZSCJaA5v30Xru+EuyCbgnRLmydEtVXK2AQiLb4ST/gIgchuVso855vsH
         Y5sApF6djpTdKPKkaqJ6+WOoKuKFK5dzKrFDcgG0HlsfNW3UAUFMwpkSCTnzwzNXiIZq
         8uQ9Ou6QwSvlwxw3FnG25veAyY7xZERdUQMa8=
Received: by 10.223.20.216 with SMTP id g24mr400071fab.63.1275012703733;
        Thu, 27 May 2010 19:11:43 -0700 (PDT)
Received: from localhost.localdomain (abwk209.neoplus.adsl.tpnet.pl [83.8.234.209])
        by mx.google.com with ESMTPS id g10sm8418278fai.0.2010.05.27.19.11.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 19:11:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o4S2DDbU008055;
	Fri, 28 May 2010 04:13:24 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o4S2CvW7008051;
	Fri, 28 May 2010 04:12:57 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1274948384-167-1-git-send-email-abcd@gentoo.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147911>

Jonathan Callen <abcd@gentoo.org> writes:

> This series of patches adds support for building git on Interix.
> 
> Interix is an interesting system, as it lacks some functions that are
> normally present on POSIX systems, such as poll().  As I did not have
> time to implement poll() on top of select(), these patches simply
> disable the three commands that require poll() to be present:
> git-daemon, git-upload-archive, and git-upload-pack.
> 
> Jonathan Callen (3):
>       Support building on systems without poll(2)
>       Support building without inttypes.h
>       Add Interix support
> 
>  Makefile          |   40 +++++++++++++++++++++++++++++++++++-----
>  builtin.h         |    2 ++
>  git-compat-util.h |    6 ++++++
>  git.c             |    2 ++
>  4 files changed, 45 insertions(+), 5 deletions(-)

Could you please, if you can, add support for detecting existence of
poll(2) and existence of inttypes.h to configure.ac, to make it
automatically detected by

  $ make configure
  $ ./configure [options]

Thanks in advance.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
