From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 15 Dec 2015 14:42:24 +0100
Message-ID: <CAP8UFD2ZUnWWO5T91pYjsDtXgFecZkJuu9fjQ_s8at=01bzxvQ@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
	<xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
	<xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	<xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
	<xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
	<CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 14:43:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8psC-0000mX-0f
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 14:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbbLONm1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2015 08:42:27 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33609 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbbLONmZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Dec 2015 08:42:25 -0500
Received: by mail-lb0-f173.google.com with SMTP id kw15so5878948lbb.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 05:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/KspS4B7Ui6C5s1+vZJ2Odl3H3c1N4n16XcQyYfJrAY=;
        b=Kh/25eU3ztSVyUaHdFw5ztAm8Eii0PfLM1CRM78/wg/K+fw627m6CTnpdngTww03cn
         ottX47xwhmFoJMvTrIAmlBCJWLUx3ZukiXhSUjlqP5dHzRMBS+swm4Wvvo5LIC9LXvAL
         z3Sci94XRmBzxXkqINcdUdMUFOgesRCKfomB99xV//Wsw66GaMc0nXZ6FHyex4hkuPF7
         B9UEPfaxim0umOF2h96ay08NVEnjGpYQH/+hDPTruIuay0SmOpW9Iw+k4rrOu4/w2DQN
         uAj68HIHUshkMfOG/PC0ZdR1DTgXEkArlncsodZn3MSDoD3Nde8uTUIdZ9CtUb+oA4FN
         A2Hg==
X-Received: by 10.112.172.130 with SMTP id bc2mr15524897lbc.132.1450186944314;
 Tue, 15 Dec 2015 05:42:24 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Tue, 15 Dec 2015 05:42:24 -0800 (PST)
In-Reply-To: <CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282475>

