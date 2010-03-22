From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Mon, 22 Mar 2010 07:38:20 -0700 (PDT)
Message-ID: <4ba780dc.5744f10a.5517.4c2d@mx.google.com>
References: <20100322120649.GA28003@sirena.org.uk> <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4BA338C1.7030803@alum.mit.edu> <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com> <alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm> <20100319115445.GA12986@glandium.org> <b4087cc51003190509y6ce7ad9dy992254cfe6ac2fb3@mail.gmail.com>
Cc: Mike Hommey <mh@glandium.org>, david@lang.hm, git@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
X-From: git-owner@vger.kernel.org Mon Mar 22 15:44:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntis3-0008Vl-Fs
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 15:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab0CVOof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 10:44:35 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37649 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab0CVOoe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 10:44:34 -0400
Received: by pwi5 with SMTP id 5so2645883pwi.19
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:cc
         :subject:in-reply-to:references;
        bh=xBI5bdWHEbRqFf/rErTBahFdrkT0LgedvWHuCY5oJ7E=;
        b=qSMc5GTkr75jdy43XrZ0cI9H/oBLi2eICRX9EyRb/j2W7hvS29DimIg9I4TL5nLZNk
         /XWPDvcoC1weOXOYNHt6JqKZKFiwEuqyFHrEsJWk9eJfdhCLCsHOnI8i7y2oJzIeGtdQ
         tZK3HC+VHXRQz4sdz3FAOGV85fqYSk9kAFE0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:cc:subject:in-reply-to:references;
        b=VvDxFuUHsBw6qhep6xuFjoy3aMeAY/D3NtL91gpyNKLrATV+49LQQVD6Xovfd6IRZM
         jWOlKFdj7UNpjhxIHjavMfZGZJuD5UQ6yBTTZ/cYtpbwOmHJTsxBf78oxHZIQcagg0Ud
         TxObqfBBrH4T2GwZSqXFk3fyQiuyiOd7siXFc=
Received: by 10.142.151.26 with SMTP id y26mr264058wfd.6.1269268701197;
        Mon, 22 Mar 2010 07:38:21 -0700 (PDT)
Received: from gmail.com (tor-proxy.fejk.se [66.90.75.206])
        by mx.google.com with ESMTPS id 23sm4940248iwn.14.2010.03.22.07.37.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 07:38:20 -0700 (PDT)
In-Reply-To: <20100322120649.GA28003@sirena.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142936>

On Mon, Mar 22, 2010 at 06:06, Mark Brown <broonie@sirena.org.uk> wrote:
>
> You're assuming they aren't conflated - for example, when people do work
> both personally and for their employer they often use distinct e-mail
> addresses to identify how the work was funded.

Indeed.

The model I propose handles this case much better, as I explain here:

    http://marc.info/?l=git&m=126900051102958&w=2

Specifically:

    > if they do need to set it on multiple machines and
    > can't be bothered to keep their e-mail consistant,
    > why would they bother keeping this additional thing
    > considtant? Linus is pointing out that people don't
    > care now about their e-mail and name, and will care
    > even less about some abstract UUID
    
    The user doesn't have a damn choice!

    [These first few paragraphs aren't completley correct;
     there's an explanation below them. It's mainly just
     setting up for the important part below.]
    
    The email can't be kept consistent over time because
    the tools expect it to be and/or use the actual
    physical email used to send/receive stuff. It's
    information that CONFLATES identity with whatever
    tool/system you're using.
    
    For instance, Michael Haggerty cannot reasonably use
    
        [user]
            name  = Michael Haggerty
            email = mhagger@MIT.EDU
    
    because he likely no longer has that email account
    to use. He is forced to change it and therefore
    forced to make his identity confused.

    [The above isn't quite true; my mistake. Michael
     could actually keep "mhagger@MIT.EDU" but inform
     tools like "git send-email" to send patches from
     another email address; this way, send-email will
     emit the necessary information to carry that
     authorship identity ("mhagger@MIT.EDU") along
     with the patch.
    
     However, it's still the case that Michael Haggerty
     is essentially stuck with "mhagger@MIT.EDU" for
     his identification---a problem that my proposal
     essentially fixes, as described now:]
    
    I'm proposing ALLOWING him to say:
    
        [user]
            uuid  = Michael Haggerty <mhagger@MIT.EDU>
            name  = Michael Haggerty
            email = mhagger@ALUM.mit.edu
    
    Heck, let's say he works at Red Hat as well; he
    might make some commits under this config AT WORK:
    
        [user]
            uuid  = Michael Haggerty <mhagger@MIT.EDU>
            name  = Michael Haggerty
            email = mhagger@redhat.com
    
    Then, he can make, say, commits to the Linux kernel
    repo for both work and hobby related issues and
    still be recognized as the same person.
    
    That is, he can have some commits [publicly] under:
    
        Michael Haggerty <mhagger@ALUM.mit.edu>
    
    and other commits [publicly] under:
    
        Michael Haggerty <mhagger@redhat.com>
    
    and still link them all together as the [SAME PERSON]
    with just the uuid:
    
        Michael Haggerty <mhagger@MIT.EDU>

The idea is to help users manage their own identities more effectively.

It's clearly advantageous to be able to apply different public identities
(personal vs. work identity for instance) to different commits, tags, etc.,
but it's also advantageous to be able to link those different identities
together.

At the moment, the different identities can only be linked together by
editing and transmitting a .mailmap file to be used by git tools. My
proposal distributes this kind of work UPFRONT by having individuals
choose UPFRONT some reasonably unique identification string to use
as the link between public identities.

Sincerely,
Michael Witten
