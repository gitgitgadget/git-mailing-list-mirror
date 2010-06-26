From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] string-list.h: Add STRING_LIST_INIT macro and make use of 
	it.
Date: Sat, 26 Jun 2010 20:44:32 -0300
Message-ID: <AANLkTinw3XHPM1jUljnwangpN8q9CqbyeSDKT7CCZXET@mail.gmail.com>
References: <ef57c1f7439b43564af4ec88ddf100a9a908b745.1277591559.git.tfransosi@gmail.com>
	<20100626230425.GA2265@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 01:44:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSf3A-0006Tr-GO
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 01:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab0FZXoe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 19:44:34 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38626 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab0FZXoe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jun 2010 19:44:34 -0400
Received: by qwi4 with SMTP id 4so1124206qwi.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 16:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kMWtuDAiIeT1WZ951MqydrlyK7C60WQoO3CzdSM4sHE=;
        b=rks/A6Oj/ps7zTKKSWfJbkff+G3WlpSf13CfXZELBC28j8G3LVBAX42wPP238bhyO3
         fYwlC4sb6XNNKxSNa6gPEpyrXnLdoiMKYWu3OQHDk3Jb9Eev5N5VmPFDt5syPFDaPYS+
         XprZcN2F6MxXuO7CoRHHyAD6Rd12X+hp/Vb9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JppPQCjwT1gq6NM90ppMYHOxnorCFCidXCCugRXNsSGXAgFN9xOA3ZXFqn5qK5/rJT
         0GMNnMQiiXIlECZr1piQmq48Y3wPB28iik+9J0b5t4ipJtilzf4fCPw5cwfKAvKI056Y
         pI4kL461+YFvwUtD9bnG7N0HmZ5gBgrqo2KNk=
Received: by 10.229.186.211 with SMTP id ct19mr1536310qcb.206.1277595872417; 
	Sat, 26 Jun 2010 16:44:32 -0700 (PDT)
Received: by 10.229.186.76 with HTTP; Sat, 26 Jun 2010 16:44:32 -0700 (PDT)
In-Reply-To: <20100626230425.GA2265@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149783>

On Sat, Jun 26, 2010 at 8:04 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Thiago Farina wrote:
>
>> =C2=A0builtin/fast-export.c =C2=A0| =C2=A0 =C2=A02 +-
>> =C2=A0builtin/fetch.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A08 ++=
++----
>> =C2=A0builtin/receive-pack.c | =C2=A0 =C2=A02 +-
>> =C2=A0builtin/remote.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 ++--
>> =C2=A0builtin/show-ref.c =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
>> =C2=A0remote.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A04 ++--
>> =C2=A0string-list.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
2 ++
>> =C2=A07 files changed, 13 insertions(+), 11 deletions(-)
>
> =C2=A0$ git grep -e 'string_list.*=3D' origin/master | grep { | grep =
-v 1 |
> =C2=A0> wc -l
> =C2=A016
> =C2=A0$ git grep -e 'string_list.*=3D' origin/master | grep { | grep =
-v 1 |
> =C2=A0> cut -d: -f2 | uniq
> =C2=A0builtin/fast-export.c
> =C2=A0builtin/fetch.c
> =C2=A0builtin/mv.c
> =C2=A0builtin/receive-pack.c
> =C2=A0builtin/remote.c
> =C2=A0builtin/show-ref.c
> =C2=A0merge-recursive.c
> =C2=A0remote.c
> =C2=A0transport-helper.c
>
> Looks like you missed a few. =C2=A0Still,
>
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks Jonathan. I think the other entries you found have different
initializations.
