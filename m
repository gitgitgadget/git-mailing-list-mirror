From: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: dangling blob which is not dangling at all
Date: Wed, 1 Aug 2007 09:42:37 +0200
Message-ID: <20070801074237.GA14790@raptus.dandreoli.com>
References: <20070801013450.GA16498@raptus.dandreoli.com> <alpine.LFD.0.999.0707311914570.4161@woody.linux-foundation.org> <20070801063209.GA13511@raptus.dandreoli.com> <7vhcnjbtpt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 09:43:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG8rB-00055Q-Tp
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 09:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758569AbXHAHml (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 03:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757130AbXHAHml
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 03:42:41 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:53272 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757272AbXHAHmj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 03:42:39 -0400
Received: by fk-out-0910.google.com with SMTP id z23so115038fkz
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 00:42:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=BD+bFZO4nqnzbL/wPOBTOD+rQ86UnIJYsWis4y8L5CcexfcXs4R4jx8XHu5++Ry43boRLBWGOSujLg6GiTIGj1fOicBasDMKwjx2f0LdhEK3Lz3Laar/fKfKahMeAt9bhJxUjawCXY8241lKEjlrknD2dppe0WIyh97LShWaRxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=M+hgbYJ83y2/MDEZj+PkhMr+63lXh1RaaYamuKoaSVit+qfGIoHBiTmzd1TrjBskrYUZvQoVXBJASkA2h4i5OaPVw+BSC35RbfuHJGilsRnRvE5leZgE4QR4OMvK3Zn+gPssOmA3razVJ+o0Hzr2/IdnBgRXRLQ0QzRNgVClkgQ=
Received: by 10.86.1.1 with SMTP id 1mr368168fga.1185954157156;
        Wed, 01 Aug 2007 00:42:37 -0700 (PDT)
Received: from raptus.dandreoli.com ( [159.149.71.27])
        by mx.google.com with ESMTPS id 22sm872413fkr.2007.08.01.00.42.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Aug 2007 00:42:35 -0700 (PDT)
Received: by raptus.dandreoli.com (Postfix, from userid 1000)
	id A527A84563A; Wed,  1 Aug 2007 09:42:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhcnjbtpt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54414>

On Wed, Aug 01, 2007 at 12:27:10AM -0700, Junio C Hamano wrote:
> Domenico Andreoli <cavokz@gmail.com> writes:
> 
> > This fixed things and also warned about two heads referring to pruned
> > commits, which may be those two commits I removed by hand (I hope).
> 
> Exactly.
> 
> All refs under .git/refs (the special case of this includes the
> branch heads in .git/refs/heads) are your _promise_ to git that
> everything that is reachable from them are supposed to be
> available in your repository.  If you remove specific commits by
> hand without adjusting the branch ref, you are breaking that
> promise and git-fsck will notice it as a repository breakage.

If I move any ref by hand (not that I pass the day doing this..), I
understand that some commits may suddenly result as unreachable. But
those commits I removed by hand were already unreachable so no refs
should have been referring them.

What is this reflog thing and why is required?

Domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://www.dandreoli.com/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
