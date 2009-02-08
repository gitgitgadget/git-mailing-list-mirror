From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: checking sha1's of files
Date: Sun, 8 Feb 2009 07:22:31 -0500
Message-ID: <81bfc67a0902080422s7f12d86ft5196c184c06385f9@mail.gmail.com>
References: <81bfc67a0902080139j1331d967g34bfc18f4068e443@mail.gmail.com>
	 <7veiy9z1v8.fsf@gitster.siamese.dyndns.org>
	 <81bfc67a0902080253x5082201co7da3319b8237f5a0@mail.gmail.com>
	 <20090208111343.GC14359@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 13:25:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW8ie-0001HY-J6
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 13:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbZBHMWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 07:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbZBHMWe
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 07:22:34 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:16718 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbZBHMWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 07:22:33 -0500
Received: by qw-out-2122.google.com with SMTP id 3so881124qwe.37
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 04:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oY6DNDfUsSXP5OwNdf8iJvhCgew9QBXxQs1rYOcpxl8=;
        b=xfu4vwN5LAxmc07gPkgKf5dSmW+inPzUPF8EwuZgtJTwlPHMRW9h9tT1Oe/oGXzv5N
         2BAm2hPVQoOemWvgdmklTWVTg2ErrN3xLKa+0hbn4zT3WoC9NFmz1d2kZwqdbrOK0thg
         XTW2NV1REDngY8xC+GKLR5c5o/6m/BqVWhQHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NzoIp+ZQ6XM5YPnJSRP4xGxDlhv69GjnZtoBPo8sa5mzDwlSoWY0gcjdpNicEvkda3
         oKYwPDmfmX5e2uG0BKl+EPwJ8L8FdvsjoLMnXDjwmzVvjzQWQbhg+qxU5EAyVgnFvPMo
         hTz3HSVAnmbQKUOl7TvwFGklCag1/oHAZP5w4=
Received: by 10.229.82.83 with SMTP id a19mr998546qcl.42.1234095751907; Sun, 
	08 Feb 2009 04:22:31 -0800 (PST)
In-Reply-To: <20090208111343.GC14359@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108966>

> So if I understand you correctly, you would use the former when
> generating your manifests from a revision, and the latter when verifying
> the contents of the filesystem against those manifests.


that sounds about right actually. except there won't be manifests e.g.
I may actually run

find . -name Manifest -exec rm '{}' +

from the root of the tree. (depends on whether I can get rid of
manifesting distfiles, but they don't change so often, so aren't
really a problem).

>  $ git hash-object --stdin < Makefile
>  27b9569746179e68c635bdaab8e57395f63faf01

is there anyway built in way to do that and check to see if the hash
matches HEAD? (before I go and write a string comparison so that it
does)
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
