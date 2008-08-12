From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: Allow missing base objects when creating
 thin packs
Date: Tue, 12 Aug 2008 14:12:30 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808121402440.22892@xanadu.home>
References: <20080811182839.GJ26363@spearce.org>
 <7vk5enuqfg.fsf@gitster.siamese.dyndns.org>
 <20080811224404.GQ26363@spearce.org> <20080812012859.GT26363@spearce.org>
 <alpine.LFD.1.10.0808120023250.22892@xanadu.home>
 <20080812164149.GB31092@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 20:13:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSyNN-0004di-UV
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 20:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbYHLSMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 14:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbYHLSMh
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 14:12:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44867 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbYHLSMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 14:12:37 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5I00MSG2KUXQC0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Aug 2008 14:12:31 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080812164149.GB31092@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92123>

On Tue, 12 Aug 2008, Shawn O. Pearce wrote:

>  Now with a test! :-)
>  
[...]
> +# Clone patch_clone indirectly by cloning base and fetching.
> +#
> +test_expect_success \
> +    'indirectly clone patch_clone' \
> +    '(mkdir user_clone &&
> +      cd user_clone &&
> +      git init &&
> +      git pull ../.git &&
> +      test $(git rev-parse HEAD) = $B
> +
> +      git pull ../patch_clone/.git &&
> +      test $(git rev-parse HEAD) = $C
> +     )
> +    '

What if the first test command fails?  Won't its result be ignored?


Nicolas
