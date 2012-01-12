From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 06/10] clone: delay cloning until after remote HEAD checking
Date: Thu, 12 Jan 2012 08:27:33 +0700
Message-ID: <CACsJy8AJxRDkz9-pm5aW70zj8AyBt1WqfSu7w45avDOVj26DpQ@mail.gmail.com>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
 <1326189427-20800-7-git-send-email-pclouds@gmail.com> <7v8vle6ng3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 02:28:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl9Sv-0001Vy-6H
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 02:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab2ALB2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 20:28:08 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58833 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab2ALB2F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 20:28:05 -0500
Received: by bkvi17 with SMTP id i17so887343bkv.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 17:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WXaGYYz0m1HOpxmfkNXFdq7Wx3YqcbQh5xs6bG1yX2M=;
        b=pBb2Wm5brbS1iqePUFTZeZm58NIvPTMJ61tP3cAvNQH4uGQ2MBniZ1oVu7xcdLieHe
         wgNgOoA4SAB7pBZR6yot65lP+xORjcAufPHqSydANET9H3S2dGWN0IVP+9z31sRIv8CS
         YreZwdx4yBCj0GEbM01UXPdqk45iiWmui3ID8=
Received: by 10.205.132.14 with SMTP id hs14mr396228bkc.130.1326331684135;
 Wed, 11 Jan 2012 17:28:04 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Wed, 11 Jan 2012 17:27:33 -0800 (PST)
In-Reply-To: <7v8vle6ng3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188411>

2012/1/12 Junio C Hamano <gitster@pobox.com>:
>> @@ -938,6 +940,7 @@ struct transport *transport_get(struct remote *r=
emote, const char *url)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *handler =3D x=
malloc(len + 1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 handler[len] =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(handler, ur=
l, len);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remote->foreign_vcs =3D =
helper;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 transport_helper_in=
it(ret, handler);
>> =C2=A0 =C2=A0 =C2=A0 }
>
> This I am not sure. What value does "helper" variable have at this po=
int
> in the flow? Wouldn't it be a NULL? Or did you mean "handler"?

Ah yes "handler", my bad.
--=20
Duy
