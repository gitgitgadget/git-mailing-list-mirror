From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Test that the 'rebase -i' "reword" command always 	cherry-picks
 a commit.
Date: Mon, 22 Mar 2010 18:06:45 -0400
Message-ID: <4BA7E9F5.2000404@xiplink.com>
References: <4BA11B23.4090801@xiplink.com> <1269285942-17496-1-git-send-email-marcnarc@xiplink.com> <32541b131003221323u1ed540bbi87d8d427cfcc421a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 23:04:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtpjY-00051v-Iq
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 23:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab0CVWET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 18:04:19 -0400
Received: from smtp132.dfw.emailsrvr.com ([67.192.241.132]:38219 "EHLO
	smtp132.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab0CVWET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 18:04:19 -0400
Received: from relay13.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay13.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 79D963130C8F;
	Mon, 22 Mar 2010 18:04:18 -0400 (EDT)
Received: by relay13.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 01B523130C4F;
	Mon, 22 Mar 2010 18:04:17 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
In-Reply-To: <32541b131003221323u1ed540bbi87d8d427cfcc421a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142969>

Avery Pennarun wrote:
> On Mon, Mar 22, 2010 at 3:25 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>> +Sometimes you're in a situation like this
>> +
>> + P---o---o---M---x---x---W---x
>> +  \         /
>> +   A---B---C
>> +
>> +where you:
>> +
>> + - Need to rewrite one of the commits on the A-B-C branch; and
>> +
>> + - Want the rewritten A-B-C branch to still start at commit P (perhaps P
>> +   is a branching-off point for yet another branch, and you want be able to
>> +   merge A-B-C into both branches).
>> +
>> +The natural thing to do in this case is to checkout the A-B-C branch and use
>> +"rebase -i A" to change commit B.  However, this does not rewrite commit A,
>> +and you end up with this:
>> +
>> + P---o---o---M---x---x---W---x
>> +  \         /
>> +   A---B---C   <-- old branch
>> +   \
>> +    B'---C'    <-- rewritten branch
>> +
>> +To merge A-B'-C' into the mainline branch you would still have to first revert
>> +commit W in order to pick up the changes in A, but then it's likely that the
>> +changes in B' will conflict with the original B changes re-introduced by the
>> +reversion of W.
> 
> I think you need to clarify in the above text that W is a revert of M.
>  I was very confused by this at first.

Someone who reads through the whole file will see that W is the reversion of
M.  It's probably good to repeat that in the addendum for readers who jump to
the addendum right away.

> Other than that, I'll leave it to others more opinionated than me to
> comment on whether regenerating a commit just for the sake of
> regenerating it is actually desirable or not :)

I'm all ears!

		M.
