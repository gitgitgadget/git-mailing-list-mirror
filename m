From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP/PATCH 0/4] Re: Making error messages stand out
Date: Wed, 11 Aug 2010 19:58:56 +1000
Message-ID: <AANLkTinxm9Fzwewh2BS0kMxDGG=QKhz3wfVwNikTVZSr@mail.gmail.com>
References: <20100725005443.GA18370@burratino>
	<AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com>
	<201007251122.41166.trast@student.ethz.ch>
	<20100729235151.GB6623@burratino>
	<AANLkTi=ao2RY8NGm4cACqz3_5zfT2zvXB4JHOopBD9T5@mail.gmail.com>
	<20100811083100.GA16495@burratino>
	<AANLkTi=cNUTG-DGZNpwrag9Wz2-JoQQamiayKVNA5wbn@mail.gmail.com>
	<vpqhbj11o9d.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 11 11:59:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj85P-0003bd-Nn
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 11:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113Ab0HKJ66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 05:58:58 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63566 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab0HKJ65 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 05:58:57 -0400
Received: by wyb32 with SMTP id 32so1675043wyb.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=GzSWFPj2s5Hc3VdAFYm2II8fXelO3bjb20wxMpjep28=;
        b=Gg5GpiYWHO0E6q3kgd/heXMddIfpjyg3CNjyNFlYNVI1/yjwopVJB7VNfWl1NSNVq7
         JcNtStO36q/frYKc39xh9/XDIGID1huU89gZMNzLBiDKX7dTQcPpyJ8LYMHJj24tENOb
         dnIrA8FK3wKbGZ0Dkht0e4XYJ6Ry/O+F08WaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GCTV6nf+cacuS0RLtI1ZPMYYh2AZoJF0U0eEBLrr5ECRYilkZSx1PnXXHPs1lI6AXD
         4iofTckYkU8fdKHDbdWIFaMW4nDBc/a+ArxSXWCM8b47ZebQ6jnWdYCLPdiX0uwhfa9r
         2Y29LZRRJBtkVghXgvIeXA8X0mJtHfVnXiU4s=
Received: by 10.216.145.199 with SMTP id p49mr5073458wej.18.1281520736591;
 Wed, 11 Aug 2010 02:58:56 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Wed, 11 Aug 2010 02:58:56 -0700 (PDT)
In-Reply-To: <vpqhbj11o9d.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153222>

On Wed, Aug 11, 2010 at 7:39 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Even better, make it available for some time with, say "git hints".
>> After doing lots of things to resolve conflicts, I simply forget what
>> it hinted me.
>
> Actually, I don't think we should add a new command for that, but add
> something to "git status", like
>
> $ git status
> # On branch master
> # rebase in progress (use "git rebase --continue" to proceed)
> # ...
>
> Same would apply to conflicting merges. It's very common for beginners
> (especially when they come from SVN) to start a merge, mis-read the
> message telling you to commit once you fixed the conflicts, fix
> conflicts, and continue hacking. A message in "git status" when
> .git/MERGE_HEAD exists would help a bit, like (depending on whether
> the index still has conflicts):
>
> # merge in progress (fix conflicts below and commit)
>
> # merge in progress (use "git commit" to proceed)

Yes. Looks good. Except that I rarely use git-status these days. Maybe
that will motivate me to use that command more.

> If one adds an option to make it all-caps, red, and blinking, then
> I'll activate it for my students ;-).

I'd suggest you patch git-status with figlet to get some more attention :-)
-- 
Duy
