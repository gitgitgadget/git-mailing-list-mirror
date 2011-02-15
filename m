From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC/PATCH 1/2] Introduce CHERRY_HEAD
Date: Wed, 16 Feb 2011 00:42:54 +0100
Message-ID: <AANLkTi=MzZdOKeWYDTXoE6kg+OCcnjTUsQax5oN-k5Jq@mail.gmail.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
	<1297805034-3512-2-git-send-email-jaysoffian@gmail.com>
	<20110215221832.GA826@elie>
	<7v4o84nbuh.fsf@alter.siamese.dyndns.org>
	<AANLkTimZUhxkxuUMubmPxjd8MG0Pu=9mrLoPqi=MpPWZ@mail.gmail.com>
	<7vzkpwlwqx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 00:43:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpUXu-0002LV-4C
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 00:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770Ab1BOXm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 18:42:57 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59847 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab1BOXmz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 18:42:55 -0500
Received: by wyb28 with SMTP id 28so766196wyb.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 15:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CJjMYZNd8tgySZxTVckLRO5UMYtvNQoE2A4GUzCGmNo=;
        b=qOLWrSR49x+fypt/D+Qye3iYoh+fC1l0iQwMqaptqq0+U3YbCrIKhvsdfInOXcx2Jx
         MGMOEZ6rc2/QFFu41qOWxDmLcj78YgE73tFpQXvbUBrE5i4ZfqRte1DkBx195U3c7fyx
         cnXqEgbpWXx+HBN96JnsSi2iKiVmt1/N46NpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ueyvsIXrkN9hPSMOcDtb9odBQ8S+/bLe6G6YKvFCOn3r1KaJTPiy31M8tPxhHPb6Q4
         Ii6QyGxLkXW8VoOdMzqR1Q+nvOguMW4SuXQPti+RFLaOOqXstywl6qR17Fwt/Jbd0YUi
         MR3pRLl/4mOOsfrt44mVAVJ3ko5C7l4Iq+IT0=
Received: by 10.227.155.198 with SMTP id t6mr4204425wbw.194.1297813374213;
 Tue, 15 Feb 2011 15:42:54 -0800 (PST)
Received: by 10.227.129.18 with HTTP; Tue, 15 Feb 2011 15:42:54 -0800 (PST)
In-Reply-To: <7vzkpwlwqx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166900>

On Wed, Feb 16, 2011 at 00:10, Junio C Hamano <gitster@pobox.com> wrote=
:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>>> What happened to the `=3D=3D=3D=3D=3D=3D=3D`? =C2=A0I thought you w=
ere copying and pasting
>>> from the said section.
>>
>> I think this is clear enough, else you would need to mention the
>> '|||||||' and conflict_marker_size too.
>
> If so then probably the section this was copied from needs updating?
>

Right, the origin does not mention them too. It also uses just 3
characters, instead of the default 7. I think using '<=3D>'/'<|=3D>' as=
 a
visual hint about conflict markers should suffice here plus
referencing the next section. This next section
HOW CONFLICTS ARE PRESENTED does describe both conflict styles but it
doesn't mention the conflict-marker-size option. There are more
references in the documentation where only the RCS style is mentioned.

Anyways, referencing "TRUE MERGE" alone is not enough, it should
mention the following sections too, namely HOW CONFLICTS ARE PRESENTED
and HOW TO RESOLVE CONFLICTS. In German we would do this by '"TRUE
MERGE" ff.' Where 'ff.' is the plural of the abbreviation for
'following'. I don't know how to do that in English.

Also I'm wondering, why the git repo does not set the
conflict-marker-size for its offending files itself. The current
offender would be:

$ git grep -l '^<<<<<<<' Documentation/
Documentation/git-merge-file.txt
Documentation/git-merge.txt
Documentation/user-manual.txt

I may provide a patch in the future, if no one beats me.

Bert
