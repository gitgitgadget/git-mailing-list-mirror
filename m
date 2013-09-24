From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 01:41:19 -0500
Message-ID: <CAMP44s3ee_SmY=NOeMW31D4E01-Ft9qY5wa9VhRQWrY0fo7S=A@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<20130924045325.GD2766@sigill.intra.peff.net>
	<CAMP44s1tirA5w91L2YomaduZVkqL3=n1j79eoueB6XeGuyY3Mw@mail.gmail.com>
	<20130924053712.GA6114@sigill.intra.peff.net>
	<CAMP44s1-AXKRz4pqQsyCMLZgnxmxTaoeBGt8aNDFM0ttDTmBRQ@mail.gmail.com>
	<20130924061830.GB6114@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 24 08:41:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOMJJ-0007ob-NJ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 08:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724Ab3IXGlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 02:41:21 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54794 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3IXGlU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 02:41:20 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so3395310lbh.19
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 23:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GF4B9AGXvBU+zIrjuOShj+D1Kz0r1MeKRzhg7aYCXbQ=;
        b=PQNvsTyFifFjNef/UPUibSKqhvlrSmAlcxT9WTXjT20V2fFfnKtdaxQdEstjmFSfwQ
         Lm6dv4bb7GhTrHVnylp9KS9bCZyCcl1EXl5JhnDulTR21HjTUrYN07jGgK8PUMdNq8qE
         vXY+qOQ3qQqK5tLVz48qhN0HHjy1wp8EslrYPChZjQQgzDdLUdDagoghIKG3/J81BQb8
         0ycsYBYhokZLGbFfcsBu5JOT9+xAsRPWKIDyJx62nLYa14aLH0M8MXmunrWmbSbUnQke
         7n0iNoo9SCPNzRlfUOJl7VA3eH2PIKqEzmG3ea/lh4R2A9Df/tC7IQ3R2X+GIdpJN500
         FIIg==
X-Received: by 10.152.88.20 with SMTP id bc20mr133734lab.37.1380004879185;
 Mon, 23 Sep 2013 23:41:19 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 23 Sep 2013 23:41:19 -0700 (PDT)
In-Reply-To: <20130924061830.GB6114@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235275>

On Tue, Sep 24, 2013 at 1:18 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 24, 2013 at 12:49:21AM -0500, Felipe Contreras wrote:
>
>> Anyway, if you are so worried about this hypothetical user not
>> noticing that 'git ci' didn't commit all the files, we could ma ci to
>> 'git commit -v' so we are being straightforward to the user as to what
>> is being committed.
>
> I do not think that is a useful suggestion, as the output of "commit -v"
> is typically too long for unsuspecting people to check carefully, and is
> redundant with the filename summary we already put in the commit
> template. And neither is shown with "-m", anyway.  I agree it's a
> minority of cases where somebody will make a bogus commit because of it,
> though.
>
> But let's take a step back for a moment. What was the goal of the patch?
> Who are we trying to help? People who already have identical aliases are
> not helped on existing boxes; they already have them. They might be
> helped on new boxes, where they will not have to copy over their custom
> aliases (but they would probably end up wanting to copy the rest of
> their config and aliases anyway).

They probably will want that, but they won't be forced to by typing
failing commands, they could do it later at their pleasure.

> People who have different aliases for
> the same terms are unaffected on existing boxes, but slightly hindered
> on new boxes as the aliases do something else.

Less hindered than in the current situation.

> People with no matching aliases now get these aliases. What do they
> expect them to do? Do they expect "commit" or "commit -a"? Do they
> expect "status" or "status -s" or "status -sb"? Are we trying for
> consistency across git installations, or consistency with similar
> aliases in systems like cvs (in which case, would that argue for "commit
> -a")? Do people who have not bothered to configure the aliases even
> care?

cvs ci = cvs commit
cvs co = cvs checkout

svn ci = svn commit
svn co = svn checkout

hg ci = hg commit
hg co = hg checkout

And somehow you think this is not natural and sensible?

git ci = git commit
git co = git checkout

I think it's as clear as day.

-- 
Felipe Contreras
