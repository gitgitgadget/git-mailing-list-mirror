From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Rollback of git commands
Date: Tue, 27 Nov 2007 22:55:05 -0500 (EST)
Message-ID: <BAYC1-PASMTP02DBA3FB25E09FE45F0BF2AE770@CEZ.ICE>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com> 
    <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
    <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:21:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKwj-0004hu-0n
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:19:13 +0100
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxE5f-00076e-Kq
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 04:59:59 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxE4Z-0002Yp-1o
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 04:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbXK1DzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 22:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbXK1DzP
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 22:55:15 -0500
Received: from bay0-omc2-s12.bay0.hotmail.com ([65.54.246.148]:33057 "EHLO
	bay0-omc2-s12.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751438AbXK1DzN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2007 22:55:13 -0500
Received: from BAYC1-PASMTP02 ([65.54.191.162]) by bay0-omc2-s12.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 27 Nov 2007 19:55:12 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP02.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 27 Nov 2007 19:55:11 -0800
Received: from apache by linux1.attic.local with local (Exim 4.43)
	id 1IxE0v-00052R-DL; Tue, 27 Nov 2007 22:55:05 -0500
Received: from 10.10.10.27
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Tue, 27 Nov 2007 22:55:05 -0500 (EST)
In-Reply-To: <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 28 Nov 2007 03:55:12.0097 (UTC) FILETIME=[79E25D10:01C83172]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.5, required=5.0, autolearn=disabled, MSGID_FROM_MTA_HEADER=1.495,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: E60CA7B74C080595516AF9E8CD00B2CB5B6AC744
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -54 maxlevel 200 minaction 2 bait 0 mail/h: 40 total 723767 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66297>

On Tue, November 27, 2007 8:33 pm, Jon Smirl said:

Hi Jon,

> I'm only looking for a command that would rollback the effect of
> changes to the object store (you don't have to remove the objects).
> Losing complex staging would be ok since it can be recreated.
>
> Let's take my recent problem as an example. I typed 'git rebase
> linus/master' instead of 'stg rebase linus/master'. Then I typed 'stg
> repair'. The repair failed and left me in a mess. Both of these are
> easy to rollback except for the fact that stg has stored a bunch of
> state in .git/*.
>
> After doing the commands I located my last commit before the rebase
> and edited master back to  it. But my system was still messed up since
> moving master got me out of sync with the state stg stored in .git/*.
> The 'stg repair' command had changed the stored state.

 From your description is seems that Git proper was able to handle the
situation just fine.   It sounds instead like you're describing a problem
with Stg where it became confused without a way to restore _its_ meta
data.  There's not much Git itself can do to help in this situation
unless Stg stores all of its meta-data as standard Git objects, rather
than just using the .git directory.

Sean
