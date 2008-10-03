From: "Klas Lindberg" <klas.lindberg@gmail.com>
Subject: Re: How to remove a commit object?
Date: Fri, 3 Oct 2008 13:42:53 +0200
Message-ID: <33f4f4d70810030442l5042fdbfw18f97336c5a331cc@mail.gmail.com>
References: <D53D127D-97DD-417C-9109-ABD46BBD4E18@midwinter.com>
	 <48D36DF4.3030607@drmicha.warpmail.net>
	 <33f4f4d70810020636g77f4180cm7aa6b7de07ae5beb@mail.gmail.com>
	 <m3ljx7qemk.fsf@localhost.localdomain>
	 <33f4f4d70810020726g71c6f39eq16585269fb268322@mail.gmail.com>
	 <48E4E27E.7030308@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Michael J Gruber" <git@drmicha.warpmail.net>,
	"Steven Grimm" <koreth@midwinter.com>,
	"Git Users List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 03 13:44:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klj4p-0001It-Im
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 13:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbYJCLm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 07:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752608AbYJCLm4
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 07:42:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:53581 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbYJCLmz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 07:42:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1075640fgg.17
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 04:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gFWXcrqFBBGKn4OppT/hPHLrrv4mE7F3tx4EiDS9ZTw=;
        b=Y+ACRtSwyotjUMFwQz2IpnYTzLZM3XYp9BoVvZY0GWVZrP8SM1TZabgDYutUL7nf5l
         xX6ZKoe6tIbou5E3D2OihiF95ZdnAvzbgL6icx6+A53T38eW6IUbS/8Woicv5PFF6Ner
         hatmPfSnapZPFAwXWRV9Dz/AdGQDDdXJNuEeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YLVtLnLxJ6jamwEtlXh3WydHP5xs8Lh0813qZE+Ymxkpkt909ZchtpnKZvDLehSv10
         MwUwDROjuipLOklOh4wQJ+5LJN7TIkQSMj+wRRhny/pFZxchlCyPZwrvBIFBnqtY0L9U
         o1iNFlQYD6uR6Hvkq/cuwS2cFVh1BsuHtAIHk=
Received: by 10.86.33.19 with SMTP id g19mr1006874fgg.13.1223034173168;
        Fri, 03 Oct 2008 04:42:53 -0700 (PDT)
Received: by 10.86.84.16 with HTTP; Fri, 3 Oct 2008 04:42:53 -0700 (PDT)
In-Reply-To: <48E4E27E.7030308@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97416>

On Thu, Oct 2, 2008 at 5:02 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> with filter-branch, I would appreciate some guidance for using it. It
>> basically seemed to do exactly what I wanted (recreate the repo, minus
>> some explicit stuff, with history intact otherwise), except the result
>> looked crazy.
>
> And your definition of 'crazy' is...?

Right... :-)
Crazy ==  Obviously incorrect behaviour that I didn't analyze. Out of
167 commits on subdirectory B, only 14 survived the filtering.

I tried "git filter-branch --tree-filter 'rm -rf <list of everything
except B>' HEAD" instead, but I can't use that. The change history for
all the non-B paths are still in the repo afterwards, and thus you can
easily recreate any file outside subdirectory B.

Is there some way to do what I need with git-filter-branch today, or
must I wait until 1.6.1 is released?

BR / Klas


> I assume that you used --subdirectory-filter. This has issues that will be
> fixed in 1.6.1. You need a current 'master' git (at least b805ef08).
>
> -- Hannes
>
