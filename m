From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Fri, 27 Jan 2012 01:02:52 +0100
Message-ID: <CACBZZX5_qjC6WZsZ9hKvSR5vQJPs=jgWn-R4EnWZGVq+RvjRyg@mail.gmail.com>
References: <20120126073547.GA28689@sigill.intra.peff.net> <20120126073752.GA30474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 27 01:03:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqZHj-0002FY-J5
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 01:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab2A0ADP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jan 2012 19:03:15 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:41925 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752176Ab2A0ADO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 19:03:14 -0500
Received: by lagu2 with SMTP id u2so657459lag.19
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 16:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Q1CVCgSD2VIGLtl/w2UsK20MvSYb3mJg937WubaBoMM=;
        b=cN9zqQkfnR4Z1CBDGl2Vz6SQpa90w23QNo66PRovc6IrdmZ8qtjTssU+cQGKT1ro5E
         UQ2mTl2k2bZnzbweEK2y/cPpA9HXI1wjtUId37lmM34sBEUau8TO36NkPa3dy6O62uM9
         gSAC/VwqgoLJcHjCPKmrnu7AWHwzeBTVKpVtk=
Received: by 10.152.144.133 with SMTP id sm5mr2391183lab.38.1327622593152;
 Thu, 26 Jan 2012 16:03:13 -0800 (PST)
Received: by 10.112.48.9 with HTTP; Thu, 26 Jan 2012 16:02:52 -0800 (PST)
In-Reply-To: <20120126073752.GA30474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189175>

On Thu, Jan 26, 2012 at 08:37, Jeff King <peff@peff.net> wrote:
> This patch introduces an include directive for config files.
> It looks like:
>
> =C2=A0[include]
> =C2=A0 =C2=A0path =3D /path/to/file

Very nice, I'd been meaning to resurrect my gitconfig.d series, and
this series implements a lot of the structural changes needed for that
sort of thing.

What do you think of an option (e.g. include.gitconfig_d =3D true) that
would cause git to look in:

    /etc/gitconfig.d/*
    ~/.gitconfig.d/*
    .git/config.d/*

As well as the usual:

    /etc/gitconfig
    ~/.gitconfig
    .git/config

It would make including third-party config easy since you could just
symlink it in, and it would follow the convention of a lot of other
programs that have a foo and a foo.d directory.
