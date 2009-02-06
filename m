From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] git notes show: test empty notes
Date: Fri, 06 Feb 2009 16:42:51 +0100
Message-ID: <498C5A7B.3030506@drmicha.warpmail.net>
References: <1233933543-28407-1-git-send-email-git@drmicha.warpmail.net> <1233933543-28407-2-git-send-email-git@drmicha.warpmail.net> <alpine.DEB.1.00.0902061635560.7377@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 16:44:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSsT-0002i3-Pm
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbZBFPm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbZBFPm5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:42:57 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:34485 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752920AbZBFPm4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 10:42:56 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id AC987283C25;
	Fri,  6 Feb 2009 10:42:55 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 06 Feb 2009 10:42:55 -0500
X-Sasl-enc: hOFORBlQntrZ2TRZzUlY7DtlUMxNVuquQyy6JhhAM039 1233934975
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A33AC14902;
	Fri,  6 Feb 2009 10:42:54 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <alpine.DEB.1.00.0902061635560.7377@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108740>

Johannes Schindelin venit, vidit, dixit 06.02.2009 16:36:
> Hi,
> 
> On Fri, 6 Feb 2009, Michael J Gruber wrote:
> 
>> Add a test for the handling of empty notes by "git notes show".
>> ---
>>  t/t3301-notes.sh |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
>> index 9393a25..4900dca 100755
>> --- a/t/t3301-notes.sh
>> +++ b/t/t3301-notes.sh
>> @@ -35,6 +35,11 @@ test_expect_success 'need valid notes ref' '
>>  	! MSG=2 GIT_NOTES_REF='/' git notes show
>>  '
>>  
>> +# 1 indicates caught gracefully by die, 128 means git-show barfed
>> +test_expect_failure 'handle empty notes gracefully' '
>> +	git notes show || test 1 = $?
>> +'
> 
> That test would succeed if the exit status is 0.

Yes. If "git notes show" returns 0 then even better. It does neither
before nor after the patch. Or should we always expect 1 and test for
that? I thought about grepping the output for "fatal" (which appears
now) but that seemed ugly.

Michael
