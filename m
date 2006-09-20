From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] cvsimport move over to using git for each ref to read
 refs
Date: Wed, 20 Sep 2006 11:26:05 +0100
Message-ID: <4511173D.7020702@shadowen.org>
References: <20060920085200.GA21865@shadowen.org> <eer19l$6hm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 12:26:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPzHj-0005BN-TF
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 12:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWITK03 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 06:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWITK03
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 06:26:29 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:19982 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751014AbWITK02 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 06:26:28 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GPzHF-0006zE-20; Wed, 20 Sep 2006 11:26:01 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eer19l$6hm$1@sea.gmane.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27337>

Jakub Narebski wrote:
> Andy Whitcroft wrote:
> 
>> +       open(H, "git-for-each-ref --format='%(objectname) %(refname)'|") or
> 
> By the way, this is equivalent to using "git-show-ref" introduced by Linus.
> But if you want commit timestamp
> 
>> cvsimport opens all of the files in $GIT_DIR/refs/heads and reads
>> out the sha1's in order to work out what time the last commit on
>> that branch was made (in CVS) thus allowing incremental updates.
> 
> you can use it in --format as well.

Unfortuantly, for-each-ref only offers us the textual version of this
information not the numeric offset from the epoch which is what
cvsimport is after.

I guess we could teach for-each-ref to output this as well?  Perhaps
something like authorstamp?

-apw
