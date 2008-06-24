From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 19:53:07 -0400
Message-ID: <486188E3.10803@gmail.com>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624163810.GA4654@sigill.intra.peff.net> <alpine.DEB.1.00.0806241750030.9925@racer> <alpine.DEB.1.00.0806241808400.9925@racer> <486153DB.3070502@alum.mit.edu> <486179C8.2000704@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:54:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBILS-000089-Po
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 01:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbYFXXxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 19:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbYFXXxQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 19:53:16 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:21900 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbYFXXxP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 19:53:15 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1115802ywe.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 16:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wxIXiO+dRkmhbjXA/KDFWgqo6BXZXmHarX4yZ9pG0T8=;
        b=j4eH9ZAugu9tFM+IxALoeOsq2ncFbKAPFqvYaw/q+El2eVDDlJxG+45tLaWhIgZNcm
         P4vlXZAN7FYv+hm4JeXNqVj+0B5sV8BFiepp1L8GSMkzZFmpsrnS4t4grrH2JgYyTKNy
         VD67RmgM9ts+9kDfO9KqCeRJXyJnSeSGdf20U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=oqPciYj+2lOvgcI12ZMVksTQLsfaJJsRBxOozfv9LGp1Y/9SancQpKKMAO4hhujWVD
         OJ2829ySG1LZ2yVjBu7nNbsXZMFMjnuizBqmmhMImJ9cxZLmWLFq7AAxr4nQ3X+ocR/J
         iqsY5/wtMq8Gudr7PEu8uVU7jZto4bWMDl+1o=
Received: by 10.141.1.2 with SMTP id d2mr15680845rvi.129.1214351593406;
        Tue, 24 Jun 2008 16:53:13 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 6sm160836ywi.1.2008.06.24.16.53.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 16:53:12 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <486179C8.2000704@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86187>

Lea Wiemann wrote:
> Michael Haggerty wrote:
>> Therefore it should be easy to teach git-bisect to locate either kind of
>> transition, "bad" -> "good" or "good" -> "bad", depending only on where
>> the user places the original "good" and "bad" tags.
> 
> I think this is a good suggestion (though I haven't thought things 
> through).  Another idea is to add "old" and "new" (or something like 
> that) as aliases to "good" and "bad", since that's the only semantics 
> that the bisect labels actually seem to have.

"Before" and "After" the "Change" maybe?
