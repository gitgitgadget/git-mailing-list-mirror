From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: git diff --added (Re: Command-line interface thoughts)
Date: Mon, 13 Jun 2011 16:31:09 -0400
Message-ID: <BANLkTinqRZyMVwMqZTA8Ei1Tg0nc0Od==A@mail.gmail.com>
References: <201106051311.00951.jnareb@gmail.com>
	<201106101844.16146.jnareb@gmail.com>
	<4DF25D50.5020107@ira.uka.de>
	<201106102035.42525.jnareb@gmail.com>
	<4DF29EA5.60502@ira.uka.de>
	<20110613034347.GA4222@elie>
	<buotybu2wx7.fsf@dhlpc061.dev.necel.com>
	<7vmxhlrk3m.fsf@alter.siamese.dyndns.org>
	<4DF66946.8000101@ira.uka.de>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 13 22:31:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWDn3-0007Ob-Ib
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 22:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465Ab1FMUbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 16:31:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43786 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab1FMUbL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 16:31:11 -0400
Received: by bwz15 with SMTP id 15so4006650bwz.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 13:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=BugS7qMWXn3eb7dt20Jnn7y/3dRdFgYGaTHKYDo2d48=;
        b=LGVb2Ts8YIl+sMeX250iM84qM1RZZWjCwP4k5nC8YuzIloAlqkowlDaq/VROMWVWby
         eADFyEuuu0c62kYASTPpQc1L64dwqA+GuFW37zXXGsqgWwZNvuKad06tBL4l+U1I1+wS
         pY3yEyGT90IEEhb66lMf5mhfd+XiRJrNHYy30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=WngRn4B0Z5UqD89maABIFg/vSmmQc7c467PzVn8vno53FhiOJYJTYt3y3Zu5Cv8U2A
         9SJC8pCsqcwfgrIBSXZsPUvzLH5D8RzSHQRfHLoGVbdnFt4xi7N320NdVTaCsUK5rn5W
         LKJijIE3JEaIl4T3dVqbJjvWnj2OM8V4tiOiI=
Received: by 10.204.57.135 with SMTP id c7mr4923147bkh.88.1307997070090; Mon,
 13 Jun 2011 13:31:10 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Mon, 13 Jun 2011 13:31:09 -0700 (PDT)
In-Reply-To: <4DF66946.8000101@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175731>

index is a file with multiple uses.
E.g., during a conflict it may have 4 "stages".

I prefer either index0 or NEXT.

On Mon, Jun 13, 2011 at 3:47 PM, Holger Hellmuth <hellmuth@ira.uka.de> wrote:
> Am 13.06.2011 14:28, schrieb Junio C Hamano:
>>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>>> Do you think it would be valuable to introduce --added as a synonym
>>>> for --cached and slowly steer documentation to encourage the latter
>>>> in place of the former?
>
> No. Apart from Junios reason more options won't help that much because
> git is already loaded with options (git diff for example has 49). Don't
> misinterpret this as a suggestion to remove options, just that an option
> in this sea of options must be very obvious to help the casual user.
> And "git diff --added" is not telling with what it compares the "added"
> files, which means you either know the concept or you have to read the
> man page whenever you need to use it. Until you fix it in your memory,
> which may be never because you don't use it often enough.
>
>> It is an entirely different issue that "cached" is _not_ the best way to
>> spell "index-only", though.
>
> Yes, and the one and only word that would be right here (apart from
> spelling it out with index-only) is "index", while "index" as used in
> git stash and git apply should have been something like 'with-index'. At
> least to me '--something' suggests 'something-only' much more than
> 'something-too'
>
> Since this is not possible anymore, we are stuck with 'cache' and
> essentially a diff-command that will never be user-friendly. That is why
> I still think that an alternate usage with 'git diff wtree index' would
> be beneficial, especially with a corresponding 'git put'.
>
> Holger.
>
