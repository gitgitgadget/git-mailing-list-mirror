From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Tue, 23 Feb 2016 12:05:34 +0000
Message-ID: <CAE5ih7_vBMsi+zRZRTCaO56VrOYZUR0NQ0CSSE+Do48xkJ_BwA@mail.gmail.com>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com>
	<1455919074-5683-1-git-send-email-aidecoe@aidecoe.name>
	<xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com>
	<87fuwnd4u7.fsf@freja.aidecoe.name>
	<xmqqbn7aa522.fsf@gitster.mtv.corp.google.com>
	<877fhwd1g0.fsf@freja.aidecoe.name>
	<xmqqegc33oal.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 13:05:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYBil-0003WS-Nt
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 13:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbcBWMFg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 07:05:36 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36680 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbcBWMFf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 07:05:35 -0500
Received: by mail-ob0-f177.google.com with SMTP id gc3so191940833obb.3
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 04:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qn0pCXQl7STMcQhrXH9O/Chl1pMEF+c77oQcSOKtM4o=;
        b=K62js0Dk7TDgoL2XYcw2+oA0lY5bDoEBZBXhNimmAUgbKoEIuGD4MGGYytilkOWG9A
         BPECHtKoFtdwqD5I7ACR0XrDt067nK/8NdYC5IUw5i4nihWYSYdGYWLx2CQVHyB8Kf7U
         pu2YNO0l4PJoaYMJW8gsDS/BPvgl0WDbUFP0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qn0pCXQl7STMcQhrXH9O/Chl1pMEF+c77oQcSOKtM4o=;
        b=CLp3bNL/ZviFZuMf0oAFxyafbSJMs6AlZrHzah5+KxKV9ZEtqzPvvzTOoczQxln5an
         V8Q+ISnfxzoYLaD7GVZuYBSAnb65ptxNVgxrwBpGO6inFOSEGnsFygeB48UU0HWsqD5t
         F76OxrjiUgjuo1sA+wePuWHuWEfsRhUQaxrKshsihJxrmed/jVCYzDpd83s0Q2U49OF7
         R35BTnkKFwBbbYvpRbLo7OQdaPK3E4860GDToiLTCjCd3UK1VDb6+CiW1kYF7KPvfpqC
         PnKUrc+HtzB7Ff7KjxGSb4NNxhjB+nToz5u2ELX3Mt+kXJ8ytRG2RQVOBMEBirznuBPt
         ztXQ==
X-Gm-Message-State: AG10YOShld64duvfbwYV9ebzGUU0oJKtQNp8oVvWF/5R7QFyH2yVxFuAnFQwFlbHSNEoTUL5CpVaNLj/lXizJw==
X-Received: by 10.182.186.105 with SMTP id fj9mr27053284obc.17.1456229134575;
 Tue, 23 Feb 2016 04:05:34 -0800 (PST)
Received: by 10.202.214.18 with HTTP; Tue, 23 Feb 2016 04:05:34 -0800 (PST)
In-Reply-To: <xmqqegc33oal.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287046>

On 23 February 2016 at 06:59, Junio C Hamano <gitster@pobox.com> wrote:
> Amadeusz =C5=BBo=C5=82nowski <aidecoe@aidecoe.name> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>> I wonder if it makes sense to just silently allowing submit without
>>> rebasing, and without telling the user how to clean it up.
>>
>> It is a good point. Maybe submit shouldn't be allowed by default at =
all
>> From bare repository. What do you think about following approach?  I=
f
>> core.base is true, then if git-p4.submitFromBare is also true then
>> submit without performing proper rebase, but update master ref from
>> p4/master. If core.base is true, but git-p4.submitFromBare is false,
>> abort immediately. Submitting from bare repository would require awa=
re
>> decision from a user.
>
> (I think you meant "bare" where you wrote "base" in the above).
>
> As a non user of git-p4, the above sounds a safe and sensible
> approach, but I'd like to hear from Luke, who has been active in
> this area and is far more expert than I am ;-)

Sorry, I've been travelling so not been able to reply earlier. Jetlag
has now kicked-in, and 4am is the perfect time to reply to this!

I think it would help to understand why we're doing a git-p4 submit
from a bare repo in the first place.

The usual workflow is you have a normal repo and submit from that.

I'm guessing that the reason for using a bare repo is so that changes
can be pushed to it from several different git repos. This then saves
doing the initial git-p4 clone multiple times.

As Amadeusz pointed out, the submit fails:

$ git p4 submit --git-dir=3D/path/to/bare/repo
=2E..
=2E..
fatal: This operation must be run in a work tree
Some files in your working directory are modified and different than
what is in your index. You can use git update-index <filename> to
bring the index up-to-date or stash away all your changes with git
stash.

If this had actually worked, I think the next thing I would want to do
is to rebase one or more branches in the bare repo against p4/master.
I don't think there's any way that git-p4 can work out which branches
would be rebased, and nor should it.

I think the approach of using a submitFromBare config variable to
force the user to make a choice feels a bit bogus, since they clearly
*want* to submit from this bare repo, as otherwise they wouldn't have
done "git-p4 submit" in the first place.

It might make sense to have a command-line or config option
("--skip-rebase" ?) to tell "submit" to only do the submit part, and
skip the rebase stage (and get the rebase stage to give a more useful
error message on a bare repo when the option isn't used). That would
then mean that git-p4 does not have to know if it's running in a bare
repo or not, and the submit-without-rebase functionality is available
to people doing other different things not involving bare repos (which
we haven't though of yet) but still requiring submit without rebase.

Luke

>
> Thanks.
>
