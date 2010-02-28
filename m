From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 4/5] grep: Colorize filename, line number, and separator
Date: Sun, 28 Feb 2010 15:15:40 -0500
Message-ID: <ca433831002281215i66af2401n221813466f2ffa85@mail.gmail.com>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com> 
	<1267246670-19118-5-git-send-email-lodatom@gmail.com> <4B89079C.8030206@lsrfire.ath.cx> 
	<7vy6ie1u9a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 21:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlpYg-0003jD-7d
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 21:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032010Ab0B1UQE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2010 15:16:04 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42621 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031966Ab0B1UQB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Feb 2010 15:16:01 -0500
Received: by gwb19 with SMTP id 19so720930gwb.19
        for <git@vger.kernel.org>; Sun, 28 Feb 2010 12:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=sndFHq1rJl4qJ/MTCDfWVOx7Xo0x+VEIjDNlIJDXwTw=;
        b=SZs+t2eIO3BiKTLv2ypt5yEM2cxV1iMROJdsQQ6I5+4gMdwd5SJZXlbdTi0o3YQ1bS
         RqW9dd7JRiaqEl5Q3W1LO/vMPFYoyhyue/Kw7YdMmz2jgjN09Vuas2sH9wFWE5iZGrYq
         HRKYG6gP/W5XsZ8kieXpUNEt3xTYpzu4I1VuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cLfH7S/s0LkdjUvZEnbE56FfXplYsk47t++kubnAuvu2zS0hbTo3pSNkM4PqmtEkTg
         Y2bcfHeMrvF8UBV0L2zTxiLbrbz92mGKwpEZkt+SHAjPURmgNMRnxpU8Lxzq1yZ/zE/D
         az73+RVdKBSas7WAuLtX7oO0FWjNY8elKY4mw=
Received: by 10.90.40.17 with SMTP id n17mr2816494agn.3.1267388160126; Sun, 28 
	Feb 2010 12:16:00 -0800 (PST)
In-Reply-To: <7vy6ie1u9a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141268>

On Sat, Feb 27, 2010 at 12:08 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0opt->output(opt, bol + match.rm_so,
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(int)(match.rm_eo - match.=
rm_so));
>>
>> The third parameter of output_color() (and of ->output(), so you did=
n't
>> introduce this, of course) is a size_t, so why cast to int? =C2=A0Is=
 a cast
>> needed at all?
>
> I don't think so.
>
> Earlier in 747a322 (grep: cast printf %.*s "precision" argument expli=
citly
> to int, 2009-03-08), I casted the difference between two regoff_t you=
 were
> feeding to printf's "%.*s" as a length, introduced by 7e8f59d (grep: =
color
> patterns in output, 2009-03-07), and 5b594f4 (Threaded grep, 2010-01-=
25)
> carried that cast over without thinking.

Ok.  I'll remove the cast.  Should I note this in the commit message?
