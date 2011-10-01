From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git, Mac OS X and German special characters
Date: Sat, 01 Oct 2011 16:14:45 -0700 (PDT)
Message-ID: <m3hb3snw4b.fsf@localhost.localdomain>
References: <CAO1Q+jf=RO=sE90-mQdi+=fUWH1RLM+JTubSgSVGC5uDyhU+2A@mail.gmail.com>
	<4E87182C.8050201@op5.se>
	<CAO1Q+jeLEp2ReNc9eOFoJxdGq6oRE3b+O=JvMNU0Kqx_eAX=7w@mail.gmail.com>
	<4E872288.10503@op5.se> <20111001194746.GA16826@inner.h.iocl.org>
	<CAMOZ1BuXiQkZG_7mvay-ybm7Q7niwXVhbmbCmkfy=wD1AKsasQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Krey <a.krey@gmx.de>, Andreas Ericsson <ae@op5.se>,
	Albert Zeyer <albzey@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 02 01:15:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA8m1-0001MQ-2S
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 01:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193Ab1JAXO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 19:14:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36481 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157Ab1JAXOu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 19:14:50 -0400
Received: by bkbzt4 with SMTP id zt4so3448868bkb.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=/besPMvTeg8RdVQSfi3KHXi+qGA3gTyUuDSbjzJgQL0=;
        b=Uhl1Dduf6UJ8Cm3wMalJiuDKkkk1cP+bpupZjkC/sZWqlTti1eLXTBekie5lxfcYcP
         nrQJRIc7d6fm/hbzzQ8dZy17slq84Bvr3/pzCsRUAOKUT2SFTVhvWSMZNiqK8AOs3FsJ
         mPZjSeqTkDy47pey1XFvB0khoZcUu9eLODnNk=
Received: by 10.223.48.86 with SMTP id q22mr20978532faf.127.1317510888546;
        Sat, 01 Oct 2011 16:14:48 -0700 (PDT)
Received: from localhost.localdomain (abws180.neoplus.adsl.tpnet.pl. [83.8.242.180])
        by mx.google.com with ESMTPS id y8sm13685515faj.10.2011.10.01.16.14.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Oct 2011 16:14:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p91NE5OT027969;
	Sun, 2 Oct 2011 01:14:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p91NDeVH027964;
	Sun, 2 Oct 2011 01:13:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAMOZ1BuXiQkZG_7mvay-ybm7Q7niwXVhbmbCmkfy=wD1AKsasQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182581>

Michael Witten <mfwitten@gmail.com> writes:
> On Sat, Oct 1, 2011 at 19:47, Andreas Krey <a.krey@gmx.de> wrote:
>=20
> > The question is, should git forbid two filenames that consist
> > of the *same* characters, only differently uni-encoded? I don't
> > think anyone would make two files named 'B=FCro', with different
> > unicode encodings. But as far as I know that is a shady area.
>=20
> So, let's leave git's current behavior as the default and provide
> a config variable that when set, tells git to handle file names
> in terms of characters rather than bytes.

You meant here _graphemes_, not Unicode codepoint when talking about
characters, didn't you?

IIRC the problem with MacOS X is that it accepts different composition
when creating a file from what it returns when asking for contents of
directory (NFD if I remember correctly, which is less used).


There are some beginnings of sanely handling filesystem encoding in
Git (the framework), but it is currently underutilized only to handle
case-sensitivity and case-preserving.

--=20
Jakub Nar=EAbski
