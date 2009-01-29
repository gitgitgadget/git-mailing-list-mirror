From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Something weird is happening...
Date: Thu, 29 Jan 2009 14:10:12 -0800
Message-ID: <49822944.8000103@zytor.com>
References: <49814BA4.6030705@zytor.com> <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 23:18:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfD8-0006yr-VS
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbZA2WQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbZA2WQq
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:16:46 -0500
Received: from terminus.zytor.com ([198.137.202.10]:39425 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbZA2WQp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:16:45 -0500
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id n0TMACX2020388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Jan 2009 14:10:12 -0800
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: ClamAV 0.93.3/8920/Thu Jan 29 10:30:26 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107735>

Junio C Hamano wrote:
> 
> Is the blob borrowed from one of its alternate object store, and not in a
> pack?  That would explain (note that I am not saying "justify" here, just
> "explain") the symptom.
> 

Yes, it is.

> But it still does the connectivity check fully from your refs.  And if it
> finds an object that ought to be reachable from your refs that it hasn't
> validated, it gives the "missing" warning above.  There is a check to
> exclude objects in packs when running "git fsck" without --full from this
> warning but I do not see a corresponding exclusion of objects that were
> borrowed from your neighbour which we didn't check either.
> 
> But that is just a conjecture from a cursory looking at the current code.
> I do not remember (or did not know from the beginning) some details of it.
> And that is why I asked you if "git fsck --full" reports it missing in my
> earlier response to you.

Just tried it, it doesn't.  So I guess things are OK.

	-hpa
