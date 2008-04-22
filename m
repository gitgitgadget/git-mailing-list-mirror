From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Git on Windows, CRLF issues
Date: Tue, 22 Apr 2008 12:51:14 -0400
Message-ID: <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
	 <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness>
	 <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com>
	 <20080422023918.GA5402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Peter Karlsson" <peter@softwolves.pp.se>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 18:53:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoLjB-0004df-6g
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 18:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbYDVQvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 12:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754944AbYDVQvS
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 12:51:18 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:40435 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754246AbYDVQvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 12:51:16 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3215829fkr.5
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xyVj9iadIko5zFBkP2WejqQxf3fbCGnVkOdTPs7lFpA=;
        b=fZ/BhbN9T48Zmq27eTXz0eRKqo3Oj0vCQeSZx+tbE2RlrRXZGf44O+YTXehLdmUzSoSE9h3yb0pz0a+7eN0uIqqkJimtJTdwxkAm1doSHQ8/NhpmtwZ5vmBBE5/nOHAY5/JthEwkJ9L+U9LSQjqbHxHvPxvdKKUyqjuTPMDozX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jujhSX9JzyXaQsMIO7IPIWqmPUaKpA4FWlf3hCTjlZm4grZrBzEhoratPpPhVpzU2EiQYkyDm1BHNNU9lzjvSPUze3011SEARM+4wPVpuzxeAi4OzDYy+cFfS7e06bZPurCcjgtzL8m1Ay0zIiJ8b41OlSf7qZ6ORwOgY8Vqv/4=
Received: by 10.82.185.3 with SMTP id i3mr69816buf.15.1208883074146;
        Tue, 22 Apr 2008 09:51:14 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Tue, 22 Apr 2008 09:51:14 -0700 (PDT)
In-Reply-To: <20080422023918.GA5402@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80134>

On 4/21/08, Jeff King <peff@peff.net> wrote:
>  You could maybe do an index filter that gets the blob SHA1 of each file
>  that is new, and just munges those. But I think it is even simpler to
>  just keep a cache of original blob hashes mapping to munged blob hashes.
> [...]

Thanks, this is really cool.  I'll try it next time I'm messing with
our repositories (this week is unfortunately a bit too busy).

Do you think git would benefit from having a generalized version of
this script?  Basically, the user provides a "munge" script on the
command line, and there's a git-filter-branch mode for auto-munging
(with a cache) every file in every checkin.  Even if it's *only* ever
used for CRLF, I can imagine this being useful to a lot of people.

Thanks,

Avery
