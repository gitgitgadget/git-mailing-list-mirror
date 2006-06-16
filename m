From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Running parse cvs
Date: Fri, 16 Jun 2006 15:10:22 -0400
Message-ID: <9e4733910606161210r12306622g139b54eeb87dc68d@mail.gmail.com>
References: <9e4733910606161147m403a3f36r6657bd7b620958f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 16 21:10:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrJi8-0002F3-Bw
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 21:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWFPTKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 15:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWFPTKX
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 15:10:23 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:62902 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751384AbWFPTKW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 15:10:22 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1138320nze
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 12:10:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P78p8039wDDZgXmmJOsAWZjcLnzOWXWFzDsyViOFdXIQ7ZsgvGnn5dk0ifgWwyXTkXn83wUc65s8lne258EFGoJxexgLmRzCjjOBqFthzxwc0rD1LNH9rd7o+S98BJEOavbWzHvjFZLkm0M6ocAfPnc9VZVuNN8Hrd1nWaVjDwU=
Received: by 10.36.38.19 with SMTP id l19mr859732nzl;
        Fri, 16 Jun 2006 12:10:22 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 16 Jun 2006 12:10:22 -0700 (PDT)
To: git <git@vger.kernel.org>, "Keith Packard" <keithp@keithp.com>
In-Reply-To: <9e4733910606161147m403a3f36r6657bd7b620958f3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21965>

On 6/16/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> I am running the latest parsecvs from your git tree. I am hitting a quick gpf.
>
> oad: sible/src/html/nsHTMLLinkAccessible *....................   253 of 100111
> Load: essible/src/html/nsHTMLLinkAccessib *....................   254 of 100111
> Load: ble/src/html/nsHTMLSelectAccessible *....................   255 of 100111
> *** glibc detected *** /home/jonsmirl/workspace/parsecvs/parsecvs:
> munmap_chunk(): invalid pointer: 0x08fd1db0 ***
>
> In the call stack I am in git_rev_list_pack line 619 doing a free.
> Called from parsecvs.c at 776

The GPF is because git-Pack_directory is calling free(git_dir) when
git_dir is an atom.

>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
