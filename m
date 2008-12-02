From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: Re: more merge strategies : feature request
Date: Tue, 2 Dec 2008 09:28:41 -0500
Message-ID: <81bfc67a0812020628l53c209a6yca5a619d211b6bfc@mail.gmail.com>
References: <81bfc67a0811290848m6cb219c0y71a7266001096f2d@mail.gmail.com>
	 <4933AC03.6050300@op5.se>
	 <81bfc67a0812011838m68100020v727da1c06f0bcee4@mail.gmail.com>
	 <20081202033013.GD6804@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 15:30:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7WGH-0004Mj-U0
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 15:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbYLBO2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 09:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbYLBO2n
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 09:28:43 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:8524 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbYLBO2n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 09:28:43 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2992076rvb.1
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 06:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5+6MfFKcAzJ7EwQyOb+xh2SFa0LWwXk6qLHTUQK7Djo=;
        b=nAyKJ7eplNwrScKuGUGL48OebyETOlpoyA1+KbOnwtnNKX51NZcnMFakam90UGl9hC
         n8JTbC6SGsCnyi4dKPOp7E3Blw0DbtOzUZt9lu5emam4XIQF5ueI2wbCQjQ46xiDBjRs
         5uL61dPxHxw7fC4o1/leDzb8SgqHuEM9zIaDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PtgzLr6+upbeSujAeRTHQunJG2R8xHcHjFyBcAbb8qIuSIwisU1Ya3BpSSp8st/hbS
         GbsS6q8bVvgzVorg2w0Nnxxb5//PIwshWN4PMSXMj86JNIaQtMbNVRLpYK5529Z6+1qD
         mr7hiaPc2YPxU3yQjovXNOr60TGecsQUxhuHc=
Received: by 10.141.43.5 with SMTP id v5mr5765312rvj.281.1228228121442;
        Tue, 02 Dec 2008 06:28:41 -0800 (PST)
Received: by 10.141.145.7 with HTTP; Tue, 2 Dec 2008 06:28:41 -0800 (PST)
In-Reply-To: <20081202033013.GD6804@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102136>

>
> It's not clear to me exactly what you want. Let's say I have a file
>  ....

I'm afraid I don't fully understand your example


lets say git merge foo bar
foo          bar
1             1
2              8
3              3
4              4
5              5
6
7

lines 6 and 7 are new in foo line 2 has a conflict because the other
head has an 8, history wise because of an early merge the other
direction and fix, there was the 8 in foo and it was changed to a 2,
when I merge back it will overwrite the 8 with  a 2. however I need
the 8 to be the 8 and the 2 to be the 2. but I want the 6 and 7 in
both.

conflict would create a conflict

such as

foo
1
<<<<<< bar
8
======
2
>>>>>>  foo
3
4
5
6
7

no overwrite would result in file1 looking like this

1
8
3
4
5
6
7

>  Did you want conflict markers in the resulting file? If so, what should
>  the conflict markers look like, since there isn't actually a conflict?

if the the remote and local branches are not identical there's a
difference which should be able to result in a conflict. for all
purposes I'm not sure git couldn't just ignore the history of the
files and do a straight head to head merge.  the steps you suggest
make it more complicated than it needs to be an if done post merge or
without merge will probably be need to be done again in a future merge
if merging back and forth


-- 
Caleb Cushing
