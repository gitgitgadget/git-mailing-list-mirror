From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 13:48:08 -0500
Message-ID: <76718490902161048i3c19bb43h30b1cfc62dd9a61e@mail.gmail.com>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
	 <20090216000443.GB3503@coredump.intra.peff.net>
	 <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm>
	 <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
	 <alpine.LNX.1.00.0902160322530.19665@iabervon.org>
	 <7veixybw7u.fsf@gitster.siamese.dyndns.org>
	 <loom.20090216T101457-231@post.gmane.org>
	 <20090216135812.GA20377@coredump.intra.peff.net>
	 <49999ED6.7010608@gmail.com>
	 <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 19:49:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ8XE-00023j-Jg
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 19:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbZBPSsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 13:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbZBPSsK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 13:48:10 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:50964 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbZBPSsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 13:48:09 -0500
Received: by rv-out-0506.google.com with SMTP id g9so1143323rvb.5
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 10:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vwdrRDgxn/UCo9eOA3pNjuaqJQEjbM1CmnJGvvvFfkE=;
        b=k5dgeU9Ar8cafTKWppNyObH08QiBUcu3U1E+C+pwbURmMBsLqaVuEcWotrzq2l+OtF
         MVfEw/66At977fmI0g/FHhNYytiXb/Zgp0Rp049H7aXyOtzG7zBaq/eFjYS9BWgmXxM/
         89tcdWrIKhSkqVkUt+LS6Olm0QcwwUrMpQizA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pRvifLR+zv/PpuYQLRhwlvgzVtMBRFwppEVziSdWyqrqoPfdKy8DKrbFJv1pmpaFOQ
         zt9VN4elL5G1vosucu96+R/dHZzNCliKoMfcSvCKSEojmJqJwI7zr1Q9MANooClgCanc
         UvFXFXF+XPxUAQ98V1LIvE0veUdQu4K8gXkSc=
Received: by 10.140.127.13 with SMTP id z13mr2805558rvc.145.1234810088210; 
	Mon, 16 Feb 2009 10:48:08 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110227>

On Mon, Feb 16, 2009 at 12:43 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> And of course, you need a way to show the user all the updates the branch
> went through while the HEAD was detached, so that the user has a chance of
> understanding what happened in the meantime.
>
> So much additional work, just to fix up the shortcomings of the 'detach'
> paradigm?  I take it as a clear mark of a not-so-elegant design.

You did plant a seed in my head with PUSH_HEAD though, and I'm still
thinking about it. :-)

I think the right thing is *not to detach*, but rather when pushing
into a non-bare repo for it to go into refs/remotes. Too bad clone
doesn't set it up this way by default when cloning from a non-bare
repo[*]. That would probably make more sense for new users.

[*] Clone can't currently know it's cloning from a non-bare repo, at
least via git://, as I recall...

j.
