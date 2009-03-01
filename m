From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Changing the defaults for send-email / suppress-cc ?
Date: Sun, 1 Mar 2009 01:59:02 -0500
Message-ID: <76718490902282259q39da4267r34d169ec200704ba@mail.gmail.com>
References: <7d1d9c250902281129t1ea0d9d0k796d97bdd0af046d@mail.gmail.com>
	 <7vsklycct9.fsf@gitster.siamese.dyndns.org>
	 <20090301153000.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 08:01:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldffd-0002Kw-3J
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 08:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbZCAG7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 01:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbZCAG7G
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 01:59:06 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:50577 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbZCAG7F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 01:59:05 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1804657rvb.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 22:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NEeeEknRuyHQAriT6lvHzWRA0u2X+9agd7cQAH26Q0o=;
        b=EB86AZKJQQBjpxHkm9iTahPEAGrB8sT2dd6JhL8VNaa8zz2Z+tCJpb7fJjdS9mpkCm
         nkMEDwAe4jRlk7oeuluL0UV0mzXq7q0wvnx3inX0nvP3uMYWEuTIkM4NKoqx58cHXUa2
         n5qRfERJSAILLN++xph1W9w4Pan1lOKjdbfhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iYo1j+4ptNpHe8My69wqcMzjG3nX4gbd81NV3gVQUbXSlX4ROOKCLI5cT2InJAZG6e
         fSlaOL3HxOY9NedIPSHWZk1OG6XDZqbWSxEpz6/W3nIEzHP/xch7c7eqMQc0iwvQE8BX
         uSkqfvdhVj2EJLf2sMsaxqDOIgOpP6iE05KQQ=
Received: by 10.141.36.10 with SMTP id o10mr2205505rvj.152.1235890742741; Sat, 
	28 Feb 2009 22:59:02 -0800 (PST)
In-Reply-To: <20090301153000.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111822>

On Sun, Mar 1, 2009 at 1:30 AM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Isn't it an option to introduce a new program, say 'git send', that
> reimplements what 'git send-email' is meant to be used for, but has a
> better implementation and a better default setting?

I would, at some point, like to unify format-patch, send-email, and
possible imap-send. I envision being able to "git format-patch
--email" (and possibly "git format-patch --imap").

I don't have any illusion that writing my own SMTP client in C is much
fun, so I was going to see if it was reasonable to link format-patch
against msmtp. OTOH, I don't want to bloat the git binary, so it may
just be best to have format-patch be able to run msmtp automagically
when it is called with "--email".

Or something. I haven't thought real hard about it yet. :-)

j.
