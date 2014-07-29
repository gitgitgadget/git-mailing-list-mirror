From: Nico Williams <nico@cryptonector.com>
Subject: Re: Amending merge commits?
Date: Tue, 29 Jul 2014 17:07:11 -0500
Message-ID: <CAK3OfOgsY43oiuUNggS+Tz2zfMKB_eO2U+S2tiNsoYGk5qhn2w@mail.gmail.com>
References: <CAK3OfOjr6ej5VdGU=bLmtag9cca1=ogLxVakCFTMG7b-A2uBiA@mail.gmail.com>
	<87r4147agk.fsf@osv.gnss.ru>
	<CAK3OfOhFzbUA7gZbox84W=VC+0aSuiNc-XRP_MTyYy1UeFFzZQ@mail.gmail.com>
	<DFE66A48CBC646E795B3B4A0903AB19E@PhilipOakley>
	<CAK3OfOgZt55+tKv5455Jk-F=buULtftmCasbxHYcxGzppbWcfg@mail.gmail.com>
	<9EFB89B516004883AC0FD774595B84E7@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sergei Organov <osv@javad.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Besen, David" <david.besen@hp.com>,
	git discussion list <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 00:07:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCFYH-0003PH-Jw
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 00:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbaG2WHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 18:07:14 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:32843 "EHLO
	homiemail-a87.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300AbaG2WHN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2014 18:07:13 -0400
Received: from homiemail-a87.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a87.g.dreamhost.com (Postfix) with ESMTP id 625B526C05E
	for <git@vger.kernel.org>; Tue, 29 Jul 2014 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=iVcQtmpZ/bc4bTPiH+L0
	Tk3fT+o=; b=Fibu4WeHYUvTl2H9khNrfCoMhudPNy7Bj6YHIMT+kvykmZZf3yKD
	FtoEveAE/TkBC09S8rMlFHLYBoCEdyQRt5z7Iia9L5pJs4AA6RdVlYjSSZAf3ou5
	TbA/ugUem7UedjFQJSVEVMZzXU6yX/f3jGcdJ5EmHQ6EuPyHWw8DC4o=
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a87.g.dreamhost.com (Postfix) with ESMTPSA id 13B6F26C005
	for <git@vger.kernel.org>; Tue, 29 Jul 2014 15:07:12 -0700 (PDT)
Received: by mail-wg0-f43.google.com with SMTP id l18so276914wgh.26
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 15:07:11 -0700 (PDT)
X-Received: by 10.180.7.230 with SMTP id m6mr74584wia.3.1406671631831; Tue, 29
 Jul 2014 15:07:11 -0700 (PDT)
Received: by 10.217.98.6 with HTTP; Tue, 29 Jul 2014 15:07:11 -0700 (PDT)
In-Reply-To: <9EFB89B516004883AC0FD774595B84E7@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254474>

On Tue, Jul 29, 2014 at 4:38 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Nico Williams" <nico@cryptonector.com>
>> That workflow works just fine with git.
>
> I'm not saying that it isn't a good technique and can work well. Rather I'm
> saying we should be tolerant of the rules and techniques of others who do
> [...]

Sure.  I was just giving advice as to how to avoid any problems at
pull time w.r.t. local merge commits.

Better merge commit handling at pull time might be great (I'd not
know; I avoid local merge commits!), but I would still strongly
recommend keeping all local commits on top because otherwise you lose
local history.  Even if you use -m to set a better commit message, you
might prefer to have kept the original N local -now rebased- commits
around so you can tell what each discrete change was, even if you'll
eventually squash them (you might not squash them all into one).

>>  It worked really well at Sun
>> (with thousands of engineers working on Solaris alone).  And it should
>> work well for anyone who doesn't have two or more forked upstreams to
>> follow.
>
> I'm just cautious of an accidental one size fits all approach, so the
> ability to rebase lines of development which contain merge commits should be
> possible (with an appropriate and documented option) without hidden traps.

Thus far the only case I've seen where this approach doesn't work _at
all_ is the case where you have multiple forked upstreams.  The only
other case where it doesn't work is a social problem: rebase allergy.
For the repos I maintain I insist on contributed commits applying as
fast forward merges, or I'll rebase them myself if need be.

Nico
--
