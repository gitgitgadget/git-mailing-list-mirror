From: Heikki Orsila <shd@modeemi.fi>
Subject: Re: [PATCH] Add --filedirstat diff option
Date: Wed, 3 Sep 2008 03:08:27 +0300
Message-ID: <20080903000827.GB1252@jolt.modeemi.cs.tut.fi>
References: <20080901011259.GA31696@zakalwe.fi> <7vd4jnnifp.fsf@gitster.siamese.dyndns.org> <20080902115848.GA1252@jolt.modeemi.cs.tut.fi> <7vwshuglq1.fsf@gitster.siamese.dyndns.org> <7v3akigl1g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 02:10:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kafwn-0007vg-Qz
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 02:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbYICAJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 20:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbYICAJD
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 20:09:03 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:50516 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbYICAJB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 20:09:01 -0400
Received: from amavis1.cs.tut.fi (amavis1.cs.tut.fi [130.230.4.69])
	by mail.cs.tut.fi (Postfix) with ESMTP id 198CE2A78;
	Wed,  3 Sep 2008 03:08:59 +0300 (EEST)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis1.cs.tut.fi (amavis1.cs.tut.fi [130.230.4.69]) (amavisd-maia, port 10024)
 with ESMTP id 11954-19-6; Wed,  3 Sep 2008 03:08:58 +0300 (EEST)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id 11C902A64;
	Wed,  3 Sep 2008 03:08:57 +0300 (EEST)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id D349322202;
	Wed,  3 Sep 2008 03:08:27 +0300 (EEST)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id B9687A317C; Wed,  3 Sep 2008 03:08:27 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7v3akigl1g.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94745>

On Tue, Sep 02, 2008 at 04:55:39PM -0700, Junio C Hamano wrote:
> realized that I forgot to mention one thing.
> 
> The name.
> 
> "filedirstat" is simply too long to type, and it has a certain "Huh?"
> factor --- is it about file, or is it about directory?
> 
> This option essentially is just the dirstat but with different logic to
> compute how big the damage is.  Conceptually, the original one gives one
> "damage point" to each added or deleted line.
> 
>         $ git show --dirstat=<one-point-per-line>
> 
> and yours awards one point to each file, whatever the size of the damage
> is.
> 
>         $ git show --dirstat=<one-point-per-file>
> 
> I cannot come up with a short-and-sweet name for one-point-per-X offhand,
> but expressing this variant as an option to --dirstat will leave the door
> open for other people to come up with different system to award damage
> points.  Perhaps
> 
> 	$ git show --dirstat=exclude-typofixes
> 
> might even be not just interesting but useful ;-)

I wouldn't add new semantics for --dirstat=x since it's easy to add 
new options. We already have --cumulative, so adding options is not 
new. How about "--dirstat --filemode"? It's long, but it is obvious. I 
don't think length is relevant here. A shorter but obscure syntax would 
be "--dirstat2" :-) 

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
