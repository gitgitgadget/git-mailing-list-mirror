From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] git-sequencer.txt
Date: Tue, 10 Jun 2008 08:17:41 +0200
Message-ID: <200806100817.42495.jnareb@gmail.com>
References: <20080607220101.GM31040@leksak.fem-net> <m3d4mqwnxh.fsf@localhost.localdomain> <20080610012159.GI8079@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 08:19:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5xBy-0007XL-3w
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 08:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbYFJGR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 02:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbYFJGR4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 02:17:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:60814 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbYFJGRz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 02:17:55 -0400
Received: by ug-out-1314.google.com with SMTP id h2so24053ugf.16
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 23:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lHS4LM4kpfnKWquMBVld48MKnZ1ai45EI2IlwjCG58o=;
        b=UUYrYhkQIA3DWWKvnaMYutR+qrDTqLgZbqst3TtU+xdNspsmlp4wncI37UPtOao8Uv
         Pdeky0BRiT1oi9hUcXlKnR4FMAWjgBzKVDnP6FAbcgLOz5hFQOPpKpuoTCgrcyOOU4xp
         TB0/1LsGNvD8aAAqrxSghmkhxJDcTw1WzKfTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dr8KcxaIr6qAn356d3KRM2kuBk7WrbhRtvIwpdXhjLl1Ce9PmD+0nVhxMxRiSAHAyK
         d+sMPfG2z5oYKgMNd5VPBMnHSaBYBngrI92LnVj+Qx9TfK2bLD/FxpCDmredDS/ITneg
         O/jn+Ei4IBxvGJW+9P6k64tdTEBbMl6V9ei0w=
Received: by 10.67.116.6 with SMTP id t6mr200048ugm.76.1213078673346;
        Mon, 09 Jun 2008 23:17:53 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.223.181])
        by mx.google.com with ESMTPS id o24sm722827ugd.68.2008.06.09.23.17.50
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 23:17:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080610012159.GI8079@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84473>

On Wed, 10 Jun 2008, Stephan Beyer wrote:

Could you please try not to cut (remove) quotes attributions? It is harder to follow discussion without them...

> Jakub Narebski wrote:

>> Second, about "pick" accepring (I guess) git-cherry-pick options: I
>> would like to have documentation on '--mainline <parent-number>'
>> option in git-sequencer manpage, or at lest explicitely mentioned that
>> it can be used to pick merge commits.
> 
> Btw it is currently pretty stupid and doesn't accept any git-cherry-pick
> options.
> 
> And I didn't know that --mainline exists. I've always thought the first
> parent in the parent list is the "mainline".

It depends on the workflow.  Git tries to not make first parent all
that special.  Due to using fast-forward yourline can actually be
second parent.

Probably better name would be --pick-parent.  Note that without this
option there is no way to "pick", as in pick changes brought by commit,
merge commit (unless you default to first-parent...).

> Well, seems to be an easier-to-use alternative to the "merge" insn if you 
> want to keep the non-mainline parents, commit message and authorship.
> So I think, it's ok to support it ;)

They are two opposite sides of spectrum.  "pick --mainline" is to pick
a merge, "merge" is to create merge commit.  You might want to make
merge into ordinary commit, make ordinary commit into merge, make merge
into merge preserving other parents, make merge into merge rewriting all
parents.

> > BTW, is "pick --no-commit"  symmetric equivalent^W alternative to "squash"?
> 
> Seems that it's yet another variant to realize squash, but less generic
> than the reset --soft ; commit approach.

I'm not sure if less generic.  You can use "pick; squash; squash" or 
"no-commit; no-commit; pick".
-- 
Jakub Narebski
Poland
