From: Sergei Organov <osv@javad.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 21:59:41 +0300
Message-ID: <87zlxi6kf6.fsf@osv.gnss.ru>
References: <874pfq9q8s.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com>
	<A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de>
	<200711131842.03622.jnareb@gmail.com> <87d4ue81tv.fsf@osv.gnss.ru>
	<8c5c35580711131017p451f831bqd928ef033c9a0e98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Steffen Prohaska" <prohaska@zib.de>, git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1CX-00060C-ND
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 20:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760085AbXKMTJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 14:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759778AbXKMTJS
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 14:09:18 -0500
Received: from javad.com ([216.122.176.236]:2769 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038AbXKMTJR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 14:09:17 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lADIxl059455;
	Tue, 13 Nov 2007 18:59:47 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Is0z7-0005MG-RJ; Tue, 13 Nov 2007 21:59:41 +0300
In-Reply-To: <8c5c35580711131017p451f831bqd928ef033c9a0e98@mail.gmail.com> (Lars Hjemli's message of "Tue\, 13 Nov 2007 19\:17\:51 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64831>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On Nov 13, 2007 6:58 PM,  <osv@javad.com> wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> > Steffen Prohaska wrote:
>> >> It doesn't make sense to delete remote-tracking branches
>> >> locally if they are still present at the remote.  The main
>> >> purpose of a remote-tracking branch is to be identical to the
>> >> real remote branch.
>> >
>> > True, but it would be nice to have an option to _exclude_ some
>> > branches from fetching (for example 'html' and 'man' branches
>> > of git.git), while still picking up new branches automatically
>> > on fetch.
>>
>> Guys, could you please read man git-branch?
>
> I understand that the man-page could be confusing, the problem is that
> these examples are quite old: they made more sense when git didn't
> support wildcards in refspecs.

Yeah, I understand that. But there doesn't seem to be actual reason not
to support them even with wildcards support.

> You want an easy way to tell git to stop tracking the pu-branch. This
> can be achieved by editing the [remote "origin"] section in
> .git/config: remove the fetch-line containing refs/heads/* and add one
> fetch line for each ref you'd like to track. But beware that you have
> to add any new branches which you would like to track in the same way
> (editing .git/config).

Thanks, I got it. Though the last sentence makes it less useful then it
should be. [This somewhat reminds me CVS problems when you can delete
directories that you don't want, and checkout won't restore them
(without special switch), but then you won't automatically get new
directories :( Though admittedly the situation with the remote-tracking
branches is less annoying.]

>
> The reason git-branch -d -r doesn't do this automatically is probably
> that nobody has seen a need for it to do so...

Me thinks it has probably been just overlooked when wildcards were
added. Anyway, either documentation or git-branch -d -r should be fixed,
I think.

-- 
Sergei.
