From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] transport-helper: update remote helper namespace
Date: Thu, 11 Apr 2013 00:18:08 -0500
Message-ID: <CAMP44s1LF46VU0E4W=r-qog3JY+Y-qyYGfkqxLEnTG8X8GoWOA@mail.gmail.com>
References: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
	<1365638832-9000-3-git-send-email-felipe.contreras@gmail.com>
	<20130411043346.GE14551@sigill.intra.peff.net>
	<CAMP44s0FkiwPMJVhVBNa32J3rgghRZy6xDTN-YnHKcQ4Fj0BMQ@mail.gmail.com>
	<20130411050509.GC27795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 07:18:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ9tn-0004BJ-Hc
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 07:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab3DKFSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 01:18:11 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:51633 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294Ab3DKFSK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 01:18:10 -0400
Received: by mail-lb0-f172.google.com with SMTP id u10so1228532lbi.17
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 22:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=oLNUIMr1FZ73rBuYGKeylAMsMHpXJOr7M5qXDjRNgbA=;
        b=nXa+AE5PsN9D+qH1BQIEcszZ04FPOB5MKbyD1EZPooJ3oVsyvQXCWqu5WxGOsuBNdo
         GN8ISYeHsiFyryr4l9uomPR1cOHjx8AIfGHjTitPzNjbeMCwiPklrj03EmOyw7hhYC/A
         K38QgBkxyU9Bz9mINwANckuKqsWOU9Y2gROk+my3CdkiMM1V2vxR4wDiBaXMNbiDX0ya
         lnefCBIe17wbfSM8cloUD+rm8pHio48R+yElfB00NFnRVx+0x6KL8W+/ZgvP2NN0tZrF
         pn7FEHszLEYcXjYQ4tkRiw6+uN+21C+1rhBnUewcQBt1b8gCQMhQFSFl0KHJHQ5INjIW
         wBiw==
X-Received: by 10.112.161.38 with SMTP id xp6mr2558706lbb.32.1365657488610;
 Wed, 10 Apr 2013 22:18:08 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Wed, 10 Apr 2013 22:18:08 -0700 (PDT)
In-Reply-To: <20130411050509.GC27795@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220821>

On Thu, Apr 11, 2013 at 12:05 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 10, 2013 at 11:53:38PM -0500, Felipe Contreras wrote:
>
>> > But if we push some commits to the helper, moving Y up to Z, then it
>> > would build the new commit (which contains the foreign-vcs's equivalent of
>> > Y..Z) on top of Z, not Y.
>>
>> Why would it do that? If X points to say revision 100, presumably it
>> was stored somewhere while doing a fetch. Similarly, if foreign
>> version of Z is 150, it can update that number while doing a push. The
>> next fetch it would start from 151.
>
> I think the only reason not to bump the marker forward during the push
> would be if the helper wants for some reason to "re-import" from the
> foreign source rather than accepting the git versions of the commits.
> Something like git-svn's markup of the commit messages with revision ids
> comes to mind.

Yeah, but that's already a second level hypothesis. First,
remote-helpers would need to be able to work without marks, and they
can't.

> But if it matters, then by definition that would mean
> that the import/export is not bidirectionally clean.

I don't see how would that matter.

> So I can buy the argument that bumping it forward ourselves will not
> matter for any well-implemented helper.

Or any helper.

> That is the sort of thing that might be helpful to include in the commit
> message; if somebody does run across such a helper and bisects to your
> commit, then they can understand the rationale for the decision.

If it did matter, it would be mentioned. I will updated it later if
there's no further comments.

--
Felipe Contreras
