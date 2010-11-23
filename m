From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 6/6] win32: use our own dirent.h
Date: Tue, 23 Nov 2010 11:45:19 -0600
Message-ID: <20101123174519.GE12113@burratino>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
 <1290533444-3404-7-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 18:45:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwwC-0003mm-JO
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992Ab0KWRpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 12:45:30 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36829 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab0KWRp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 12:45:28 -0500
Received: by wwa36 with SMTP id 36so8933375wwa.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qf3xPLBBMuVob3+xxE97uZZyvvuukIa/imUf0syK8PM=;
        b=VTVmJmyrWFtEn9dhZpn2FzPuoMnX1zClo4xi5yssgyVU5FyYFlh8QWo7GUQcDuXy/4
         /+Hb8seilQErNqJOzHtAQz5mB56+Htar1KXoNej3NzBNtNJ8SIBsdSRyjqQmziHyx/gY
         rvjAk5vsTMX1gOGpX96LlYLXQ0Essbd2IaZOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=b620uWzZMZSysbefPHDfHuQ1J7d31zjkQqR/7xJl3y+tI1cZH7T+rRHA2wOPu7v+FX
         uw6iliSmo2L7X1dCVF0oOtRo9BB+n5wWNiPf1kbJJORwNVP/I3x5JgxCrLw7xYe5yIb3
         2uXCuUZDvxaAE4u/5T1lk0tV3uJwrz3jiJMd0=
Received: by 10.227.9.148 with SMTP id l20mr8041815wbl.184.1290534325014;
        Tue, 23 Nov 2010 09:45:25 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id y15sm2990887weq.30.2010.11.23.09.45.23
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 09:45:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290533444-3404-7-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161994>

Erik Faye-Lund wrote:

> This provides a generic Win32-implementation of opendir, readdir
> and closedir which works on both MinGW and MSVC and does not reset
> errno, and as a result git clone is working again on Windows.

Nice!  Thanks.

>  Makefile                        |    7 ++-
>  compat/mingw.c                  |   60 ------------------
>  compat/mingw.h                  |   29 ---------
>  compat/msvc.c                   |   49 ---------------
>  compat/vcbuild/include/dirent.h |  128 ---------------------------------------
>  compat/win32/dirent.c           |  105 ++++++++++++++++++++++++++++++++
>  compat/win32/dirent.h           |   24 +++++++
>  7 files changed, 134 insertions(+), 268 deletions(-)
>  delete mode 100644 compat/vcbuild/include/dirent.h
>  create mode 100644 compat/win32/dirent.c
>  create mode 100644 compat/win32/dirent.h

Does this diff get smaller with -M -C -C -C?
