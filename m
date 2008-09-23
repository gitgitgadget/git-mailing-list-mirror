From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: clone fails: Could not get the current working directory
Date: Tue, 23 Sep 2008 14:39:09 +0200
Message-ID: <81b0412b0809230539x340bd579q3489d5e257b9740@mail.gmail.com>
References: <48D59A30.5020403@cs.tamu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John Freeman" <jfreeman@cs.tamu.edu>
X-From: git-owner@vger.kernel.org Tue Sep 23 14:40:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki7Bk-0004iM-Nl
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 14:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbYIWMjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 08:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbYIWMjL
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 08:39:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:5537 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbYIWMjK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 08:39:10 -0400
Received: by wr-out-0506.google.com with SMTP id 69so682236wri.5
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=J2NkRLhP21sEPWNBv+xT0hm38XEoMCMrvYAFgj4/cdI=;
        b=WPFoXUoqrHtW5ug2Zrv4UhQ+rg4/oZJzdWejbcp2j4kIY8igmRwqM2PdTg1cgpdUMU
         /z724Sef04zlZOGGAhxwtmG+ZLLs81X8AqH5mXrjTVXXKMja3T8Ta5/VCko4+B7T6PFJ
         KIE5vVwU31DPQqbmA/qaiP9w0MPDuE+fZq4xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sNKlD7sFPRjA9/HDTOKaTasF/0U6PTGS7VxTLD/kgfyM2Yq8MfbtU8OURyxcSn1oQ9
         T9W05tv/6o7OzpoXqQjVFxQ/llW/+DZsxJLtjIq0ycYLQF+DcnT2Jdyp7b3ns6uTltjZ
         bo6brMegqaZrDpjEHv3nacEB99AuImKAZpJ5M=
Received: by 10.150.230.8 with SMTP id c8mr9139296ybh.47.1222173549299;
        Tue, 23 Sep 2008 05:39:09 -0700 (PDT)
Received: by 10.151.107.13 with HTTP; Tue, 23 Sep 2008 05:39:09 -0700 (PDT)
In-Reply-To: <48D59A30.5020403@cs.tamu.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96557>

2008/9/21 John Freeman <jfreeman@cs.tamu.edu>:
> - The repository is bare, under Bob's home directory on a remote Sun system.
> - Bob has set the group permissions for the repo directory to repogroup.
> - I have an account on the remote system that is in repogroup.
>
> I am trying to clone the repo on my home machine, using
>
>> git clone ssh://john@remote.system.edu/home/bob/path/to/repo
>
> It fails with
>
> remote: fatal: Could not get the current working directory

Do these work:

  $ ssh john@remote.system.edu ls -R /home/bob/path/to/repo
  $ ssh john@remote.system.edu 'cd /home/bob/path/to/repo && pwd'

?
