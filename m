From: Hannu Koivisto <azure@iki.fi>
Subject: Re: Unable to clone empty repositories remotely
Date: Wed, 26 Nov 2008 15:13:13 +0200
Message-ID: <834p1ur5p2.fsf@kalahari.s2.org>
References: <837i6rplcd.fsf@kalahari.s2.org>
	<46d6db660811251333u583468e0ma2846796ca9df68d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Christian MICHON" <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 14:49:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Kls-00041c-W9
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 14:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbYKZNsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 08:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755046AbYKZNsF
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 08:48:05 -0500
Received: from s2.org ([195.197.64.39]:50198 "EHLO kalahari.s2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754515AbYKZNsC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 08:48:02 -0500
X-Greylist: delayed 2087 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Nov 2008 08:48:01 EST
Received: from azure by kalahari.s2.org with local (Exim 4.69)
	(envelope-from <azure@iki.fi>)
	id 1L5KCf-0006BS-1d; Wed, 26 Nov 2008 15:13:13 +0200
In-Reply-To: <46d6db660811251333u583468e0ma2846796ca9df68d@mail.gmail.com>
	(Christian MICHON's message of "Tue, 25 Nov 2008 22:33:48 +0100")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: azure@iki.fi
X-SA-Exim-Scanned: No (on kalahari.s2.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101736>

"Christian MICHON" <christian.michon@gmail.com> writes:

> On Tue, Nov 25, 2008 at 10:05 PM, Hannu Koivisto <azure@iki.fi> wrote:
>> Greetings,
>>
>> mkdir test
>> cd test
>> git init --bare --shared=group
>> cd ..
>> git clone test test2
>>
>> works, though clone says it cannot checkout, which is expected.
>> This is nevertheless very useful when you create a shared
>> repository for a new project; you can then create a personal clone
>> and start adding stuff to it.  If, however, you normally work on
>> another machine and want to have your personal clone there
>> (i.e. git clone ssh://therepomachine/somewhere/test), cloning
>> doesn't work at all (tested with git 1.6.0.3.525.ge32c2 in Cygwin):
>>
>> Initialized empty Git repository in /cygdrive/c/temp/test/.git/
>> fatal: no matching remote head
>>
>> This behaviour isn't documented by either git-init(1) or
>> git-clone(1).  I think it would be very convenient if this worked
>> for the reasons mentioned above.  I'm sure you could create your
>> personal repository with git init and then git remote add the
>> shared repository to it but that's much more difficult.
>>
>> --
>> Hannu
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> how about creating at least 1 empty commit before any cloning ?
>
> wouldn't this solve the problem ?

No, it wouldn't.  I don't doubt that there are workarounds - I
mentioned one possibility myself.  Admittedly your workaround may
be more convenient than mine, but it's still a workaround.

Now that I think of it, I wonder if one could go one step further
in shared repository creation usability and make it possible to do
that git init step remotely as well (I mean, directly with a
one-step git command instead of ssh host "cd /repos ; mkdir foo ;
cd foo; git init ...").  Since git init doesn't take non-option
arguments, I suppose it could be extended to accept ssh (and file)
urls for this purpose?  And maybe an option to create a
corresponding local clone at the same time.

-- 
Hannu
