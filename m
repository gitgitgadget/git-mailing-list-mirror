From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv7.2 0/4] Gitweb caching v7.2
Date: Sat, 13 Nov 2010 00:35:46 +0100
Message-ID: <201011130035.50229.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <1288607092-31458-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 13 00:36:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH3A7-0002VP-Gn
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 00:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933154Ab0KLXgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 18:36:03 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45576 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157Ab0KLXgB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 18:36:01 -0500
Received: by fxm6 with SMTP id 6so593238fxm.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 15:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=HTP8kpQJQKduBOYYWv9jLdY6xgFzqTznq57PpzKyOvw=;
        b=W7S1x7lPKJpfFfxssovqgiVUDKBK7RYneOkzx6OSqZgdr9Rv1huZ75WUTVf3GYKqrv
         Xm1ZQdBZNZntZ0I6IW+Q5uu4UcUQk8TfNW06iqVIj9l4CjRMAvohZde2re+W5G8PZ+pR
         0Gw9IHcOiNIJcIeZfyLjgYHLNbjvteynMtx/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MaCkZyUoQeEwJJ+f1d9sHualJxtwnhGD6hNod0HA/rzqMe9kBJOfmddnVyu8HgVFVV
         l8mOa6+uUm4jZ/g8mx3wb5prFGWhfhTKZru7vMzV8jd0IquYTW7zkgFaTaRI2Ck+WGSA
         OFNBnNjaJeNjH6YF/HH3B6/vHSbXv3jCoKbps=
Received: by 10.223.109.199 with SMTP id k7mr2132381fap.93.1289604958041;
        Fri, 12 Nov 2010 15:35:58 -0800 (PST)
Received: from [192.168.1.13] (abwe118.neoplus.adsl.tpnet.pl [83.8.228.118])
        by mx.google.com with ESMTPS id p18sm200942faa.40.2010.11.12.15.35.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 15:35:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1288607092-31458-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161368>

This series is a bit fixed up and a tiny bit cleaned up version of
"Gitweb caching v7" series from John 'Warthog9' Hawley:
  http://thread.gmane.org/gmane.comp.version-control.git/160147

This series is based on top of 'next', because it contains 
'jn/gitweb-test' branch.

The difference from v7.2 is that it takes into account 'test-installed'
target in gitweb/Makefile in first patch of its series, and that testing
of caching support is slightly extended.  Note that some of those tests
fail currently, not because of error in gitweb caching code, but because
I was not able to disable calling cacheWaitForUpdate(), which hinders
testing.

Those differences were also described in "Re: What's cooking in git.git
(Nov 2010, #01; Tue, 9)":
  http://article.gmane.org/gmane.comp.version-control.git/161309


Table of contents:
==================
 [PATCHv7.2 1/4] gitweb: Prepare for splitting gitweb
 [PATCHv7.1 2/4] gitweb: add output buffering and associated functions
 [PATCHv7.1 3/4] gitweb: File based caching layer (from git.kernel.org)
 [PATCHv7.2 4/4] gitweb: Minimal testing of gitweb caching

Shortlog:
=========
Jakub Narebski (2):
  gitweb: Prepare for splitting gitweb
  gitweb: Minimal testing of gitweb caching

John 'Warthog9' Hawley (2):
  gitweb: add output buffering and associated functions
  gitweb: File based caching layer (from git.kernel.org)

Diffstat:
=========
 gitweb/Makefile                           |   20 ++-
 gitweb/gitweb.perl                        |  134 +++++++++++-
 gitweb/lib/cache.pl                       |  348 +++++++++++++++++++++++++++++
 gitweb/static/gitweb.css                  |    6 +
 t/gitweb-lib.sh                           |   15 ++
 t/t9500-gitweb-standalone-no-errors.sh    |   20 ++
 t/t9501-gitweb-standalone-http-status.sh  |   13 +
 t/t9502-gitweb-standalone-parse-output.sh |   33 +++
 8 files changed, 579 insertions(+), 10 deletions(-)
 create mode 100644 gitweb/lib/cache.pl

-- 
1.7.3
