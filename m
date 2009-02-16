From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: A little mystery - crash caused by empty commit message.
Date: Mon, 16 Feb 2009 11:18:06 +0100
Message-ID: <1a6be5fa0902160218r65965c18nd3ee90d040702b9@mail.gmail.com>
References: <1a6be5fa0902100315q554dc457j8c8476d3f59a314f@mail.gmail.com>
	 <20090210113234.GE12089@coredump.intra.peff.net>
	 <1a6be5fa0902100458w246f2bfeu5c0c303d18d17a3b@mail.gmail.com>
	 <20090210153048.GA17660@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 11:19:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ0Ze-0007dX-5i
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 11:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbZBPKSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 05:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbZBPKSK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 05:18:10 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:48757 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbZBPKSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 05:18:09 -0500
Received: by fxm13 with SMTP id 13so5546820fxm.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 02:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3xRoufbwZTV7TOHWf6RQH0VB/MZ7HFcYS3D0Bte22eI=;
        b=NggA72q30LytdqjhH84Db/Aabt176uisLH45ZfWsIaMAMMqMWx46+czhVMsq6qftts
         RCybvA3zib12V70Q6abhfyRt+EgpoNj5SssBTWV44wiLQjzcj33DDBC9hYYwxQmM8iZD
         N9OWyUPKpp/Jm1a5DcWBXTEZZA4FGddp85uVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LeWrWhc14ISR210fYemkvA+BBMF40Uv5+D4bgw7TM4nfRTbKlLr6R4Ki2Dr6KV9Ls4
         Fl4fAjx9NiMc67KxI1v49jlSAUQ+9c5kSqiie7GOtblkxfyki7VLoStg494RGV6CUxEt
         sj8Plwyqy33DVeKunckodNKvhY6L/lyimBjhA=
Received: by 10.103.220.18 with SMTP id x18mr2788298muq.38.1234779486690; Mon, 
	16 Feb 2009 02:18:06 -0800 (PST)
In-Reply-To: <20090210153048.GA17660@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110161>

On Tue, Feb 10, 2009 at 4:30 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 10, 2009 at 01:58:43PM +0100, Tor Arvid Lund wrote:
>
>> So - after the "+0100" on the committer line, hd tells me (as
>> expected) that I have 0a 0a before "[HIA]". On the "faulty" commit I,
>> for some reason, have 0a 00 instead. I do not understand why, but I
>> guess strchr will return NULL when "\0[HIA]....." is passed to it, and
>> segfault on the next iteration.
>>
>> So - I am no closer to understanding what got me to this state, but
>> your reply was helpful anyway, thanks :-)
>
> Well, it certainly seems like a bug in one of the history-rewriting
> programs. Can you try rebasing, cherry-picking, etc on the original
> version of the commit to see if you can reproduce the breakage?

Hi, I haven't had much time to test this thoroughly, but my primary
suspect is now git-p4 in conjunction with python v2.6, which I
recently installed. I will try to find some time to investigate
further, and let you all know for sure.

-Tor Arvid-
