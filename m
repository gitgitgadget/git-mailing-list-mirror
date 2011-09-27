From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH v2] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Tue, 27 Sep 2011 17:09:58 +0000
Message-ID: <CAMOZ1BuK1dNdW9gVSnXCwtUBYL7Ef-4-uNNyTMf-wwVCa+0tuw@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr> <CAMOZ1Buf5KxbN59o8QK_dMmF_SEY_Ckuz4DALorZpwuL9gx-Pg@mail.gmail.com>
 <vpq8vpa2agq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 27 19:10:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8bAw-0007vD-3z
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 19:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568Ab1I0RK3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 13:10:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42807 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab1I0RK2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 13:10:28 -0400
Received: by iaqq3 with SMTP id q3so5918785iaq.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zRmJaXll+yV4EMFjlk9wJb0+lQ76NVuOByoQ1qVDDhE=;
        b=t+Yre+7fpy9glwNFQIsRNdgXXNTJOBpwPNoifov7cDE2xfeGuTEStc6inLirPgXm+/
         4zH+5tt7PWFnOnk0ouDy6QQO4rls0FUWuyvw5MGYj1xmivdEhitfGyHXMkMnuVIwQIPv
         fX8TmlMK4yNQzYWIrRmTgYtTqKkf7XxIMqpYI=
Received: by 10.42.134.4 with SMTP id j4mr10044692ict.135.1317143428109; Tue,
 27 Sep 2011 10:10:28 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Tue, 27 Sep 2011 10:09:58 -0700 (PDT)
In-Reply-To: <vpq8vpa2agq.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182253>

On Tue, Sep 27, 2011 at 16:53, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:

> Michael Witten <mfwitten@gmail.com> writes:
>
>> I think that the last paragraph provides enough context to understan=
d
>> its usefulness.
>
> The last paragraph tells the user how to commit something different f=
rom
> what is already here, which is pretty much the opposite.
>
> IOW, I see two uses for --orphan:
>
> 1) Publish the same tree without its history
>
> 2) Start a different project, but for some reason you wanted it to le=
ave
> =C2=A0 in the same repository and you didn't want a "git init".
>
> The next paragraph documents 2), but your removed paragraph was
> documenting 1). Reading the new version, it feels like the user is
> encourraged to modify the index, while it's just an option.

Those 2 uses are not really different; both are manifestations of
creating a new root commit using some tree.

The way I see it, people would think:

   1. I've got to get rid of this proprietary stuff
      before I publish as open source.

   2. I'll need a new root commit for the open source
      stuff, too, otherwise it'll still be accessible.

  3a. Aha! I can create a root commit based on the
      proprietary stuff, but altered in any way that
      I need.

  3b. Aha! I've already got a cleaned commit, I can
      just use that as the basis for the root commit
      without further alteration.

In any case, removing history is probably better handled by
filter-branch or rebase, as I bet more often than not there are
existing descendants of the proposed root commit that need to be
played back anyway.
