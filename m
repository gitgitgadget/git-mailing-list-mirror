From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Wed, 12 Aug 2009 17:01:33 +0700
Message-ID: <fcaeb9bf0908120301q17812b5cw5e19def7887d31db@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-2-git-send-email-pclouds@gmail.com> <1250005446-12047-3-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-4-git-send-email-pclouds@gmail.com> <1250005446-12047-5-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-6-git-send-email-pclouds@gmail.com> <1250005446-12047-7-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-8-git-send-email-pclouds@gmail.com> <1250005446-12047-9-git-send-email-pclouds@gmail.com> 
	<7v3a7xa6e5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 12:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbAes-0006Ja-S7
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 12:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbZHLKCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2009 06:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbZHLKCE
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 06:02:04 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:23356 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987AbZHLKCD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2009 06:02:03 -0400
Received: by an-out-0708.google.com with SMTP id d40so4645019and.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ymL3nPUpnN0/ZyWvDfUdFV7t5iV15oLZOiP+lFebGok=;
        b=izLEU/+CYWQQIYv3jdktNnZdfpRfKUO2ynLvOcjdyB2NiG8ZqvVrKAhbpucTeZVATy
         rDAma/RJvRjFnlFqlfjBLrTRON5CKMzh3JvmoC1QHsudoYbcbOmJZ0U5YGoSGDNcnC6P
         tdmYsfk2LFxfA3Dq0tfGwP9+Hzyxs9UPg3xBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uX+M/SDGoX5YHk/BgWNDd1AGHDXjyCHfG6Jr/gFH14+si17IaMxdOO06UqAH4uImov
         tOmLt4hXNqkHjIOp6tc3bNoiOYCP1hV2QsNjR/CL2W+O1tNUittBwnFT46vYAZk0XuJ9
         VmP10AoLF0sOemgbXD7KsbiRSuNMSXk8MxgrA=
Received: by 10.101.166.37 with SMTP id t37mr61841ano.138.1250071313124; Wed, 
	12 Aug 2009 03:01:53 -0700 (PDT)
In-Reply-To: <7v3a7xa6e5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125691>

2009/8/12 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> @@ -594,6 +596,8 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN('m', "m=
erge", &opts.merge, "merge"),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_STRING(0, "conf=
lict", &conflict_style, "style",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0"conflict style (merge or diff3)"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_SET_INT(0, "sparse",=
 &opts.apply_sparse,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 "apply sparse checkout filter", 1),
>
> Shouldn't this be BOOLEAN not INT, i.e. "--[no-]sparse"? =C2=A0That w=
ay, you
> could enable it by simply the presense of $GIT_DIR/info/sparse.

This patch was written carelessly. I wanted to have something to test.
If you agree on option name "--sparse" then yes BOOLEAN is better.

> It could also require core.sparseworktree configuration set to true i=
f we
> are really paranoid, but without the actual sparse specification file
> flipping that configuration to true would not be useful anyway, so in
> practice, giving --sparse-work-tree option to these Porcelain command=
s
> would be no-op, but --no-sparse-work-tree option would be useful to
> ignore $GIT_DIR/info/sparse and populate the work tree fully.
>
> Or am I missing something?

Sounds good (and --sparse-work-tree is apparently better than
--sparse). So let's enable it by default, add --no-sparse-work-tree to
disable it and wait until some one complains, then we'll add
core.sparseworktree. I think core.sparseworktree can also be used to
specify what spec file to be used instead of the default
=2Egit/info/sparse, if users like to switch among some well-defined spe=
c
files.
--=20
Duy
