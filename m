From: =?UTF-8?B?RnLDqWTDqXJpYyBIZWl0em1hbm4=?= 
	<frederic.heitzmann@gmail.com>
Subject: Re: Need to set GIT_WORK_TREE when setting GIT_DIR !?
Date: Sat, 10 Mar 2012 14:23:52 +0100
Message-ID: <4F5B55E8.4080000@gmail.com>
References: <CALeToSUaPzdr=u7FfwHEtEanphVP5LZ09QdQXno52PLBTK0H-g@mail.gmail.com> <7v4ntx4bol.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 14:29:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6MMs-00072S-1R
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 14:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725Ab2CJN3t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Mar 2012 08:29:49 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:33287 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab2CJN3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 08:29:48 -0500
Received: by wejx9 with SMTP id x9so1855915wej.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 05:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=AtyJmHdinf0y/5VDxCbYPbFvxUqP6tw9q4ekUdUGGRo=;
        b=FeTVisXG03iq9OGGdw+VlVvz/BGcTVdw3nWwj9M6xsIFzTgWkXTkR8FO4421uSad92
         BLKMXUdVYnNuZgV2iIjQEkbuMZfmzjWe8HeDCu4G8gOYlLvXaVpS/lqW07mGI40B9shr
         7JYtzFSQGh271+w6D4Ako5FDGdTJlDCgYHqnegvcE5Lz7HtHnWW3uBJJyLFYECjRO6FW
         K+FSU4jb1jgeT8YM8jvh6P8mSWeEpGG8Po55/NT6B6XHnxBMfUfol0L07nAK7libUIVw
         aZWgsFVcfQJVptY2/jE98fQql0diA6HqJznJWeXvM4Cc6MhGf082R9nQy5K8ti+FSMeM
         N6iA==
Received: by 10.180.93.232 with SMTP id cx8mr13091038wib.14.1331385835169;
        Sat, 10 Mar 2012 05:23:55 -0800 (PST)
Received: from [192.168.0.10] (dra38-7-88-179-84-80.fbx.proxad.net. [88.179.84.80])
        by mx.google.com with ESMTPS id fl2sm26240235wib.4.2012.03.10.05.23.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 05:23:54 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7v4ntx4bol.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192781>


Le 10/03/2012 00:06, Junio C Hamano a =C3=A9crit :
> Yes, to the question on the Subject line.  But you can also say
>
>      [core] worktree =3D /path/to/the/work/tree
>
> in $GIT_DIR/config.  Make sure your $GIT_DIR/config does *NOT* say
> that the repository is a bare repository.

Thanks for clarification.
However man git-config says :

"If --git-dir or GIT_DIR is specified but none of --work-tree,=20
GIT_WORK_TREE and core.worktree is specified, the
current working directory is regarded as the top level of your working=20
tree."

Some more context on my precise problem :
I have a project, with source files managed with git.
I also use some Makefiles that I would like to manage with git _in a=20
separate repository_

$ GIT_DIR=3D<project_path>/.git git add some_file.c ...
$ GIT_DIR=3D<project_path>/.git_mk git add Makefile ...

Setting worktree in each GIT_DIR/config will fix that but I can't figur=
e=20
out why current git implementation actually needs this.

--
=46red
