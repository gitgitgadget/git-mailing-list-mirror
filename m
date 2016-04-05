From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.8.1 (and call-for-help to "make rpmbuild" users)
Date: Tue, 5 Apr 2016 12:39:52 +0200
Message-ID: <CA+EOSBndKHN1xR-iyyJQongSQJ7++BBjO3WtKK=g7Ki_A47E9A@mail.gmail.com>
References: <xmqqtwjiebw2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Apr 05 12:40:12 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1anOP5-0003Um-FG
	for glk-linux-kernel-3@plane.gmane.org; Tue, 05 Apr 2016 12:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757641AbcDEKjz (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 5 Apr 2016 06:39:55 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:32958 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763AbcDEKjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2016 06:39:53 -0400
Received: by mail-vk0-f42.google.com with SMTP id k1so12115423vkb.0;
        Tue, 05 Apr 2016 03:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ObCR1Ee0fxo+Lvc7hb8r260ieNXGEHcbtJsQjsX9UOI=;
        b=u1iwoBIaUdhC61oSlNq2nbW5cfrAIPh9j5awMMVcmmgNheao9IVPg6JiztXVf/IyGE
         9ZDcQNEY+qKLbtYkVq0EixF7jOv1VhsHvvhbSMwER4FmLl9VAS+pbx2/FOCQ1t5vmPp7
         zNE7hJ8NBTzAnCL4kEevmKjTFRcNLs8/Z6zSW4qHdwa3BxROyZOEejUszQtxXbU1OrOz
         n404QbOFmy8u5KQ4UgcfQXTq4dxvP+KQe1tshxNQtM0jaURX1OvxOCsTOaEErgVSRk+d
         z2DHdovijk1De5SDdp/MuOPYkMF1ZRi39S0FA0shCrmC/+pihWpiARzBvLB+94uiduqB
         litg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ObCR1Ee0fxo+Lvc7hb8r260ieNXGEHcbtJsQjsX9UOI=;
        b=UtO1FXCi/dl2jmSTQ7k/5ZfrAhzDboZsI0CIIFTAVnKnqd66JXNcsEs+RgzTJnC9cl
         XlECYR2WKXW8EpLD6/5wtaK0rgGJCjNDVvQBr5vLpts5wERLuaWGqzFC2FnYgLkUYerP
         NQOpFP6c47EwZOrpiLaMqp5OfZPIp8/g3I0Vk2D56xv1OZYVOZ+enIyuXtEXUkvXT1ZN
         D6ktkya5IQhFaZ3RrleI+6QIX99bzCgwXO9VV9q7NvBUZovQU4Rb4/Ajp5VRC9IbIoEG
         eFjCGXitg0/eAvqK2X/B1Ir45ld5o6MT6r5FQQdcML/js2CW4WOTMNKMUIArxueVEeNz
         9vKA==
X-Gm-Message-State: AD7BkJKolaaB1Mt0Vos2Cdi3nFqmtBKibkE3sDpyxmMZquAC5BjTsqwiJnRNc0gZTx9YwISJTdniKtJg0IkcCg==
X-Received: by 10.31.149.73 with SMTP id x70mr7629268vkd.83.1459852792161;
 Tue, 05 Apr 2016 03:39:52 -0700 (PDT)
Received: by 10.31.56.10 with HTTP; Tue, 5 Apr 2016 03:39:52 -0700 (PDT)
In-Reply-To: <xmqqtwjiebw2.fsf@gitster.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290772>

2016-04-03 21:21 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> If you do not build RPM binary packages from our pristine source,
> you can safely ignore this release and stop reading this message.
>
> Now that the audience of this message has been limited to a narrow
> target, before I make an announcement, here is a call-for-help to
> you.
>
> Git v2.8 removed README file and added a corresponding README.md
> file.  The change however did not adjust git.spec.in that still
> referred to README, causing "make rpmbuild" to fail.  The breakage
> was not noticed by anybody who tested v2.8.0-rc0 and later release
> candidates, and ended up in the final v2.8 release, and we saw a
> handful of bug reports on the list after the release happened.
>
> This maintenance release is to correct this bug for those who run
> "make rpmbuild". It has no other changes.
>
> It is clear that nobody who relies on being able to "make rpmbuild"
> ever tried any of the 5 release candidate snapshots that happened
> during Feb 26-Mar 28.  We had a whole month and nobody noticed?
>
> This incident clearly shows that something needs to happen, if
> people want "make rpmbuild" to keep working.  Even though this
> maintenance release may fix this single bug, breakages similar to it
> that only affect "make rpmbuild" users are guaranteed to appear in
> future releases, unless those who can prevent them from happening
> start helping to test at least release candidate snapshots.
>
> It is even more preferrable if they can test the tip of 'next'
> branch regularly, in order to prevent such breakages from hitting
> the 'master' branch to be included in the next release, which is
> what the other parts of the system aims at.
>
> The other obvious option is for us to stop pretending that "make
> rpmbuild" does anything useful to do and drop the build target and
> the unmaintained git.spec.in file on which nobody in the active
> development community keeps eyes.  I do not mean this as a threat
> "help us or else"; there is a precedent.  We used to ship our own
> debian/rules and friends for those who wanted to debbuild from the
> source, but the Debian packagers wanted to have their own proper
> ones and ours ended up confusing the users, and we made the world
> a better place by removing our copy.  If "make rpmbuild" people want
> us to take this route, that is also OK for us.
>
> So that's the call for help.  Now to the announcement.

How old contributor to rpm5.org (as devzero2000) I have been following
these issues in the past.
Unfortunately, to my knowledge, no one has ever come to a convergence
of views between the distros
that use rpm on the various differences.
Keeping for a project a spec file that then no distro uses (and i
think also a local sysadmin)
i do not think it is worth the effort.

http://lists.rpm.org/pipermail/rpm-maint/2008-June/002185.html

IMHO

Best

>
> The latest maintenance release Git v2.8.1 is now available at
> the usual places.
>
> The tarballs are found at:
>
>     https://www.kernel.org/pub/software/scm/git/
>
> The following public repositories all have a copy of the 'v2.8.1'
> tag and the 'maint' branch that the tag points at:
>
>   url = https://kernel.googlesource.com/pub/scm/git/git
>   url = git://repo.or.cz/alt-git.git
>   url = git://git.sourceforge.jp/gitroot/git-core/git.git
>   url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
>   url = https://github.com/gitster/git
>
> ----------------------------------------------------------------
>
> Git v2.8.1 Release Notes
> ========================
>
> Fixes since v2.8
> ----------------
>
>  * "make rpmbuild" target was broken as its input, git.spec.in, was
>    not updated to match a file it describes that has been renamed
>    recently.  This has been fixed.
>
> ----------------------------------------------------------------
>
> Changes since v2.8.0 are as follows:
>
> Junio C Hamano (1):
>       Git 2.8.1
>
> Matthieu Moy (1):
>       git.spec.in: use README.md, not README
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
