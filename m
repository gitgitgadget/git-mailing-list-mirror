From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] New commit object headers: note headers
Date: Mon, 11 Feb 2008 11:08:30 +0100
Message-ID: <200802111108.31828.jnareb@gmail.com>
References: <200802091746.09102.jnareb@gmail.com> <200802100026.39340.jnareb@gmail.com> <alpine.LSU.1.00.0802100106330.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:09:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVbF-0001sk-JL
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbYBKKIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 05:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbYBKKIq
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:08:46 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:16795 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbYBKKIp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:08:45 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3751454fga.17
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 02:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=eZ7pH6j1AecZXow5IrY35ftCylPuhM9BErNobH04xlQ=;
        b=wrApYRPGI4JUpR2n6MMcHjJnSsFwt8XfOqir8JG7D1TIUNdSSfr62CKQW/kOVQUKyMQVo5/XrhyeK6LMTuhhbD8Ju085rfyKAE96HSDddVO4bS2FHR4IxrN4FOedSlN5A0llqXZnq2HTZqMxV4tVYppdrZOf5xuXWb7meHXdAgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=L6B3h8kHELW3+Gp/JSfdSxdW2PKQVCxUlHOxzzYr2xgwSGG1GyHqZvkuoMuMlvLfDsKfhVHIQcyDvKnRRzWKuabeq5scgQeQ+9dsKntLE0G4Qw7FugJg89N3HgLJxJ+IjwjMLoEdg2oQDOJYKf/BzUXCfR3QsuvapAT9yMJsidM=
Received: by 10.82.187.2 with SMTP id k2mr29163970buf.16.1202724523149;
        Mon, 11 Feb 2008 02:08:43 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.19])
        by mx.google.com with ESMTPS id g11sm8553762gve.6.2008.02.11.02.08.40
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 02:08:41 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802100106330.11591@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73498>

On Sunday, 10 February 2008, Johannes Schindelin wrote:
> On Sun, 10 Feb 2008, Jakub Narebski wrote:
> 
>> Still I think it is would be nice to have original commit id in a header 
>> when importing from foreign SCM. First, it would not pollute commit 
>> message, which would be identical with the original commit message 
>> (which allows easy two-way interaction). Second, it is much easier and 
>> much less error prone to extract it by machine.
> 
> I cannot agree to either reason.  It is _not_ a git specific header, so it 
> does not belong in the commit header.

Well, that, and the fact that the same commit imported using two
different tools, one using this header and one didn't would result
in different commit object... although if they differ in adding
original revision id to the commit message commit objects would
differ too.

> Also, I find it does not clutter the commit message _at all_, but adds 
> information that the user might find useful.

Revisions ids can be long, and together with prefix introducing
original SCM revision identifier be longer than customary 80
characters.

Besides, "git cherry-pick" was changed to _not_ add information
about original commit id by default. Shouldn't this apply also
for import?

> Lastly, I cannot see _any_ reason why it should be _easier_ or _less error 
> prone_ to put an "original commit id" into the commit header than into the 
> commit body.

Well, if commit message talks about foreign commit IDs...

-- 
Jakub Narebski
Poland
