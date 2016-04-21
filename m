From: Stefan Beller <sbeller@google.com>
Subject: Re: problems serving non-bare repos with submodules over http
Date: Thu, 21 Apr 2016 10:11:02 -0700
Message-ID: <CAGZ79kYmobvZgAeJv7MNXeFXd+Ahg5mtyagt5m+f7Gpp=Ps4iQ@mail.gmail.com>
References: <20160420152209.GH23764@onerussian.com>
	<CAGZ79kYS-F1yKpNP7jmhTiZT1R_pucUBBTCbmHKZz6Xd6dy8EA@mail.gmail.com>
	<xmqqh9ewukhw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZMOv0r9fRFbP1WV8qFJBm+s=V8=ueFbYvnyFtgV8j9iQ@mail.gmail.com>
	<xmqqshygt1gs.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbyDuu8hUQXOUNmDLyO88GOi3kqSzsc0UfgzwAL9peZHg@mail.gmail.com>
	<20160421031426.GY23764@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>, Jens Lehmann <Jens.Lehmann@web.de>
To: Yaroslav Halchenko <yoh@onerussian.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 19:11:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atI8D-0002Ee-Um
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 19:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbcDURLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 13:11:05 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34548 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbcDURLE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 13:11:04 -0400
Received: by mail-io0-f175.google.com with SMTP id 2so92895936ioy.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=MPyhffei4p9O0lyczqeiTAP607VWPkjKB9BQwtTano4=;
        b=FJBMtx2RilVEq+okZKe1v8J147KIIuhtH7Od+oW9coeBmOng+CvrmyvsgRt/RCIqx1
         AbAj2irl4A+y6yFHGHb1sV+ItWBGz4jsMBQ2nSoibnc8Hky1Kdgk1WyrPqneEmS24Ed/
         fK2i1Jhlg8IEXpLQXoYEBTvJmn/7ivk6aj853Kds6C8SJFvkjAbd9qEXALON/tufh18R
         Hiu/eS7nhnQo2xxo6Ftz5u08tydbj2Pb8s4uWQ817kCLEjwwUk184ET0aztmh2bw2Byz
         P0me0y5BioGcF2lFp0h2E1H0fMIhhr1DoIy+ihOqAhTuHzCRBqUhr4AZnmlDy/MKgj3v
         LEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=MPyhffei4p9O0lyczqeiTAP607VWPkjKB9BQwtTano4=;
        b=WwZ+LDAI/av0r8kDkg70zWxYQaQSJrLLOV+KiGBrh6pIxN+FBVeM4F8LYmnkQS3ZnE
         4RZsgJXyT7dc1bE5Mji13+gh2PU7yCShDnzDq43DP42RXQo2CVr+Q4FKXhoSsQGUK9UQ
         IRW6hTqK9Fr3NMjAvseSI0isntSU5XNfyDZBBH07X+zTveL+6EmEhPOYYIFL6LHZP4Bz
         DT0Mlt0wKQiDj8iH1vZtTanV14dqp4IPNJ5TNaMasTcVyENoUHmoPKg/bryaqDsGfiCk
         vnWS92wfksX0jFHQZ0jytHK9DGqD2R11Y2vGIJ7gCWmwWRdz8izNJO/Db27Wj3I4l8vc
         QgKg==
X-Gm-Message-State: AOPr4FXnAL7P+Qi769QJB8JAFPL1edmwaHUdg5RGg86tSf7w7vbR/Z1zA86UW9LfN/FEAkx79Sr3mX+NtiTpL71o
X-Received: by 10.107.184.8 with SMTP id i8mr17806007iof.96.1461258662514;
 Thu, 21 Apr 2016 10:11:02 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 21 Apr 2016 10:11:02 -0700 (PDT)
In-Reply-To: <20160421031426.GY23764@onerussian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292129>

On Wed, Apr 20, 2016 at 8:14 PM, Yaroslav Halchenko <yoh@onerussian.com> wrote:
> NB Thank you for the lively discussion!
>
> On Wed, 20 Apr 2016, Stefan Beller wrote:
>
>> >> So currently the protocol doesn't allow to even specify the submodules
>> >> directories.
>
>> > Depends on what you exactly mean by "the protocol", but the
>> > networking protocol is about accessing a single repository.  It is
>> > up to you to decide where to go next after learning what you can
>> > learn from the result, typically by following what appears in
>> > the .gitmodules file.
>
>> Right. But the .gitmodules file is not sufficient.
>
> why?

What do you expect from cloning a repo with submodules?

In case of a bare repo:

    Get the repo from the specified remote and get the submodules
    from "somewhere" (and .gitmodules helps you guessing where
    "somewhere" is).

This has been the traditional way, and the .gitmodules file
is just a helper for a best guess where to get a submodule sha1
from. (The repo pointed at from the .gitmodules file may not exist
any more; or it may have forgot the wanted commit)

In case of non bare:

    Get the repo and all its submodules from the specified remote.
    (As the submodule is right there, that's the best guess to get it from,
    no need to get it from somewhere else. The submodule at the remote
    is the closest match you can get for replicating the superproject with
    its submodules.)

This way is heavy underutilized as it wasn't exercised as often I would
guess, so the "wrong" default (to obtain the submodule information from
.gitmodules instead of from the remote directly) was not pointed out before.

Now that the client wants to make a decision where to get the
submodules from, based on the bare-ness of the remote, it may
require changes in the wire protocol, such that the remote simply
advertises it is a (non-)bare repository when you clone the superproject
from it. Then the client can make a better decision where to get the
submodules from.




>
>> >...<
>
>> I think on a hosting site they could even coexist when having the
>> layout as above.
>
>>          top.git/
>>          top.git/refs/{heads,tags,...}/...
>>          top.git/objects/...
>>          sub.git/
>>          sub.git/refs/{heads,tags,...}/...
>>          sub.git/objects/...
>
>>          # the following only exist in non bare:
>>          top.git/modules/sub.git/
>>          top.git/modules/sub.git/refs/{heads,tags,...}/...
>>          top.git/modules/sub.git/objects/...
>
>> The later files would be more reflective of what you *really*
>> want if you clone from top.git.
>
> may be there is no need for assumptions and .gitmodules should be
> sufficient?
>
> - absolute url in .gitmodules provides absolute URL/path to the
>   submodule of interest, regardless either submodule is present in
>   originating repository as updated submodule.  Either cloning it
>   instead of original repository would be more efficient is already a
>   heuristic which might fail miserably (may be I have a faster
>   connection to the original repository pointed by the absolute
>   url than to this particular repository)
>
> - relative url in .gitmodules provides relative location to the location
>   of the "top" repository, and that is only when that submodule "absolute"
>   url should be resolved relative to the one of the "top" repository

I think the .gitmodules file is not sufficient for the following reason:

* As a "downstream" user you cannot change remote locations without
altering the history. Maybe you just want to have a mirror of some cool
open source project without the hassle to always merge and maintain changes
in your local submodules configuration. (c.f. git config url.<base>.insteadOf
for repos, just for submodule specific)
>
> NB I will consider it a separate issue either relative paths
> without '../' prefix are having any sense in bare repositories.

I guess it is a separate issue.

>
> or have I missed the point?
> --
> Yaroslav O. Halchenko
> Center for Open Neuroscience     http://centerforopenneuroscience.org
> Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
> Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
> WWW:   http://www.linkedin.com/in/yarik
