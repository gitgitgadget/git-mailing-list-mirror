From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 1/1]   Make git-tar-tree more flexible
Date: Sun, 30 Jul 2006 11:46:43 -0700
Message-ID: <44CCFE93.7040500@gmail.com>
References: <20060730174847.GA32574@eve.kumria.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 30 20:46:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7GJT-0005xZ-5j
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 20:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWG3Sqw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 14:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWG3Sqv
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 14:46:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:45354 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932426AbWG3Sqv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 14:46:51 -0400
Received: by nz-out-0102.google.com with SMTP id i11so116004nzi
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 11:46:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=b67NzB5vIqUx8+jQmzMQzGYRu+hwu0yrqoYhSFQAwrXUuwZtrgS9z2qjpURmDIO/6W5zGVJim4rfMwY+6RYAwLRl0UzqxhAqfsfaWkgm4fvy95rGgJ3jLdnfKu0yNy3JQzU6t7ga81ymtnlxI/FD++8At6yAwd1MDeC7H4INtPo=
Received: by 10.65.122.20 with SMTP id z20mr2220534qbm;
        Sun, 30 Jul 2006 11:46:50 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.32.187.210])
        by mx.gmail.com with ESMTP id 15sm3133444nzo.2006.07.30.11.46.48;
        Sun, 30 Jul 2006 11:46:50 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: Anand Kumria <wildfire@progsoc.org>
In-Reply-To: <20060730174847.GA32574@eve.kumria.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24471>

Anand Kumria wrote:
>   If you have a project which is setup like:
>      project
>      website
>   and you decide you wish to generate a tar archive of _just_ the 'project'
>   portion, git-tar-tree is not able to help. This patch adds two parameters
>   which can assist.
> 
>   The first is '--pathlimit', which forces git-tar-tree to only generate the
>   tar archive for project; as in:
>     'git tar-tree --pathlimit=project project-1.0 tag-1.0'
> 
>   The above command will mean that paths in the tar archive look like:
>     project-1.0/project/src/main.c
>   etc.
> 
>   The second parameter allows you two strip the extraneous project, as in:
>     'git tar-tree --strippath=project --pathlimit=project project-1.0 tag-1.0     Which will result in tar archives looking like:
>     project-1.0/src/main.c
> 

This could be made more general and more Git-ish instead, by 
implementing a strip common prefix option and using a double dash option 
to signal that the remaining arguments are the paths of interest.

The synopsis would then look like:

	git-tar-tree [--remote=<repo>] [ --strip-common-prefix ]
		<tree-ish> [ <base> ] [ -- <paths>... ]
