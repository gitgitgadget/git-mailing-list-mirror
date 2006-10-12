From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: [RFC] separate .git from working directory
Date: Thu, 12 Oct 2006 13:04:19 +0800
Message-ID: <452DCCD3.2080600@gmail.com>
References: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>	 <BAYC1-PASMTP10003954B66E10247020A7AE140@CEZ.ICE> <fcaeb9bf0610111455y225237cmdbaadbf294686d8e@mail.gmail.com> <452DBF9E.7010900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Thu Oct 12 07:05:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXskv-0004bl-Tg
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 07:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbWJLFFJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 01:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbWJLFFJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 01:05:09 -0400
Received: from qb-out-0506.google.com ([72.14.204.236]:22453 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965270AbWJLFFC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 01:05:02 -0400
Received: by qb-out-0506.google.com with SMTP id p36so30645qba
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 22:05:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QfoOgNt93qMZDukHrNIVMam4gfK1N/4ivE5lxmHMmrS+QQw1JhwbxF3aolMa1op3/Wy8z5oiMVghl6AnPWQe0/0bf8/2a+2fx2eGM9AktvArQ9Rgr68j1QPjPim/eM0vAU4+AmX+PU3fo9KzfjsQDW8HBNkx206xo87uhXTsbWQ=
Received: by 10.65.188.4 with SMTP id q4mr2059876qbp;
        Wed, 11 Oct 2006 22:04:59 -0700 (PDT)
Received: from ?192.168.88.85? ( [221.122.47.70])
        by mx.google.com with ESMTP id r15sm1243822nza.2006.10.11.22.04.57;
        Wed, 11 Oct 2006 22:04:58 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: git@vger.kernel.org
In-Reply-To: <452DBF9E.7010900@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28771>

Liu Yubao wrote:
> Maybe the svk way is worth considering, it maintains a map relation
> between paths in repository and file system like this:
> 
> $ svk checkout --list
>           depot path            path
> ==================================================================
> //path/in/repos/hello/world.c           /path/in/fs/hello/world.c
Sorry, I made a mistake, svk maintains a map of the top directory
of checkout, not each file:
            depot path             path
====================================================================
//path/in/repos/myproject                /path/to/myproject
> 
> The problem is users must maintain this map when move or delete
> /path/in/fs/hello/world.c, it's a bit annoying.
> 
> see 
> http://svkbook.elixus.org/nightly/en/svk-book.html#svk.ref.svk.c.checkout
> for more information.
> 
