From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/4] submodule update: Initialize all group-selected
 submodules by default
Date: Thu, 21 Jan 2016 11:39:38 -0800
Message-ID: <CAGZ79kbHvPRa9vn7_BjiNJ+PGT3LWXZXMdTZRJmHP9bJ-_rHZA@mail.gmail.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-4-git-send-email-sbeller@google.com>
	<xmqqr3hc3pmz.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYJJ+JxgLBqD1Y_UWACUd7yJGnU+rnwEnU6X041deftjQ@mail.gmail.com>
	<xmqqlh7jzgsx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 20:40:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aML5J-0006WH-R3
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 20:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbcAUTjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 14:39:53 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:36742 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcAUTjj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 14:39:39 -0500
Received: by mail-io0-f173.google.com with SMTP id g73so66916362ioe.3
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 11:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gNpWKaBr8v8fXa4puqVRLtAXhWtvCtcGIk5Rc+fupT0=;
        b=KiT1fVkg0XcovkkPaRaewsGlE0W0qmYNgCr8nUELrsYPM5Je9gEHLTnzN0sU+yRoWm
         rd/Q6viPShjY2+ViONh9F+K1ns+waf71Ks/thjpANZezwfq3KvAOk3TTlfZnH+mRcC/M
         ScnnM4Rj3qmcpysx0wqw/tvB46oOq4ktatRbOtt0PMekmlWD/3DPC6xFOT+VS7VI5f0+
         pW33zJT7JouoW9yokR4ulttLOhftGQvht3mpKXydFwao1oQIblyhF2AVcgYIIgMSofuy
         ev6y7IfwY9d2BKmBTZBux8lGgX8X0GFUyUrQ+X/qCD919z6fON9JhvgIAVHnaP8uoL/I
         5uoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gNpWKaBr8v8fXa4puqVRLtAXhWtvCtcGIk5Rc+fupT0=;
        b=IiJcVwq7xd/j5QWPePpBzzNx1nYRyWTKGEs9u21OIFEn8txvCr6GRAjSaz9imKEOej
         ZVHjLRZEGwmuPyRbf94vuCN3IPqR+totMeO9aTZhDsvr4JcunP2NOOvJni3PGCEghLg2
         eHfnwf26wvcnGKEsUrt3M6AUNuCfJLqzlLdbq9EG4nRZtII2enLEMpJAVNq3N+9nJ9Z5
         nxl0WSfFTu3cMyjUJytkzFCO0A8q7dR6oozJmR35jTlpYdKhrHgVwf52rhyrinOzUiHl
         YrxHQP1v28pckw+R7WkdDYhiKGDF2U9rTVA941lu7hrMHECXXG5x1vgQzreu6rhV5am6
         2W9w==
X-Gm-Message-State: ALoCoQmpC1tivXFdAwVP6ScnRjSEa6lWlP3bhLrUrDBFfHB4jobJT+2v4PzIXXNQmcDfuL8681zaatCn0oyURlcIZp69CY+RU65F1IY7r+xlDIBgrSNv/CU=
X-Received: by 10.107.129.149 with SMTP id l21mr37849241ioi.174.1453405178431;
 Thu, 21 Jan 2016 11:39:38 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Thu, 21 Jan 2016 11:39:38 -0800 (PST)
In-Reply-To: <xmqqlh7jzgsx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284520>

On Wed, Jan 20, 2016 at 8:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I am not sure what you mean by the above snippet.  With
>
>         [submodule "foo"]
>                 group = default
>         [submodule "bar"]
>                 group = optional
>         [submodule "baz"]
>                 group = optional
>                 path = sub/baz
>
> it would be nice if you can say "modules in the default group",
> "modules in the default group and the module 'bar'", "modules at
> path sub/baz", etc.
>
> Am I repeating more or less the same thing as you wanted to say with
> the above?  If so, yes, I do think there should be a uniform syntax
> that lets users specify set of modules via different mechanisms.

Yes, we have the same vision here. However I wonder if we really need
syntax to differentiate between groups, names and paths. At least
for groups we can make it a requirement to have the same identifier as
another name or path.

Technically it is possible for names and paths to mix up such as
         [submodule "bar"]
                 path = baz
         [submodule "baz"]
                 path = bar

such that we would need to have a way to tell apart if the user means
the name or path. This could be solved implicit by some sort of precedence
(If there is a name then take it by name, otherwise take the path.)


>> Of course then the --group option would need to be named
>> differently in git clone and probably the submodule.groups should
>> also be named differently.
>
> I do think --group option is a mistake, as you are only saying
> "please give a name of a group to this option" without hinting how
> the modules in the specified group are to be treated differently, or
> more importantly, the option is about submodules.
>
>     Side note: this is a common delusion developers fall into
>     thinking that the feature they currently working on is the most
>     important thing in the world.

I fell into that trap, sure.

> In the context of "clone", there
>     is no reason to expect that "groups of submodules" is any
>     special than groups of other things.  For the same reason, I
>     think --init=<group> is a mistake, as it is not clear from the
>     option name that we are initializing submodules in the context
>     of "clone".
>
> So perhaps --init-module.

Why not spell it out completely (--init-submodule)?
Then we don't have to add to the glossary that a module is the same as
a submodule. (Could there be other modules such as co-modules,
which happen to be not in the tree, but in "../sibling" relative to the
root of the repository?)



>
> Once we establish a uniform convention for specifying a group of
> submodules is by giving the names of groups, the "group" ness of the
> option argument becomes less and less important, as that would be
> implicitly known by users.  "clone --init=A" would be more
> understandable than "clone --group=A", as everybody would know A is
> naming a set of submodules either way, but the latter does not say
> what will happen to the chosen modules.

