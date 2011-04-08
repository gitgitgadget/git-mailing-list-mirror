From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] magic pathspec: add tentative ":/path/from/top/level"
 pathspec support
Date: Fri, 8 Apr 2011 22:39:41 +0700
Message-ID: <BANLkTi=h9idi70KtaSALaozYoJaTxzoMPA@mail.gmail.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-2-git-send-email-gitster@pobox.com> <BANLkTint7sGCg7_seu1-SWJC=_sKF-FKYw@mail.gmail.com>
 <7vd3kyf327.fsf@alter.siamese.dyndns.org> <BANLkTi=YK-4TOxoD1qR8TO4SymLK6sPnQA@mail.gmail.com>
 <7vtye84wc3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 17:40:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8DnK-0007RF-4B
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 17:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325Ab1DHPkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 11:40:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41429 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab1DHPkM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 11:40:12 -0400
Received: by bwz15 with SMTP id 15so2936090bwz.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=r/bqnIp/UOzKs2/0ZYYaOySiXPg0Jly9Pa0zlZHPz60=;
        b=DeJVRcD2jIuwlzDd6zJ+38Z0O5VmDurb/rrYSphZ5D3VPAnK7tOnDmJVr15ctdc3rm
         ojtt5BjYG2eYwkeMKWjKt8EpRQN3SJThyW/XJorsc953xOahRPDuy/0FOIXZ/Uk+jXmN
         NsLEkokWKddXIDgactbdq88lSV1I5t7M3Hx+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MEesvWfNAtCQNv2iA1aqcmYRi2KqV2R8bHpXzR9+p+eUkVWgeWm5Wi59aUn3SAd1W4
         YXSIYwuQXSsceVry1YkuH+0mzBxFQyPLc0n5KZM0ryPFQfyNyXBPZNWKhZVObkQEvc6z
         +Em9ZTtes9lZzGsYFV8NNeKX8s30lVettOHGE=
Received: by 10.204.16.209 with SMTP id p17mr1579839bka.17.1302277211101; Fri,
 08 Apr 2011 08:40:11 -0700 (PDT)
Received: by 10.204.37.195 with HTTP; Fri, 8 Apr 2011 08:39:41 -0700 (PDT)
In-Reply-To: <7vtye84wc3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171132>

On Fri, Apr 8, 2011 at 10:05 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Thu, Apr 7, 2011 at 11:18 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>
>>> This is so that you can say ":/.gitignore" and do not have to say
>>> ":/:.gitignore".
>>
>> But then, say people have a file named @foo at top dir. They can wri=
te
>> ":/@foo" to address the file. Some time later we decide to use '@' a=
s
>> magic, how can we re-train user's fingers?
>
> You don't. =C2=A0The primary goal of short form is to be short to typ=
e from the
> command line, and if you are in doubt, you can always disambiguate by
> saying ":/:@foo", and you can use the terminating colon even if you a=
re
> sure "@" is not a magic in your version of git.

If you allow me to use ":/@foo", I would (because it's convenient).
And over time it will be carved in my muscle memory. Doubts and
surprises after that are not good. Suppose I usually do "git co
:/@foo", then '@' in later versions means many files, not just '@foo'
at top. The '@' magic surprise would upset (enrage in the first few
minutes maybe) me. My argument would be "it used to work fine"
(against "you should use 'git co :/:@foo'" because it's less
convenient that way).
--=20
Duy
