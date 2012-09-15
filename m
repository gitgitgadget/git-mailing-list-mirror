From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Please pull git-l10n updates for git v1.7.12-146-g16d26
Date: Sat, 15 Sep 2012 09:34:39 +0800
Message-ID: <CANYiYbGJP3rpd+t-gVSc0EpbHg9e_8_z24S6v0g2bT72+faj2Q@mail.gmail.com>
References: <CANYiYbExJRAK0zvO4FSce2tOTyW1fLW1OLqZSm0KLjG1V4nTbg@mail.gmail.com>
	<CACsJy8A-prPd=5R83LhcLO1rd-rBZRhfnvABvzvdDiC=hZ3ofQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 03:35:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TChIL-0008Bq-K2
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 03:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab2IOBel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 21:34:41 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61670 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab2IOBek (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 21:34:40 -0400
Received: by iahk25 with SMTP id k25so3933414iah.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 18:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=naraIay5zXqMCuEoXvXlwVJD0pYyo1o0lNcrXLIJkDU=;
        b=wZXULu8EuI+3VVLbVVShiEKEGgoFvqzZV6F97WUFe3vTewD2VASFAnfxsOpZABnBWR
         +6BWcZlrUX/M9VTJAqJ68ZSdLKHeSnjCAuTl3sXfsN5rdmzh9YKTRqTSCfG85pQYt25j
         wb4lQlxfQ1LTlN8RHo5FhO0ZX+xnjct914IhNxafm/LgpT3Zk+KbAqWea5KIE63pful6
         e+sn8ITZHg9x/GRGN8lcAjThbeIi1PerwniKaN5D6pgLe9CXdpa3d98ocHsRp9btBmS3
         hFLpSTvnqEYpbB4UDAy9dI96bqUhM0cbHm/fw8ppFXdmUxaq/oCZ6udV4GZUykR2cfBH
         PnYA==
Received: by 10.50.219.229 with SMTP id pr5mr253725igc.59.1347672879357; Fri,
 14 Sep 2012 18:34:39 -0700 (PDT)
Received: by 10.50.42.230 with HTTP; Fri, 14 Sep 2012 18:34:39 -0700 (PDT)
In-Reply-To: <CACsJy8A-prPd=5R83LhcLO1rd-rBZRhfnvABvzvdDiC=hZ3ofQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205543>

2012/9/14 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> (Dropping translators as they probably are not interested in this)
>
> I saw a gnu project does this (I don't remember what project). If we
> update .po* files with --no-location, we can avoid a lot of diff
> noises due to line number changes. A typical translator does not care
> about these lines anyway. Those who do can easily search the string in
> source files without them.

I believe some translators need these location infomation to find the
context. In order to squelch noise, users can:

1. Define a new diff driver, such as:

    $ git config --global diff.podiff.textconv "sed -e '/^#/ d'"

2. Add two lines in .git/info/attributes to use this driver for po/pot files:

    *.po diff=podiff
    *.pot diff=podiff

--
Jiang Xin
