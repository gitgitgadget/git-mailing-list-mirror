From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 4 to 6/3] Move remaining header files into a include/
 subdirectory
Date: Thu, 17 Feb 2011 22:29:16 -0600
Message-ID: <20110218042916.GC15643@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <20110218023750.GD23435@elie>
 <AANLkTi=VhJi4eDrtRPHukckQKo9TYCcnh1_u0_tnv24z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 05:29:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqHyB-0007h4-6J
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 05:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488Ab1BRE3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 23:29:23 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41237 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab1BRE3V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 23:29:21 -0500
Received: by iyj8 with SMTP id 8so3115343iyj.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 20:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZMoR7SGH4ZTaA6asvIK8MLO6u2V3CFZYY2QAxUk7V6Y=;
        b=JQXCJ88nZCyhsDyB+WU5PzlscB0rAV/hbnWxElw0CR8+rIGXjKaPo0leK7kBOfbqVZ
         IWO/cRPB3YXIHwt/iiAXsPQBVgAAf3r9sq7CYU+d/ahoS4lsrw0UcYrjLS9c1vGd85X9
         AJJ2VC7Lk7K5opsqkUcvYG4P/zekN/y07BuuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a7uQLuC2JEjhls6sW0e3PFeTg7x9xM+uGaeOVmRh/Xmrx9V4hkbGfX0hiwV+p192+j
         1eKt+FJYaLIlzb4Bwg41mmdhRqVEUqyf1saHguiAqXVBPCGJMDbKOjzmIUF5sc1j9OOH
         iw1cUkGkpFt9J0ZNQ5s/EMkrsKouShzT/ySCg=
Received: by 10.42.164.74 with SMTP id f10mr343011icy.92.1298003361087;
        Thu, 17 Feb 2011 20:29:21 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.ameritech.net [69.209.72.148])
        by mx.google.com with ESMTPS id u9sm1332047ibe.20.2011.02.17.20.29.19
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 20:29:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=VhJi4eDrtRPHukckQKo9TYCcnh1_u0_tnv24z@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167165>

Nguyen Thai Ngoc Duy wrote:

> Perhaps it's time to split a large portion of cache.h to libgit.h and
> make cache.h include libgit.h.

Interesting idea.  Is this a sneaky way of renaming cache.h to git.h?
Which translation units could include libgit.h without cache.h?

> cache.h and git-compat-util.h at topdir is ok to me. strbuf.h should
> go to libgit though, imo.

If libgit is to be self-contained, they all should be in libgit.
Not sure how I feel about that.

Here's a series to move those three headers to include/.

Jonathan Nieder (3):
  compat: do not use relative paths for git-compat-util.h et al
  block-sha1: do not use relative path for git-compat-util.h
  Move git-compat-util.h et al to include/

 Makefile                                       |    6 +++---
 block-sha1/sha1.c                              |    2 +-
 compat/basename.c                              |    2 +-
 compat/cygwin.c                                |    4 ++--
 compat/fopen.c                                 |    2 +-
 compat/inet_ntop.c                             |    2 +-
 compat/inet_pton.c                             |    2 +-
 compat/memmem.c                                |    2 +-
 compat/mingw.c                                 |    4 ++--
 compat/mkdtemp.c                               |    2 +-
 compat/mmap.c                                  |    2 +-
 compat/msvc.c                                  |    4 ++--
 compat/pread.c                                 |    2 +-
 compat/qsort.c                                 |    2 +-
 compat/setenv.c                                |    2 +-
 compat/snprintf.c                              |    2 +-
 compat/strcasestr.c                            |    2 +-
 compat/strlcpy.c                               |    2 +-
 compat/strtok_r.c                              |    2 +-
 compat/strtoumax.c                             |    2 +-
 compat/unsetenv.c                              |    2 +-
 compat/win32/dirent.c                          |    2 +-
 compat/win32/pthread.c                         |    2 +-
 compat/win32/syslog.c                          |    4 ++--
 compat/win32mmap.c                             |    2 +-
 compat/winansi.c                               |    2 +-
 cache.h => include/cache.h                     |    0
 git-compat-util.h => include/git-compat-util.h |    0
 strbuf.h => include/strbuf.h                   |    0
 29 files changed, 32 insertions(+), 32 deletions(-)
 rename cache.h => include/cache.h (100%)
 rename git-compat-util.h => include/git-compat-util.h (100%)
 rename strbuf.h => include/strbuf.h (100%)

-- 
1.7.4.1
