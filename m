From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 05 Mar 2007 23:40:31 -0800
Message-ID: <7vlkiastu8.fsf@assigned-by-dhcp.cox.net>
References: <esgm1m$33f$1@sea.gmane.org>
	<7vejo2uaxs.fsf@assigned-by-dhcp.cox.net> <45ED179B.90500@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Tue Mar 06 08:40:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOUHj-0003Dt-E4
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 08:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbXCFHkd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 02:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933973AbXCFHkd
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 02:40:33 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:38167 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932741AbXCFHkc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 02:40:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306074032.LANS3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 02:40:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XKgX1W00J1kojtg0000000; Tue, 06 Mar 2007 02:40:32 -0500
In-Reply-To: <45ED179B.90500@lu.unisi.ch> (Paolo Bonzini's message of "Tue, 06
	Mar 2007 08:26:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41553>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

>> Hmm. I think your use of 'mytopic' is very good for the purpose
>> of illustration. It makes clear which configuration takes name
>> from what. So I like your first paragraph. However, one reason
>> people like the separate remote layout is that it allows you to
>> name your own branch identically with that of the other side, so
>> in that sense, the description in your second paragraph matches
>> the real-life usage better. What I am getting at is that (1)
>> these two paragraphs are inconsistent, (2) there is a reason to
>> prefer the description in the first paragraph, and (3) there is
>> another reason to prefer the description in the second one.
>
> Ok, I'll prefer using "mytopic" anywhere.
>
>> As Johannes already pointed this out, I think allowing this to
>> be controlled per remote is nice but overkill.  A single boolean
>> configuration, say "branch.autosetupmerge", would suffice.
>
> In this case, patch 2/3 should also be withdrawn, right?

Do you mean you would agree that it is overkill?  Just in case;
you do not have to necessarily agree with me but convince me
your way, if you feel I am wrong.

If so, yeah, 2/3 needs a minor adjustment since the configuration
will not be on remote.* but one configuration variable.

Also I agree with many points Dscho made.  I understand you
agreed to avoid asprintf() from portability worries, which I
think is a sensible thing to do.

While I do not think we should avoid sscanf("%n"), I suspect
that the code in your patch is not helped by using it that much.
