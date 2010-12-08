From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Push to all repositories
Date: Wed, 8 Dec 2010 12:00:49 -0600
Message-ID: <20101208180049.GC5687@burratino>
References: <1291829983410-5816069.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Sheedy <kevinsheedy@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 19:01:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQOKD-0003hm-H4
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 19:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392Ab0LHSBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 13:01:04 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52056 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab0LHSBB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 13:01:01 -0500
Received: by yxt3 with SMTP id 3so828696yxt.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 10:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=oFSQL0nRzcZm0GrZGpIjFJyoeKa+Zid29Vx2va1JG9o=;
        b=i+Vxq/lqcPLkmH7CxHE8OdpETlwh0QRR7xNQE2bfs28hXuerjMqgVERBrzL2dGjof6
         9uf2TCj4i3R3Yr4ai23ygHt5UF5O0UcDZRxRxIgclS6XI9NL/RDIw+/Q48gSCQ1cUMUq
         jMZtp1EE2VKSstVjnhdQFB7FeuS25ptK9EbZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EgNzKxPqxvpEG5QGFSGITA1ZbpKCUDRVKZqqTnmXTKAovLGl3II3TIF2EKlLLqi6Pu
         7gxv0ouhk7am+S9zBeq56UiktW4AUMQWUshO+s52Zq/86oIUW186+mtfWjs7qfOi/nZa
         Bw76yxRJuEEM54x0ehahnXbQ7AwmUJIfXKno8=
Received: by 10.100.31.9 with SMTP id e9mr6200322ane.162.1291831261063;
        Wed, 08 Dec 2010 10:01:01 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.sbcglobal.net [69.209.58.175])
        by mx.google.com with ESMTPS id c7sm916976ana.17.2010.12.08.10.00.59
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 10:01:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291829983410-5816069.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163209>

Kevin Sheedy wrote:

> Basically, I want every developer to be able to push their code to the whole
> team.

What does this mean, in practice?  Do you want (1) the code in their
working directories to change under their feet, (2) the code you've
written to be immediately available to them in case they pull out the
network cable, or something else?

If case (2), then git currently provides support for fetching from
multiple repositories at once:

	$ git fetch --multiple alice bob sam

but does not include such support for pushing.  One can do so explicitly
like so:

	$ for repo in alice blob sam
	  do
		git push $repo *:refs/remotes/kevin/*
	  done

Regards,
Jonathan
