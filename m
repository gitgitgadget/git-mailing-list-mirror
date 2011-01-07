From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: clone breaks replace
Date: Fri, 7 Jan 2011 15:34:26 -0600
Message-ID: <20110107213426.GB8693@burratino>
References: <4D262D68.2050804@cfl.rr.com>
 <20110106213338.GA15325@burratino>
 <4D276CD2.60607@cfl.rr.com>
 <20110107205103.GC4629@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 22:35:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbJxa-0006f2-Tn
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 22:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122Ab1AGVem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 16:34:42 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54583 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab1AGVel (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 16:34:41 -0500
Received: by vws16 with SMTP id 16so7292680vws.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 13:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XXT3L7UJ3CMlwF/uUSsjLsBSzGxMdvSrnFCn0NQAmiY=;
        b=VK4ez6C5tPXjMW5Bf0MP2QQHZE0gTSSGxYRVme1qrtvj8Fmr6+zdj9GpsZ0NW2sevE
         nmNGHg1NuInuF/zUmmNPKCsmh3Q+H8b4sNRDr3YfYOKS459zWB23TeBQiq+KOo7kxexQ
         R9b18DHraRqWr+BWtcCYbNHWllyW37ELyIZKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GLl+RoUy1dIYKFSrRn5uJTMt+yPJ3pya94PVjvFyV2alQjbn8hi6MC/RYYsPJnCj+x
         W4QXWXf12EJsxlGmXkemN1LriJOh8GCaJ9/cOPBexEqQy3bNAu8GVKnngBwZaTtQNSlI
         VPHJA3H8Fww64iPosXd07Fsqq62D46zLySVs4=
Received: by 10.220.203.140 with SMTP id fi12mr8050152vcb.168.1294436080992;
        Fri, 07 Jan 2011 13:34:40 -0800 (PST)
Received: from burratino ([69.209.72.219])
        by mx.google.com with ESMTPS id q5sm5843612vcr.39.2011.01.07.13.34.38
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 13:34:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110107205103.GC4629@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164765>

Jonathan Nieder wrote:

> Transport machinery needs to ignore grafts --- otherwise, the two ends
> of a connection could have different ideas of the history preceding a
> commit, resulting in confusion and breakage.  A fix to that was
> finally grafted on a few years later (see also [2]).

Sorry, I walked away mid-paragraph and left out a crucial piece when I
returned.  Because transport machinery ignores grafts, garbage
collection must make sure not to remove pieces of the non-artificial
history.  It is the garbage collection that Dscho fixed with
v1.6.4-rc3~7^2.

Sorry for the nonsense.
