From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 5/5] builtin-remote: Make "remote -v" display push urls
Date: Tue, 09 Jun 2009 19:47:57 +0200
Message-ID: <4A2EA04D.9080405@drmicha.warpmail.net>
References: <1244563298-15479-1-git-send-email-git@drmicha.warpmail.net>	<1244563298-15479-2-git-send-email-git@drmicha.warpmail.net>	<1244563298-15479-3-git-send-email-git@drmicha.warpmail.net>	<1244563298-15479-4-git-send-email-git@drmicha.warpmail.net>	<1244563298-15479-5-git-send-email-git@drmicha.warpmail.net>	<1244563298-15479-6-git-send-email-git@drmicha.warpmail.net> <7vvdn5nzmb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 19:48:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME5Qk-000607-Kc
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 19:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbZFIRsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 13:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753678AbZFIRsC
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 13:48:02 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36526 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751752AbZFIRsB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 13:48:01 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C762A35FC63;
	Tue,  9 Jun 2009 13:48:02 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 09 Jun 2009 13:48:02 -0400
X-Sasl-enc: BiBibZB1KQ9j6wzApRt13zPJz8oNdwcqF5RTtsSX1Yvz 1244569682
Received: from localhost.localdomain (p54859AE3.dip0.t-ipconnect.de [84.133.154.227])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 070403449B;
	Tue,  9 Jun 2009 13:48:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090609 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vvdn5nzmb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121194>

Junio C Hamano venit, vidit, dixit 09.06.2009 18:25:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Example with "mjg" having 1 url and 1 pushurl, "origin" having 3 urls,
>> sb having 1 url:
>>
>> mjg     git://repo.or.cz/git/mjg.git (fetch)
>> mjg     repoor:/srv/git/git/mjg.git (push)
>> origin  git://repo.or.cz/git.git (fetch)
>> origin  git://repo.or.cz/git.git (push)
>> origin  git://git2.kernel.org/pub/scm/git/git.git (push)
>> origin  git://repo.or.cz/alt-git.git (push)
>> sb      git://repo.or.cz/git/sbeyer.git (fetch)
>> sb      git://repo.or.cz/git/sbeyer.git (push)
> 
> The readers will get distracted, saying "eh, git:// can be used for push?"
> (and the answer is "yes, sometimes, but not for repo.or.cz") even though
> that is not the point of these illustrations.  For these examles, I think
> it is better to use "repo.or.cz:foo.git" style, instead of "git://".

Uhm, isn't host:foo.git equivalent to ssh://host/foo.git?

In any case, if you clone from a fetch-only url (which is the typical
head start) then the default push url does not work (like sb above),
before as well as after this series.

I noticed that I left an URL alias ("repoor" = "repoor:/srv/git/" plus
ssh config for "repoor") in that example which isn't great either...
Maybe I should just use generic domains (example.com).

I'll answer to the other points in a different reply.

Michael
