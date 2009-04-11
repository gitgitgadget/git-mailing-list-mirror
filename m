From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH&RFC] get_short_ref(): add strict mode
Date: Sat, 11 Apr 2009 21:50:35 +0200
Message-ID: <36ca99e90904111250t7f4563e6x495937d8f3f45d40@mail.gmail.com>
References: <36ca99e90810172355n2c578b07pd2868b15e6631ef7@mail.gmail.com>
	 <1239470086-13818-1-git-send-email-bert.wesarg@googlemail.com>
	 <7vr5zzdmg8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:52:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsjFN-0004Cj-5l
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113AbZDKTui convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 15:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755589AbZDKTui
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:50:38 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:36690 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540AbZDKTui convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 15:50:38 -0400
Received: by bwz17 with SMTP id 17so1556812bwz.37
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dM+4Qxs8mSnrBy/z9zNpZjL7aHfSYdIRaaDSL99f7jw=;
        b=wLzx+DVZFTyyLLvbPjJAuU5zFySBqAHukXsdqgc4GysFWylYOP0+qu2NtdVnLIpYtX
         +rijWmbc29mPmRUxYAxV1lVptXrV+EVR5QIhqsCEJ4ELnBxLNV1Q+Tx0WIMR/LOHJeeN
         eBLr0Iww1UsrV5dz7wkDJaRwS9nGOgQQh2ddg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Gq/sMIfn1sKIcpfeA1yso2diMRW3zkt2YIg9VWzRE/iXNeNCwyvRU1dIL+xK3TthSH
         sM41gW18WvLzOBTJsaTs/TI6wGI+zOzyjjWeC6sFTzdso1JUUvfv635uPqd9t0OLHkFu
         ewZPUL9JjQyb6ThehzYNW1UhBm3xIB8twY7mM=
Received: by 10.223.123.129 with SMTP id p1mr1374023far.0.1239479435807; Sat, 
	11 Apr 2009 12:50:35 -0700 (PDT)
In-Reply-To: <7vr5zzdmg8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116341>

On Sat, Apr 11, 2009 at 21:23, Junio C Hamano <gitster@pobox.com> wrote=
:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> I think of 3 alternatives to use this mode for the "refname" format =
(and
>> probably others):
>>
>> =C2=A0 a) Use core.warnAmbiguousRefs to control strict mode.
>> =C2=A0 =C2=A0 =C2=A0This would change the current default behaviour,=
 because this is true
>> =C2=A0 =C2=A0 =C2=A0by default.
>>
>> =C2=A0 b) Introduce a new core config variable to control this, eith=
er for
>> =C2=A0 =C2=A0 =C2=A0for-each-ref alone ore globally.
>>
>> =C2=A0 c) Introduce a "refname:short-strict" format to get the stric=
t abbreviation.
>>
>> I'm currently slighty in favour for option b).
>
> Your earlier http://thread.gmane.org/gmane.comp.version-control.git/9=
6464
> made a lot of sense to me. =C2=A0The request "refname:short" cannot b=
e for use
> by scripts (well, scripts may pass it to for-each-ref but that has to=
 be
> for final consumption by humans wanting to view the names in a format=
 not
> overly long, as opposed to scripts using for-each-ref to extract
> unambiguous names to be used for further processing, in which case th=
ey
> would be using "refname" without ":short"), so I do not see "change t=
he
> current default behaviour" is a bad thing at all. =C2=A0If anything, =
it is an
> improvement, isn't it?
Sure it is. So you're still with option a) and I'm ok with this. I
prepare a patch.

Bert
