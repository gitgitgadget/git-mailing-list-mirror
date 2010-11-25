From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Thu, 25 Nov 2010 13:34:33 +0100
Message-ID: <AANLkTi=N=-e+BYM+Bjp665pN=GxK5fWSKbJ34T8Qfh77@mail.gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org> <AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
 <AANLkTinWtG8dp_CvoH+EWYz4d=D-N0QUiBSrCNwamROo@mail.gmail.com> <AANLkTim0hYKcPPaZjxjbpekhR4Ho_cOVaE=41HyJOrMZ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 13:35:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLb2X-00087b-J3
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 13:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab0KYMe4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 07:34:56 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64371 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979Ab0KYMez convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 07:34:55 -0500
Received: by fxm13 with SMTP id 13so720532fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 04:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=x6hnfXGUjYSmcJ3UgwBK6ti9u0qj1Ccy9mpTZb56RHg=;
        b=J1gI50wI9gj01egkSBvu5aWTET3DL1Ec0Ma2w/RGD+eR5M2VUMgs+OWClvnsvEDJ28
         GeGeJBUhdBGVroI+c4acTTJih7sns8YNClVnLAX1E1tWM1t42Zbf+bWoU49CEEp9OtI4
         Yf2Kj3jka+9qM7HMtxnXsUoYML6HGye2E8heY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=LHj7WECYOlmgqCYvDKbLUV2GBveZlfj2gj+Xsb0AItp93Qdh4JawNmrTwk5BMaDBAA
         iHcQD+m+3TtyS/DW8tSiswEFkQImOM8Oee+F2A9+hnsnFpCQnYThTwf7K1ZouCqGszPT
         iouyhvLfq4QTA0RS0QNsD3QxJYf1LOecQ/a04=
Received: by 10.223.107.16 with SMTP id z16mr701513fao.7.1290688493844; Thu,
 25 Nov 2010 04:34:53 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Thu, 25 Nov 2010 04:34:33 -0800 (PST)
In-Reply-To: <AANLkTim0hYKcPPaZjxjbpekhR4Ho_cOVaE=41HyJOrMZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162130>

On Thu, Nov 25, 2010 at 1:00 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Nov 25, 2010 at 11:35, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
>> On Thu, Nov 25, 2010 at 10:45 AM, =C6var Arnfj=F6r=F0 Bjarmason
>> <avarab@gmail.com> wrote:
>
>>> Is there anything else than that (the builtin.h includes) that you
>>> think needs work?
>>
>> There was an issue where setting NO_GETTEXT wasn't enough to disable
>> internationalization. Has this been fixed?
>
> Do you mean the issue with eval_gettext in git-sh-i18n.sh? I fixed
> that issue, but even under NO_GETTEXT=3DYesPlease we'll still pass
> things through git-sh-i18n--envsubst. Since I can't just #define
> things out under NO_GETTEXT=3DYes like I can in the C code.
>
> Maybe you mean something different that I'm forgetting. But IIRC that
> was the only issue.
>

I'm talking about this:

$ git diff
diff --git a/Makefile b/Makefile
index 8357106..0a49c2c 100644
--- a/Makefile
+++ b/Makefile
@@ -1124,6 +1124,7 @@ ifeq ($(uname_S),Windows)
        NO_STRTOK_R =3D YesPlease
        NO_FNMATCH =3D YesPlease
        NO_MEMMEM =3D YesPlease
+       NO_GETTEXT =3D YesPlease
        # NEEDS_LIBICONV =3D YesPlease
        NO_ICONV =3D YesPlease
        NO_C99_FORMAT =3D YesPlease

kusma@KUSMA-EEE2 /git (pu)
$ make
GIT_VERSION =3D 1.7.3.2.846.gf4b062.dirty
    * new build flags or prefix
    CC daemon.o
In file included from daemon.c:7:
gettext.h:15:21: error: libintl.h: No such file or directory
make: *** [daemon.o] Error 1

Basically, it seems like you're treating NO_GETTEXT and NEEDS_LIBINTL
as two independent flags but they shouldn't be. libintl is just
another name for gettext, and I've already declared that I don't want
to use it. NEEDS_LIBINTL should only matter if NO_GETTEXT isn't set.
