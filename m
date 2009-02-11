From: Elijah Newren <newren@gmail.com>
Subject: Re: git fast-export issue -- anyone know if this is a bug or a 
	feature?
Date: Tue, 10 Feb 2009 23:12:08 -0700
Message-ID: <51419b2c0902102212y4285319br2dd8ebd4a4e96590@mail.gmail.com>
References: <51419b2c0902082131o512e966l1fb3029c7513b02e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 07:13:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX8Lp-00021A-Qt
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 07:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbZBKGMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 01:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbZBKGMK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 01:12:10 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:64432 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbZBKGMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 01:12:09 -0500
Received: by yw-out-2324.google.com with SMTP id 5so31981ywh.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 22:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=GzzRpdgX32nlicjNiyskOixcSQkolQ6DmqioF+sfCEU=;
        b=TLcz+R37xy2ThKVR7E5vhZVcoCgyVWK89gb4WkvXij4VNyLpAESvB2qKys2hKVye3M
         ZoaCMZkC7J14jSoOAKxFhUy9PnC7BNOJjcA5ar+I9uKgWw6hO/XSSs1XbZXMMLduD/Bn
         7BB+64SHPY/DI8fXZ1VmlBEncbAbVSgvK/fh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=gFiNcg/3QhZ76SYljILiIfMRRcXNSM113ykcmAxt9rIVmIyZSDzl7jlfv1wCtlZYJO
         nx1cHQfsoysFyQ2LGGCSAnv1E83PtKPkz7UhZpZkrezCKdY+TBhZpQCa239Q9dLApvkL
         amqSuljzLi1SNPRGFFV/mPRy4os5/kYssD9YA=
Received: by 10.231.16.129 with SMTP id o1mr494199iba.47.1234332728218; Tue, 
	10 Feb 2009 22:12:08 -0800 (PST)
In-Reply-To: <51419b2c0902082131o512e966l1fb3029c7513b02e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109380>

Hi,

On Sun, Feb 8, 2009 at 10:31 PM, Elijah Newren <newren@gmail.com> wrote:
> The "source" repository is one that has been created by cvs2git (which
> operated on a franken cvs repository munged together from lots of
> different places; I'm running git-fast-export & git-fast-import based
> on it since I want to do some extra changes outside of cvs2git).  In
> the source repository, I noticed that 6 of the earliest commits in one
> root of history looked like:
>
>     /--E
>    /  /
> A--C--D
>  /
>  B
>
> In the "mirrored" repository, I notice this history had been modified
> so that it looked like
>
>        E
>       /
> A--C--D
>  /
>  B
>
> The latter history seems much more sane to me; since D is a child of
> C, making E a merge of C and D seemed really weird.  I did pour over

I think I found the source of the bug, and have sent out a couple
patches in separate emails.  However, I wanted to correct my statement
here.  The repositories created by cvs2git did not have such a commit
history; I think it was simply too late at night and I wasn't reading
things correctly.

Elijah
