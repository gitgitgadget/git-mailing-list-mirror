From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 12:33:10 -0400
Message-ID: <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com>
References: <483AC2CE.7090801@gmail.com>
	 <7vy75vvtxo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Mark Levedahl" <mlevedahl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 18:34:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Obr-0001ZN-17
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 18:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbYE1QdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2008 12:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbYE1QdO
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 12:33:14 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:48155 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbYE1QdN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2008 12:33:13 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2719159fkq.5
        for <git@vger.kernel.org>; Wed, 28 May 2008 09:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=p3j5fEiZLw+OnPz/aJpH88TKJGdqCzIfT/oYcZIsMXI=;
        b=LBLE+uSv0VYAr2ZPLL6/iNyEAMBuNlyVAxShfgPqM/qtQpDUpJdB9uJEMxbWveX/vUqflfZx5VpqsPeq0Jv5Wzi+xVgyjUj04QXYmGh8q4dtJvC8F1lZxhee5lziIMcvNpIWuQE3R9RU7rEjghAyqc/9Qk/g6UrJk2yP6MljYWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IY80H2dIin7/EVbWh5HSC7d1QUNK40Cd+UU5BVZVe8uVjf0FBNaSmBiHvV+nfpT60ZxRqeRxBqJWK0a70SmR+qEwO+FVa8HWD+VnJ9DV7Dbd6qF0+k9L5walt7NCyn9t00ctt48114UxVRui5mpwyJvTV+QkGqJR9vkFDBR2ChM=
Received: by 10.82.123.8 with SMTP id v8mr81094buc.22.1211992390942;
        Wed, 28 May 2008 09:33:10 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Wed, 28 May 2008 09:33:10 -0700 (PDT)
In-Reply-To: <7vy75vvtxo.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83106>

On 5/28/08, Junio C Hamano <gitster@pobox.com> wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>  > As this commit is part of the published master branch, I am not su=
re
>  > the correct resolution: leaving this commit in place means that an=
y
>  > commit between it and a commit fixing this will always cause an er=
ror
>  > on Cygwin / Windows. Of course, it *is* on the published master br=
anch.
>
> Some broken filesystems may not be capable of checking out and using
>  project files.  Too bad.
>
>  It's not a big deal.  It is not limited to this project.  We just fi=
x them
>  or work them around and move on.
>
>  Perhaps we should remove the infamous gitweb/test/M=E4rchen file whi=
le we
>  are at it?  I do not think the file is ever used.

As an unhappy Windows user myself (sometimes), I think it might be
better to simply fix git to *survive* failing to create files like
'nul' on Win32, rather than trying to *fix* such files in the repo.
It sounds (from the original post) like git has a *fatal* error
("cannot be checked out on cygwin") when trying to create 'nul', which
might be overkill.

The argument about rewriting the git history for this one file is
mostly predicated on the fact that you can't git-bisect if this file
exists.  Rather than making the file not exist, it might be better to
make git work when it does.

Have fun,

Avery
