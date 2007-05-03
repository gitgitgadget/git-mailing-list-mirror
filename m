From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Problem with case-insensitive file cleanup
Date: Thu, 3 May 2007 15:32:41 +0200
Message-ID: <81b0412b0705030632k5056ffc9sada117111598006d@mail.gmail.com>
References: <4639DA65.3030401@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bug-gnulib <bug-gnulib@gnu.org>
To: "Eric Blake" <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Thu May 03 15:33:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjbQm-0001cA-P0
	for gcvg-git@gmane.org; Thu, 03 May 2007 15:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbXECNcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 09:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754077AbXECNcn
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 09:32:43 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:62866 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048AbXECNcm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 09:32:42 -0400
Received: by an-out-0708.google.com with SMTP id b33so488411ana
        for <git@vger.kernel.org>; Thu, 03 May 2007 06:32:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S+w27WxXmO9HdlYS2LP5qbX152nJLI53FogEboWGd8OZ+UccXRl9ZdI2PwTBIR+sKjeWyUwLePJm6JRwJQn0vYp24rlJQNOok0VY5wmsptFdRg0LK4aJMSBfYNRQQNgNZhcBAIQOmKl0LbWKrNMp6iBJBWdvSlK3hK4tPNRv0Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B4h3UvTVxmXWun9rIRVT3s+IWVjOznufHcX5Ko28hnqKCF/ePxHAyYa5ZWJ31k9AYxj7A2zTSf1BGmbBEIjg6MHbBrL+5H+CuYkjlfBEoisiqpb8yNZjxvV8t6Gncb2H/AWJwatBysT1lbha5vuoIUWWdfPh6Yj8PpWZDn+yLfY=
Received: by 10.100.227.5 with SMTP id z5mr1504033ang.1178199161604;
        Thu, 03 May 2007 06:32:41 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Thu, 3 May 2007 06:32:41 -0700 (PDT)
In-Reply-To: <4639DA65.3030401@byu.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46086>

On 5/3/07, Eric Blake <ebb9@byu.net> wrote:
> Right now, the gnulib repository is mastered in CVS but mirrored by git (I
> am still awaiting the day that Jim decides that his hooks are adequate
> enough that git can be the master and CVS provided by git-cvsserver).
> Earlier this week, I reported a problem when two case-insensitive files
> were created, which is a no-no for checkouts on Mac HFS+ or Windows-based
> platforms [1].  The problem was quickly corrected in CVS (note that
> _Exit.texi now lives in the attic [2]).  But somehow the git repository
> still thinks that _Exit.texi belongs to the current tree [3], ...

cvs-to-git conversion seem to be buggy in this respect

> What needs to happen to get rid of the _Exit.texi listing in the git
> repository, so that case insensitive file systems can clone the gnulib.git
> repository?

git update-index --force-remove _Exit.texi
git commit -m 'Really removed _Exit.texi'