On Tue, Dec 15, 2015 at 2:04 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Dec 14, 2015 at 8:44 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>
> I'm replying to & quoting from two E-Mails of yours at once here for
> clarity & less noise. I'm working wich Christian on getting this
> integrated, and we both thought it would be good to have some fresh
> input on the matter from me.
>
>> Christian Couder <christian.couder@gmail.com> writes:
>
>>> If you want only some repos to use the UC, you will set
>>> core.untrackedCache in the repo config. Then after cloning such a
>>> repo, you will copy the config file, and this will not be enough to
>>> enable the UC.
>>
>> Surely.  "Does this index file keeps track of the untracked files'
>> states?" is a property of the index.  Cloning does not propagate the
>> configuration and copying or not copying is irrelevant.  If you want
>> to enable, running "update-index --untracked-cache" is a way to do
>> so.  I cannot see what's so hard about it.
>>
>>> And if you have set core.untrackedCache in the global config when y=
ou
>>> clone, UC is enabled, but if you have just set it in the repo confi=
g
>>> after the clone, it is not enabled.
>>
>> That's fine.  In your patch series, if you set it in the global, you
>> will get the cache in the new one.  With the cleaned-up semantics I
>> suggested, the same thing will happen.
>>
>> And with the cleaned-up semantics, the configuration is *ONLY* used
>> to give the *DEFAULT* before other things happen, i.e. creation of
>> the index file for the first time.  Because the configuration is
>> only the default, an explicit "update-index --[no-]untracked-cache"
>> will defeat it, just like any other config/option interaction.
>
> As you know Christian is working on this for Booking.com to integrate
> features we find useful into git.git in such a way that we don't have
> to maintain some internal fork of Git.
>
> What we're trying to do, and what a lot of other big deployments of
> Git elsewhere would also find useful, is to ship a default sensible
> configuration for all users on the system in /etc/gitconfig.
>
> I'd like to be able to easily enable some feature that aids Git
> performance globally on our thousands of machines and for our hundred=
s
> of users by just tweaking something in puppet to change
> /etc/gitconfig, and more importantly if that change ends up being bad
> reverting that config in /etc/gitconfig should undo the change.
>
> It's an unacceptable level of complexity for system-level automation
> to have to scour the filesystem for existing Git repositories and run
> "git update-index" on each of them, that's why we're submitting
> patches to make this a config option, so we can simply flip a flag in
> /etc/gitconfig.
>
> It's also unacceptable to have the config simply provide the default
> which'll be frozen either at clone time or after an initial "git
> status".
>
> Let's say I ship a /etc/gitconfig that says "new clones should use th=
e
> untracked cache". Now I roll that out across our fleet of machines an=
d
> it turns out the morning after that the feature doesn't work properly
> for whatever reason. If it's just a "default until clone or status"
> type of thing even if I revert the configuration a lot of users &
> their repositories in the wild will still be broken, and will have to
> be manually fixed. Which again leads to the scouring the filesystem
> problem.
>
> So that gives some more context for why we're pushing for this change=
=2E
> I believe this feature breaks no existing use-case and just supports
> new ones, and I think that your objections to it are based on a simpl=
e
> misunderstanding as will become apparent if you read on below.
>
>> The biggest issue I had with your patch series, IIRC, is that
>> configuration will defeat the command line option.
>
> I think it's a moot point to focus on configuration v.s. command-line
> option. The important question is whether or not this feature can
> still be configured on a repo-local basis with this series as before.
> That's still the case since --local git configuration overrides
> --global and --system, so users who want to enable/disable this
> per-repo still can.
>
>>> Shouldn't it be nice if they could just enable core.untrackedCache =
in
>>> the global config files without having to also cd into every repo a=
nd
>>> use "git update-index --untracked-cache" there?
>>
>> NO.  It is bad to change the behaviour behind users' back.
>
> I'm not quite sure what the objection here is exactly. If you're a
> normal user you can enable/disable this per-repo just like you can
> now, and enable/disable it for all your repos in ~/.gitconfig.
>
> If you mean that the user's configuration shouldn't be changed by the
> global config in /etc/gitconfig I do think that's a moot point. If
> you're a user on a system where I have root and I want to change your
> Git configuration I'm going to be able to do that whatever the
> mechanism is.
>
> That's indeed that's what we're doing to enable this at Booking.com
> currently, we run a job to find some limited set of common checkouts
> and run "git update-index" for users as root. The problem with that i=
s
> that it's needlessly complex, hence this series.
>
> But in case you mean disabling the config for existing checkouts if
> there's no configuration, I address that at the end of this mail.
>
> [...]
>> The primary reason why I do not like your "configuration decides" is
>> it will be a huge source of confusions and bugs.  Imagine what
>> should happen in this sequence, and when should a stale cached
>> information be discarded?
>>
>>  - the configuration is set to 'yes'.
>>  - the index is updated and written by various commands.
>>  - more work is done in the working tree without updating the index.
>>  - the configuration is set to 'no'.
>>  - more work is done in the working tree without updating the index.
>>  - the configuration is set to 'yes'.
>>  - more work is done in the working tree without updating the index.
>>  - somebody asks "what untracked paths are there?"
>>
>> In the "configuration decides" world, I am not sure how a sane
>> implementation efficiently invalidates the cache as needed, without
>> the config subsystem having intimate knowledge with the untracked
>> cache (so far, the config subsystem is merely a key-value store and
>> does not care _what_ it stores; you would want to invalidate the
>> cache in the index when somebody sets the variable to 'no', which
>> means the config subsystem needs to know that this variable is
>> special).
>
> I think this is the main misunderstanding about how this works that
> needs to be clarified.
>
> It would indeed really suck if changing this to some configuration
> option introduced some race condition where fiddling with the config
> option would render the cache stale & invalid. I fully agree that tha=
t
> should prevent the inclusion of this patch series.
>
> The way the "config decides" patch series deals with this is that if
> you have the UC information in the index and the configuration is set
> to core.untrackedCache=3Dfalse the UC will be removed from the index.
>
> Otherwise you would indeed easily end up with a stale cache, since yo=
u
> could disable it, then make some tweaks to the index or your files,
> and then subsequently enable it and end up with nonsensical "git
> status" output.
>
> There's a test for this in t/t7063-status-untracked-cache.sh called
> "unsetting core.untrackedCache and using git status removes the
> cache".
>
> Summing this up: The only thing that this configuration potentially
> *does* break, and doesn't address, and which could be fixed. Is the
> following scenario. Once this series is applied and git is shipped
> with it existing users that have set "git update-index
> --untracked-cache" will have their UC feature disabled. This is
> because we fall back to "oh no config here? Must have been disabled,
> rm it from the index" clause which keeps our UC from going stale in
> the face of config flip-flopping.
>
> We *could* make even that use-case work by detecting the legacy marke=
r
> for the UC in the index (the uname info), then we'd do a one-time "gi=
t
> config --local core.untrackedCache true" and remove the marker. Thus
> users who upgrade git and had the untracked cache enabled already
> would have their checkouts migrated to whatever their existing setup
> was.

The above needs a patch, that I haven't sent yet, but will send really
soon now, and that removes everything from the "ident" field in the
UC, because this field is useless with the patch series.

> I don't think that's worth it for two reasons 1) This is a really new
> experimental feature and I think it's fine to just change how it work=
s
> 2) It's just as likely that this surprises users and doesn't do what
> they want, i.e. someone will think "neat, I can toggle this in
> ~/.gitconfig now", then they set it to "false" because they don't wan=
t
> it, but some of their existing checkouts that had it enabled will be
> migrated to "core.untrackedCache=3Dtrue".
>
> So I think it makes the most sense to just apply this as-is.

Or rather to apply something based on the patch series I will send soon=
=2E
