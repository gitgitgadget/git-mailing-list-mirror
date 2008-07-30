From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [ANNOUNCE] GitStats development finished (WRT GSoC)
Date: Wed, 30 Jul 2008 17:41:56 +0200
Message-ID: <bd6139dc0807300841n3e1670cdie2cd3fec47ab0db4@mail.gmail.com>
References: <bd6139dc0807291511v2d70d549r3682291eb10a745d@mail.gmail.com>
	 <7vabfz97fl.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0807300212r67ccb849i542e490c8cd00953@mail.gmail.com>
	 <alpine.LSU.1.00.0807301621570.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailinglist" <git@vger.kernel.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"David Symonds" <dsymonds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Sam Vilain" <sam@vilain.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 17:43:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KODpz-0003tp-Mg
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 17:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758701AbYG3Pl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 11:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758663AbYG3Pl7
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 11:41:59 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:37200 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758064AbYG3Pl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 11:41:57 -0400
Received: by wf-out-1314.google.com with SMTP id 27so117159wfd.4
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 08:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BmYHBLkrNjg5engXMMIRrZsIb03JqqIo+1AK5VddPR4=;
        b=mkoGjdw4t3loXkofanabXnzh0z7GgQdxbn9RdYdF7oHkwdCNg3QMGSXJ768w99CUMR
         3L5zmuqW2XyxPUtVtgJprgB+etNneeEOJcWvpFzdBSy/WKZDmjQCRhPb9/muzYHuiQEV
         pWNnZCbHHzxMHNhrCgIyjgTlcF7er8ikeGLvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=NzWyM1lQxLyiY3eLe6H/63eUly2ZlzHfeQan8oQrVBAupZPgZICTrajUhFBxeWi+lS
         7P9tO5g6yvbcW5DO47+6sKrESM+rb353+kk2V3VdD3dCdZiftwflWKmg3zOJbFyyr2FP
         O/D6FdcOmt7ytUvioQ8Vo9sW0k1Ynr0dCms5w=
Received: by 10.142.230.11 with SMTP id c11mr2771490wfh.302.1217432516624;
        Wed, 30 Jul 2008 08:41:56 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Wed, 30 Jul 2008 08:41:56 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0807301621570.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90807>

On Wed, Jul 30, 2008 at 16:22, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 30 Jul 2008, Sverre Rabbelier wrote:
>> Hehe, don't expect too much of it yet though (the 'bug' module that is),
>> there won't be any "99% of the bugs come from Dscho" yet :P.
>
> So what should I expect?  What does it show?

Atm I have 4 'metrics' (4 out of the 5 suggested ones), namely:

* Does a commit belong to a specific branch. This can be used, for
example, to mark commits on 'maint' as bugfixes with 99% reliability
(you need to make sure your regexp catches all branches you are
interested in, when Junio splits of '1.5.6.4' of maint, it might list
'1.5.6.4' instead of 'maint', as they both point at the same ref).
* Does a commit fully revert another one (e.g., make commit A, do 'git
revert A', it will detect that commit as reverting A).
* Does the commit message match a certain regexp (e.g., if it contains
the word "fixes", it is likely a fix).
* Does the commit diff match a regexp (e.g., a change from
"test_expect_failure" -> "test_expect_success")
- (not tweaked yet) Does a commit partially revert another one, this
needs some tweaking, otherwise small changes are quickly seen as
similar. (If you have two unrelated one-lines, and you set it to
ignore one difference...)

You have to configure a few things to get it running (for example, you
need to tell it what branch is your maintenance branch, if any). You
can also configure how valued each metric is (you can say "if it's in
'maint', add 5 points, but if it's a revert, add 10, and add only 1
point if it matches this regexp). Configuration is trivially done with
'git config GitStats.key value".

(Will add the above to the bug module's documentation)

If anyone comes up with any more metrics to determine whether
something is a bug it can be easily hooked in.

-- 
Cheers,

Sverre Rabbelier
