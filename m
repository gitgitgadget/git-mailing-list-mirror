From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Add test-string-list.c
Date: Mon, 6 Sep 2010 20:48:29 -0300
Message-ID: <AANLkTi=J_0XaVYUt8Umu3uW15W86wbWv-xCMuVGA7cUE@mail.gmail.com>
References: <4f798daaf4631e00927b455b77919d5bb8fade03.1283653854.git.tfransosi@gmail.com>
	<20100905050254.GA6134@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 01:48:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OslQU-0004D7-52
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 01:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929Ab0IFXsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 19:48:32 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46388 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0IFXsa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 19:48:30 -0400
Received: by qwh6 with SMTP id 6so4202159qwh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 16:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5eyZn4sCnWoRp41OEK5MXdo6zlV+449WH+teVHIcGw8=;
        b=xlva7kjiUzmUjhkQTexratOOdex0FH1LbXcaby56BoEZnDgr1z2bddM8w8hWX/XoPX
         dQH/BQVslvDd9UvSdUKCmZhw7Rvo1nojvBb3qfz7Xx0Mvd5bqpaIT8cKkQYcpkBIYF7e
         /frd47rWAKuWaQABZ4dwGUPtjBu0K4BF7kOWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N3K2smO9hl4stpMVoLgR90h69d/M8BnQOIPnE2my0k4S+qO5JtECqRt/w4cyBVBVcN
         WAECeJeeIak/wEKaZJwuz9IjJNEeBULOPY1UIRCSEFHRalClE4W8lfnEeT13Iy3MVBnu
         mIPLJw/OJVlDYUKjmhrsmrLBy6IdhnNo+ndSA=
Received: by 10.229.52.32 with SMTP id f32mr3015900qcg.265.1283816909293; Mon,
 06 Sep 2010 16:48:29 -0700 (PDT)
Received: by 10.229.245.202 with HTTP; Mon, 6 Sep 2010 16:48:29 -0700 (PDT)
In-Reply-To: <20100905050254.GA6134@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155643>

On Sun, Sep 5, 2010 at 2:02 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:>
>
> Git programs tend to start with
>
> =C2=A0#include "cache.h"
>
> or
>
> =C2=A0#include "git-compat-util.h"
>
> to get all the portability niceties.
>
Including it now.

>> + =C2=A0 =C2=A0 print_string_list(&list, "");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int has_foo =3D string_list_has_string(=
&list, "foo");
>
> Whitespace, declaration after statement... (see
> Documentation/CodingGuidelines).
>
=46ixed.

>> + =C2=A0 =C2=A0 if (has_foo !=3D 1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("List doesn't have=
 foo.");
>
> This does not exit with nonzero status when it fails. =C2=A0You proba=
bly
> wanted
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bad things)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error("=
problems!");
>
=46ixed.

>> + =C2=A0 =C2=A0 string_list_clear(&list, 0);
>> + =C2=A0 =C2=A0 if (list.nr > 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("List is not clear=
=2E");
>
> To make sure this example remains valid, wouldn't you want to include
> a caller in the t/ directory so it can be automatically run? =C2=A0(S=
ee
> t/README.)
>
I read it, but I'm not sure how to do this. Maybe you could point me
to an example?

> Thoughts separate from the code:
>
> =C2=A0* for this to be useful as a test I think one has to sort of be=
lieve
> =C2=A0 that it can break. =C2=A0That is, a test of something this bas=
ic (which
> =C2=A0 is already demonstrated and exercised by code throughout git, =
after
> =C2=A0 all) would tend to be especially devious.
>
It is basic, so anyone can read it, and say "Oh, I can do this.".
Looking through the code maybe not so easy.

It can be expanded later by anyone to test many other things though.
So, why not? (Is it so bad to not have it at all?).
