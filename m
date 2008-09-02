From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Mon, 1 Sep 2008 23:13:42 -0700
Message-ID: <20080902061342.GI13248@spearce.org>
References: <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org> <7vwsi0a2op.fsf@gitster.siamese.dyndns.org> <48B784FD.3080005@zytor.com> <7vej488gcu.fsf@gitster.siamese.dyndns.org> <20080829173954.GG7403@spearce.org> <905315640809010905w20f4ceeo43e7b0a14abd48a3@mail.gmail.com> <20080902060608.GG13248@spearce.org> <48BCD899.3010805@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tarmigan <tarmigan+git@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 08:14:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaPA9-0007Zg-24
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 08:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbYIBGNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 02:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbYIBGNn
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 02:13:43 -0400
Received: from george.spearce.org ([209.20.77.23]:50480 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbYIBGNn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 02:13:43 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 64EB838375; Tue,  2 Sep 2008 06:13:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48BCD899.3010805@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94650>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Shawn O. Pearce wrote:
>>
>> Correct.  Today _none_ of the transport protocols allow the server
>> to force the client to use some sort of reference repository for an
>> initial clone.  There are likely two reasons for this:
>>
>>  *) Its a lot simpler to program to just get everything from
>>     one location.
>>
>>  *) If you really are forking an open source project then in
>>     some cases you may need to distribute the full source,
>> 	not your delta.  You may just as well distribute the full
>> 	source and call it a day.
>>
>
> 3) it encourages single points of failure.

Or bad network usage, as I pointed out later about an India user
unknowingly being forced into a US based mirror when another was
closer to them.

I didn't make it clear in my response but I'm really against our
protocol having this sort of explicit redirect.  I'd rather put a
requirement in that says "Unless you have X,Y,Z in common with me
(directly or indirectly) I'm just not going to give you a pack".

FWIW that fixes an issue for me at day-job that people will be
cursing about later this year in public.  Not my fault.  We would
all rather just publish the entire repository.  Instead we have
to publish something that requires the user to clone it from
another source first, and use fetch or "clone --reference" to get
our updates.  *sigh*

-- 
Shawn.
