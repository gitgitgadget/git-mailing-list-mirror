From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-push: prevent multiple occurences of branches
Date: Wed, 27 May 2009 09:40:34 +0200
Message-ID: <36ca99e90905270040x2ac8e739j99411d61e8ef2689@mail.gmail.com>
References: <1243373820-13442-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090527072100.GA13559@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Marc Weber <marco-oweber@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed May 27 09:50:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Dtq-0007Ht-1z
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 09:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761072AbZE0Hki convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 03:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761635AbZE0Hkh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 03:40:37 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:43216 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763622AbZE0Hke convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 03:40:34 -0400
Received: by fxm12 with SMTP id 12so2614240fxm.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 00:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=alfrIs1gbTCS7353u0Dnu7U/bga9PttOpMY4owMfHzw=;
        b=aegOpFBoesXzFpxkpYBWSLIcwESwx9BN+V1OZIUU0W/UrmApXw0wZT+3Zmt0umxw6S
         DguiMCffbGiTVcbZzuZw8Sjube6KPW7T1i782bDJ8xDjmHwm+sY8kdWFiKT/Stw8M5g9
         9B9KeMYpL4DKkwwr/pOGMiEgR7vFygHuyG61A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FTfvgvxjDdBkDDiOEOr7FwAHu+Y8Ieltt70UhKFpcvlc3QI0ATajk6cFvK859L8h7i
         AFFJT6beH/GHJUjLFiXelXT9f6CGvCzSdmc7R+lfub3z/hOIU99M2Oha3AcZ8QpyZxcQ
         aUYjbyG6FDqgh9PRT59MD1pyrth7ULIlV1bPo=
Received: by 10.223.113.3 with SMTP id y3mr4975702fap.71.1243410034316; Wed, 
	27 May 2009 00:40:34 -0700 (PDT)
In-Reply-To: <20090527072100.GA13559@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120045>

2009/5/27 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hi Bert,
Moin Uwe,

>
> On Tue, May 26, 2009 at 11:37:00PM +0200, Bert Wesarg wrote:
>> So, I finally tried tg-push and got a lot of warnings and errors:
>>
>> warning, no base found top-bases/master
>> warning, no base found top-bases/master
>> warning, no base found top-bases/master
>> warning, no base found top-bases/master
>> warning, no base found top-bases/master
>> warning, no base found top-bases/master
>> warning, no base found top-bases/master
>> warning, no base found top-bases/master
>> warning, no base found top-bases/master
>> warning, no base found top-bases/master
>> warning, no base found top-bases/master
>>
>>
>> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc6=
1ccbd94 but expected 0000000000000000000000000000000000000000
>> error: failed to lock refs/heads/master
>> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc6=
1ccbd94 but expected 0000000000000000000000000000000000000000
>> error: failed to lock refs/heads/master
>> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc6=
1ccbd94 but expected 0000000000000000000000000000000000000000
>> error: failed to lock refs/heads/master
>> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc6=
1ccbd94 but expected 0000000000000000000000000000000000000000
>> error: failed to lock refs/heads/master
>> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc6=
1ccbd94 but expected 0000000000000000000000000000000000000000
>> error: failed to lock refs/heads/master
>> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc6=
1ccbd94 but expected 0000000000000000000000000000000000000000
>> error: failed to lock refs/heads/master
>> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc6=
1ccbd94 but expected 0000000000000000000000000000000000000000
>> error: failed to lock refs/heads/master
>> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc6=
1ccbd94 but expected 0000000000000000000000000000000000000000
>> error: failed to lock refs/heads/master
>> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc6=
1ccbd94 but expected 0000000000000000000000000000000000000000
>> error: failed to lock refs/heads/master
>> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc6=
1ccbd94 but expected 0000000000000000000000000000000000000000
>> error: failed to lock refs/heads/master
>> error: Ref refs/heads/bw/log is at a16df35cc7009b36f6f71717ae3d9a3dc=
29987da but expected 0000000000000000000000000000000000000000
>> error: failed to lock refs/heads/bw/log
>> error: Ref refs/top-bases/bw/log is at b725fc951a37854fc65945ac5bcab=
3bc61ccbd94 but expected 0000000000000000000000000000000000000000
>> error: failed to lock refs/top-bases/bw/log
>>
>> =C2=A0! [remote rejected] master -> master (failed to lock)
>> =C2=A0! [remote rejected] master -> master (failed to lock)
>> =C2=A0! [remote rejected] master -> master (failed to lock)
>> =C2=A0! [remote rejected] master -> master (failed to lock)
>> =C2=A0! [remote rejected] master -> master (failed to lock)
>> =C2=A0! [remote rejected] master -> master (failed to lock)
>> =C2=A0! [remote rejected] master -> master (failed to lock)
>> =C2=A0! [remote rejected] master -> master (failed to lock)
>> =C2=A0! [remote rejected] master -> master (failed to lock)
>> =C2=A0! [remote rejected] master -> master (failed to lock)
>> =C2=A0! [remote rejected] bw/log -> bw/log (failed to lock)
>> =C2=A0! [remote rejected] refs/top-bases/bw/log -> refs/top-bases/bw=
/log (failed to lock)
> hhm, does this happen because
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git push $remote master master master mast=
er
Exactly.

