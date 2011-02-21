From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [1.7.5] Let fetch and pull recurse into submodules when new commits
 are recorded
Date: Mon, 21 Feb 2011 10:12:50 -0500
Message-ID: <4D6280F2.5000409@xiplink.com>
References: <7vwrky5f48.fsf@alter.siamese.dyndns.org> <4D5FF264.5050002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 21 16:13:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrXRk-000368-68
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 16:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608Ab1BUPNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 10:13:01 -0500
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:51258 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab1BUPNA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 10:13:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp44.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 1DD481283BD;
	Mon, 21 Feb 2011 10:13:00 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp44.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D34171282BF;
	Mon, 21 Feb 2011 10:12:55 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <4D5FF264.5050002@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167486>

On 11-02-19 11:40 AM, Jens Lehmann wrote:
> Am 18.02.2011 02:02, schrieb Junio C Hamano:
>> It seems that not many things need breaking, but we will break some.
>>
>> Here are the ones that needed discussion and were discussed that I am
>> aware of, with my comments (which shouldn't be read as final decision).
> 
> Sorry for not having posted this earlier:
> 
> Proposal:
> Add a new "on-demand" mode to fetch and pull and make it the default.
> 
> When using the new "on-demand" mode every time new commits are fetched
> in the superproject they will be parsed for submodule commits. If these
> commits aren't present in a populated submodule, run "git fetch" inside
> that submodule. (Also see this thread for an in depth discussion:
> http://article.gmane.org/gmane.comp.version-control.git/158979/ )
> 
> Additionally change "git submodule update" to only then run fetch in a
> submodule when the commit it wants to check out is not already present
> there.
> 
> This behavior can be configured per submodule, per repo and globally.
> 
> Advantages:
> * Disconnected operation. Right now it is really easy to forget to fetch
>   all submodules before you get on a plane, possibly leaving you unable
>   to check out certain revisions.

I support the proposal, but just to be clear I'd rephrase that advantage as:

Disconnected operation. Right now it is really easy to forget to update
populated submodules before you get on a plane, possibly leaving you unable
to check out certain revisions.

(Obviously, I think the only-works-on-already-populated-submodules part is
very important.)

		M.
