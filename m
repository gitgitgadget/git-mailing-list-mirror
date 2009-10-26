From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: What's cooking in git.git (Oct 2009, #04; Wed, 21)
Date: Mon, 26 Oct 2009 11:07:56 +0100
Message-ID: <20091026100756.GA9874@localhost>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <20091025160213.GA8532@localhost> <7vzl7eocd6.fsf@alter.siamese.dyndns.org> <20091026082931.GA6192@localhost> <4AE56552.70407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 11:08:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2MUi-00077w-PD
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 11:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476AbZJZKHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 06:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755473AbZJZKHn
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 06:07:43 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:35421 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755451AbZJZKHm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 06:07:42 -0400
Received: by bwz27 with SMTP id 27so1937303bwz.21
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 03:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=M1uI7ptqeLE0Il29e/1KmKb6szN+9sntHSiSIpazpp0=;
        b=q5ULStF5OA6KBs6pPsf7vve09ZIJmRGDqAR1EAf7A9Uv9ZL2n9Rp1XQLFJ67ycvKZV
         NoCj5N+H4VL4WAFhazDHewX1sRJ4r9Hy5q2bsmyXVPSddrEAu5WPj1gRVB3XfXC600by
         nfhRl+Z2fU0q/qgbyAHws5u9pudL53kI12ZD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=MeWDcj39khfqLR1zFSI96V+qYmi7mKz+uiErByWaO3VBffeKihrv7JXhSoIHWwZj7N
         tGfjPYSSvs2F14Mqdh+iyIebz63IxfMoZoqFbnJ0b6TWYB66Fn8/BniJ4zSftmZUkpH6
         Z3Aw0DL6Pd5zgPYS9iJxMRRJ0K0ifQE2xtXkw=
Received: by 10.204.153.220 with SMTP id l28mr5888377bkw.86.1256551666754;
        Mon, 26 Oct 2009 03:07:46 -0700 (PDT)
Received: from darc.lan (p549A7830.dip.t-dialin.net [84.154.120.48])
        by mx.google.com with ESMTPS id 13sm790688bwz.2.2009.10.26.03.07.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 03:07:45 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N2MUW-0003Ec-Ak; Mon, 26 Oct 2009 11:07:56 +0100
Content-Disposition: inline
In-Reply-To: <4AE56552.70407@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131247>

On Mon, Oct 26, 2009 at 02:01:06AM -0700, Stephen Boyd wrote:

> Clemens Buchacher wrote:
>
> > Why does your PATH include the build directory during make, Stephen?
> 
> The Makefile says:
> 
> git-completion.bash: git-completion.bash.in git-completion.bash.generate
>         # Generate completions for binaries we have just built
>         PATH="$(shell pwd)/../..:$$PATH" ./git-completion.bash.generate

Right, of course. I guess ignoring *.sh and *.perl is reasonable then.

> Personally, I'd rather keep it dynamic but I can see how it's useful to
> get the 10x speedup. It would be really cool if we could have the best
> of both worlds, where I keep my dynamic loading, but others can build
> the completion and get the speedup.

Should not be too hard to do using a configuration variable like
core.completion = dynamic.

Clemens
