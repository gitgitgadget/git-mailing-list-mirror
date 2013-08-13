From: David Jeske <davidj@gmail.com>
Subject: Fwd: ephemeral-branches instead of detached-head?
Date: Tue, 13 Aug 2013 08:36:26 -0700
Message-ID: <CA+CP9O5cK_zuRRj6uBdW_H7XO-w=B=vcjQsT1iF70Ce-jc02Ow@mail.gmail.com>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
 <7veh9z1gym.fsf@alter.siamese.dyndns.org> <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
 <CACsJy8Dke6Pezqsdcjzejc_cWCgOGTGs8LifjM2h2TQJy7N4HA@mail.gmail.com> <CA+CP9O5Ak3YD60--Mj+eLv3qzbZuuwTN-AxY3xb=SciKD=uZoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 13 17:37:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9GfI-00086y-PW
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 17:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758215Ab3HMPhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 11:37:39 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:60120 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757877Ab3HMPhH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 11:37:07 -0400
Received: by mail-oa0-f49.google.com with SMTP id n10so9049995oag.8
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=FJRE5YzDbHQ81tbTJJOnxHhjTrlbrku/CDzMOOv8YdY=;
        b=qxHyd8nACdYf3befFWRIEzvPBdOMf8scZug36UeYB9Ws61jY1pgiCsHJoS3pImEpMS
         ItsKBk3k/ihkRMxSJmswu/EdrhweYhRH87QkGbC74rix8Pmifv1Pt3mvQ0xUIZOzJhgx
         bc/Q97eRATNy+C6eaw+sybjMp8p+DdBU1cCyrYmcgqoowZJHR72DQZPJoOpTDQ7I1IHu
         VeKGVFyDXo+jISNdtlP80xyrUOwTtBimXTmjiU/BhxQOnWj/6Y7ciCocVGhyzeW4yEpp
         AD95o2L44ISMY4sycdAyBi/ZYwmsQKpvWn8T6DFSg0eaAkPmErREDZv63tzgaggdVeAj
         51fw==
X-Received: by 10.182.204.72 with SMTP id kw8mr2456603obc.54.1376408227109;
 Tue, 13 Aug 2013 08:37:07 -0700 (PDT)
Received: by 10.60.120.65 with HTTP; Tue, 13 Aug 2013 08:36:26 -0700 (PDT)
In-Reply-To: <CA+CP9O5Ak3YD60--Mj+eLv3qzbZuuwTN-AxY3xb=SciKD=uZoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232227>

On Aug 12, 2013 11:06 PM, "Duy Nguyen" <pclouds@gmail.com> wrote:

>
> On Mon, Aug 12, 2013 at 3:37 PM, David Jeske <davidj@gmail.com> wrote:
> > Is there currently any way to say "hey, git, show me what commits are
> > dangling that might be lost in the reflog?"
>
> How do you define dangling commits?

Any commit which I did not explicitly do something with. (Merge,
rebase, amend, branch name, discard)

Today every one of those actions is explicit except discard.

> When you do "git commit --amend",
> the current commit will become dangling (in the sense that it's not
> referred by any ref, but the commit exists) and those are just noise
> in my opinion.

This is *exactly* my point.

There is no way to distinguish a commit which was accidentally and
implicitly dangled due to checkout or submodule update on a detached
head, from all those other intentionally dangling refs which were
explicitly handled with merge, rebase, amend.

Ephemeral branches would change only the implicit discard.. Turning it
into a named branch and requiring an explicit discard.
