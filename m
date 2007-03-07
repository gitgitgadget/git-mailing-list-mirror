From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git's is_inside_git_dir too strict?
Date: Wed, 7 Mar 2007 19:17:42 +0700
Message-ID: <fcaeb9bf0703070417n5d3fb168jc7efd4642ad38c92@mail.gmail.com>
References: <fcaeb9bf0703060741l7cbfd0f3ue443730176606db6@mail.gmail.com>
	 <Pine.LNX.4.63.0703062232570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 07 13:17:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOv5Y-0001bA-8H
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 13:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbXCGMRo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 07:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbXCGMRo
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 07:17:44 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:44846 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbXCGMRn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 07:17:43 -0500
Received: by wr-out-0506.google.com with SMTP id 58so220461wri
        for <git@vger.kernel.org>; Wed, 07 Mar 2007 04:17:42 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WZ2/2yJC1sW2ecDojjWo1a4rtc8f8Y20w9yFRGxJBBqeddhIu5oWZEsww4ZvBJScZUraMcKrAM4txPJg7VHS3Tv2vY3R3kQhobBtjF3NV+fMh+XTnPaIcEogY3vZ/Pneqy+tNUrSdLcVhDQvXhDAEBGa43okk/sbiux5hXI1SLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JC8xqcY7GzSy1aZ9YOsC1SaJa7wyZ6KFNN7mdC/wBDRrvTGLQlLTqhTjbmEZLS+TeKDDP1n+fdkFKeKVvfEs8M8tybH2YFgDZpZkyYCssv6VQ9tj7e4GMsOMBjO80gmMBvoXQ0lMhDrtRFX+Grf62bedEbmKZrkbi6hCowgjIxU=
Received: by 10.114.126.1 with SMTP id y1mr2132518wac.1173269862101;
        Wed, 07 Mar 2007 04:17:42 -0800 (PST)
Received: by 10.115.19.15 with HTTP; Wed, 7 Mar 2007 04:17:42 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0703062232570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41664>

On 3/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Complaints include "cannot be used without a working tree" and "This
> > operation must be run in a work tree". Can I have the former behaviour
> > back in some ways?
>
> Well, there is a real problem with "This operation must be run in a work
> tree". What operation is that? We tried to make it hard to overwrite
> things in $GIT_DIR by running Git operations meant for the working tree,
> and it seems like you are running one of them.

>From this command:

git --git-dir=/home/pclouds/blog/data.git ls-files --others --modified
2007-03-07T18_52_41.txt

It was run in /home/pclouds/blog/data, which is the working directory
of data.git.

By the way, is it plausible to add --git-workdir option to specify
working directory? With that option, I won't need to chdir to the
working directory, run git commands and chdir back.

>
> However, I think that is_bare_repository() really should check if
> $GIT_DIR is a prefix of $(pwd). Because if it is not, we are likely to run
> in a detached work tree.
>
> If you agree, then is_inside_git_dir() might actually be a better way to
> ask if the repo is bare than is_bare_repository().
>
> Comments?

I didn't follow git development lately so I'm afraid I'm incapable to
comment on this :-)

>
> Ciao,
> Dscho
>
>


-- 
Duy
