From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 6/9] clean ":" is like specifying nothing
Date: Tue, 10 May 2011 12:14:59 -0300
Message-ID: <BANLkTi=OQtNh3fkd-xTSrrpo_FPpvH6isw@mail.gmail.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
	<1305006678-4051-1-git-send-email-gitster@pobox.com>
	<1305006678-4051-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 17:15:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJoeT-00005P-I5
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 17:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585Ab1EJPPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 11:15:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57621 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548Ab1EJPO7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 11:14:59 -0400
Received: by iwn34 with SMTP id 34so5288210iwn.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jcz2mM/9MaxzecokjtIA91eX3FtTiKiWlMn89kfkFiA=;
        b=q8Jw0MrQQ2t3377rM6bZOOzo1NDxq6t7K0mtJXyIiqiliqn7zZ58PuQESYwYo9BI6o
         r7msi2AxWt+GVn03FqnMptUL2aH78cidsFY/f4RiRPMdTRb5lX379JvRKLOprG1O8OfW
         KHxEj9gqsJaZxq25WT9dQLfAJSd3MRxIu8BhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CgtKmAKcz6GuwNSrp81ZbS+6UllAaHMD1X2/+m4iR4yUCh2/PcottjyRJPACD7V0nO
         lfQTKT345HgOZe6cl7W50eG/2e1r0i/Cc3SLJKqkNQDbmXnw4NICPXGP+IX5MA7Pv2mC
         0Xse3Zg7Wle5gj02IXVLqziBflLmulnB56K3U=
Received: by 10.42.97.67 with SMTP id m3mr7742164icn.380.1305040499246; Tue,
 10 May 2011 08:14:59 -0700 (PDT)
Received: by 10.42.170.132 with HTTP; Tue, 10 May 2011 08:14:59 -0700 (PDT)
In-Reply-To: <1305006678-4051-7-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173338>

On Tue, May 10, 2011 at 2:51 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Adjust argc that is meant to correspond do the number of elements in
s/do/to ?

> the pathspec array.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =C2=A0builtin/clean.c | =C2=A0 =C2=A01 +
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 4a312ab..686cd6b 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -96,6 +96,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0add_exclude(ex=
clude_list.items[i].string, "", 0, dir.exclude_list);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pathspec =3D get_pathspec(prefix, argv);
> + =C2=A0 =C2=A0 =C2=A0 argc =3D count_pathspec(pathspec);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fill_directory(&dir, pathspec);
>
> --
> 1.7.5.1.290.g1b565
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
