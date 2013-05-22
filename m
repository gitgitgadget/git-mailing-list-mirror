From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Wed, 22 May 2013 09:49:12 +0200
Message-ID: <CALKQrge33R9NiQ6isy4xEFaPe7SUmRaDbrXsjPahjtGp9ELG9Q@mail.gmail.com>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
	<CALKQrgcmmaqAt-oVtFeem_xvqsjehacVoVJ2bYOyfKWTUzV0AA@mail.gmail.com>
	<7vtxlwqrbg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 09:49:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf3nb-0007w9-AQ
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 09:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697Ab3EVHtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 03:49:21 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:53052 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689Ab3EVHtR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 03:49:17 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Uf3nQ-000EVF-5Q
	for git@vger.kernel.org; Wed, 22 May 2013 09:49:16 +0200
Received: from mail-pd0-f170.google.com ([209.85.192.170])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Uf3mQ-000JQn-FY
	for git@vger.kernel.org; Wed, 22 May 2013 09:48:14 +0200
Received: by mail-pd0-f170.google.com with SMTP id x10so1323417pdj.15
        for <git@vger.kernel.org>; Wed, 22 May 2013 00:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9wsElM4Dql9yGThNsiBfbcXC+qC81CdD63eFgl7MFKU=;
        b=MXySORXiRN19690OeelVqj9NbkHLXq3ROutaKBluTGY/eW46/D8+Kvgjh5mtvbc1Ri
         YchL37INGDikeJnpwWoqHLXnQP9PWLhxps5cMxzxvc9T8js585gvH2jJBhOMhrP/rhSe
         xEipZ7hMKIlNnjNFHBioJtIoM1GxGLrV+tfjiWo4+59I9VfQHG9IzNJBV+w3ShUEL+KA
         8gijx/+fQhHdUt2YNH5EHCxdkNRQm1Qs80hZIv8EcCT+a5gThCvp5be6EK2nZjeMfdAW
         fI+7UmHo9GS4zxzyNQFJbXHGDZHQKJaWtJwFXL1+II5A8lu/NHaJ0eV6TNHyOBoJkOcm
         soPQ==
X-Received: by 10.68.245.200 with SMTP id xq8mr6698644pbc.32.1369208952139;
 Wed, 22 May 2013 00:49:12 -0700 (PDT)
Received: by 10.70.12.197 with HTTP; Wed, 22 May 2013 00:49:12 -0700 (PDT)
In-Reply-To: <7vtxlwqrbg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225137>

On Tue, May 21, 2013 at 5:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> On Tue, May 21, 2013 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> * jh/shorten-refname (2013-05-07) 4 commits
>>>  - t1514: refname shortening is done after dereferencing symbolic refs
>>>  - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
>>>  - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
>>>  - t1514: Add tests of shortening refnames in strict/loose mode
>>>
>>>  When remotes/origin/HEAD is not a symbolic ref, "rev-parse
>>>  --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
>>>  "origin/HEAD", which is fixed with this series (if it is a symbolic
>>>  ref that points at remotes/origin/something, then it should show
>>>  "origin/something" and it already does).
>>>
>>>  I think this is being rerolled using strbuf_expand().
>>
>> Actually, that was not on my TODO. Sure, my other series ([PATCHv2
>> 00/10] Prepare for alternative remote-tracking branch location) builds
>> on top of this one, and changes a lot of the same code, but I
>> considered jh/shorten-refname a good set of changes in its own right,
>> and I didn't want it to be held up by the much longer (and probably
>> much longer-running) series.
>
> On the other hand, this itself is fixing the case nobody encounters
> in real life, and in that sense it is not urgent at all even though
> it may be a correct fix, no?  When was the last time you saw a
> refs/remotes/*/HEAD that is not a symbolic ref?
>
> If it makes it is easier for you to work on the follow-on series to
> have this shorter one already cast in stone, I do not mind merging
> this early post 1.8.3 cycle at all.  If on the other hand you are
> hit by a realization that this part could be done in a different and
> a better way (I am not saying that that is the likely outcome) when
> you will look at redoing the follow-on series using strbuf_expand
> post 1.8.3, we would regret it if we cast this part in stone too
> early.  I think we can go either way, and the above "I think this is
> being rerolld" was primarily keeping the options open.

You're right. No point in setting things prematurely in stone. I'll
fold jh/shorten-refname into the ongoing series.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
