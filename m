From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH 10/10] [RFC] tg-patch: simulate mnemonic prefixes
Date: Sat, 9 Oct 2010 23:03:00 +0200
Message-ID: <AANLkTinzjwt6FAE2kau5M5MAWMAJ-az=YYxN7ehzq37c@mail.gmail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
	<101fe6e1e47292faa21770ab3a5a0b204897ac63.1286524446.git.bert.wesarg@googlemail.com>
	<20101009204640.GP29673@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 23:03:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gZb-0001kJ-0W
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 23:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757295Ab0JIVDO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Oct 2010 17:03:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50657 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757075Ab0JIVDN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Oct 2010 17:03:13 -0400
Received: by iwn6 with SMTP id 6so1742738iwn.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 14:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ahhxVKy3unxC0hh1EwxuqVaVmKkY4+F8J///UMvkVOo=;
        b=sWAtzROm3lqoo3gLRYRbhm+DWHOncAGwwWYiMTDIgc6N42sDwScAXJ/ifaJylAaY6Z
         N8wFIDi9x+SHekHhzVLbldNY/mcS4sX0d0gB9v5qYfhKedYvZqRhzpsdkPleyfiGVbzG
         WeoqUv1dW2IRu2ASwk6ObL2y4LRPSqEPfHpJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KGAHTuI2ikGZWNFvmxAJAgtudFLKzN7HLB+kERGSA34G7sbEdDNXTEoJ842xrA/BvI
         YjktlJku0/qKDVRYNFiAMTQQVFwkHumA2GVyquAiEoC9U7yR8B4cX85a1xPxIXaJF10+
         DjeLi9ST2MhIwmonQJGBGuRgqhA/Js3A7yBwo=
Received: by 10.231.172.205 with SMTP id m13mr3499138ibz.35.1286658180701;
 Sat, 09 Oct 2010 14:03:00 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Sat, 9 Oct 2010 14:03:00 -0700 (PDT)
In-Reply-To: <20101009204640.GP29673@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158622>

2010/10/9 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> On Fri, Oct 08, 2010 at 09:58:08AM +0200, Bert Wesarg wrote:
>> b/ is for base, i/ and w/ correspond to -i/-w and t/ is the committe=
d
>> topic.
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>> ---
>> =C2=A0tg-patch.sh | =C2=A0 =C2=A08 ++++++--
>> =C2=A01 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/tg-patch.sh b/tg-patch.sh
>> index dcce672..c8ad723 100644 tg-patch.sh
>> --- a/tg-patch.sh
>> +++ b/tg-patch.sh
>> @@ -6,7 +6,7 @@
>> =C2=A0name=3D
>>
>> =C2=A0head_from=3D
>> -
>> +dst_prefix=3D"t/"
>>
>> =C2=A0## Parse options
>>
>> @@ -15,7 +15,8 @@ while [ -n "$1" ]; do
>> =C2=A0 =C2=A0 =C2=A0 case "$arg" in
>> =C2=A0 =C2=A0 =C2=A0 -i|-w)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ -z "$head_from" ]=
 || die "-i and -w are mutually exclusive"
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 head_from=3D"$arg";;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 head_from=3D"$arg"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_prefix=3D"${arg#-}/"=
;;
>> =C2=A0 =C2=A0 =C2=A0 -*)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "Usage: tg [..=
=2E] patch [-i | -w] [NAME]" >&2
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1;;
>> @@ -72,6 +73,9 @@ if [ $b_tree =3D $t_tree ]; then
>> =C2=A0else
>> =C2=A0 =C2=A0 =C2=A0 # use the ui diff command when the pager is act=
ive
>> =C2=A0 =C2=A0 =C2=A0 diff_command=3Ddiff
>> + =C2=A0 =C2=A0 if $(git config --bool diff.mnemonicprefix); then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff_command=3D"$diff_co=
mmand --src-prefix=3Db/ --dst-prefix=3D$dst_prefix"
>> + =C2=A0 =C2=A0 fi
> Do I assume right, that diff.mnemonicprefix is topgitish only? =C2=A0=
 Maybe
> it should go then into a topgit namespace?

No. it is from git. From the manual:

       diff.mnemonicprefix
           If set, git diff uses a prefix pair that is different from t=
he
           standard "a/" and "b/" depending on what is being compared. =
When
           this configuration is in effect, reverse diff output also sw=
aps the
           order of the prefixes:

           git diff
               compares the (i)ndex and the (w)ork tree;

           git diff HEAD
               compares a (c)ommit and the (w)ork tree;

           git diff --cached
               compares a (c)ommit and the (i)ndex;

           git diff HEAD:file1 file2
               compares an (o)bject and a (w)ork tree entity;

           git diff --no-index a b
               compares two non-git things (1) and (2).

And it is only a diff ui option too. I thought to take c/ for the
committed case for us too, but I have also no strong opinion about t/
either.

>
> Hmm, nice idea, the only thing about it I don't like ad hoc is that b=
/
> is already used by default and so it might be confusing. =C2=A0OTOH y=
ou need
> to enabled it in the config, ... =C2=A0Hmm, will think about it.
>
> Uwe
