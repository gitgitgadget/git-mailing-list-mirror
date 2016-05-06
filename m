From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 11/15] diff: ignore submodules excluded by groups
Date: Fri, 6 May 2016 11:23:59 -0700
Message-ID: <CAGZ79kY5uDzG8PDLMh5e9afg+S3oTjEjq2aRo+s4ud86UCxZQA@mail.gmail.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-12-git-send-email-sbeller@google.com>
	<xmqqlh3wxnuq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaOXxqDEqVnf5K3QjXg5bfmKW2XkmPT-mqJ93+RF5N40g@mail.gmail.com>
	<CAGZ79ka37jWYDJrAWy5KLhaaJmrLRbmTzRC6A5DneuE63+XCeQ@mail.gmail.com>
	<xmqqy47o9s1h.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYGbjOKPQk8A-ag+JgvybW4Kf5=g8azVAOoMq79oXc5-Q@mail.gmail.com>
	<xmqqfutw9mfs.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYKbef7DTkmE3Vf3C=PLfgB3xf0ikVKHFUfQ8+KkgGHPg@mail.gmail.com>
	<xmqqfutw85oz.fsf@gitster.mtv.corp.google.com>
	<xmqqa8k37m6i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 20:24:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aykQ2-0002Ny-Vp
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 20:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758223AbcEFSYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 14:24:01 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36854 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758091AbcEFSYA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 14:24:00 -0400
Received: by mail-ig0-f180.google.com with SMTP id u10so53402785igr.1
        for <git@vger.kernel.org>; Fri, 06 May 2016 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8m+OwRuuzrUhyQVoUZuaDtvIK4zHXDZxICPf0+ZGnDk=;
        b=brsPcqsN2H/wXnTN4uVwdVLd90K0B3EcqN/Rw/EqWP+51jy/rBzrHXkCQHq8nzPdHJ
         ISJkuZbCDAcGOj36MQdgBVRmpREc3/nit90TaB7SbhBFVfsavSLDTZoQi3+BwDzsUK0D
         A3SjNyYxWB2PGpTbE5eofpa5HcdAoX0RZ9btDYSxGu6kmCXMY/Y2ki9KqV61HohPnWfG
         K+H1tdGZfExg1zIu6vBmyptIjhbQ6FfzR3nG95L7iOefpTE6/bpygTqeHKk7fCP2SD6v
         AZd9gv16oen5cg3Kc5PZMuhhus4rmVxsGjxfmbxeGBxu2EIzNjl7ZJzWu6GTTQIrbUYL
         50pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8m+OwRuuzrUhyQVoUZuaDtvIK4zHXDZxICPf0+ZGnDk=;
        b=keV+LdzdP7/4FKz/aX1h1mopHYrrVc8Fr+XsXA9FZR4DCrfp4LdnnGenu04hEcH2MN
         allt0Er8Nfk7L/iJ+O5do+IjdZQXDNYTQkdNt+Z8rh95BC7z/DTsV+06JvZNLf15vqZ9
         zEh5vWUiOMUcsiC/CbD8GxwciTNruPvEg/vzFEctSgtnLe+wezT48NqIbuRShk/efra7
         gQ4G7W76I0Xkp1zRi0Tb4l0ESTKFc0c2PxwMSs773uqj0/yAzMKYnt44HJqFNu0G/6bB
         X+reDbCRWI/hnQ654UnAM5md4ufE9IoAnNWXC8/oVisxbnnZ2zK+6mmoYr3aLl4StB/Z
         RHPg==
X-Gm-Message-State: AOPr4FUMfO0QLN21XhIUgqFVh4qBwZWx517d4HjKwLZeKW259YbCI6RVqt29F65/JE+Z3oOxxWBSJLUf+0RahHA/
X-Received: by 10.50.30.228 with SMTP id v4mr12197752igh.85.1462559039553;
 Fri, 06 May 2016 11:23:59 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 6 May 2016 11:23:59 -0700 (PDT)
In-Reply-To: <xmqqa8k37m6i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293843>

