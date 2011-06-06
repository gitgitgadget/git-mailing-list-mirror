From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 0/3] submodule add: allow relative repository path even
 when no url is set
Date: Mon, 06 Jun 2011 17:23:23 -0400
Message-ID: <4DED454B.1050105@xiplink.com>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org> <1306943792-1825-1-git-send-email-marcnarc@xiplink.com> <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de> <7v39jsdulf.fsf@alter.siamese.dyndns.org> <4DE93B29.4030401@web.de> <7vipskb0br.fsf@alter.siamese.dyndns.org> <4DED30E0.6090608@web.de> <7vei368ylj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>,
	Phil Hord <hordp@cisco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 23:23:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QThGp-0008GR-Lp
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 23:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635Ab1FFVXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 17:23:30 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:33170 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569Ab1FFVX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 17:23:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp56.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 6F00C3D867E;
	Mon,  6 Jun 2011 17:23:28 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp56.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 02D173D828F;
	Mon,  6 Jun 2011 17:23:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <7vei368ylj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175170>

On 11-06-06 05:00 PM, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 05.06.2011 20:27, schrieb Junio C Hamano:
>>> If you think about "absense of the remote in the superproject means the
>>> project originates from here", what you are doing in step 3. is to
>>> changing the origin of these set of projects. After changing the origin of
>>> these set of projects, isn't "git submodule sync" an established way to
>>> adjust to the change? I was hoping that that would update .git/config in
>>> step 3. so you wouldn't have the problem in step 4. at all.
>>
>> Thanks for explaining that in detail, I think I do get it now.
> 
> I actually still have a feeling that I may be missing something from the
> discussion.  While I do like a solution that lifts existing limitation to
> allow workflows that were hitherto impossible, that only makes sense when
> the newly allowed workflow makes sense and useful, and when the lifted
> limitation was not protecting some silly mistakes from getting made.
> 
> I _think_ our last exchange gave me a fuzzy confirmation that we are not
> lifting a useful limitation, but I still do not know if the new workflow
> matches the workflow Marc (who kicked off this thread) wanted to use. I
> think it does match the set-up Phil Hord mentioned in an earlier message,
> though.

Well, Jens's changes do remove the error I encountered, and they also do what
I was expecting in the original context I was in when I started this thread.
 So I think this is a definite improvement.

There may still be a lingering niggle where git might do something the user
doesn't expect.  For example, git might create a submodule out of
git://origin/foo.git instead of the local ../foo.git.  You have to be paying
attention to git's output to notice that difference, and I could see where a
user might get tripped up.  But IMO improving this can be done independently
of Jens's patches.

		M.
