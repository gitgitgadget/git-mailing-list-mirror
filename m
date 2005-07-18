From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: git, porcelain, darcs, and version 1.0
Date: Mon, 18 Jul 2005 16:18:54 -0400
Message-ID: <42DC0EAE.8000600@gmail.com>
References: <7islyev5s4.fsf@lanthane.pps.jussieu.fr>	<42DB341D.6050506@gmail.com> <7vslycnd42.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 22:21:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Duc5Q-0006VY-AA
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 22:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVGRUT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 16:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVGRUT1
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 16:19:27 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:55570 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261620AbVGRUTZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2005 16:19:25 -0400
Received: by zproxy.gmail.com with SMTP id k1so977954nzf
        for <git@vger.kernel.org>; Mon, 18 Jul 2005 13:19:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WyG1xWmr1C8DAKawUbjawe/0nC+XzYUv6OdXsw4VQ/LiXDxyOKU92XL1pCqA+vkGIxbaDkC9zJBI8eUXCpL9MSN8lP4koGXvson9HGS+8tSPIlBUNqGuqmVE5/9oBhjxj3rkW1gDZRzVgd1E/8RXOuho2SPA/1ty9Y1d/BPZjHM=
Received: by 10.36.36.15 with SMTP id j15mr3681020nzj;
        Mon, 18 Jul 2005 13:18:53 -0700 (PDT)
Received: from ?192.168.2.109? ([69.159.204.165])
        by mx.gmail.com with ESMTP id 10sm6708587nzo.2005.07.18.13.18.53;
        Mon, 18 Jul 2005 13:18:53 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslycnd42.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> 
> I fully agree that supporting C-level linkage is worthy, and
> should be one of our longer term goals.

Excellent.
> 
> 
>>A similar 1.0 goal would be to document porcelain's use of the .git
>>directory.  For instance, stacked git uses .git/patches,
>>.git/patchdescr.tmpl and .git/patchexport.tmpl.  If Linus does not
>>accept a patch documenting this usage, stacked git should use .stgit
>>instead.
> 
> 
> I agree that coordinating the namespace under $GIT_DIR among
> Porcelains is something we need (it was what prompted me to
> steal the branches/ convention from Cogito).  The job of the
> core should be to help Porcelains avoid stepping on each other's
> toes.
> 
> The documentation of the internals for $GIT_DIR/patches is
> probably better left to StGIT documentation, though, at the
> moment.  When other Porcelains start wishing to access the
> "series of patches expressed as a set of commit chain" expressed
> by StGIT there (e.g. show patch series in addition to regular
> commit chain in gitk), the core should help the Porcelains to
> work well with each other, to do things in a compatible way.
> This may involve moving some common things to core side and
> mention the convention for Porcelains to work well together in
> the core documentation.

I think we want the same thing, you're just expressing it explicitly: 
stgit's usage of the .git namespace should be mentioned in git 
documentation.  actual details belong in stgit, either explicitly in 
documentation or implicitly in the code.


> 
> However, I am slightly negative about suggesting these two to be
> part of the 1.0 goals.  Linus wanted to make 1.0 how many weeks
> ago?  I personally think that a usable baseline, stable enough
> to allow stripping out the core part currently shipped as part
> of Cogito, would be a good place to stop and declare 1.0.  My
> list was meant to enumuerate what might be missing from the
> "usable baseline".

All I'm looking for is a statement like "once we're at 1.0, darcs 
doesn't break until 2.0".  If we don't actually break out a blessed lib 
interface until 1.1,  that's fine with me.  To me, 1.0 implies core 
stability.

thanks,
Bryan
