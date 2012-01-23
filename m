From: Albert Yale <surfingalbert@gmail.com>
Subject: Re: [PATCH/RFC] Fix the result of "git grep -l -C <num>"
Date: Mon, 23 Jan 2012 12:10:39 -0500
Message-ID: <CALEc4zGV6Oo-WR0vPE6=oEmm=fo4dd=nyBWFuK1oU7rmF9K41A@mail.gmail.com>
References: <1327334484-35196-1-git-send-email-surfingalbert@gmail.com> <8762g2ieq0.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 23 18:11:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpNQU-0008DC-J1
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 18:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411Ab2AWRLW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 12:11:22 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:56594 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878Ab2AWRLV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2012 12:11:21 -0500
Received: by werb13 with SMTP id b13so2290715wer.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 09:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3MEjNAQVtneJlIBW2jyYXYVXJZruZLGAU9W7KobDwcI=;
        b=QsHkzvUIMt1nHmg+4RuowUm8YuRgRFqzEhLIk+QnEpeC3e0dHzrWyHjWnSDyvHtAwL
         Oo2BxBCgb+PCXuAShs8CoGrJSv9wiTNgUQNd1oONiOjhh1mwyRJ0BjMhed5TP/s99jTf
         KSR8Gq6FL2fcEgiuzIpqd2ODfcMwV/J41wabA=
Received: by 10.216.132.19 with SMTP id n19mr4080484wei.31.1327338680282; Mon,
 23 Jan 2012 09:11:20 -0800 (PST)
Received: by 10.223.86.144 with HTTP; Mon, 23 Jan 2012 09:10:39 -0800 (PST)
In-Reply-To: <8762g2ieq0.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189000>

You're right. This solution is incomplete. It needs to take into
account "opt.unmatch_name_only", and possibly other states. I'm open
for suggestions.

I've just posted Version 2 of this patch.

As for creating a test, I'm unfamiliar with the testing procedure for
git-core. A "how to" in the "Documentation" folder would be very
useful in that regard.

Albert

On Mon, Jan 23, 2012 at 11:08 AM, Thomas Rast <trast@student.ethz.ch> w=
rote:
> Albert Yale <surfingalbert@gmail.com> writes:
>
>> When combining "git grep -l" with "-C <num>",
>> the first result is omitted.
> [...]
>> For example, if the following command should output a list of 3
>> different files (a.txt, b.txt, c.txt):
>>
>> $ git grep -l -C 1 albert_yale
>> b.txt
>> c.txt
>
> Nice catch. =A0Can you add a test?
>
> Is -l the only option affected? =A0Why isn't, for example, -L?
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
