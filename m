From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: Stitching together private svn repo and public git repo
Date: Thu, 3 Jan 2008 01:13:54 +0300
Message-ID: <37fcd2780801021413g5f2a602dkb9fc289a13517375@mail.gmail.com>
References: <C3A195B5.10839%jefferis@gmail.com>
	 <20080102214005.GA10924@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Gregory Jefferis" <jefferis@gmail.com>, git@vger.kernel.org
To: "Charles Bailey" <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Jan 02 23:14:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JABrE-0005xo-5g
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 23:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbYABWN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 17:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbYABWN4
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 17:13:56 -0500
Received: from nz-out-0506.google.com ([64.233.162.230]:33553 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYABWNz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 17:13:55 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1076634nze.1
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 14:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SOwhcanAWLZwbs3I+MlWbltvjsHMO7BLKPOZjSs7x4M=;
        b=ldxVPsSW5ifr3YL8LeWJxTw3bp92unjeCdolS0T7dsBS1k7E62ARBPlkS7uae+oh50162YiesjsklOHiEBNJTyK31fx2OsBL7r+lVoWNU4ETkoygoW6845Ge119atD8SLGs+96stTRTVl4quiNcZd8frHMJc/zh83l/fSle53SM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=x0kTp1pucqaVSsujFHGDtucUcWpm9W1VHDI40cPnsrXSDxk+7a2gyfeaTYDdilZZoF2VIvu1OSDbjzKOeuBO3yEhIMBVJsL6cxajYD6RTWXPySypcjUiP0WjHLj2XsZZhPwBHiNzEbtkCr9cCtC8HrSQmPgNkXrEJUYP14KM5wY=
Received: by 10.142.103.6 with SMTP id a6mr60508wfc.21.1199312034371;
        Wed, 02 Jan 2008 14:13:54 -0800 (PST)
Received: by 10.143.45.14 with HTTP; Wed, 2 Jan 2008 14:13:54 -0800 (PST)
In-Reply-To: <20080102214005.GA10924@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69497>

On Jan 3, 2008 12:40 AM, Charles Bailey <charles@hashpling.org> wrote:
> You could then do this with a 'git filter-branch --parent-filter' to
> rewrite the parents of the merge commits.  As far as I can see, you
> would need to call filter-branch once per merge to rewrite everything
> from the merge commit forwards.

I believe there is a much easier way to do that using .git/info/grafts
The first step is to create .git/info/grafts, which specifies commit-id
and its parents for each commit that you want to change. Then you
can check the result using gitk, and if you are satisfied with what
you see then you run git filter-branch on it to convert 'fake' parents
into real ones.

Dmitry
