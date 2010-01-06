From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] git-update-index: report(...) now flushes stdout after 
	printing the report line
Date: Wed, 6 Jan 2010 09:51:06 +0800
Message-ID: <be6fef0d1001051751p33c2f4a6r5b6f3fbbbeac9fa9@mail.gmail.com>
References: <loom.20091119T221732-624@post.gmane.org>
	 <loom.20100103T114055-16@post.gmane.org>
	 <be6fef0d1001031503h11cb65c6ha34eee345b9b7055@mail.gmail.com>
	 <7vwrzwoxh4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Sebastian Thiel <byronimo@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:51:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSL3M-000281-Jx
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 02:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212Ab0AFBvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2010 20:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755070Ab0AFBvL
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 20:51:11 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:39550 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495Ab0AFBvK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2010 20:51:10 -0500
Received: by iwn32 with SMTP id 32so1271274iwn.33
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 17:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l371JjqTShPQZ57B53hsamawN4/9Pg8h6vxfEXm+Zdk=;
        b=BvKDyGKJOTa5cNcP0jdYJP+G8DZiIZR2qH7pVxuJ/MOUBRoxcI+TbGysODykq7HjE+
         VCwzBh1fLmpFyqN95N0Gacti8HN5hFwV9ICAbc55gLYIwqHz97sR4+kZmF4MEmF1EhIr
         5qOXkgGT8bmUWgM+GhaWbaIgPLfTJ2dV+7Rzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hNTV2tDQo+pwntvbqNOf4+lbtZFm/UbogwM60FA/5MTi4KIu7XrKdv0YRK8l6zb4+L
         6HIz5L7L+TnVukX9N6ncNIGk9yIJyvAQTEkTZmvzuDGLDr0ns94RF63yoi7gHqCYpnpW
         Xm/352Od5cwFKYnoc8WraPVN4Mu/SAyYZVvDI=
Received: by 10.231.146.2 with SMTP id f2mr1307552ibv.23.1262742666597; Tue, 
	05 Jan 2010 17:51:06 -0800 (PST)
In-Reply-To: <7vwrzwoxh4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136235>

Hi,

On Wed, Jan 6, 2010 at 9:04 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> from your above message solely and setting aside your original patch=
,
>> I presume that you want to introduce the ability to force progress
>> reporting even if stderr isn't a terminal.
>>
>> I am working a feature (display progress for http operations) that
>> happens to add this ability to git-push and git-fetch, by specifying
>> the --progress option.
>>
>> Regarding git-pull - I guess it's only git-fetch (being
>> transport-related) that reports progress?
>
> Are you talking about this topic?
>
> =A0* tc/clone-v-progress (2009-12-26) 4 commits
> =A0- clone: use --progress to force progress reporting
> =A0- clone: set transport->verbose when -v/--verbose is used
> =A0- git-clone.txt: reword description of progress behaviour
> =A0- check stderr with isatty() instead of stdout when deciding to sh=
ow progress

no, I'm not referring to that - the topic I mentioned is still off-list=
=2E

> What do people think about it? =A0I vaguely recall that somebody aske=
d to
> add a warning to release notes on the behaviour change to this series=
, and
> I think it may be a worthwhile thing to do (e.g. "Earlier we did X bu=
t now
> we do Y; change things in this way if you want us to keep doing X"), =
but
> otherwise I think it is a sensible change.

Yes, that request was from Dscho, and Miklos said something to that
effect as well. Could you advise how one could go about adding such a
warning, as I'm not sure about the release schedule details.

--=20
Cheers,
Ray Chuan