>
> tries to lock master four times? =C2=A0I'd think this is something th=
at needs
> fixing in git-core.
Cc'd Junio. And Junio, you can stop reading now.

>
>> Also the result was ok this output is defintive not ok.
>>
>> To prevent multiple occurences of the same branchname we maintain th=
ese in a
>> file.
>>
>> In push_branch ref_exists was called, which is redundant because _de=
p_is_tgish
>> tells us exactly this.
> ... what about breaking this out?
By your command.

>
>> ---
>> =C2=A0tg-push.sh | =C2=A0 48 +++++++++++++++++++++++++++++----------=
---------
>> =C2=A01 files changed, 29 insertions(+), 19 deletions(-)
>>
>> diff --git a/tg-push.sh b/tg-push.sh
>> index 8d09a02..c813927 100644
>> --- a/tg-push.sh
>> +++ b/tg-push.sh
>> @@ -45,31 +45,41 @@ for name in $branches; do
>> =C2=A0 =C2=A0 =C2=A0 ref_exists "$name" || die "detached HEAD? Can't=
 push $name"
>> =C2=A0done
>>
>> +_listfile=3D"$(mktemp -t tg-push-listfile.XXXXXX)"
>> +trap "rm -f \"$_listfile\"" 0
>> +
>> +# prevent multiple occurrences of the same branch
>> +add_to_list()
>> +{
>> + =C2=A0 =C2=A0 fgrep -qx "$1" "$_listfile" ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "$1" >> "$_listfile=
"
>> +}
> This has complexity O(n**2) for n calls (I think). =C2=A0Just writing=
 then to
> the list and doing sort -u afterwards only has O(n log n) (for a
> reasonable implementation of sort).
Ahh, that takes a while, but yes. I thought I need to sort each time I
put a new branch in this file.

>
>> =C2=A0push_branch()
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 # if so desired omit non tgish deps
>> =C2=A0 =C2=A0 =C2=A0 $tgish_deps_only && [ -z "$_dep_is_tgish" ] && =
return 0
>>
>> - =C2=A0 =C2=A0 echo "$_dep"
> what about $tgish_deps_only?
Hmm, I think I have not changed the semantics here. I replace this
line with 'add_to_list "$_dep"'.

>> - =C2=A0 =C2=A0 local base=3D"top-bases/$_dep"
>> - =C2=A0 =C2=A0 if ref_exists "$base"; then
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "top-bases/$_dep"
>> - =C2=A0 =C2=A0 else
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "warning, no base f=
ound $base" 1>&2
>> - =C2=A0 =C2=A0 fi
>> + =C2=A0 =C2=A0 add_to_list "$_dep"
>> + =C2=A0 =C2=A0 [ -z "$_dep_is_tgish" ] ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_to_list "top-bases/$=
_dep"
>
Bert

> Best regards
> Uwe
