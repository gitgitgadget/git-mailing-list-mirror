From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 10/51] i18n: git-am core say messages
Date: Sun, 3 Apr 2011 19:35:01 +0200
Message-ID: <BANLkTinYVRcar0m-d5ZC=7RbputR5AbZ3A@mail.gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
	<1301849175-1697-11-git-send-email-avarab@gmail.com>
	<m3ei5j44wz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 19:35:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6RCj-0005Qt-R8
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 19:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab1DCRfE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 13:35:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48805 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab1DCRfD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2011 13:35:03 -0400
Received: by fxm17 with SMTP id 17so3485463fxm.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/vd56D69BfXKG6znbrFLrpAPB3ZIcHDS4y+4nMx/jBQ=;
        b=M1HscLbbRz0MjuxJ/Ihyo/jmRLkMl2Y5f+L4SSPQ7N4EwGeLO1qcdiZU0RUKYJ7gzW
         iyqtZ0dSjV8gkgMFzvw/vxWo78xcngO7uU4rsmZki59FQZAbP/p8Yu+noFI/4l4Iqbsf
         vpcTiFaf7yTT7JvXRgBXcOUP6V8l0y4TB/DMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OJey34Gn2jTPgLyewLSlTUr0bNO36MWVaXOyR9lkshIhXXT3EjpW1IMvasIZUzbImn
         oQUC63DcOXL2uaEjW8w5gtXvySXupeSEjwVx7FHGl9xdXIl+bS6vPNb4k7IpkqcOXwjL
         P+np39nYwrocOM351BB6lPD9WRrmyAr8h9IYg=
Received: by 10.223.127.210 with SMTP id h18mr2222435fas.46.1301852101550;
 Sun, 03 Apr 2011 10:35:01 -0700 (PDT)
Received: by 10.223.93.196 with HTTP; Sun, 3 Apr 2011 10:35:01 -0700 (PDT)
In-Reply-To: <m3ei5j44wz.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170762>

On Sun, Apr 3, 2011 at 19:33, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> Make the core git-am messages that use say() translatable. These are
>> visible on almost every git am invocation.
>>
>> There are tests that depend on the "Applying" output that need to be
>> skipped along with this translation.
>
>
>> - =C2=A0 =C2=A0 say "Applying: $FIRSTLINE"
>> + =C2=A0 =C2=A0 say "$(eval_gettext "Applying: \$FIRSTLINE")"
>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 say No changes -- Patch already applied.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 say "$(gettext "No changes -- Patch already applied.")"
>
> I guess that you canot simply make 'say' to do the translation becaus=
e
> one doesn't know if getext or eval_gettext is needed, isn't it?

Indeed, the xgettext() rule couldn't tell the difference. And even if
we only used say() for gettext() I'd prefer not to make things more
complex by supporting gettext extraction from our own custom
functions. I'd like to be able to grep for gettext and get all the
invocations.
