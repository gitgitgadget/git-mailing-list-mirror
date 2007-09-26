From: Russ Brown <pickscrape@gmail.com>
Subject: Re: Workflow question
Date: Tue, 25 Sep 2007 19:01:02 -0500
Message-ID: <46F9A13E.4000608@gmail.com>
References: <46F93A99.5080707@gmail.com> <46F95CCC.4080209@op5.se>	<46F96493.8000607@gmail.com>	<20070925201717.GB19549@segfault.peff.net>	<46F97618.9010207@gmail.com> <7vabra5tah.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 02:01:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaKLF-0001DF-KL
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 02:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbXIZABL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 20:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbXIZABL
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 20:01:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:62614 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbXIZABK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 20:01:10 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1643027wxd
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 17:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=BlCvFPYqzLQxEo1kihZU7zlKnPVlc86dDljxx6oTmq0=;
        b=VFMs2k7LkjRgRqDH41tx/508i1K3EzSoOlkKk2GLob/DvHWs7ydUdiflfGPPVVwFXX3kUzgQmL7Ah9Iq0HrT2C5ZyDMFO2SoseHrhic8oDeywvK9oQ9hYKvpvwlk/ja9MaFccCA1RYpxV+UtggaoSX985uWLperPxK5/Nzc2B5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AQIOKMYB4gNj9Ht0KGP1YOLyeGLJ7qotZle7HrBG4IOIoE0p0dFeWL55hJiPb52xQGXor3bHV01iKlKqvYkdRtfE66pJhiNDv52d2wJ9I4cul1vbsiUBHTEtgjQothmAzx/AC2lE75MbiPElMRMB9Vn3qO2+dkkabU35gsRacA8=
Received: by 10.90.86.10 with SMTP id j10mr43399agb.1190764869351;
        Tue, 25 Sep 2007 17:01:09 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.252.196.170])
        by mx.google.com with ESMTPS id c29sm68510anc.2007.09.25.17.01.07
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Sep 2007 17:01:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
In-Reply-To: <7vabra5tah.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59197>

Junio C Hamano wrote:
> Russ Brown <pickscrape@gmail.com> writes:
> 
>> I keep reading things similar to this and bit by bit I'm starting to get
>> it. :) I suppose this is one case in which it's definitely a
>> disadvantage to have a good understanding of svn before coming to git...
>>
>> <yoda>You must unlearn what you have learned</yoda>
> 
> You do not have to unlearn; if Jeff truly unlearned he wouldn't
> have spotted you were trapped in SVN mentality.  You just need
> to learn there could be other ways ;-).
> 

I suppose what I really mean is you need to stop assuming what you've
already learned. :)

>> If you delete a branch that has commits on it that aren't referenced by
>> any other branches, will those commits be removed by something like git
>> pack or git gc?
> 
> Yes, eventually.
> 
>> I suppose what has me the most confused is how a developer works with a
>> remote branch: I've come to understand that a developer should never
>> check out and work on a remote branch, and always create a local one and
>> work on that. If he does that using the above hierarchy, there then
>> becomes main->projectX->featureY->jeff_local_branch_of_featureY. Or is
>> is possible for a developer to work directory on a remote branch?
> 
> The statement in the last sentence does not make any sense.
> Remote is called remote because it is remote and supposed to be
> out of reach ;-)
> 

Ah. I think I was a little confused by the fact that git does let you
checkout remote branches, through I see that it does warn you about it
when you do it.

> More seriously, remotes are used as reference points so if you
> "work directly on them", you cannot use them as reference points
> any more; you defeat the sole purpose of existence of remotes.
> 
> You can work _without_ using remote tracking branches, but that
> is mostly for merge based workflow.  It appears that you are
> leaning towards rebase-heavy workflow, so I do not think it is
> applicable to your project.

Right, I think we're going to be aiming for that, though as I say I'm
going to be experimenting a bit to see how things work when using both
approaches.

Thanks.

-- 

Russ
