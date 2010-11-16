From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 08/10] checkout: add --full to fully populate working directory
Date: Tue, 16 Nov 2010 09:50:18 +0700
Message-ID: <AANLkTin8SbeFkcOQXyGBEmwk7K3LKfV2N5GhfDx6hGnw@mail.gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-9-git-send-email-pclouds@gmail.com> <20101115212311.GI16385@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 03:50:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIBd8-0008FO-1Q
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 03:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab0KPCul convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 21:50:41 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50529 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab0KPCuk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 21:50:40 -0500
Received: by wyb28 with SMTP id 28so203746wyb.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 18:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vEcFR27JNCK9UJD6pYOnGR1kWO6G9SE1v9orw7loz5Y=;
        b=stngm37/4H48mo+XehxkWK6mMDvPA1FyiAyqLhIe/FmBadBdULTCgyhy5R8bvA+ywG
         9nQcgEwtomC6F/kpcfGBuv2PD4kv+EdabaVCImhw/nY1Ar7msA8EX8QrvpqUuV5R3j7h
         vBkJ6nPb9FU17ERHDQ43GZIXBgHfNu7SKw5w8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NW2MRBF8SXlwqEj7OmcLMi9ukAk6jkYstvwABt6SC/aYpxWrnxS9wXck1Gmdxzr0t2
         QI08ZfCF7SV9Qn5l4Tw3YuO6t21TaZE5vMmvO+kSzAGFcGrZNSp7d0ZqcqRofIjG8We9
         pPW0IHDMTDJnsPglpxHQAcjpd3trd+G7h/90s=
Received: by 10.216.22.74 with SMTP id s52mr7573424wes.11.1289875839000; Mon,
 15 Nov 2010 18:50:39 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Mon, 15 Nov 2010 18:50:18 -0800 (PST)
In-Reply-To: <20101115212311.GI16385@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161534>

2010/11/16 Jonathan Nieder <jrnieder@gmail.com>:
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -952,8 +957,20 @@ no_reference:
>> =C2=A0 =C2=A0 =C2=A0 if (opts.writeout_stage)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("--ours/--their=
s is incompatible with switching branches.");
>>
>> - =C2=A0 =C2=A0 if (update_sparse_checkout)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 edit_info_sparse_checkou=
t();
>> + =C2=A0 =C2=A0 if (update_sparse_checkout) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (full_checkout) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 FILE *fp =3D fopen(git_path("info/sparse-checkout"), "w+");
>
> What should --full --edit-worktree-shape-or-whatever-that-was-called =
do?

Should die().
--=20
Duy
