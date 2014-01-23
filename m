From: Pierre Penninckx <ibizapeanut@gmail.com>
Subject: Re: [PATCH 1/4] subtree: support split --rejoin --squash
Date: Thu, 23 Jan 2014 09:51:49 +0100
Message-ID: <CAMzgWy3pfmESX1uvU2=nUtr1AdEVhtw-fXPwdtkNk4U6G4DCoA@mail.gmail.com>
References: <20131207185853.GA3353@comcast.net> <CAMzgWy18wH4_Ds00x7UASQjLgN8LiEucFSZFp-5PJio_pEwmnA@mail.gmail.com>
 <20140123035923.GA4176@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 09:52:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6G1a-0003g4-M0
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 09:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbaAWIwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 03:52:31 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:45931 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaAWIwa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 03:52:30 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so2086916qcy.12
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 00:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UA5VJI7J1I/Yp4BJYvvWNduOw5tCWMV1kLAa9Vm1cY0=;
        b=UciftkS1dbvLySq3/dH6U4WmdenMTBsImWbO3dYaVChz/MeT3WB3wAIqeszwg7+NKc
         s+Z9Nz2AXlB2ThR+YS9H2F8TiVcEwjzmTCyoDRqwiU167xBzUIxcx6RGCVGMVzq4FwEH
         ev4alSSp6smLUkkBQsRRFX4lmQpVZV5Xye9vpFvvzvxlUMtMVJnZ3ysas20Rxis2OF3Q
         KIaElKl65EX5NBiMEoLcoBUvHGNhpVTnWEDZAzBb0Wsb7dKXUzyTihguaAWLErBH5sED
         9pkJNOuITX/CMI61ltgaBFFjzrZI/I8mD8ACxeHkYJidWvGexXr2dCA8CKR5xqtIrPbO
         gjeg==
X-Received: by 10.140.23.209 with SMTP id 75mr8991330qgp.94.1390467149789;
 Thu, 23 Jan 2014 00:52:29 -0800 (PST)
Received: by 10.140.46.66 with HTTP; Thu, 23 Jan 2014 00:51:49 -0800 (PST)
In-Reply-To: <20140123035923.GA4176@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240907>

Hi again,

After using the patched git-subtree (with patches 1 to 3) for a while,
I suspect the added functionality does not do exactly what I wanted.
So yes, now when doing a rejoin, the squash of the split commits is
used. But how can I push this squash instead of the individual
commits? The problem is I don't know how to reference that squashed
commit.

I tried adding the --branch option but it adds the branch to the top
of the individual commits so no luck there.
This is maybe obvious but I'm not at ease with commit references in git.

Pierre

2014/1/23 Matthew Ogilvie <mmogilvi_git@miniinfo.net>:
> On Wed, Jan 22, 2014 at 03:58:28PM +0100, Pierre Penninckx wrote:
>> 2013/12/7 Matthew Ogilvie <mmogilvi_git@miniinfo.net>
>> > Subject: [PATCH 1/4] subtree: support split --rejoin --squash
>> >
>> > Allow using --squash with "git subtree split --rejoin".  It
>> > will still split off (and save to --branch) the complete
>> > subtree history, but the merge done for the "--rejoin" will
>> > be merging a squashed representation of the new subtree
>> > commits, instead of the commits themselves (similar to
>> > how "git subtree merge --squash" works).
>> >
>> > Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
>> > ---
>> >
>> > I can think of a couple of possible objections to this patch.
>> > Are these (or any others) worth fixing?
>> >
>> > 1. Perhaps someone want the saved subtree (--branch) to have
>> >    a squashed representation as well, as an option?  Maybe we
>> >    need two different --squash options?  Something
>> >    like "--rejoin-squash"?
>> > 2. It could definitely use some automated tests.  In fact,
>> >    pre-existing --squash functionality is hardly tested at
>> >    all, either.
>> >       See patch 4 comments for a script I use to help with
>> >    mostly-manual testing.
>>
>> Sorry to bother you with this again, but I was wondering if those patches
>> would be integrated into git anytime soon.
>> And if not, if there is something I can do to help.
>>
>> I found them by the way, thanks a lot!
>>
>> Pierre
>
> I'm not sure when or if the patches will make it in.  Junio's
> weekly "What's cooking..." email has asked for "Comments?" about
> them for the past several weeks, but I have yet to see
> anyone actually comment about them.
>
> Searching throught the last couple of years of mailing list
> archives for "subtree" reveals a general lack of a active
> maintainer(s) to help review and improve patches for "git
> subtree".  Given the general lack of help and feedback, it is
> understandable that Junio has largely limited inclusion of
> subtree patches to trivially obvious bug fixes.
>
>                         - Matthew Ogilvie
