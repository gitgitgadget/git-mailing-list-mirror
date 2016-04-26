From: Christian Couder <christian.couder@gmail.com>
Subject: Re: RFC: Supporting .git/hooks/$NAME.d/* && /etc/git/hooks/$NAME.d/*
Date: Tue, 26 Apr 2016 19:52:11 +0200
Message-ID: <CAP8UFD37djTYZAeR_vcSf0G49rH=zAmn6nVXj5QG+ozDMD2x-Q@mail.gmail.com>
References: <CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com>
	<xmqq4mapmvjq.fsf@gitster.mtv.corp.google.com>
	<CACBZZX6AYBYeb5S4nEBhYbx1r=icJ81JGYBx5=H4wacPhHjFbQ@mail.gmail.com>
	<571F6FB5.2000305@xiplink.com>
	<CACBZZX6CRBQ5qOBdwamqJMz+_QU-cmVfA7iLTyjOCYentjx-mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:52:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av79v-0006cz-Es
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbcDZRwP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 13:52:15 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34998 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbcDZRwM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 13:52:12 -0400
Received: by mail-wm0-f54.google.com with SMTP id e201so6339595wme.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=PPIwHjGafCvMswEAU6fb+KefD52ejZtVzeYsnbRG0sk=;
        b=AlBUfVDqZv8SW2lAYUmUVjIkh5DRBoS4tyhYVbdbb+amyzRE2NwrWLokn1Qbxv3cZv
         Nd2WA2vLC0aX5mi563fG/RRyU7RLIp8pmkjO2R6a5Klfr6fg+EplDFmwcdXAzytk6YOo
         5VA6CaeBz9SEb02dBmENXTx1mf76Pdvz7glfvHoN+1GCTXE/oPJuDpXKnDPCz4iQt8JP
         64TNLQ+YMJFXxlN169SqQnVriq4+TAlM6vSIVQJGn5GdU5TWRLd6tgSibU1a4HZFN/11
         tLeAL6t8V7vs5JiJtlNrbs7e48SO8ZabebjhSk8J9LPMthna/fWe7BnMyVvaefk0UN9W
         HRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=PPIwHjGafCvMswEAU6fb+KefD52ejZtVzeYsnbRG0sk=;
        b=KcwKY/fGAAGAr7ky6Jexf+yACUKKQBEq1o9fD9u/1rVfY4JVbGRwZqLz67pRli0S3b
         QmHK0fup0vj+Qa3Aac3Tuje9suU/CQTFLT77mj66qpBR++szSxMZl7r9ZOc+6onudeD4
         AMPr9slkC7ugNLgQbBa4lR7BW8WDMAltmgoO6+b8+VFTE8eKmOVcq/Ggv+olDj6kIyEY
         8+dFUKLKflAf1Nl5x6PXtEhYqUoV3qopD6YPUr2047BmgkCm61HIqpV7uDR6lWVjh5w6
         37IBdZb6ghpiZ5Tb8Zk28QJMpCzrCTqTyI/ues7aHtO15/iJnlfA2JLzzdGoB1atyABz
         +mvw==
X-Gm-Message-State: AOPr4FVzW/n69OCUC3xcl2Eaorjh6FNMPvrzSlGj6Yrd9q7ILOWnS6SGnpq/lm0Cq46rjjbYhpDXev2ngtMd0A==
X-Received: by 10.194.117.70 with SMTP id kc6mr5010747wjb.94.1461693131127;
 Tue, 26 Apr 2016 10:52:11 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Tue, 26 Apr 2016 10:52:11 -0700 (PDT)
In-Reply-To: <CACBZZX6CRBQ5qOBdwamqJMz+_QU-cmVfA7iLTyjOCYentjx-mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292631>

On Tue, Apr 26, 2016 at 6:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Apr 26, 2016 at 3:40 PM, Marc Branchaud <marcnarc@xiplink.com=
> wrote:
>> On 2016-04-26 06:58 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote=
:
>>>
>>> Makes sense to have an experimental.* config tree for git for stuff=
 like this.
>>
>> I disagree.
>>
>> * If the point is to express some kind of warning to users, I think =
the
>> community has been much better served by leaving experimental settin=
gs
>> undocumented (or documented only in unmerged topic branches).

There are features considered experimental that are documented, like
--split-index in `git update-index` and `git interpret-trailers`.

As far as I know the possible reasons they are considered experimental =
are:

- in the release notes they were described as "experimental",
- they are not considered complete, because of missing features,
- they might not be useful as is,
- they might be buggy in the real world.

>> It feels like
>> an experimental.* tree is a doorway to putting experimental features=
 in
>> official releases, which seems odd considering that (IMHO) git has s=
o far
>> done very well with the carefully-planned-out integration of all sor=
ts of
>> features.

Some people have been happily experimenting with or even using some of
the experimental features, like the ones I am talking about above.

>> * Part of the experiment is coming up with appropriate configuration=
 knobs,
>> including where those knobs should live.

I agree that it can be difficult to find the right knobs for any new fe=
ature.

>> Often such considerations lead to a
>> better implementation for the feature.  Dumping things into an exper=
imental.*
>> tree would merely postpone that part of the feature's design.

I am not so sure about this. For example `git update-index
--untracked-cache` used to be considered experimental, but it
definitely had knobs that were not right, so its UI has been reworked
recently.

Maybe if it had first been created with an UI in an experimental.*
config tree, rather than only options to `git update-index` it would
have been an easier transition.

>> * Such a tree creates a flag day when the experimental feature event=
ually
>> becomes a "real" feature. That'll annoy any early adopters. Sure, th=
ey
>> *should* be prepared to deal with config tree bike-shedding, but sti=
ll that
>> extra churn seems unnecessary.

Not sure about that. New config options outside the experimental.*
config tree could always take over config options in the
experimental.* config tree, as if they appear, it means that the user
is aware that they are the new way to configure the feature. Then the
cost of supporting both the old options in the experimental.* config
tree and the new ones outside should be very small, especially if
there are not many changes between the two set of options.

If there are a lot of changes between these two sets, it means that we
were probably right to have the old ones in the experimental.* config
tree. And in the worst case, which should hardly ever happen, we can
probably afford to just emit warnings saying "old 'experimental.XXXX'
config option is not supported anymore, please use YYYY config option
instead" and just ignore the 'experimental.XXXX' config option.

> By "stuff like this", yeah I did mean, and I assume Junio means,
> putting "experimental" features in official releases.
>
> E.g. perl does this, if you type "perldoc experimental" on a Linux bo=
x
> you'll get the documentation.
>
> Basically you can look at patches to a project on a spectrum of:
>
>  1. You hacked something up locally
>  2. It's in someone's *.git repo as a POC
>  3. It's a third-party patch series used by a bunch of people
>  4. In an official release but documented as experimental
>  5. In an official release as a first-rate feature

Yeah, and it seems to me that Git also has:

4.5. In an official release, documented, but scarcely documented as exp=
erimental

and in fact more stuff under 4.5. than under 4.

And in Git there is also the notion of porcelain vs plumbing, where
porcelain output can more easily be changed a bit than plumbing
output.

> Something like an experimental.WHATEVER=3Dbool flag provides #4.
>
> I think aside from this feature just leaving these things undocumente=
d
> really provides the worst of both worlds.

Yeah I agree. Undocumented stuff in Git is already for stuff that we
don't want people to use.

> Now you have some feature that's undocumented *because* you're not
> sure about it, but you can't ever be sure about it unless people
> actually use it, and if it's not documented at all effectively it's a=
s
> visible as some third-party patch series. I.e. only people really
> involved in the project will ever use it.
>
> Which is why perl has the "experimental" subsystem, it allows for
> playing around with features the maintainers aren't quite sure about
> in official releases, and the users know they're opting in to trying
> something unstable that may go away or have its semantics changed fro=
m
> under them.

An "experimental" subsystem is perhaps overkill for Git though.
