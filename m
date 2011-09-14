From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] contrib: add a credential helper for Mac OS X's keychain
Date: Wed, 14 Sep 2011 14:19:41 -0400
Message-ID: <CAG+J_DzfcNfp8r6g09DChUrUxgDbFC3O=zi0FSuD5eS+XwAjbw@mail.gmail.com>
References: <1316023117-84755-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 20:19:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3u3q-0001gf-CV
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259Ab1INSTn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 14:19:43 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:41503 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162Ab1INSTm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 14:19:42 -0400
Received: by yie30 with SMTP id 30so1631286yie.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UdVCYxrWuXISW9TWrh9qF96+lbSpH9z7+R/RfnoEm50=;
        b=XOwTv8VLcrqmAWmMx24A6s/o/aXFNzsZ7udG7l/T00NPynnv0uDpKNe0NEbaW8mhtP
         MKXT1hdQWkvLWRXIxmOm3KSWZNPnJIoxIoy5Y2n+DM0a+Gmk7JH5mzhJGKi7uV+NQU12
         eAO7OsnvdirAyQj06r4bCIvofb/tt5AMEIJQ8=
Received: by 10.236.76.230 with SMTP id b66mr1128223yhe.8.1316024381499; Wed,
 14 Sep 2011 11:19:41 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 14 Sep 2011 11:19:41 -0700 (PDT)
In-Reply-To: <1316023117-84755-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181371>

On Wed, Sep 14, 2011 at 1:58 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> diff --git a/contrib/credential-osxkeychain/git-credential-osxkeychai=
n.c b/contrib/credential-osxkeychain/git-credential-osxkeychain.c
> new file mode 100644
> index 0000000000..64bcc636cb
> --- /dev/null
> +++ b/contrib/credential-osxkeychain/git-credential-osxkeychain.c
>
> [...]
>
> +int find_internet_password(SecProtocolType protocol,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0char *hostname,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0char *username)
> +{
> + =C2=A0 =C2=A0 =C2=A0 void *password_buf;
> + =C2=A0 =C2=A0 =C2=A0 UInt32 password_len;
> + =C2=A0 =C2=A0 =C2=A0 OSStatus status;
> + =C2=A0 =C2=A0 =C2=A0 char *password;
> + =C2=A0 =C2=A0 =C2=A0 int free_username;

int free_username =3D 0;

j.
