From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: config-file includes
Date: Mon, 26 Sep 2011 22:13:44 -0400
Message-ID: <CAG+J_Dw3B0qReTevph725sPatpKDzikC=W0XTvKo4GsYLVcL4w@mail.gmail.com>
References: <20110923195829.GA27677@sigill.intra.peff.net>
	<CACsJy8BAVRAct=sxTpZ+b-ft1OjbY9oZG6uEXrcsTXw3CXnwSg@mail.gmail.com>
	<20110926192126.GA55743@gmail.com>
	<20110926200553.GA492@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 27 04:13:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8NB8-0007XM-P3
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 04:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab1I0CNq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 22:13:46 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:50292 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab1I0CNp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 22:13:45 -0400
Received: by yib18 with SMTP id 18so4796563yib.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 19:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=RRNsXRe2Q7bb2XZ3GTB2Nhzh4l6JPvAmU1/P9AlgLN4=;
        b=NCrClS9t5xqZsBPooP2jnV8DcYI5be/3GVpqReBB5hlR4RDChTg6fpv05e3RjdGFog
         HvEihTAZquTOWPFI97yZqCTQqfgfFaQnW2LxWQaq8XUZtlVy5dxqun04xf3sL+PFPx8k
         YEA6o9wgCLs4y1LRkDhnb7tOlQHqTfPQfAN6Q=
Received: by 10.147.5.21 with SMTP id h21mr438067yai.26.1317089625020; Mon, 26
 Sep 2011 19:13:45 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Mon, 26 Sep 2011 19:13:44 -0700 (PDT)
In-Reply-To: <20110926200553.GA492@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182203>

On Mon, Sep 26, 2011 at 4:05 PM, Jeff King <peff@peff.net> wrote:
>> [include-ifdef "darwin"]
>> =C2=A0 =C2=A0 =C2=A0 path =3D ~/.gitconfig-darwin
>
> Thanks for another concrete example.
>
> I'm not sure how that would be implemented, though. I don't think git
> knows that it is compiled for darwin. Would it just be running "uname
> -s" behind the scenes? Should it happen at runtime, or as part of the
> compile process?
>
> We could allow arbitrary shell code like:
>
> =C2=A0[include-if "test `uname -s` -eq Darwin"]
>
> Very flexible, though it makes me think we are getting a little
> overboard. =C2=A0And it's an extra shell invocation whenever we read =
the
> config, which is ugly.

I would think git could just learn a few useful defines at the time of
compile, such as e.g. OS_Darwin would be more than sufficient.

I can also give you another use use case. I keep all my work repos
under ~Work/ and I want my user.email on all those to be my work email
addy, and all other repos on my system I want to use my personal email
address. So my ~/.gitconfig has my personal email address and then 99%
of the time I forget to configure the repos under ~/Work correctly.
That said, I'm not sure how the config include would help this...

j.
