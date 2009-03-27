From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Two RPM building improvements
Date: Fri, 27 Mar 2009 20:43:17 +0100
Message-ID: <49CD2C55.8020502@drmicha.warpmail.net>
References: <1238157134-27558-1-git-send-email-Niels@Basjes.nl> <m3k56b2hy2.fsf@localhost.localdomain> <7vvdpvdjj4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Niels Basjes <Niels@Basjes.nl>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 20:45:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnHzB-0004s2-BM
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 20:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757386AbZC0Tn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 15:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756992AbZC0Tn2
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 15:43:28 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34640 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756250AbZC0Tn1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 15:43:27 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 5C8B4301AE7;
	Fri, 27 Mar 2009 15:43:25 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 27 Mar 2009 15:43:25 -0400
X-Sasl-enc: rxSBNdS+W5k99ZVd65zJP/4Co2Ks1Un1GVJUfTh9aAms 1238183004
Received: from localhost.localdomain (p4FC63422.dip0.t-ipconnect.de [79.198.52.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6226812152;
	Fri, 27 Mar 2009 15:43:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090326 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vvdpvdjj4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114922>

Junio C Hamano venit, vidit, dixit 27.03.2009 17:20:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Niels Basjes <Niels@Basjes.nl> writes:
>>
>>> Two RPM building improvements:
>>
>> Two _unrelated_ RPM building improvements squashed in one commit.
>>
>>>   - Building the RPMs can now be done by a non-root user.
>>
>> It was always possible, you only have to configure rpm / rpmbuild,
>> namely put path to where you want your RPM_BUILDING directory in
>> ~/.rpmmacros as %_topdir, for example:
>>
>>   $ cat ~/.rpmmacros
>>   %_topdir        /home/local/builddir
>>
>> Please RTFM first, before going to solve non-problem in (ugh) fairly
>> complicated way.
> 
> That might be a bit too harsh to somebody who genuinely wished to share
> his improvement with others.
> 
> Being RPM novice, the first thing I asked around immediately after taking
> the maintainership over was the ~/.rpmmacros trick.  We really should
> mention it in _our_ documentation, even just a sentence or two would be
> sufficient.

I assumed everyone building rpms would use rpmdev-setuptree from
rpmdevtools, but apparently not ;) I'm not sure whether non-Redhat
rpm-based distros have that, though.

I'm wondering a bit about the all-rpms target. How does this work
without mock? All build requirements installed for all platforms?? I
think it really calls for a mock build/vm (unless i386 on x86_64).

Michael
