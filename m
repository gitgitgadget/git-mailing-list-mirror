From: Richard Maw <richard.maw@codethink.co.uk>
Subject: Re: Some issues when trying to set up a shallow git mirror server
Date: Fri, 8 Jan 2016 10:19:03 +0000
Message-ID: <20160108101903.GC3397@logi.codethink.co.uk>
References: <20160107165417.GB3397@logi.codethink.co.uk>
 <xmqq4mep5kyg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 11:19:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHU8h-0006W1-Pe
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 11:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609AbcAHKTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 05:19:12 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:56907 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbcAHKTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 05:19:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 92B1A461A61;
	Fri,  8 Jan 2016 10:19:07 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Soj8tAF4LX2; Fri,  8 Jan 2016 10:19:05 +0000 (GMT)
Received: from logi.codethink.co.uk (unknown [10.24.1.141])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id F28F9460245;
	Fri,  8 Jan 2016 10:19:04 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqq4mep5kyg.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283531>

On Thu, Jan 07, 2016 at 10:00:07AM -0800, Junio C Hamano wrote:
> Richard Maw <richard.maw@codethink.co.uk> writes:
> > This is inconvenient for us,
> > as we were explicitly using refspecs which didn't force the fetch,
> > since we were using the "non fast-forward update" errors
> > to detect whether upstream force pushed important refs
> > which could be a sign of tampering.
> >
> > While the client doesn't have enough information
> > the server has those commits.
> > Would it make sense for the server to be able to tell the client
> > "trust me, that commit is a descendant of the previous one"?
> 
> It does not in our security model, as you do not blindly trust the
> other side, whether you are a "client" or a "server".

Fair enough.
I didn't know whether Git passed responsibility for that to the transport layer.

Would a mode for fetch to also include the commit chain without the trees fit
the security model?
