From: Rick Bradley <rick@rickbradley.com>
Subject: Re: problem with updating a shallow clone via a branch fetch
Date: Mon, 28 Feb 2011 20:07:35 -0600
Message-ID: <AANLkTimSRG+UkD1vJszUf+3j0nV+_pPWSE3N2Dy9SfTa@mail.gmail.com>
References: <AANLkTinx01bzzLKk=DfyEvfSz8Hun-YqzJfEDpX7gNSS@mail.gmail.com> <7vtyfng00i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 03:08:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuF0X-0002xw-3u
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 03:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700Ab1CACH5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 21:07:57 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63730 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab1CACH4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 21:07:56 -0500
Received: by fxm17 with SMTP id 17so4388580fxm.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 18:07:55 -0800 (PST)
Received: by 10.223.72.15 with SMTP id k15mr7418763faj.54.1298945275163; Mon,
 28 Feb 2011 18:07:55 -0800 (PST)
Received: by 10.223.72.208 with HTTP; Mon, 28 Feb 2011 18:07:35 -0800 (PST)
In-Reply-To: <7vtyfng00i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168182>

Junio,
Thanks for the assistance.  I'll be looking in the direction of what
could have caused sanity problems in the upstream repo.  If it happens
again and we can collect more tea leaves (this checkout was cleaned up
before I could get a copy of it to do further diagnosis :-/) I'll see
what else we can find out.

Rick

On Mon, Feb 28, 2011 at 6:25 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Rick Bradley <rick@rickbradley.com> writes:
>
>> So I have a git repo that is shallow cloned:
>>
>> =A0 % git clone --depth 1 <repo url>
>>
>> Sometimes (very rarely), when I do a branch fetch to update that
>> repository I get an error:
>>
>> =A0% git fetch origin +refs/head/<branch>:refs/remotes/origin/<branc=
h>
>>
>> fatal: did not find object for shallow <hash>
>
> The message comes from the repository you are fetching from. =A0When =
you
> fetch from a shallow clone, the fetch process on your end tells the o=
ther
> side what commits your incomplete history ends at, and if the other e=
nd
> does not have any of these commits, you get that message. =A0So the o=
nly
> case (unless there is a bug---and I don't think this codepath is heav=
ily
> exercised so it is very possible there are bugs) you would see that
> message is if the other side rewound the branch and then later garbag=
e
> collection lost the commit.
>
