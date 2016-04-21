From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: problems serving non-bare repos with submodules over http
Date: Thu, 21 Apr 2016 15:42:50 -0700
Message-ID: <CA+P7+xrHpjaTNfu-spfdVGM9OcksYpATpp9yeO10-YXU9GTePQ@mail.gmail.com>
References: <20160420152209.GH23764@onerussian.com> <CAGZ79kYS-F1yKpNP7jmhTiZT1R_pucUBBTCbmHKZz6Xd6dy8EA@mail.gmail.com>
 <xmqqh9ewukhw.fsf@gitster.mtv.corp.google.com> <CAGZ79kZMOv0r9fRFbP1WV8qFJBm+s=V8=ueFbYvnyFtgV8j9iQ@mail.gmail.com>
 <xmqqshygt1gs.fsf@gitster.mtv.corp.google.com> <CAGZ79kbyDuu8hUQXOUNmDLyO88GOi3kqSzsc0UfgzwAL9peZHg@mail.gmail.com>
 <20160421031426.GY23764@onerussian.com> <CAGZ79kYmobvZgAeJv7MNXeFXd+Ahg5mtyagt5m+f7Gpp=Ps4iQ@mail.gmail.com>
 <xmqqr3dysvne.fsf@gitster.mtv.corp.google.com> <CAGZ79kYTo+CHPvhV6i0U3xqezhGBSXQs9h+5JL6MRh9oAWXvFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Yaroslav Halchenko <yoh@onerussian.com>,
	Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>, Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:43:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atNJc-00059r-Q1
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 00:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbcDUWnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 18:43:12 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:32806 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbcDUWnL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 18:43:11 -0400
Received: by mail-vk0-f53.google.com with SMTP id n62so115833022vkb.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3CM4cCn07KeLNuOIt1a6CpGt+O1YeFuJ151e6uKmcQQ=;
        b=VQqsAeJBsjTT2Q+0FOk619BK3FC/X34pCwHy83Bkx5OvjFZQkhxhdSpek4zIP15km8
         +uH/b/19EYsp+fMMidi9vbrO8np8kmq4tJUGXYnszUvaQToVP6NCQdnDERYY2jh+dDah
         ShCXoy5sZZrC8JOnrrvdvRG1PNn7y+KI/TTySj03XUte/XxgiSNMBspMYRlGinF6Q4SY
         hgnYGU/2mJ8DO76M1LbfOqSQqlgD5iD53GHddb6/nMikHM4h2IS6qfzhEbX9bK5wUOL7
         1egDUhHbHlNrStnVJU9fXKTE/LfCiWV+3Rndnjx21wGivmsklOMCyq6hd3BIeNbz0AX7
         atrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3CM4cCn07KeLNuOIt1a6CpGt+O1YeFuJ151e6uKmcQQ=;
        b=TjptAibxNAFj3gq5727Bl145D2Q4HIijUGox9tsP4QDe4MiyoovQsGuCzsec1I8fkB
         HcuzAH+PutzTLtL8FIzLJiEQ9mLWNxqz5kQRSKadlJKPXoHuVo12fr7lXWemj+LR6pJu
         QY1sP+Eo9pG9a6mdKk0hNUi9TjIp/eJLLWSZWdr0kIG3BO9dFiG1dc5FtybzimHFGNi8
         lBcSHYa8PCw5QUjmxnJ6Slz3uBduqwBaJNUlYio04P/FAeJ6vWgxnUvQk8VfGi8pg2sk
         5kHW/WShgrayyy+KafDqTvD7l1JnD1DtBkxKm+dbGJBadV/14CW29SYlXp48H5a8qrHE
         FzTw==
X-Gm-Message-State: AOPr4FUEqCKIM3yiFEkiuxPxxvPqhvT1Ps8Q4GWN5qjPQNhgQd+FHQ4wYIAZN93yS82hSVaU0NRnBFTZYXJB7w==
X-Received: by 10.159.38.75 with SMTP id 69mr3483640uag.139.1461278590250;
 Thu, 21 Apr 2016 15:43:10 -0700 (PDT)
Received: by 10.159.53.112 with HTTP; Thu, 21 Apr 2016 15:42:50 -0700 (PDT)
In-Reply-To: <CAGZ79kYTo+CHPvhV6i0U3xqezhGBSXQs9h+5JL6MRh9oAWXvFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292159>

On Thu, Apr 21, 2016 at 10:48 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Apr 21, 2016 at 10:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> In case of non bare:
>>>
>>>     Get the repo and all its submodules from the specified remote.
>>>     (As the submodule is right there, that's the best guess to get it from,
>>>     no need to get it from somewhere else. The submodule at the remote
>>>     is the closest match you can get for replicating the superproject with
>>>     its submodules.)
>>>
>>> This way is heavy underutilized as it wasn't exercised as often I would
>>> guess,
>>
>> My guess is somewhat different. It is not used because the right
>> semantics for such a use case hasn't been defined yet (in other
>> words, what you suggested is _wrong_ as is).  You need to remember
>> that a particular clone may not be interested in all submodules, and
>> it is far from "the closest match".
>
> Yes, when that clone doesn't have some submodules, we can still fall back
> on the .gitmodules file.
>
> If you have a submodule chances are, you are interested in it and modified it.
> So the highest chance to get your changes is from your remote, no?
> --

I agree with Stefan. I think that if I clone from my local non-bare
repository that may have work done inside the submodule it would be
best if the clone could grab the submodules directly from here and get
this work which might not yet be in the "real" remote yet.

The case could be made that you don't want to do this, I suppose..
Generally I think since we're already connected to this remote we know
we can access it, and getting submodules from here means we know it
will work, and give us the actual sha1 that the clone is using.

If we use .gitmodules, we'll possibly get a module that doesn't have
the commit, and the current gitmodules url might not even work
anymore.

That is, I don't really understand any downside to Stefan's
proposal,and I see a bunch of upside.

Thanks,
Jake
