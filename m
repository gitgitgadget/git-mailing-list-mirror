From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Topics currently in the Stalled category
Date: Wed, 28 Nov 2012 04:33:41 +0100
Message-ID: <CAMP44s2Cw-Vr0pEi7vOYx3aPxrKWZNpRxx+DjjtejndsC0P7Bw@mail.gmail.com>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org>
	<7vy5hvq1ey.fsf@alter.siamese.dyndns.org>
	<7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
	<CAMP44s30cbH5+HUxRBByk5sZGq=j_MdqLSnNzREozEk40_zbOw@mail.gmail.com>
	<20121128025928.GA27772@sigill.intra.peff.net>
	<20121128031118.GB27772@sigill.intra.peff.net>
	<CAMP44s3ZtCNsedJtsHDJx5d4Myjbbp+D6yT-rO-CmKOTtt91VQ@mail.gmail.com>
	<20121128032245.GD27772@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:34:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdYPP-0005qJ-Gf
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740Ab2K1Ddo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:33:44 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44064 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413Ab2K1Ddm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:33:42 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13139976oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 19:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Vzr5kZDwU/vMit/k2vCSYFGQgye6B50bq5TSrWX82YQ=;
        b=A2VCJS7MRDZaSOrXlOGmdQP3m2lIoxRyVeadaQiEB2k23Q3Shtc+CSxBX06ObSuDo4
         oYS3ahZm8S5Crydj2bn8knLq02ztzVbnezn7kjxeMzP3NtdAtK7LxZmT6q6wdulq4lZl
         haOo8yAGGHIFZQ4mGTJXF8AK1rMI8Rko5RLxq+Bt3gY+JJnR24z+Whyvg5iVa0bZOcxu
         pQOb2BudEPD16AUC9V3Ywu67m6YaTHQyVtUCqUyKkP/r2Q+n4M3MiJtPqwtgbv0sCfio
         zn4eG2g+XnJRtscvvssy8z6f6ERss2Mu079YzgEVJli8By3VLCzOgDdQwB8d55dvDTgO
         1KSg==
Received: by 10.60.30.70 with SMTP id q6mr14461164oeh.103.1354073622052; Tue,
 27 Nov 2012 19:33:42 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 19:33:41 -0800 (PST)
In-Reply-To: <20121128032245.GD27772@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210690>

On Wed, Nov 28, 2012 at 4:22 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 28, 2012 at 04:15:12AM +0100, Felipe Contreras wrote:
>
>> > We could improve the test in t5801, but it is nice to let people on such
>> > systems test it, as well. And the infrastructure might be useful if we
>> > ever acquire more bash scripts.
>> >
>> > There's a fair bit of boilerplate, but I think this squashable patch
>> > would do it:
>>
>> Yeah, but I wonder what's the point of installing this script, it's
>> mostly for testing and reference, and to add a whole category for that
>> seems like overkill.
>
> There's no point in installing it; I just didn't make the effort to
> avoid doing so (note that testpy and testsvn are also installed, which
> are in the same boat; it might make sense to split them all out like we
> do for $TEST_PROGRAMS).
>
> I agree it's an annoying amount of boilerplate, but it seems simpler
> cognitively to me for it to behave as the other SCRIPT_* builds than to
> do something simple but inconsistent.
>
> I do not care enough to argue about it. We need to do something to fix
> the impending test breakage on systems like Solaris. I have posted the
> patch to handle BASH_PATH, so do what you want.

I'm not objecting to the change, I'm simply wondering.

Personally I think switching to '/usr/bin/env bash' should be enough
for now. Doing a grep on my git installation throws this:

% grep '/usr/bin/env' -r /opt/git
/opt/git/lib/python2.7/site-packages/git_remote_helpers/git/git.py:#!/usr/bin/env
python
/opt/git/lib/python2.7/site-packages/git_remote_helpers/__init__.py:#!/usr/bin/env
python
/opt/git/lib/python2.7/site-packages/git_remote_helpers/util.py:#!/usr/bin/env
python
/opt/git/libexec/git-core/git-instaweb:#!/usr/bin/env ruby

So it's doubtful a lack of /usr/bin/env would cause any more breakages
than it already does for test-git.

And this just landed on 'pu', I don't think there's anything big
impending. If the /usr/bin/env solution turned out to be not enough
for some reason, we can deal with it then. That's my opinion.

Cheers.

-- 
Felipe Contreras
