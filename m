From: Stefan Beller <sbeller@google.com>
Subject: Re: Allow git alias to override existing Git commands
Date: Tue, 10 Nov 2015 14:49:42 -0800
Message-ID: <CAGZ79ka_RACVEDJBU8_5UsEyUBvQgKTh7FbvSoHxpMjDYDgPOw@mail.gmail.com>
References: <56421BD9.5060501@game-point.net>
	<CAGZ79kZxQWVMe3N1ti8npyp9_4DUPAVy9Uk5a75Jwh3Eud2eZQ@mail.gmail.com>
	<5642685F.9070405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeremy Morton <admin@game-point.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 10 23:50:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwHjh-0008V6-BO
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 23:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbbKJWtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 17:49:43 -0500
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35239 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbbKJWtn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 17:49:43 -0500
Received: by ykba77 with SMTP id a77so21092659ykb.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 14:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6fYwTMw0n18hDM9D2FS7vTPwMxjo/ka/O115F6r9F1I=;
        b=lZe10nmYOyo4Nrlib700ObEH+g2dTZMqrAwbC3TdH+DL6CH/SVoISb1uPBIfbbv6nQ
         aLdiAjjaCgwpldWiV0YtQu1iVyJA43aC4hZvMDGd/Q9m0DqcP/FsGIvbUKalVY5W9MF1
         aM1EmqFIcuo0wdNuv4uhP9LgJ5hN8wr4MeniSO8iQdi8MUDI07PpsFl94ZB281qyoY4l
         NMbtEZQyMTQAxKlza31iStUB3ADYIF+37jpPVMA7p8dxaYvovQcQTRdnxZz8nD7adJ5Q
         eNTXJAL4OEcKJfEke+WNf6w+7hDN9It4RBJA1k8+3VV8KtTzyXGKXpRedpJR8Eo2W+2G
         YU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6fYwTMw0n18hDM9D2FS7vTPwMxjo/ka/O115F6r9F1I=;
        b=T1xpTk0ZZT/w1B5Y7kJXjYDGgXBMdlO6AmJRvhtqu+vuGuNYD7aJu8/YP2rrQNfGZY
         wjAsfH8Jf+gYg/06opeEswFOdnIYtMw+Omdr3u3PC86Ek7IRTXhRkYFPI+faTnom4HSX
         FRnFWu0Hwd8vFtqEGlIvRgyKN83Kl73fw8CsoCsEq50J3NYkO/zS0ahRbo+HSbuWERow
         0NjWkdbe8z0LjNr39cJDAge3GuqAdzaP92dOGo4JszZ+AtrTyNZ5tDs2dYP2AHJ6rUj+
         u8zo2JKUNilBvypIOnQA8aeB8L7yUCtfgrl9km07XNvZRXJemErptDgijkgxvw0vrWIO
         b/kg==
X-Gm-Message-State: ALoCoQnnRj0ONq4R7x6VrVN91QFMw9cJ1FCYGHYI1lC+TqY9U8gloQWyK2ARaWeXTKG3cY4QC5qt
X-Received: by 10.13.251.2 with SMTP id l2mr5797328ywf.44.1447195782227; Tue,
 10 Nov 2015 14:49:42 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Tue, 10 Nov 2015 14:49:42 -0800 (PST)
In-Reply-To: <5642685F.9070405@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281138>

On Tue, Nov 10, 2015 at 1:57 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 10.11.2015 um 19:12 schrieb Stefan Beller:
>>
>> On Tue, Nov 10, 2015 at 8:31 AM, Jeremy Morton <admin@game-point.net>
>> wrote:
>>>
>>> It's recently come to my attention that the "git alias" config
>>> functionality
>>> ignores all aliases that would override existing Git commands.  This
>>> seems
>>> like a bad idea to me.
>>
>>
>> This ensures that the plumbing commands always work as expected.
>> As scripts *should* only use plumbing commands, the scripts should
>> work with high probability despite all the crazy user
>> configuration/aliases.
>
>
> Exactly.
>
>>> For example, I wanted to setup "git clone" to automatically act as "git
>>> clone --recursive".  Sure I could do it in the shell, but it's more of a
>>> pain - any tutorial I set up about doing it would have to worry about
>>> what
>>> shell the user was using - and if you're going to make that argument, why
>>> have "git alias" at all?  It can all be done from the shell.
>>
>>
>> I think the git way for your example would be to configure git to include
>> that
>> option by default, something like
>>
>>      git config --global submodules.recursiveClone yes
>>
>> though I was skimming through the man page of git config and did not find
>> that option there. I guess it's missing.
>
>
> We thought about adding such a config option, but I believe that would
> fall a bit short. If I want to have recursive clone I also want to init
> all those submodules appearing in later fetches too (otherwise the end
> result would depend on whether you cloned before or after a submodule
> was added upstream, which is confusing). Extra points for populating
> the submodule in my work tree when switching to a commit containing
> the new submodule.
>
> So what about a "submodule.autoupdate" config option? If set to true,
> all submodules not marked "update=none" would automatically be fetched
> and inited by fetch (and thus clone too) and then checked out (with my
> recursive update changes) in every work tree manipulating command
> (again including clone).
>
> Users who only want the submodules to be present in the work tree but
> not automagically updated could set "submodule.autoupdate=clone" to
> avoid the extra cost of updating the work tree every time they switch
> between commits. Now that Heiko's config-from-commit changes are in
> master, someone could easily add that to fetch and clone as the first
> step. We could also teach clone to make "submodule.autoupdate=true"
> imply --recursive and execute the "git submodule" command to update
> the work tree as a first step until the recursive checkout patches
> are ready.
>
> Does that make sense?

I guess.

So the repo tool has the concepts of groups. I plan to add that to git
eventually, too.
i.e. with comma separated list that looks like:

    git clone --submodule-groups=default,x86builds,new-phone-codename

Having a new option there there I would also set the

    submodule.autoupdate=all

implicitly which then enables --recurse-submodules on all supported commands.

By introducing such a new submodule groups option we don't need to tell
the users about all the new submodule options, but they can still take
advantage of them,
I'd assume.

Does that make sense, too?
