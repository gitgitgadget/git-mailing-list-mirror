From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Mon, 16 Jun 2008 11:30:40 -0500
Message-ID: <lZpNyxfI-KdPeks7z8vB8LO0LOJTHllWcHbQS34JEY4@cipher.nrlssc.navy.mil>
References: <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com> <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <7vzlpqza0t.fsf@gitster.siamese.dyndns.org> <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com> <7vlk1az8aa.fsf@gitster.siamese.dyndns.org> <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com> <alpine.DEB.1.00.0806130551200.6439@racer> <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com> <alpine.DEB.1.00.0806132239490.6439@racer> <612BAE20-8DF3-43
 23-8AEF-527B92122A7A@wincent.com> <200806142359.m5ENxsBI028758@mi0.bluebottle.com> <7vabhne15k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: =?ISO-2022-JP?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>, Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 18:39:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Hk8-00014C-10
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 18:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbYFPQir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 12:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754187AbYFPQir
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 12:38:47 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56638 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbYFPQiq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 12:38:46 -0400
Received: by mail.nrlssc.navy.mil id m5GGUfvC014612; Mon, 16 Jun 2008 11:30:42 -0500
In-Reply-To: <7vabhne15k.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 16 Jun 2008 16:30:41.0608 (UTC) FILETIME=[51689480:01C8CFCE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85208>

Junio C Hamano wrote:
> しらいしななこ  <nanako3@bluebottle.com> writes:
> 
>> I apologize for my lack of perfect foresight as the original
>> author of the command.  As I already said, I think expiration
>> period of reflogs that is configurable for each ref as suggested
>> earlier by Junio makes sense.
> 
> You do not need to be overly apologetic.

I whole-heartedly second this.

> ... the
> way for them to thank you would be to scratch their own itch by filling
> the remaining 10% to make it work better in their context, not by bitching
> and quibbling on what the dictionary definition of the word "stash" is.

I think you're being a little unfair here on two points:

 1) I think it is a valid point that the name of the command and it's
    subcommand "save" have contributed to the confusion by those who were
    not involved in the implementation of the stash feature.

 2) A patch _has_ been offered and there has been no discussion of the
    merits of that patch, only on why the stash should be persistent or not.

You have suggested two alternatives, one (--keep) was not commented on
favorably by anyone, and the other was not really commented on at all.

Besides, the point (for those arguing it) was not that users should
have the option to keep stashes, it was that keeping stashes
_by_default_ is the option of least surprise and doing so modifies the
stash behavior to match user expectations. So up until now, there has
been no reason for anyone to offer any alternative patch, since "--keep"
is not satisfactory and per reflog expiration _alone_ does not solve what
people think the problem is (that stashes expire by default).

Your suggestion of per reflog expiration, along with a default
configuration of never for the stash reflog expiration, _does_ solve
the problem. Time will tell if this feature is useful outside of
controlling the stash reflog expiration.

-brandon
