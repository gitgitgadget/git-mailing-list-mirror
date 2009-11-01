From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Fw: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Date: Sun, 1 Nov 2009 21:54:24 +0100
Message-ID: <fabb9a1e0911011254j316920e6y63c4f129f7df186d@mail.gmail.com>
References: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru> 
	<7v8weq50pm.fsf@alter.siamese.dyndns.org> <fabb9a1e0911010646v2043bdb7l9215f1114e9e8385@mail.gmail.com> 
	<alpine.LNX.2.00.0911011504460.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Samium Gromoff <_deepfire@feelingofgreen.ru>,
	git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>,
	Mike Hommey <mh@glandium.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Nov 01 21:55:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4hS8-00067M-PN
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 21:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbZKAUyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 15:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbZKAUyl
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 15:54:41 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:63769 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbZKAUyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 15:54:40 -0500
Received: by ey-out-2122.google.com with SMTP id d26so287015eyd.19
        for <git@vger.kernel.org>; Sun, 01 Nov 2009 12:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=VkSJyaYcaBQxi0NLtKCsbjlxPor+Q2Ov4AlXQU0O4wQ=;
        b=m481x28cprML0t5Y8/QbfcAjQhV0LENgCoD8nCqAHqx1Eynd8Rubcaf9WR0JZAvRLn
         4prHbPN/4qmiPrPCIi8Vbft49FJNpzfHDInLWheQkpHifn0uqLfA9eUMQliyQ8kJYi3A
         puxnBYYTz7+firc1FmHuw/vxnQ9LwgFl/4y/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=UTUlt7xDIrpq5xLaRamZyXnyUhPFdK9xdW6GYoztMF4nCnvIFbVvebcX6xxpPWqPQa
         zxI5RRZ9iXhcrX8b2zFrIJQcgmouyX/IGGSgbisqm+/N2qOr75Wdmw8cmBDPuvgKNPg2
         JkkKoo8K9z2s1Iuu/r4m+h7nRI/CkxrG0Pl9Y=
Received: by 10.216.89.85 with SMTP id b63mr3416014wef.175.1257108884262; Sun, 
	01 Nov 2009 12:54:44 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911011504460.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131878>

Heya,

On Sun, Nov 1, 2009 at 21:16, Daniel Barkalow <barkalow@iabervon.org> wrote:
> If we change the ls-remote.c case, it becomes impossible for a struct
> transport to ever have a NULL remote field. And the change to ls-remote
> removes a special case. I'd go so far as to say that ls-remote.c should
> provide a struct remote, and transport_get should enforce that there's a
> struct remote.

If that is the case (that we can eliminate the only special case), I
agree that we should fix it there, where it will be the least effort.
I got the impression from Junio's original post that there are
multiple places that would have to be fixed, and I figured that we
should fix it where it will be the least amount of effort :).

-- 
Cheers,

Sverre Rabbelier
