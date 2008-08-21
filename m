From: ir0s <imirene@gmail.com>
Subject: Re: Local branch ahead of tracked remote branch but git push claims
 everything up-to-date
Date: Thu, 21 Aug 2008 08:35:38 -0700 (PDT)
Message-ID: <1219332938839-740444.post@n2.nabble.com>
References: <1219263969579-736663.post@n2.nabble.com> <8585F10E-C33C-481E-B044-A7125F3316F2@web.de> <32541b130808201401l2ad105ccnc37acdacd08d4c3a@mail.gmail.com> <7vbpznpeup.fsf@gitster.siamese.dyndns.org> <32541b130808201422l2b128beer142544ff91de5ca3@mail.gmail.com> <alpine.LNX.1.00.0808201808400.19665@iabervon.org> <7v4p5fnw3i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 17:38:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWCDM-0003rf-Ng
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 17:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbYHUPfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 11:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbYHUPfk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 11:35:40 -0400
Received: from kuber.nabble.com ([216.139.236.158]:41051 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbYHUPfj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 11:35:39 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1KWCCI-0006cG-RH
	for git@vger.kernel.org; Thu, 21 Aug 2008 08:35:38 -0700
In-Reply-To: <7v4p5fnw3i.fsf@gitster.siamese.dyndns.org>
X-Nabble-From: imirene@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93166>


Sorry if you get this twice, oddly my first attempt to send this bounced.
Thank you for all the good advice however, none of it seemed to resolve my
issue.

Attempting to call:
$git push origin mybranch

Results in the same message: Everything up to date =/
I also tried to call $git fetch origin just in case, and doing a pull
doesn't return anything (which makes sense, no one pushed anything to the
branch -- although I seem to be the only one with this issue.)

Could my branch have somehow diverged from the origin remotebranch?

-- Irene


Junio C Hamano wrote:
> 
> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
>> That is actually to say that fetch should do it (pull calls fetch for
>> that 
>> part), and I agree with that, assuming you've actually got that fetch 
>> config, of course.
> 
> Hmm, traditionally, an explicit refspec on the command line that does not
> store overrides the configured ones that do store, and I've been using it
> as a feature when I run test fetches.  If I do not like fetched result, I
> can tell the other guy to fix his history and I do not have to contaminate
> the history my tracking ref points at.  IOW, I use my tracking refs not
> just "this is where the guy is", but "this is the last good one I fetched
> from that guy".
> 
> I could be persuaded to use reflog (e.g. "git diff his@{1}..his") and
> manual tagging (i.e. "git tag -f last-good-his his") myself, but this is
> "I'd _tolerate_ such a change myself", certainly not "I am happy with that
> change and I'd help you guys advocate it and try convincing others who
> shared my expectations to switch to reglog and manual tagging."
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
View this message in context: http://n2.nabble.com/Local-branch-ahead-of-tracked-remote-branch-but-git-push-claims-everything-up-to-date-tp736663p740444.html
Sent from the git mailing list archive at Nabble.com.
