From: James Pickens <jepicken@gmail.com>
Subject: Re: [PATCH] gitignore: root most patterns at the top-level directory
Date: Fri, 30 Oct 2009 14:52:07 -0700
Message-ID: <885649360910301452g7d7311d7w1133f5d4c98072dc@mail.gmail.com>
References: <20091027011024.GA29361@sigio.peff.net>
	 <7vmy3cys0f.fsf@alter.siamese.dyndns.org>
	 <20091030182431.GA19901@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:52:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zOK-00024h-96
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 22:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920AbZJ3VwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 17:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932910AbZJ3VwE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 17:52:04 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:35144 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932903AbZJ3VwC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 17:52:02 -0400
Received: by iwn10 with SMTP id 10so2452821iwn.4
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=tFGcBXHksfFtsc/px1fxTCAW9bPWtFVx918/5quZiU0=;
        b=jAXkPric/gvY7jGdN0iAtRGmbVUG7H7EauGWqVxEeOSVj+fSU4gSu+KWV3WYx4X03I
         HtZrcRFb6/YNr9XZ7MdVRVJ7ibHMUpus5hO/2vKobFyCkIDikHfy+4N8hUs/SqAP3qJd
         c47M10epq0mVQ9WHoZ2LvHs6aNqTjvTD/RI4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=e0a+Kkon+rYNeG8EyEMquOSipEudSTXW8foOyupY40VY9j3ksrFpesv8CulwLvJmXy
         HJylnwi6+DWlkTo87CntP7PWprp416ePstTOtMKD2y7WWhcICmzeU+LVP53SnAyJSl3B
         T9fGAactivuHWZVjtw5kbj6FVPUywqR09CQXI=
Received: by 10.231.73.131 with SMTP id q3mr6337806ibj.6.1256939527408; Fri, 
	30 Oct 2009 14:52:07 -0700 (PDT)
In-Reply-To: <20091030182431.GA19901@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131757>

On Fri, Oct 30, 2009 at 11:24 AM, Jeff King <peff@peff.net> wrote:
>> If we do so, there is no need to change the current .gitignore entires.
>> You need to spell a concrete filename as a glob pattern that matches only
>> one path if you want the recursive behaviour.  E.g. if you have a Makefile
>> per subdirectory, each of which generates and includes Makefile.depend
>> file, you would write "Makefile.depen[d]" in the toplevel .gitignore file.
>
> While clever, that use of '[d]' seems unneccessarily obscure to me. Why
> not just give a wildcard for "any subdirectory of me" and do:
>
>  Makefile.depend
>  **/Makefile.depend
>
> Since "**" is in common use in other systems, it's pretty clear (to me,
> anyway, but then I am the one suggesting the syntax ;) ) what that
> means.

+1 to that.  I've often wished for Git to support the ** wildcard, not only in
.gitignore but also in other places like .gitattributes and sparse checkout (if
that feature ever gets completed anyways).  It's on my list of "git features I
would work on if I ever had any free time."

James