So keep the "groups" in .gitmodules, but ban the name from clone options.
In the .gitmodules file we could also name it "set" just as you used it in that
paragraph.

>
> There could be other ways to specify the modules, and as long as we
> can come up with the "uniform convention for specifying a group of
> submodules", "clone --init-module=$X --init-module=$Y", would be
> understandable by the users when $X specifies the modules by their
> group name and $Y specifies another set of modules by something else,
> e.g. their names or paths to them.

ok.

>
>     A strawman.  You can pass (1) the path to a submodule, (2) you
>     can pass a colon followed by the name of a submodule, or (3) you
>     can pass an asterisk followed by the name of a group.  (1) and
>     (2) specifies a single submodule, (3) specifies the submodules
>     that belong to the group.  I.e.
>
>     $ git clone --init-module='*default' --init-module=sub/module
>
>     would be a way to say "clone and then initialize the submodule
>     at path sub/module and also those in the default group.
>
>     This strawman makes "path" the default way, merely because many
>     subcommands of "git submodule" already specify which submodule
>     to operate on by taking paths arguments, and '*' prefix as the
>     sign to specify by a group, as an asterisk looks like specifying
>     multiple things.  ':' is just another prefix that is unlikely to
>     be in a pathname.

But it could be in a pathname. Another strawman:

    You can pass either (1) the path (2) or the name (3) or the group
    of submodules to --init-submodule if there are no collisions in the
    three name spaces. When there are namespaces, you need to be
    explicit, such as --init-submodule=path:foo:baz.
    Note that "path:" is the selector which of the three namespaces
    we mean and "foo:baz" is a path asking for pain.



>
>     This is merely an illustration of the kind of syntax that can be
>     used to name a set of modules using different ways.  I am sure
>     people can come up with a different and better syntax, but the
>     point of this illustration is not the exact syntax but showing
>     that a way to uniformly specify a set of modules to operate on
>     would allow us not having to worry about making 'groups' any
>     special.

ok

> The 'group' is merely a convenient way to name and choose a set of
> modules.

But not just at the time of cloning. If later upstream decides that
group=default includes another submodule, this submodule should
be initialized and fetched in the next call to "submodule update",
such that downstream has a working repository.

This idea makes groups more than just a temporary collection for
init-purposes, but we need to store the selection.

>
> I however do not see why you think "submodule.group" needs to be
> spelled differently (it should be "submodule.$name.group", though).

"submodule.$name.group" to be found in .gitmodules, maybe overwritten in
.git/config tells for each submodule its memberships of groups.

"submodule.group" should be found in .git/config only, to tell some time
after cloning which group selection was made, such that we can check
if new submodules need to be initialized (or even automatically removed).

    "git submodule update" may initialze and fetch new modules if the
    .gitmodules file changed their view of what "default" is.

>  The name of the operation, i.e. what is to be done to the
> chosen modules, should be orthogonal, so I do not think you should
> have "submodule.autoinitgroup" or somesuch.

I agree there.

>
>> However:
>> At this point in time we only care about auto-initing submodules
>> to get submodules somewhat easier to handle when having lots of them.
>> Maybe we also want to add other features to these "groups" concept, e.g.
>> all submodules of one groups should have the "(force-)checkout" update strategy.
>> If the submodule consists of binaries only, this would make lots of sense to me.
>>
>> So it is not yet clear to me if we want to extend the grouping feature
>> later on for
>> other things, which is why I named it by its concept. A group can be used for
>> different purposes, where as "all submodules having the same auto-init-tag can
>> be treated the same using one update strategy" just adds to user confusion,
>> hence I'd think telling the user about groups is the right thing to do?
>
> "clone" and other commands may want to gain use of some mechanism to
> specify a set of modules, and 'group' is one of the mechanisms to do
> so.  Also "clone" and other commands may want to gain features to do
> different things to such sets of modules.  So there are two orthogonal
> axes.
>
> Which one is more pleasant to use from the end-user's point of view?
>
>  (1) options are named after _how_ you specify the submodules:
>
>      $ clone --init-group=A --init-name=B --init-path=C
>
>      and what is done to them is implicit.
>
>  (2) options are named after _what_ is done to them:
>
>      $ clone --init-module=A --init-module=\*B --init-module=/C
>
>      and how the set is specified is implicit to the syntax.

I do think (2) is easier, unless the syntax is crazy or counterintuitive.

>
> And more importantly, which one is more extensible in the future
> when you want to add more features that work on multiple but not all
> submodules?
>
>         clone --init-module='*A' --distim-module=':B'
>
> would be one clear way to say that modules in group A would be
> inited, while the submodule B would be distimmed.  What would an
> equivalent of it look like in your "clone --group=A --name=B" world?
> Wouldn't the design along the lines of (2) above be much better?

I agree on (2) being better.

However as pointed out, we want more than to just init submodules at time
of clone, so it would be a

    clone --init-module=A --init-module=\*B --init-module=/C \
        --and-remember-to-keep-track-of=A \
        --and-remember-to-keep-track-of=\*B \
        --and-remember-to-keep-track-of=/C

I am hoping we can put that in shorter options, such as

    clone --init-module=A --init-module=\*B --init-module=/C \
        --remember-init-for-tracking

whereas:

    --remember-init-for-tracking: Submodule groups which are given to clone
        will be remembered, such that each invocation of "update" will make sure
        that group is fully there, i.e. new submodules in the group
will be initialized
        before updating.

Thanks,
Stefan
