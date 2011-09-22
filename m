From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Thu, 22 Sep 2011 02:07:59 +0000
Message-ID: <CAMOZ1Bt6gGVd6QuRZduZ4mJ=eoZ9d7xK-WfwZ3G-+oswT0RN_Q@mail.gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
 <7vwrd1z9it.fsf@alter.siamese.dyndns.org> <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	computerdruid@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 04:08:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6YiQ-0004sx-Rt
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 04:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab1IVCIb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Sep 2011 22:08:31 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53592 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab1IVCI3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 22:08:29 -0400
Received: by qyk30 with SMTP id 30so5702301qyk.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 19:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Yt05ZRLav9PzQ6DBUNKMdfB/va9KWhi6AW2H1jMtBZQ=;
        b=xQjB9jIOdRI5C7xwUvChC9tsEv8fI0sxeDeNoJPDWCqvRDmoJe9qE/yNdo2a3gQ2vJ
         yINlM7HWo/pZBxJmYof6zRPJSWaml0yVOthtAjbZ6tvsXzuW1SZP7ChbGVQmgwPRXply
         aoO5CXVZrOUfSIru0Sb7h5uuVi1hQzFk8RwLY=
Received: by 10.224.201.2 with SMTP id ey2mr282569qab.3.1316657309094; Wed, 21
 Sep 2011 19:08:29 -0700 (PDT)
Received: by 10.229.233.6 with HTTP; Wed, 21 Sep 2011 19:07:59 -0700 (PDT)
In-Reply-To: <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181874>

On Thu, Sep 22, 2011 at 02:01, Michael Witten <mfwitten@gmail.com> wrot=
e:
> On Thu, Sep 22, 2011 at 00:49, Junio C Hamano <gitster@pobox.com> wro=
te:
>> --tags is merely a short-hand for "refs/tags/*:refs/tags/*")
>> explicitly from the command line
>
> [Disclaimer: I don't know the code or the semantics]
>
> Why not just use that explanation?
>
> =C2=A0This option is merely a short-hand for writing
> =C2=A0the refspec `refs/tags/*:refs/tags/*'; consequently,
> =C2=A0using this option overrides any default refspec that
> =C2=A0would be used if no refspec were provided on the
> =C2=A0command line. That is,
>
> =C2=A0 =C2=A0git fetch --tags origin frotz
>
> =C2=A0is equivalent to:
>
> =C2=A0 =C2=A0git fetch origin frotz 'refs/tags/*:refs/tags/*'
>
> In fact, if the command line parsing performed by `git fetch'
> is reasonably intelligent, then it might be worthwhile
> to relocate `--tags' in the example:
>
> =C2=A0That is,
>
> =C2=A0 =C2=A0git fetch origin frotz --tags
>
> =C2=A0is equivalent to:
>
> =C2=A0 =C2=A0git fetch origin frotz 'refs/tags/*:refs/tags/*'
>

Maybe this is less confusing for the example:

  That is,

    git fetch origin --tags
    git fetch origin frotz --tags bar

  are equivalent to:

    git fetch origin 'refs/tags/*:refs/tags/*'
    git fetch origin frotz 'refs/tags/*:refs/tags/*' bar
