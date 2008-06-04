From: David <wizzardx@gmail.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 10:20:28 +0200
Message-ID: <18c1e6480806040120k58aaf16eg88fa318788a2af45@mail.gmail.com>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
	 <20080604080017.GB7752@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephan Beyer" <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jun 04 10:21:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3oFH-00055N-LC
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 10:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbYFDIUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 04:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbYFDIUa
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 04:20:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:56943 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbYFDIU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 04:20:28 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2028563rvb.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 01:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XyqJuWmQVpObIWXJNiN3jxcJyjDAcHBfV8iW0uUOLd8=;
        b=nzLFUVSvJOhG2kuB3LFmFQsglfDqMMzH8BirIW4Y7oop5qWYSrYJ9/gW3xKYZJ1pZvrrOOQglypbzbkfzzBm6pvVg/SVykWBtqe04xPUt2EDVT25PP0le35yUFUncmVWMvEAvM5oAM4s/zTDQKkK5gm1yCIizxnp+DExF7D/bKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I2huw3E1ApselqmKshULsJgGGwQhJI6zLOeXOEfAjmZ92oGgV3OG+Hru4rNXb1+AHV0A7MLKOsHBmUW4tOfJmcUbM2J11idUClsh45imWlC8IJq9v5/cIIq/7colFVStpLNSXvltk9AV4kijY2pN0O0xVsTQE0JtxC2afi5AJLk=
Received: by 10.141.171.6 with SMTP id y6mr6457453rvo.84.1212567628107;
        Wed, 04 Jun 2008 01:20:28 -0700 (PDT)
Received: by 10.140.194.15 with HTTP; Wed, 4 Jun 2008 01:20:28 -0700 (PDT)
In-Reply-To: <20080604080017.GB7752@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83760>

>> Is there an easier syntax for doing this?
>
> Put this into a script and you've got an easier syntax ;-)
> But note that <commit1> does not get cherry-picked then.
> Use <commit1>^..<commit2> (or $1^..$2).

Thanks for the ^ tip. I prefer to use git built-ins where possible,
instead of re-inventing the wheel badly by using my own scripts ;-)

> for C in $(git log --reverse <commit1>..<commit2> --pretty=format:%H);
> do echo pick $C ; done >temporaryfile
> /where/you/put/it/git-sequencer.sh temporaryfile
>

Thanks for the script, but I want to use git built-ins only if
possible :-) eg, so that I can easily help other people do the same
thing without telling them to download separate scripts.

Also, that syntax is almost as long & complicated-looking as my own ;-)
