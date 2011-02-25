From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 27/73] gettextize: git-commit formatting messages
Date: Fri, 25 Feb 2011 21:01:53 +0100
Message-ID: <AANLkTi=J3C9SUm1HpnXwjOpJjQG7nCQuPkNhenyN0ZtD@mail.gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
	<1298418152-27789-28-git-send-email-avarab@gmail.com>
	<20110225094342.GJ23037@elie>
	<7vd3mgar5g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 21:07:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt3wj-0006sn-0P
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 21:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932843Ab1BYUHU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 15:07:20 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64829 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932644Ab1BYUHT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 15:07:19 -0500
Received: by fxm17 with SMTP id 17so2029082fxm.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 12:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YTVSK5YtsaeSheSahSxoQjKmipPD7TV6jq26YygsBcw=;
        b=pd/usc71T4dG2NYTdvbNxK95tG4u8q1wgY7Tk7lxJJkYZ7hf6PgQyoG9j20kzS0mZr
         lZj0CJvSqeN3UU7H4tagkITR1RJZvc7Hm45+8dRecqsZIclGUKTaJyGT/f7EPdPfVEpc
         YWhbQ4j9NmbHlqYQJcXTrbo/YnaqMymlKEZ1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N5NQZ788EcOib58cSfcLw97cExSFuoZXX03U/e1TpcVUMH8DL7C74oaDhh5VYtENBs
         lp0O7bh0epwSKQcz4qD7ki5a5w+WBnUKv4RmPxtSptflS7Oy8DRmRmhouEt/TMu6SLAA
         ovfFFF6Jt0keeEiIXokYrXSchYx9lIofuyRX8=
Received: by 10.223.103.66 with SMTP id j2mr3187275fao.83.1298664113228; Fri,
 25 Feb 2011 12:01:53 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Fri, 25 Feb 2011 12:01:53 -0800 (PST)
In-Reply-To: <7vd3mgar5g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167934>

On Fri, Feb 25, 2011 at 19:46, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> diff --git a/t/lib-commit-template.sh b/t/lib-commit-template.sh
>> new file mode 100644
>> index 0000000..80ec50c
>> --- /dev/null
>> +++ b/t/lib-commit-template.sh
>> @@ -0,0 +1,19 @@
>> +#!/bin/sh
>> +
>> +# Messages such as
>> +#
>> +# =C2=A0 =C2=A0 =C2=A0# It looks like you may be committing a MERGE=
=2E\n"
>> +#
>> +# are now translatable, even though the "# " part probably ought no=
t
>> +# to be. =C2=A0Expect some tests to fail when GETTEXT_POISON is ena=
bled.
>
> We shouldn't mark "# " part as translatable to begin with. =C2=A0Perh=
aps the
> underlying code in wt-status.c needs to be changed even before we mer=
ge
> the i18n _() patches to make it easier?

Agreed, and Jonathan already implemented this:

    https://github.com/avar/git/commit/394a9d1
    https://github.com/avar/git/commit/da15d84

Perhaps it would be better to modify that patch so it goes in ahead of
the i18n series. It would simplify this going back and forth within
i18n itself.
