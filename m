From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Need to set GIT_WORK_TREE when setting GIT_DIR !?
Date: Sat, 10 Mar 2012 08:11:19 -0600
Message-ID: <20120310141119.GA11178@burratino>
References: <CALeToSUaPzdr=u7FfwHEtEanphVP5LZ09QdQXno52PLBTK0H-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 15:11:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6N1C-0004Cw-33
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 15:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab2CJOL3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Mar 2012 09:11:29 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46957 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab2CJOL2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Mar 2012 09:11:28 -0500
Received: by iagz16 with SMTP id z16so3869548iag.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 06:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5jgSjmLCQ2zIDODN4aRFL3oGoalDdVyda0pNdUCpAm8=;
        b=bRjNVORMHzqSagogitt2NahStEQqj3/bR5cRvS+JnJ9fTLQZ7c5m+7wVAy30s+C1qt
         wP4p3XDsQJECtx6dd8uP7VCoFo+Yb4rxoL82nI9L9ALT2WVghR3qpJZ1cy3bHJA4ae92
         2Kv4rnlZMhYWlRWprsY2JQYSoKXKt1ru5rpn36IUK4Se/snP61ZhEazCfFbqssfN5w3u
         lOXvmR9+wbFT73fcbbKAdM8GEWKzensSgI+SKuJQACQf2s34JelK7A9AE8IJAvW/IErT
         cRYdGcnkMvLK9EOyTtTWeJfoMk6YgpKs8Kvpm07HWvUfYCNHtagw0HUK7LGDL9vGVmlv
         k2QA==
Received: by 10.42.136.5 with SMTP id r5mr7959778ict.12.1331388688200;
        Sat, 10 Mar 2012 06:11:28 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id uy10sm4146419igc.15.2012.03.10.06.11.27
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 06:11:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALeToSUaPzdr=u7FfwHEtEanphVP5LZ09QdQXno52PLBTK0H-g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192784>

Hi,

=46r=C3=A9d=C3=A9ric Heitzmann wrote:

> export GIT_DIR=3D$PWD/.gita &&
> git init

This is where the recipe goes wrong.  It creates a bare repository.
Using vi or "git config" to edit its configuration to set the "[core]
bare" setting to false would change that.

The git-config(1) manpage says:

	By default a repository that ends in "/.git" is assumed to be
	not bare (bare =3D false), while all other repositories are
	assumed to be bare (bare =3D true).

and the logic in builtin/init-db.c seems to agree.

Maybe there is a better place to document this.  Improvements
welcome.

Thanks,
Jonathan
