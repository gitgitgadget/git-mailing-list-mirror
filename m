From: walt <w41ter@gmail.com>
Subject: Re: Bisecting through the middle of a big merge?
Date: Sat, 28 Jan 2012 10:15:51 -0800
Message-ID: <jg1e0t$5cs$1@dough.gmane.org>
References: <jfve09$ih5$1@dough.gmane.org> <m239b0fbpb.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 28 19:34:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrD6v-0002nK-UH
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 19:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab2A1Sep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 13:34:45 -0500
Received: from plane.gmane.org ([80.91.229.3]:50266 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab2A1Sep (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 13:34:45 -0500
X-Greylist: delayed 1105 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Jan 2012 13:34:45 EST
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RrCor-0001qq-SQ
	for git@vger.kernel.org; Sat, 28 Jan 2012 19:16:09 +0100
Received: from adsl-69-234-196-147.dsl.irvnca.pacbell.net ([69.234.196.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 19:16:09 +0100
Received: from w41ter by adsl-69-234-196-147.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 19:16:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-196-147.dsl.irvnca.pacbell.net
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20120106 Thunderbird/9.0
In-Reply-To: <m239b0fbpb.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189264>

On 01/28/2012 12:55 AM, Andreas Schwab wrote:
> walt <w41ter@gmail.com> writes:
> 
>> There are many individual commits from Tejun Heo et al included
>> in that one big commit from Linus.  Unfortunately for me, some of
>> those commits cause other problems that I'm not trying to bisect;
>> other problems that evidently get fixed by other commits in the
>> same big merge.
>>
>> So I do 'git bisect skip' six or eight times until the 'false' bug
>> goes away, and that leaves me at the end of the bisect without finding
>> the individual commit that's causing my 'real' bug.
>>
>> How do you experts handle this kind of problem?
> 
> If you can identify the commit that fixes the unrelated problem you can
> try to cherry-pick it during the bisect.

Thanks Andreas.  With an eye to doing that, is there an easy way to
get a list of all the commits included in Linus's merge?  (I mean a
more accurate list than Linus casually mentions in his commit message.)

Trying to build that mental model I mentioned:  All the commits from
Tejun Heo are dated mid-December but Linus didn't commit them until
mid-January.  When I'm bisecting through that merge, git builds the
kernels with names like vmlinuz-3.2.0-rc5-foo, i.e. names a month
older than Linus's current kernel version.  Where does git get those
older names during the bisect?  And does my working tree exclude all
of Linus's commits made later than 3.2.0-rc5-foo?

Many thanks.
