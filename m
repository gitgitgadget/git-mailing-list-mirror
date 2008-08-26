From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Tue, 26 Aug 2008 12:58:29 +0200
Message-ID: <cb7bb73a0808260358o41a04a9ara701e6c726cf2298@mail.gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200808242237.53953.jnareb@gmail.com>
	 <cb7bb73a0808251628q6af52292sc296fb63565b6eaa@mail.gmail.com>
	 <200808261015.37023.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Lea Wiemann" <lewiemann@gmail.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@ucw.cz>, "Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 12:59:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXwGq-0004Sw-PI
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 12:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbYHZK6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 06:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbYHZK6a
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 06:58:30 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:40503 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbYHZK6a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 06:58:30 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1110466yxm.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 03:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=50vN40Kw+fLAB4MOR3Vw2Ku/lKZrBhC9HE2rnTev6ug=;
        b=nuUGN5OKUS5itRBRm0T9LiYykJjwckkUxQam2FSRbgKvgTxDUQJwtDvFfC4CcvI9Ds
         HAfSIjN/R7VBoGMj3vcU8WdVwwmVUkxDS/yiWE3a1nlGdI1vb7vSJkz9c32BBpTxX1dC
         LdTBN2vlAcjJjNue+fZLpnfAKznihv8P8O7Co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ds+AWvEKn++dUMWD9rYwxj3DjRZl3yO8KCPV5DB+hx68Y53UAzSZhTOIWdaA+W3vYp
         Ia+XxKNNSVTjifApGnImaE5KrF3HvK2MM+LwqnOUnJM3P66n7C/uQ63p0qfK8DXHFV5n
         TW7XDTc4l56xHxJzkYCMK/o54nr+G9dfNec1k=
Received: by 10.151.156.12 with SMTP id i12mr8990200ybo.182.1219748309071;
        Tue, 26 Aug 2008 03:58:29 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Tue, 26 Aug 2008 03:58:29 -0700 (PDT)
In-Reply-To: <200808261015.37023.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93732>

On Tue, Aug 26, 2008 at 10:15 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> BTW. one thing that can be done is consolidation of "guessing action"
> code: it is done by simply calculating what is to put in $action during
> dispatch, or is done in 'object' view to calculate redirect URL with
> proper action.  I have tried to bring them together, but patches were
> I think lost in the noise.

Ah, but the problem is that guessing the action based on the object
sometimes depends on the context: for some cases the 'commit' action
is the correct one for commits, in other cases shortlog is preferred.
This is why I introduced the %views hash in some of my patches.

> IMHO v5 with small change making refs canonical (hash=>"refs/$ref")
> is preferred way to do this.  You can send v6 patch or I can send
> it (I planned doing this today).

I can do it, no problem.

> First, the great problem with gitweb patches as of today is if Lea
> Google Summer of Code 2008 work on gitweb caching would be accepted
> (merged in) into git repository; I pretty much think that any gitweb
> improvements would be "incompatibile" (read: causing conflicts) with
> 'gitweb caching' patch covering such large parts of code... but
> I might be mistaken about that.

That's ok, I can wait for Lea's code to get into the repo, so I can
work on the conflicts myself. I'm not sure what parts of the code she
touches though, so for some things it might be easy (the pathinfo
stuff, for example). Other features such as my allheads thing would
probably need to be reworked for caching.

> Thank you for contributing to gitweb...

My pleasure.

-- 
Giuseppe "Oblomov" Bilotta
