From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: RFE: "git bisect reverse"
Date: Sun, 31 May 2009 23:41:47 +0100
Message-ID: <efe2b6d70905311541y2576ef0enc66d619672d4ef34@mail.gmail.com>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net> 
	<4A1CBF7A.3090708@zytor.com> <200905270726.59883.chriscool@tuxfamily.org> 
	<efe2b6d70905271411g4e1616b5w548141ee9fab2c14@mail.gmail.com> 
	<20090527211836.GA14841@localhost> <efe2b6d70905271507s187babe9yf19a25268ab0b95e@mail.gmail.com> 
	<4A1DC7D8.2050601@vilain.net> <efe2b6d70905281329s1ae5a94coe5875714f341d5a9@mail.gmail.com> 
	<4A1F628F.9010407@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Christian Couder <chriscool@tuxfamily.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 00:42:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAtjO-0002I6-GD
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 00:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbZEaWmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 18:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbZEaWmI
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 18:42:08 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:55222 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbZEaWmG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 18:42:06 -0400
Received: by ewy24 with SMTP id 24so7470839ewy.37
        for <git@vger.kernel.org>; Sun, 31 May 2009 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IRmttcDta7qB1d9U/g59+c+G5VVmYdg2WXBtGVx5u/M=;
        b=v9dcp6jpcbFtnfwybV60ZZ7eMb3PMWH9Bjb32AwbtExUVcQwuUm/MU8rCcbhymtJgn
         aYneT5bJj7iiF6Qx9vJ4scxjffAUuj/+61c7BRMtZsLlof15+os+TlwaCROe5ktiTLNR
         ifgV4Lk3g8RIGBMLas/FYNplatjDwv5aACmxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jU04dUP16eNMloHMOJVNqDPP5zWRCAy+JcrTWF1BJ5a9CyH6S2h/ZSxJUHy7eeNlp2
         /kMKzGotZsSc6NcpHQX2yhsFsmk0+7QmDEzXd6EqlwwPsdKdP9jh/zdi5BWmWzYJwjvv
         4mqJzH+D/58snlWnmPz335AsPXtUMn3B7/S+k=
Received: by 10.216.11.137 with SMTP id 9mr1626309wex.180.1243809727104; Sun, 
	31 May 2009 15:42:07 -0700 (PDT)
In-Reply-To: <4A1F628F.9010407@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120435>

On Fri, May 29, 2009 at 5:20 AM, Sam Vilain <sam@vilain.net> wrote:

>
> I mean, can you port your algorithm from python to the git-bisect C
> source and therefore make something of benefit to existing 'git bisect'
> users ?

I haven't really looked at the git bisect code yet, but the algorithms
are so different that it would likely make the most sense to just add
my algorithm in parallel, rather than trying to combine them.
(Although my algorithm can handle the deterministic case as well,
you'd want to keep the original one too, because mine starts to get a
bit sluggish deciding which commit to test for larger commit ranges. )
It could still be driven by git-bisect script, though.

Converting it to C wouldn't be a trivial task, though, so I may not
get around to it. I'll probably write a more git-like frontend, and
maybe submit a patch to add it to  the contrib directory, to get a
better idea of whether
there are actually any users for this feature, before deciding whether
to do the conversion.

Ealdwulf
