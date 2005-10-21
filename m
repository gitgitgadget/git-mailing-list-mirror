From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: How to create a new branch based on a tag?
Date: Fri, 21 Oct 2005 16:37:32 +1300
Message-ID: <46a038f90510202037l7dd40271qcc0634295e092068@mail.gmail.com>
References: <435901F7.9020509@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 05:38:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESnir-0006Ex-D2
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 05:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVJUDhe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 23:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVJUDhe
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 23:37:34 -0400
Received: from qproxy.gmail.com ([72.14.204.202]:13530 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964855AbVJUDhd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 23:37:33 -0400
Received: by qproxy.gmail.com with SMTP id v40so453613qbe
        for <git@vger.kernel.org>; Thu, 20 Oct 2005 20:37:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CeuL7FCRnhKlM8xtIGcNzufvA2JVtCJbGoRZdJQfPEl5q/BJXoa9KA9r+qsSb2BPQceQlU6eIygFealvDLTsJgAYKG/6oJTZGA3KS6/Zf2hlkUgxqopfyxeQnMnjumGpBUB2SvJqgpjLMWqcEqJgjvAbJu8w38HMsNHJOOfTh38=
Received: by 10.65.242.2 with SMTP id u2mr1898859qbr;
        Thu, 20 Oct 2005 20:37:32 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Thu, 20 Oct 2005 20:37:32 -0700 (PDT)
To: Ben Lau <benlau@ust.hk>
In-Reply-To: <435901F7.9020509@ust.hk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10412>

On 10/22/05, Ben Lau <benlau@ust.hk> wrote:
> Hi,
>
>    I would like to create a branch of my own work based on a specific
> kernel version(i.e
> v2.6.11). I tried with:
>
>  > git-branch my2.6.11 v2.6.11
> error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a
> commit
> fatal: Needed a single revision

What you're after is

   git-rev-parse --verify <tagname>^0  > .refs/heads/mynewbranch

"branches" are very lightweight -- it's a ref containing the SHA1 of
the commit you want it to be at. So if you find the SHA1 of the commit
in gitk or wherever, just

  echo SHA1 > .refs/heads/mynewbranch

and you're sorted. Do git-checkout to switch to it.

cheers,


martin
