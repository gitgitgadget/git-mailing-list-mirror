From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when 
	appropriate to do so
Date: Tue, 6 Oct 2009 11:41:07 +0200
Message-ID: <237967ef0910060241q671baafav93fe6402a4c510c5@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
	 <20091005225611.GB29335@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0910061111410.4985@pacific.mpi-cbg.de>
	 <vpqiqesna6x.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 06 11:47:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv6b2-0001Ee-7f
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 11:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810AbZJFJlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 05:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756805AbZJFJlp
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 05:41:45 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:60172 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756803AbZJFJlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 05:41:44 -0400
Received: by bwz6 with SMTP id 6so3103976bwz.37
        for <git@vger.kernel.org>; Tue, 06 Oct 2009 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=hbV/B6VlMLqDwvf5bzciqtK2tEoi4DwiTG6QpXkjzbw=;
        b=eHDSo+9NjTk5AEGi2Lg9/yHug4Hn2/820H4J1O4eBCwwegz156MmtEbBZ7eRTkxPB6
         lmt8Bswff1dJ/J3ShB2qH8pBcpF2eVJE1Gs9I3R3drQSXvawIIP98hLm4w3eBur28Ziz
         CHKDNf5l/EuJpfa3V0d44r/D/Cs2H8h9z3IS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HKq9957u7mNcmbH4oCiUNnpIva26NKBeXli6AvVdMCkyXFweak97u6smIcfoKIk+Vx
         GynBR625LexUlfzZanyYnmfJnEJsA08f+qw3BvZLdCJtYNipZL0wH8c1TptTRC81wKkN
         u1OC9eu823QN3gP8Xy5qlsYJbZmkE5FYWnNZY=
Received: by 10.204.163.65 with SMTP id z1mr4654829bkx.145.1254822067361; Tue, 
	06 Oct 2009 02:41:07 -0700 (PDT)
In-Reply-To: <vpqiqesna6x.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129615>

2009/10/6 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Hi,
>>
>> On Mon, 5 Oct 2009, Jeff King wrote:
>>
>>> Some devil's advocate questions:
>>>
>>>   1. How do we find "origin/next" given "next"? What are the exact
>>>      lookup rules? Do they cover every case? Do they avoid surprising
>>>      the user?
>>
>> I am sure your strategy would be the same as mine: enumerate all remote
>> branches, strip the remote nickname, and compare.  If there are
>> ambiguities, tell the user and stop.
>>
>>>   2. What do we do if our lookup is ambiguous (e.g., "origin/next" and
>>>      "foobar/next" both exist)?
>>
>> See above.
>
> One problem with this approach is that if users get used to the
> behavior, the command will have great probability to end up in a
> user's script, then the script will "work" as long as there is no
> ambiguity, and cease to work afterwards. And for the user of the
> script, this will sound like "WTF, it was working yesterday and it's
> broken now".
>
> So, the good thing with being strict, even if giving advice in case of
> failure, is that it teaches the user the reliable way to do.

I can imagine this happening:
% git clone git://git.git git
% git checkout next
do you want to checkout origin/next? y
# a few days later
% git fetch
% git checkout next
[freenode] /join #git
[#git] i did git checkout next but my files are still the same?

-- 
Mikael Magnusson
