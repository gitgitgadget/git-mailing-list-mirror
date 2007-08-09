From: Richard MUSIL <richard.musil@st.com>
Subject: Re: git-svn: commit author x commit committer issue
Date: Thu, 09 Aug 2007 11:45:44 +0200
Message-ID: <46BAE248.6070404@st.com>
References: <46B9C92B.3000000@st.com> <20070808171323.GD27703@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 09 11:46:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ4ac-00021C-6V
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 11:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873AbXHIJpu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 05:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761273AbXHIJpu
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 05:45:50 -0400
Received: from s200aog11.obsmtp.com ([207.126.144.125]:57830 "EHLO
	s200aog11.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbXHIJpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 05:45:49 -0400
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob011.postini.com ([207.126.147.11]) with SMTP;
	Thu, 09 Aug 2007 09:45:47 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP
	id A34FADADB; Thu,  9 Aug 2007 09:45:46 +0000 (GMT)
Received: from mail1.prg.st.com (mail1.prg.st.com [164.130.59.16])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6205E4BF14;
	Thu,  9 Aug 2007 09:45:46 +0000 (GMT)
Received: from [10.139.4.224] (pcdyn4224.prg.st.com [10.139.4.224])
	by mail1.prg.st.com (MOS 3.7.5a-GA)
	with ESMTP id CIL36636 (AUTH "richard musil");
	Thu, 9 Aug 2007 11:45:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <20070808171323.GD27703@xp.machine.xx>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55440>

Peter Baumann wrote:
> On Wed, Aug 08, 2007 at 03:46:19PM +0200, Richard MUSIL wrote:
>> Normally, when patch is applied, git distinguishes commit author and
>> commit committer (relying on info from patch).
>> However, after the patches are committed to svn repository using:
>> git-svn dcommit
>> author and committer data are set to same values (or at least time and
>> date, I cannot verify it for names).
>> I wonder if there is any reason for this behavior, because I would
>> definitely like to keep original commit info (which came from patch) in
>> my git repository.
> 
> I think it is because in SVN, you can't differentiate between author and
> committer. And git-svn just commits every local commit to svn, and after
> that, it throws away your local commits and uses the info from the
> reimported svn commits to recreate those thrown away commits. Thats why
> you loose your author name and also your commit date.

I guess you are right. I have been thinking about the possibility to
store the original author and patch date into svn unversioned property.
Something like git:author and git:date. There is however one catch.
Modifying unversioned properties must be explicitly allowed on svn
repository, so this will have to be optional in git (svn.userevprops ?).

I do not know what others think about this. For me it seems quite
attractive, to be able to store development history of original actions
inside svn, especially when the case might be that commits into git
happen at different time on different machines and by different people
than the final commit to svn.

I have been trying to find out how this works in git-svn, but since Perl
is worse than Greek to me, I found out only that I am not able to do
anything here. Would anyone be interested to work on it?

Richard
