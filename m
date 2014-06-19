From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] gitk: use mktemp -d to avoid predictable temporary
 directories
Date: Wed, 18 Jun 2014 19:54:07 -0700
Message-ID: <20140619025406.GA8660@gmail.com>
References: <1402695828-91537-1-git-send-email-davvid@gmail.com>
 <87k38ir4p0.fsf@red.patthoyts.tk>
 <20140615163227.GE368384@vauxhall.crustytoothpaste.net>
 <20140615214928.GA619@gmail.com>
 <xmqqtx7kra5x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 04:54:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxSUP-000779-0d
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 04:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757140AbaFSCyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 22:54:09 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:63030 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081AbaFSCyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 22:54:08 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so1324633pdb.39
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 19:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8LI+wrm2g0cNBE3Ugcj7XtrXBVYWSfjuxfVK/OPaiAs=;
        b=XHDn9jpi1+ZLsdpR1VUaYvuroFMV7EAaJ5EA/67DI7RN34Doi6SJMmkPewhMwlcU2Q
         V3eHX21O23+DEEzvnoC8uv8Vk2UN9WiQTU1rA91HxQo6TcVvEjNyWQ2Wz9VgFOjuBW2M
         O5ckFSq/ajrWnLYB13nCU4maxp7kq3ECNCP3kLJHCsZC2ZmvZFgU0gZNnER3y7MxiNyo
         WXNBoTPM6urwLWEvF+mkWtpaXYnT+ac1IBhG/KWPqXzXgbPxHy44ZJjuK1e5lmanPMWr
         1TtDvoEA10mF+U1z4feB1YWFSFpcfc4I3Qdzv4NRJ8kE7w1grsmpMGELxZbYMSR6nmx1
         LhGQ==
X-Received: by 10.68.249.2 with SMTP id yq2mr2181972pbc.70.1403146447464;
        Wed, 18 Jun 2014 19:54:07 -0700 (PDT)
Received: from gmail.com (w.disneyanimation.com. [198.187.190.241])
        by mx.google.com with ESMTPSA id qj3sm5759104pbc.91.2014.06.18.19.54.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 19:54:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqtx7kra5x.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252086>

On Mon, Jun 16, 2014 at 11:17:46AM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > Hmm.. I guess what I could do is keep the old behavior (having gitk ignore TMPDIR)
> > on Windows and only use the new code path on non-Windows.
> 
> Or perhaps attempt to create, catch error and then retry the old way?
> 
> Hopefully Windows folks do not have to worry about forgetting to
> update the codepath when they update their tcl/wish if you did it
> that way, no?

True, that would be the safest. I just submitted a new replacement patch
for these two patches.

Thanks,
-- 
David
