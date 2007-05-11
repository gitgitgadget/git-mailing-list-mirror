From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.2-rc3
Date: Fri, 11 May 2007 13:08:36 +0200
Message-ID: <8c5c35580705110408g7068e917lb672e1ac56f2c84c@mail.gmail.com>
References: <7virb0gqdz.fsf@assigned-by-dhcp.cox.net>
	 <200705111023.37676.litvinov2004@gmail.com>
	 <7vtzukf0h6.fsf@assigned-by-dhcp.cox.net>
	 <200705111330.54312.litvinov2004@gmail.com>
	 <7v1whnesyn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alexander Litvinov" <litvinov2004@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 13:08:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmSzN-0000Ue-7E
	for gcvg-git@gmane.org; Fri, 11 May 2007 13:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447AbXEKLIj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 07:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754699AbXEKLIj
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 07:08:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:41757 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447AbXEKLIi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 07:08:38 -0400
Received: by wr-out-0506.google.com with SMTP id 76so993956wra
        for <git@vger.kernel.org>; Fri, 11 May 2007 04:08:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AJPjVBksZpQRD0ELgxBOJUiXVFKtWZaqS4VXh7Vhj2HHKD3124OJNeO7exPx/Z/FJ1cIIl2jOU9OFJgWnjwcBmG+AyuSzaumzgaBqLL095/u2FS8tC3pSYDstTB5ydP/Cz6YGl4QVpKyVmvfMFEMkBnulgWiDumR7YUcHI04UTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IT08zskQ+ycoGwFhBWYsPs/FwLYF0OyynSbMKmCpIND+Wh5uMHqWqDo5b7kZyl64DwTM75C3R0L/ezW5WFXIWUXn7kSNMUOh226pnmRRmKa4G6XiM1sRViSy5JKzbkI4lDij7LHUiG1WgYHIngRBhlU+VK3eH55vby3geMM8AzM=
Received: by 10.115.78.1 with SMTP id f1mr965372wal.1178881716464;
        Fri, 11 May 2007 04:08:36 -0700 (PDT)
Received: by 10.114.234.19 with HTTP; Fri, 11 May 2007 04:08:36 -0700 (PDT)
In-Reply-To: <7v1whnesyn.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46949>

On 5/11/07, Junio C Hamano <junkio@cox.net> wrote:
> Alexander Litvinov <litvinov2004@gmail.com> writes:
>
> > I have tried your test and found that cloning such repo does not clone
> > subprojects. Only empty dir 'sub' is being cloned.
>
> Yes, that is pretty much intentional.  Having a link for higher
> layer tools can use (i.e. tree objects can contain 160000 mode
> "gitlinks" to subproject commit objects) while not considering
> such linkage part of the reachability is the whole point of
> plumbing level subproject support.  It allows people not to
> download repositories of uninteresting subprojects.  Higher
> layer tools such as clone/checkout/diff could be instructed
> (currently they cannot be, though) to recurse into subproject
> directories if the user wants to.

fwiw: I just released cgit 0.3, which includes a script
(submodules.sh) used to initialize, update and check status of
submodules. It uses the file .gitmodules to map between submodule path
and git repository url (cgit now uses git as a submodule).

You can clone the repo here:

  git://hjemli.net/pub/git/cgit

just look at the files here:

  http://hjemli.net/git/cgit/

--
larsh
