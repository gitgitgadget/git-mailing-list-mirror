From: Nix <nix@esperi.org.uk>
Subject: Re: git-pull followed by git-gc often yields *much* bigger pack than git-pull alone
Date: Wed, 12 Dec 2007 22:06:17 +0000
Message-ID: <87r6hrwoti.fsf@hades.wkstn.nix>
References: <20071212215303.29921.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Wed Dec 12 23:07:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ZjC-0003mw-8D
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 23:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbXLLWGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 17:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbXLLWGe
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 17:06:34 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:46417 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbXLLWGd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 17:06:33 -0500
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id lBCM6Ibk030032;
	Wed, 12 Dec 2007 22:06:18 GMT
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id lBCM6HS4001650;
	Wed, 12 Dec 2007 22:06:17 GMT
Emacs: a Lisp interpreter masquerading as ... a Lisp interpreter!
In-Reply-To: <20071212215303.29921.qmail@science.horizon.com> (linux@horizon.com's message of "12 Dec 2007 16:53:03 -0500")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-dcc1-Metrics: hades 1182; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68104>

On 12 Dec 2007, linux@horizon.com verbalised:

> Pre-gc:
>> -r--r--r-- 1 compiler hackers   12080 2007-12-12 20:35 pack-f534c957f3ee7f3f1046dee0081fcc315d9698bb.idx
>> -r--r--r-- 1 compiler hackers  678643 2007-12-12 20:35 pack-f534c957f3ee7f3f1046dee0081fcc315d9698bb.pack
>
> Post-gc:
>> -r--r--r-- 1 compiler hackers   20912 2007-12-12 20:36 pack-5145ce9770077cee99795fc21cfcc6ea30eb6d47.idx
>> -r--r--r-- 1 compiler hackers 1144055 2007-12-12 20:36 pack-5145ce9770077cee99795fc21cfcc6ea30eb6d47.pack
>
> The fact that the index file has grown so much indicates that it's sucking in a bunch of
> extra objects from the .keep pack, and you're seeing the duplication.

I thought it had to be doing that (hence the increase in object counts
given by the git-gc runs), but wasn't sure if this behaviour was
intentional.

> I'm not sure how that's happening, though.  I thought the --local flag to git-pack-objects told
> it not to do that.

This isn't true if alternates are in use, but this repo is alternate-free.

-- 
`The rest is a tale of post and counter-post.' --- Ian Rawlings
                                                   describes USENET
