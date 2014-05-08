From: Chris Packham <judge.packham@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Thu, 08 May 2014 19:29:29 +1200
Message-ID: <536B3259.1050602@gmail.com>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>	<20140505184546.GB23935@serenity.lan> <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu May 08 09:29:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiIlw-00088g-Sk
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 09:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbaEHH3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 03:29:36 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:41464 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbaEHH3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 03:29:36 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so2393044pad.4
        for <git@vger.kernel.org>; Thu, 08 May 2014 00:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=krfZ16TeMT6V8/uveon8yCI3j0YwLbzEwU0Tk5bcXNQ=;
        b=1ELjCMdbMu6jUH/wJMegQDIOSSV6UUvCAy1Q8mlu9iL7quFGy1vbF5L4nxueLMO3rb
         PU8ArnRazqLDsoSKNZrjvIy1CSEJeTTxJotbrxt0HppVNKcmtJkv/kH0LCThEZKB9AYx
         2z9E5Zlbo65AdviCNCndjApX2re0X5fGtqeeIVdnsM8Qoi/BWn6Vull4uPOq/K5kc7xW
         zOvyBkUzfspIMVV4r72Nx+ZTL7mC/a34A21qJUebigZhEsHor3tzx7ko6FJx3BX0raZN
         MHdMoGxoeyzYsipiTbLke2CWM74njnRttICliryI1uDarK4VUmFQaP6wgIdWnAmcw5l0
         Sn3w==
X-Received: by 10.66.218.226 with SMTP id pj2mr4505585pac.134.1399534175043;
        Thu, 08 May 2014 00:29:35 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id ix7sm415087pbd.36.2014.05.08.00.29.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 May 2014 00:29:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248411>

Hi,

On 06/05/14 11:50, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
>> On Tue, Apr 29, 2014 at 03:38:07PM -0700, Junio C Hamano wrote:
>>> * fc/remote-helpers-hg-bzr-graduation (2014-04-29) 11 commits
>>>  ...
>>>  Move remote-hg and remote-bzr out of contrib/.  There were some
>>>  suggestions on the follow-up fix patches still not in 'next', which
>>>  may result in a reroll.
>>>
>>>  Will merge to 'next' and keep it there for the remainder of the
>>>  cycle.
>>
>> I'd like to register my opposition to moving git-remote-{bzr,hg} out of
>> contrib/.
>> ...
>> In the case of git-remote-hg specifically, the remote helper has to use
>> an interface that the Mercurial developers consider unstable [1];...
>> I do not want to end up in a situation where an update to Git is blocked
>> by a distribution because git-remote-hg is not updated to support newer
>> versions of Mercurial sufficiently quickly; this previously happened in
>> Gentoo due to git-svn and meant that was stuck on 1.7.8 until 1.7.13 was
>> released [2].
> 
> The same argument would apply to git-svn, git-p4, and git-cvsimport,
> I would think.

A bit of a crazy suggestion and a little off-topic. Assuming maintainers
can be found what about having these foreign vcs interfaces as
submodules. That way they can be in Junio's tree as well as having their
own release cycles. The same could apply to git-gui, gitk and gitweb. It
would also be a chance to eat-our-own-dogfood with submodules.

> Among these, I am not sure if we can find willing maintainers who
> can give enough love to them.  But unlike these other importers,
> remote-hg and remote-bzr do have an active maintainer (and IIRC I
> think I heard that Hg one even has an active competitor or two?) so
> I am reasonably confident that these can live on their own merit
> outside of my tree.  In the ideal world, I would think it may be
> even beneficial to the end users of these helpers to unbundle them.
> 
> You raised a good point on the issue of external dependencies may
> impact Git as a whole, even for those who are not interested in the
> particular remote helpers at all.  I'll have to think about it.
> 
> The silly thing is that I totally forgot that we almost got
> ourselves into a very similar situation on cvsimport when a series
> wanted to make it cvsps3-only.  It is very possible nobody would
> have picked up the entire new release, if we merged that change.
> 
> Having said all that, there is one caveat.
> 
>> Since the remote helper interface is stable and the remote helpers do
>> not use any of the Git internals, I consider the risks of including them
>> in core Git to outweigh the benefits of wider distribution.
> 
> You are correct to say that a remote helper has to talk with a
> foreign system and it would not help to dictate the update schedule
> of helpers to match the release cycle of Git itself.  At the same
> time, however, the interface the remote helpers use to talk to Git
> has not been as stable as you seem to think, I am afraid.  For
> example, a recent remote-hg/bzr series needed some enhancements to
> fast-import to achieve the feature parity with native transports by
> adding a missing feature or two on the Git side.
> 
> So in reality, a helper has to talk with two sides, needs to adjust
> to changes in the both sides, and both sides are changing.
> 
> Unbundling a helper from Git would place more burden on the helper's
> maintainer, because the helper has to know enough about versions and
> features of both sides (the foreign system and Git) to adjust its
> behaviour, to stay compatible with wider versions of both foreign
> systems and Git.  Unbundling, when done properly, may give more
> ideal user experience to the end users, because such a helper would
> allow them to pick up the latest (or stay on an older but known to
> be stable) version of the helper and expect it to work with the
> foreign system and Git they happen to have.
> 
> It however would be easier to maintain if the helper maintainer
> knows a change to Git itself will be released at the same time as
> the new version of the helper that takes advantage of the modified
> Git.  The helper maintainer only has to worry about compatibility
> with the foreign side if it is bundled with Git.
> 
> So it boils down to "how much resource are there to make sure a
> helper will stay compatible with wider versions of both sides?" and
> "how far backwards are helper maintainers willing to bend to support
> users better?".
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
