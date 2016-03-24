From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFD] minor frustration in 'git add' pathname completion
Date: Thu, 24 Mar 2016 15:40:19 -0700
Message-ID: <CAGZ79kYDWJDDJ+doy3NcZH_dqbbFE8U2UHZjnYYTo5R9GTsghQ@mail.gmail.com>
References: <xmqqr3ez7dqw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaUPf=kBCuH__8BahjM3WjSGaijiQr05pMKe+TNdg3W9w@mail.gmail.com>
	<xmqqbn637cpe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 23:40:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajDvV-0000eO-3H
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 23:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbcCXWkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 18:40:22 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:35258 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbcCXWkU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 18:40:20 -0400
Received: by mail-io0-f172.google.com with SMTP id v187so68419045ioe.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=qXbqp1dHjo74IKNJP0c/aynx085GaxWDQ0JyT9vJ6gg=;
        b=jeM+jMT3TBNYj0RU+ST8lZogtRN7iR/2F7XZFqfbX5dYJJwdnbKhI19+/thoT9KIlu
         IvQMky7UIRzhTmvGl/unc0mmSaOIc7bM7QHajepDMD6mawrX8tS7KvUiigO7mR19IA+l
         ufw33KWIdekbBl7MQOt6wzXbmL5n/HEBcPYkoQp14xz8HypR+0hoKtlkvdhhg4MoBKyU
         xsT4OOeEysJj8expYLUrFH/pEJ4n/Nps7CC8RHWhyc3/GjbvDCbifM7ukbPRBf5QbxGu
         HZ9PhA0gv/lQR7wif6scFXyc3DfW7HqCjbiCoDlS1htoTbPBQYs6+wihmjobf7cUosk6
         zs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qXbqp1dHjo74IKNJP0c/aynx085GaxWDQ0JyT9vJ6gg=;
        b=VctrOsQPtFFDS5CqkhjoEycmkTzazczpCKw6STU9k3ZYOlViBzx1hiLRvn2vPi5bKr
         AB8cQH0sUT5Wf9mdS49Uh2p0YDIjQOrdM1BJJ1Ju0OvB+V8cFSG3iww5IlfXp8+XGMVw
         hbmTf5HVofbulW1CZbSYhnw87ccTQ3B+Z/sXBi2g5c5/0CFJ41rN21ftjlEgtLctxvpH
         nmFYphr64x1ZnySDqWQN6rTJLCqLxN/N8ASts0y+MCA0tBV1kjBdHAsH/TcDizgT3qAh
         azAv9OYep681lT9hIM4GdmpC93+MQ//iprtuftmucw+V67+shL9pMb3gT8JZl0oQnGy4
         I1Sw==
X-Gm-Message-State: AD7BkJJ5GUdVnO1ZcFNb55K0qoEKjIwFVZnV/cJmSdnAWsZZjjN+Ko3CV27I8YJjDMS2AV+me+tOAZ/VaiIUWHC+
X-Received: by 10.107.131.163 with SMTP id n35mr12650940ioi.110.1458859219243;
 Thu, 24 Mar 2016 15:40:19 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Thu, 24 Mar 2016 15:40:19 -0700 (PDT)
In-Reply-To: <xmqqbn637cpe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289817>

On Thu, Mar 24, 2016 at 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, Mar 24, 2016 at 2:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Discuss.
>>
>>> For example, I keep
>>> a backup version of whats-cooking.txt in the working tree that I use
>>> to manage the 'todo' branch as whats-cooking.txt+, and this is not
>>> explicitly "ignored".
>>
>> Completely side tracking thought: Have you considered ignoring
>> whats-cooking.txt+ locally?
>
> The point is that I shouldn't have to.  I wasn't asking for a
> workaround.

It is not a workaround. You want to have an untracked file in a repository,
but you want git add to ignore it, which sounds like the definition of the
ignoring mechanism.

> If I were to explicitly ignore that file, then even though I know
> whats-cooking.txt is not ignored,
>
>    $ git add whats-coo<HT>
>
> would not offer anything.  I'd be left scratching my head, wondering
> if I mistyped the early part of the filename (e.g. "wahts-coo<HT>"?).

Well, git add cannot do anything with either of the files, so why would
it offer to complete to one of them?

In an ideal world it would tell you whats-cooking.txt doesn't need
adding and whats-cooking.txt+ is ignored locally so excluded from
being added.

>> Discuss.
>
> Eh, please don't.  Somehow this no longer reproduces for me.

Uh, is there a good way to test auto completion if at all in our
test suite? (Would we want such a thing to be tested?)
