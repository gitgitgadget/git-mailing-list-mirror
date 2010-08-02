From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: jk/tag-contains
Date: Mon, 2 Aug 2010 15:19:20 -0500
Message-ID: <20100802201920.GE2180@burratino>
References: <7vvd7zuecv.fsf@alter.siamese.dyndns.org>
 <20100730183709.GC18544@coredump.intra.peff.net>
 <20100731060703.GA21207@burratino>
 <20100731123328.GA5273@coredump.intra.peff.net>
 <7vocdlpsmw.fsf@alter.siamese.dyndns.org>
 <20100802200209.GD2180@burratino>
 <vpqk4o8bwwd.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 02 22:21:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og1VL-0000mw-HY
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 22:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab0HBUUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 16:20:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59738 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112Ab0HBUUy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 16:20:54 -0400
Received: by wyb39 with SMTP id 39so3668292wyb.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eCmbhdOUSsarDyZV3rja3WrHN/slUCrDw5YFBOHb1Nc=;
        b=Z7hgwpa4SZQgxyzFC1q4Up3cpAAmY/feYa7sQpiIZmgoGopRXyuc3HyPK8MjpU01ch
         m/wJmIqj4uFhso0IyQ9cx4ft8r/fdKrDHNcJYPqV0isJ5k0APQ+ZnFlwWVEmgEuLQTiF
         0krRDQDvEOf+o5eJxYM/t7q3pdPT7gbHV6xCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=r3Y5lRHT6CBciuuXm+9zb557CesLAqHjMWj+4FUiqjr8AzHqi3oQJuy7SB2kinAwXU
         ZphY48WRhQOPIKHbEIYsbiZ6mTKTNZvwPRgTOn1hYi2HcpLNa3qb4N03tBkdJIx6lvVb
         R/P6J/qxeVdL/66GadqOs1nxjQ7oyOfpltyWA=
Received: by 10.216.203.71 with SMTP id e49mr5410537weo.60.1280780451452;
        Mon, 02 Aug 2010 13:20:51 -0700 (PDT)
Received: from burratino ([64.107.3.126])
        by mx.google.com with ESMTPS id e8sm3103498wej.22.2010.08.02.13.20.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 13:20:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqk4o8bwwd.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152450>

Matthieu Moy wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  fatal: committer date <date> precedes parent date <date>
>>  hint: It looks like you are trying to commit on top of a commit
>>  hint: from 5 years into the future.
>>  hint: Use "git rebase -f" to rewrite the commit with a more
>>  hint: sensible date, and please, fix your clocks!
>
> If the problem is the commit you've just pulled, I'd advise against
> re-writing it: it's published, it's too late.

I guess that is the fundamental question.  What do you do when a
completely bogus commit has been published?

(For example, fsck permits extra headers after the "encoding" header,
but a commit object using random such headers would be malformed and
noticeable as such as soon as fsck learns what header is supposed to
come after "encoding".)

I would like it to still be possible to publically acknowledge a
mistake, make people rewrite their history to remove it, and move on.
But another viable solution here would be to just warn about the
problem and maintain a list of bogus commits as Junio suggested.
