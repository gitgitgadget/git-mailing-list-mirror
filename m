From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to provide authentication along with git command itself ?
Date: Thu, 14 Jul 2011 15:02:44 -0500
Message-ID: <20110714200244.GA14687@elie>
References: <20110714161508.2378c155@shiva.selfip.org>
 <CAH3AnrqR=xMa6KYWBmybXdudo8C8FoeioCs2PgOVZezAE5BWiw@mail.gmail.com>
 <20110714163149.63bad937@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Thu Jul 14 22:03:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhS7f-0000wB-Kx
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 22:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306Ab1GNUCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 16:02:54 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59151 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab1GNUCy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 16:02:54 -0400
Received: by iyb12 with SMTP id 12so537894iyb.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZkDx22SQO+nCBdjMLTXdjU+Rk6YdT4Pz7pLKZ/ZWmUY=;
        b=NLwFIFxpiuRdtekLBhonmGXOYPkCElcyTyyliF5/vGfJcT09rWo0t0GI3iMaVDI7Gy
         w5wiVi4elIP7uZU7w7QMplkH7qzTCjJah1Dti6smXF0KRC9XXRTmqJ/kn+PBfhLiDmy2
         5XGu2eJ0nXLx0kiupin+x0977809V5KWVVO/Q=
Received: by 10.43.58.15 with SMTP id wi15mr3093177icb.411.1310673773750;
        Thu, 14 Jul 2011 13:02:53 -0700 (PDT)
Received: from elie ([69.209.70.6])
        by mx.google.com with ESMTPS id d8sm589584icy.21.2011.07.14.13.02.51
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Jul 2011 13:02:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110714163149.63bad937@shiva.selfip.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177169>

J. Bakshi wrote:

> Well, I am using version 1.7, hence not DAV but using git-http-backend 

Ah, I forgot to mention the docs for gitolite and http-backend[1].

As for your original question about how to set up or cache credentials,
unfortunately I haven't tried it.  Based on git-push(1), it looks like
the usual

	http://username:pass@domain/path/to/repo

syntax should work if you're passing the full URL on the command line
or if it's okay to store the usernames and passwords in plaintext in
.git/config.

If that's not okay, it also might be possible to hack up something
evil with the GIT_ASKPASS variable.  Some of the patches mentioned in
the recent discussion about password prompts also might be
interesting[2].

Regards,
Jonathan

[1] http://sitaramc.github.com/gitolite/doc/http-backend.html
[2] http://thread.gmane.org/gmane.comp.version-control.git/176522
