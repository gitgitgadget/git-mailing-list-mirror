From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git config: clarify bool types
Date: Thu, 7 May 2009 02:07:10 +0300
Message-ID: <94a0d4530905061607s14c700e5t4b87166772c75622@mail.gmail.com>
References: <1237331631-29822-1-git-send-email-felipe.contreras@gmail.com>
	 <7vk56nocpg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 01:07:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1qCy-0001fz-Mn
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 01:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbZEFXHN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 19:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755366AbZEFXHN
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 19:07:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:10997 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292AbZEFXHL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 19:07:11 -0400
Received: by fg-out-1718.google.com with SMTP id 16so155098fgg.17
        for <git@vger.kernel.org>; Wed, 06 May 2009 16:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gGfmZG1yBD6QRs1tEuWA4D2++guuXpmq+tPYAMwbFWA=;
        b=VphtqwsRvwFwcBx3D7kLWaveUSYNrVIkYHa7tARcA4mvOs0RniWWQKICQMxJdOm2g9
         l9zInw8AcP5luerP8AkAYIxSa42Jh/1W928Ge20uqT8WFBRUY/fss4K7Xsr0NY+q84bc
         wo1Ga4FuW4PJMipuElQk3Z7VAkACv3QxSs3D8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mQ9rKPpFW1P1i96O1ufiLGNj83MCgLJwmvQlEk6Ptw7G14BglytlzwXmzBuc/1C7OK
         rgiVC9eFQ1+12PXkfO94/5tVQ5GvVh3KdQ2n0tmJwf1LS4lu0yQAhlh6djgBfLLxvVaT
         WR/f5+Dvgyvfcs4tJLuJMid1jdSKs5lIkimRs=
Received: by 10.86.1.1 with SMTP id 1mr1850493fga.0.1241651230546; Wed, 06 May 
	2009 16:07:10 -0700 (PDT)
In-Reply-To: <7vk56nocpg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118404>

On Wed, Mar 18, 2009 at 4:13 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> The value is what it is, the --bool and --bool-or-int options don't
>> specify the value type, just how it is interpreted. For example: a v=
alue
>> of '1' can be interpreted as 'true'.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>
>> This applies on top of the 'next' branch.
>>
>> =C2=A0builtin-config.c | =C2=A0 =C2=A04 ++--
>> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin-config.c b/builtin-config.c
>> index 1a3baa1..c3a0176 100644
>> --- a/builtin-config.c
>> +++ b/builtin-config.c
>> @@ -66,9 +66,9 @@ static struct option builtin_config_options[] =3D =
{
>> =C2=A0 =C2=A0 =C2=A0 OPT_STRING(0, "get-color", &get_color_slot, "sl=
ot", "find the color configured: [default]"),
>> =C2=A0 =C2=A0 =C2=A0 OPT_STRING(0, "get-colorbool", &get_colorbool_s=
lot, "slot", "find the color setting: [stdout-is-tty]"),
>> =C2=A0 =C2=A0 =C2=A0 OPT_GROUP("Type"),
>> - =C2=A0 =C2=A0 OPT_BIT(0, "bool", &types, "value is \"true\" or \"f=
alse\"", TYPE_BOOL),
>> + =C2=A0 =C2=A0 OPT_BIT(0, "bool", &types, "value is intepreted as b=
ool (\"true\" or \"false\")", TYPE_BOOL),
>
> I'd rater see it say something like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Output the value as boolean (true or false=
)
>
> so that it is consistent with others you can see in the context.
> E.g. get-color explains it to order the command to "find the color".
>
> "Interpret" is fine too. =C2=A0The point is not about the choice of v=
erb but
> use of imperative mood.

-bool is not only used to output values, it's also used to set them,
so it's not related to an action, it's an action modifier, so I don't
think it must be imperative.

I'm going to resend this patch as is.

--=20
=46elipe Contreras
