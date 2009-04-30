From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: question about a merge result
Date: Thu, 30 Apr 2009 17:05:19 +0200
Message-ID: <38b2ab8a0904300805j5ce19617mdda3254c37d06d38@mail.gmail.com>
References: <38b2ab8a0904300521m9e31867j7848135acfae0faa@mail.gmail.com>
	 <49F99AE3.5090406@gmx.net>
	 <20090430142635.GB23550@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Gaber <Michael.Gaber@gmx.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 17:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzXq5-0001Zv-Gx
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 17:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762996AbZD3PFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 11:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763930AbZD3PFW
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 11:05:22 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:60241 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763665AbZD3PFU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 11:05:20 -0400
Received: by fxm2 with SMTP id 2so1872941fxm.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Zp/OXOSmNxCKkZKHCC1nJonVnQV9uZnMss1wnbfbSNg=;
        b=xumRleOkVNPfnfSuXUiSb8THX1gFnVO3ONhTC3UdxcPq6oU6V9Kj4vER9X3A/1Qz3e
         sxQ1ftslTnStZgTz74gP3pkku+ubbvUPilJEaFauy58ooFjJVZaIqL8yQ/QxpvMoeAFk
         DXetRs+yZ3sgpRQfa/shyHxTPbqVVEfw1mNvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vhB6L62bIlUnWQNNKlfmVdZAyO7jYC71H1Xgcb2axpco4Js0I8SnpWVZnIYj7vbesU
         MAxSJBzUcl6Jf1Jg72KvvpsA/3btLxi26ijoPv6OgyyMADSFq6fcMMXSk1TGe2fe+ApS
         fZZ8DmFVfDd5jzVLWcXnZfa1aldx+sdLT1lyM=
Received: by 10.103.182.3 with SMTP id j3mr1015346mup.107.1241103919425; Thu, 
	30 Apr 2009 08:05:19 -0700 (PDT)
In-Reply-To: <20090430142635.GB23550@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118024>

On Thu, Apr 30, 2009 at 4:26 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 30, 2009 at 02:34:43PM +0200, Michael Gaber wrote:
>
>> > So merging 'b1' into master removed the B file even if in branch 'b1'
>> > I restored it.
>> >
>> > Could anybody explain me why this is the correct behaviour and why not
>> > file 'B' is not restored as it was done in branch 'b1' ?
>>
>> well, I'd say the thing is, that in b1 there is no change at all to the
>> tree anymore, so when applied to master (without B) there is no b restored
>
> That is exactly it. Git's 3-way merge doesn't look at the intervening
> history at all. It looks _only_ at the two endpoints and their
> merge-base (well, that is a bit of a simplification, as there may be
> multiple merge-bases, but it is what is happening here).
>

Well, obviously it's how git works since it's what I got.

But the question was more about if the cortectness of the end result:
should 'B' removed after the merge.

IOW if someone works on its own branch remove B file and thought it
was a bad idea and restore it whereas another person remove B file but
miss the fact that it was a bad idea, does the merge should silently
remove B file ?

-- 
Francis
