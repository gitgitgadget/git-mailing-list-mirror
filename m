From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git rebase to move a batch of patches onto the current branch
Date: Thu, 24 Jul 2008 16:42:58 -0400
Message-ID: <32541b130807241342h483169d7we955512879075161@mail.gmail.com>
References: <32541b130807241257j7820a591if8ca01c66bbcd6b2@mail.gmail.com>
	 <20080724201333.GA3760@blimp.local>
	 <32541b130807241316x4f85bcdfw12857be575fb3289@mail.gmail.com>
	 <20080724203049.GC3760@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 22:44:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM7fR-0006Ny-Rm
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 22:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbYGXUnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 16:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYGXUnB
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 16:43:01 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:57516 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbYGXUnB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 16:43:01 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1967656wri.5
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=F5s/AbmhTF9QOmCJAJNXhy9EJQXoeUTo0+DOMOM5TOo=;
        b=qiTjcBhPQPpKJhjog8RmrIz1tzeVVYJX5SHmU27EGDVEXl3wcWq7dm2WIHACoi9UUX
         WknRre1BGjpi/mbocor+pDV5NiCzEzOInEhxcutFjR3ySWHXJpMBIeEiuFfWVELnfmak
         nkURArZE14mcKpbQ2AKfSTsX1N+UF+2jivDmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lk6JsoOTxxhitGWBACLRa2wcVHgDDsyJHCjkf11JudZ0phYPqVHS6hWBK77bbKNEei
         MvqNxruSeiafg6Dv9kdCu5VwzDNFPNoEbhtQQReMbcbUUnbC5dHEnKfJAEzYBLC5bfCl
         Wsu3ZV37GBdIcLnFIwIES26T6XhlCRzks3lBk=
Received: by 10.100.202.9 with SMTP id z9mr1346824anf.8.1216932178994;
        Thu, 24 Jul 2008 13:42:58 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Thu, 24 Jul 2008 13:42:58 -0700 (PDT)
In-Reply-To: <20080724203049.GC3760@blimp.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89960>

On 7/24/08, Alex Riesen <raa.lkml@gmail.com> wrote:
> Avery Pennarun, Thu, Jul 24, 2008 22:16:06 +0200:
> > On 7/24/08, Alex Riesen <raa.lkml@gmail.com> wrote:
>
> > >     gcp3 ()
>  > >     {
>  > >         git format-patch -k --stdout --full-index "$@" | git am -k -3 --binary
>  > >     }
>  >
>  > But that'll give up when there are conflicts, right?  git-rebase lets
>  > me fix them in a nice way.
>
> No, it same as in rebase. You'll fix them and do "git am --resolved".
>  See manpage of git am.

Hmm, cool.

So that command isn't too easy to come upon by accident.  If I wanted
to submit a patch to make this process a bit more obvious, would it
make sense to simply have git-cherry-pick call that sequence when you
give it more than one commit?

Hmm, I suppose not, since git-am is a shellscript and cherry-pick is
currently a builtin, so it would be kind of a step backwards.

Thanks,

Avery
