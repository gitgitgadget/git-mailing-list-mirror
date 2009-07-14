From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] t4202-log.sh: Test git log --no-walk sort order
Date: Tue, 14 Jul 2009 16:28:52 +0200
Message-ID: <4A5C9624.1020404@drmicha.warpmail.net>
References: <4A5C785C.6060706@viscovery.net> <1247575519-9629-1-git-send-email-git@drmicha.warpmail.net> <alpine.DEB.1.00.0907141612350.4553@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Paolo Bonzini <bonzini@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 14 16:29:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQj0q-0003tT-LC
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 16:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbZGNO3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 10:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbZGNO3L
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 10:29:11 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59552 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754808AbZGNO3K (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 10:29:10 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 395333B0D6F;
	Tue, 14 Jul 2009 10:29:10 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 14 Jul 2009 10:29:09 -0400
X-Sasl-enc: XzDGr0FtM04EKm1oQxwJkjwhNItQUNwSq0B7vUeOmRa4 1247581749
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2D8D024DE8;
	Tue, 14 Jul 2009 10:29:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090712 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0907141612350.4553@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123250>

Johannes Schindelin venit, vidit, dixit 14.07.2009 16:13:
> Hi,
> 
> On Tue, 14 Jul 2009, Michael J Gruber wrote:
> 
>> 'git log --no-walk' sorts commits by commit time whereas 'git show' does
>> not (it leaves them as given on the command line). Document this by two
>> tests so that we never forget why ba1d450 (Tentative built-in "git
>> show", 2006-04-15) introduced it and 8e64006 (Teach revision machinery
>> about --no-walk, 2007-07-24) exposed it as an option argument.
> 
> Thanks.
> 
>> +cat > expect << EOF
>> +5d31159 fourth
>> +ein
>> +804a787 sixth
>> +a/two
>> +394ef78 fifth
>> +a/two
>> +EOF
>> +test_expect_success 'git show <commits> leaves list of commits as given' '
>> +	git show --oneline --name-only 5d31159 804a787 394ef78 > actual &&
>> +	test_cmp expect actual
>> +'
> 
> Just to hazard a guess: you probably used --name-only to avoid having the 
> whole diff in the output, right?  In that case, you might want to use -s 
> in the future (I do not think this needs fixing in this patch).

Yes, exactly. I was looking for "--no-p". And I was looking really hard!
I didn't see this in git-log.1 nor git-show.1 nor git-diff.1. Now,
looking again, I find it in git-diff-tree.1. Grrmml. With hindsight,
it's clear that all diff-tree options apply.

It seems that more of git-diff-tree.txt should show up in the man pages
for diff, log and show (i.e. be in diff-*.txt) or at least be
referenced. What do you think?

Michael