On Thu, May 5, 2016 at 11:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> The set of submodules you "init" to the working tree are the ones
>> that are interesting to you.  So once the tree is populated, you do
>> not ever have to look at the "defaultGroup" configuration.  You just
>> need to look at the working tree.
>> ...
>
> I forgot to prefix the first few paragraphs of that message with
> "Here is how my version of the world should work."  I did not mean
> to say "Here is how you must make your work work, or I won't talk to
> you."  I was just hurried as I had to tend to other topics.
>
> I actually do not care too deeply (except for the "automatically
> remove" part, which I do not think we should do), as I do not think
> there is a big fundamental difference between the two views.  To
> make sure we are on the same page, let me rephrase the two views I
> have in mind.

Ok, maybe we can leave that automatically remove part out for the
first series. (Eventually submodules should behave like files and we
delete files on checkout all the time, and it's a reasonable default)

So I think to reduce scope to only cover the clone/update first, all
other operations behave like today, i.e.

    git clone --recurse-submodules --init-submodule=label
--init-submodule=label2   git://...
    # will clone the superproject and recursively
    # checkout any submodule being labeled label or label2

    git config submodule.defaultGroups default
    git config --add submodule.defaultGroups devel
    # configure which submodules you are interested in.

    git submodule add --label <name> git://... ..
    # record a label while adding a submodule

    git submodule update --init-labeled(=*label)
    # will update all initialized submodules
    # and learn a new switch to also initialize the grouped
    # submodules (either the specified group or if none given
    # the default group as configured before)




    git status
    git diff
    git submodule summary
    # care about all initialized submodules, i.e. (2) below
    # a switch for recurse=label will be in a later series.



>
> The difference is what should happen when the user does not give any
> pathspec, *label, or :name to limit the set of submodules to act on,
> which, traditionally meant to work on everything, and we are trying
> to change that to some "default".
>
>  (1) The default set is what the configuration file says is the
>      default group.  The working tree state is ignored.
>
>  (2) The default set is what the configuration file says is the
>      default group, plus those the user showed interest by doing
>      "submodule init".
>
> Suppose that the user has a mostly satisfactory default configured,
> i.e. the set of submodules the configuration file says is the default
> is both necessary and sufficient to carry out her daily task.  Then
> there is no difference between the two.
>
> Further suppose that the user needs to view a submodule outside the
> default group temporarily (imagine: for a day or two), while
> carrying out some specific task.  Perhaps she is working on the
> documentation submodule, which is her primary task hence her
> configuration file specifies it as the default, but needs to see the
> submodule that houses the implementation to describe the behaviour.
>
> So she does "init code-module/"; this has explicit pathspec, so
> there is no difference between the two.  Now, while reading the code
> module, she finds a typo in a comment, and wants to fix it.  We will
> start to see differences.

Another way (3) is to add code-module/ to the "set of interesting
submodules, i.e. to the default group"

    git config --all submodule.defaultGroup ./code-module
    git submodule update

>
>  * When she wants to get a bird's eye view of everything she cares
>    about at the moment, i.e. wants to view the state of her usual
>    modules plus the code-module she is visiting, (1) is more
>    cumbersome.
>
>    With (1), "diff --recursive" will not step outside of her
>    configured default, so she says "diff --recursive \*default
>    code-module/" to say "I want to see both my default submodule(s)
>    and the one I checked out by hand".
>
>    With (2), she does not have to do anything special, as manually
>    checked out code-module/ will be acted upon, in addition to the
>    configured default.

In (3), diff --recursive will also just work fine.

>
>
>  * When she wants to see her usual modules ignoring the one-off
>    checkout, (1) is easier.

In (3) you'd do

    git config --unset submodule.defaultGroup ./code-module
    # optionally: git submodule update

>
>    With (1), she can say "diff --recursive" and done.
>
>    With (2), she needs to say "diff --recursive \*default" to
>    explicitly state "I may have checkouts of other submodules, but
>    this time I want to view only the usual default of mine".

and diff --recursive works fine again as well.

>
> The difference is not that big either case.
>
> Whichever way we choose to make the default behaviour, the user
> needs to type a bit extra when asking a behaviour that is different
> from the default behaviour.
>
> The amount of "extra" in the first use case necessary for (1) is
> greater than the amount of "extra" in the second use case necessary
> for (2), though.  In addition, in the second use case, (1) makes it
> easier for the user to miss important changes she made outside the
> area of her usual attention, while (2) forces her to make a
> conscious effort to exclude them.  These are the reasons why I have
> a slight preference for (2) over (1).
>

That makes sense.

So with (2)
 * there is no need to modify status, diff, log for the default case and the
    --recursive \*default" may come later, so the initial series can be smaller.
 *
