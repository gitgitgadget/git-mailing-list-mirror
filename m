From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] add --porcelain option to git-push
Date: Tue, 23 Jun 2009 13:09:56 -0400
Message-ID: <4A410C64.9030903@xiplink.com>
References: <20090622214032.GC19364@coredump.intra.peff.net>	<20090623011001.GA15352@cthulhu> <4A40EF9C.7000706@xiplink.com> <7v4ou79cga.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 19:10:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ9Vs-0003GD-KU
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 19:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbZFWRKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 13:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbZFWRKT
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 13:10:19 -0400
Received: from smtp162.dfw.emailsrvr.com ([67.192.241.162]:39620 "EHLO
	smtp162.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbZFWRKR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 13:10:17 -0400
Received: from relay6.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id BD7F9302BE
	for <git@vger.kernel.org>; Tue, 23 Jun 2009 13:10:20 -0400 (EDT)
Received: by relay6.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 5014430165;
	Tue, 23 Jun 2009 13:10:15 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <7v4ou79cga.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122103>

Both good points.  --porcelain is fine by me.

		M.


Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> Shouldn't this option be named "--plumbing" since it's making 'git push'
>> act like plumbing?  Actually, neither name seems intuitively descriptive
>> to me...
> 
> Perhaps.  But asking for output format designed for Porcelain
> implementions to read with --porcelain option has precedence.
> 
>> Why not teach 'git push' to change its output format if it's writing to a pipe?
> 
> That is ugly.  Besides, "writing to a pipe" would not be a right criteria,
> if you want to do
> 
>           git push >log
>           if grep blah log
>           then
>                 do blah thing
>           fi
>           if grep baa log
>           then
>                 do baa thing, too
>           fi
> 
> When you make a program behave differently depending on where your stdout
> goes, typically you see if it is going to the terminal (e.g. isatty(3)),
> but even then you would need an explicit override from the command line
> when stdout is a tty and you do not want "for humans" frills (e.g. color),
> and when stdout is not a tty and you do want such frills.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
