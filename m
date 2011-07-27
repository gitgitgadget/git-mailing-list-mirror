From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 11/18] revert: Save data for continuing after conflict resolution
Date: Wed, 27 Jul 2011 15:49:43 +0530
Message-ID: <CALkWK0=uA1ZRsmiVwmx_3HXL-v+Bi-ONPEk5kMsh1RG0ZeVQJg@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-12-git-send-email-artagnon@gmail.com> <20110727050220.GG18470@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 12:20:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm1Do-000124-2r
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 12:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292Ab1G0KUH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 06:20:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44065 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab1G0KUF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 06:20:05 -0400
Received: by wyg8 with SMTP id 8so867850wyg.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 03:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YW9AL/1xQev2z8ZZCGBKfVJVS7+T1EGs64juHkv0kjI=;
        b=eC+rx0rQDA200+S+7XlEFQ6LK7IVnpcrXbqpJ/mmZD9ft1s1e164AvKlVN0YhsLTlp
         8TH8/8Dwr+jnMoOfkBHD4Qs7cb82WI1T4dshKTTpnXOEWb0H+ECfbRDBfFbGZ3S196o8
         3yEYP4nBxGjNPkrfWwmJQcs/TPGr0Zu69TuOY=
Received: by 10.216.143.66 with SMTP id k44mr2740635wej.81.1311762003078; Wed,
 27 Jul 2011 03:20:03 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 03:19:43 -0700 (PDT)
In-Reply-To: <20110727050220.GG18470@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177962>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> @@ -59,6 +60,11 @@ struct replay_opts {
>> =C2=A0};
>>
>> =C2=A0#define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>> +#define MAYBE_UNUSED __attribute__((__unused__))
> [...]
>> +}
>> +
>> +static void MAYBE_UNUSED read_populate_todo(struct commit_list **to=
do_list,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct repl=
ay_opts *opts)
>
> This MAYBE_UNUSED with no conditional involved feels ugly. =C2=A0Why =
is it
> needed? =C2=A0Why not define read_populate_todo in the patch that fir=
st
> uses it, or barring that, tolerate a warning in this step within the
> patch series?

Junio complained about the warnings here [1], so I added MAYBE_UNUSED
to suppress them temporarily.  Would you really like to see
read_populate_todo and read_populate_opts being introduced MUCH later
in the '--continue' patch?

[1]: http://thread.gmane.org/gmane.comp.version-control.git/176899

Thanks.

-- Ram
