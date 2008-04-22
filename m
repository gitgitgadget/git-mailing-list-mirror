From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 2/7] git-submodule: Extract absolute_url & move absolute url logic to module_clone
Date: Wed, 23 Apr 2008 00:54:45 +0800
Message-ID: <46dff0320804220954y171df9b6t199f4864a32d4195@mail.gmail.com>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
	 <1208355577-8734-2-git-send-email-pkufranky@gmail.com>
	 <1208355577-8734-3-git-send-email-pkufranky@gmail.com>
	 <7v3ape5sip.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804212350t647492b2o649ddc40cfe43d6@mail.gmail.com>
	 <7v3ape2ufs.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804220209n590a0684x876270c7b1c0c2d@mail.gmail.com>
	 <46dff0320804220738u760a05f7q4ec9cbf144d78480@mail.gmail.com>
	 <46dff0320804220741p4d3f3080w493fb96dc4983a1c@mail.gmail.com>
	 <alpine.DEB.1.00.0804221609200.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 18:56:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoLmM-0006B3-QB
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 18:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717AbYDVQyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 12:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755621AbYDVQyu
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 12:54:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:43092 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbYDVQyt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 12:54:49 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1288603wra.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 09:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cwTejr4zTy2fvds0SIDC+KSIIFHcc99iSQPyvi8Vb+A=;
        b=m41SxBMr1ArabXYfUxonDIj0xVJDkCz0i0lf/O9mY49YWoLDlRcv8S0vphkm4J1EoXgeafrutCp2v5YngzI/TMmXoPDNyYvmrKfmqEh28Cym76qh3X9YZXGtB324OhhxvnSSBe2B9kJR6Uct8/TJRtFikC5XWpMluLO56Jx1RDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RHqvCuMisLNSAkYuDq3kl2fc+vIvaf+kPgBViedgOpTIX+x7x8nq7S8LrlMdIo37XyGtaMUZmyYw8W9KvWUeWhBDNvH/LmNgtZQQIKHjigDF2On+CZ8xeT0kkE9X8PEUtwKV8s6egXuvqNe0pZj4BKfbewTR6K9Wxs6WOHqEaNI=
Received: by 10.100.136.15 with SMTP id j15mr739700and.71.1208883285772;
        Tue, 22 Apr 2008 09:54:45 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 09:54:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804221609200.4460@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80137>

On Tue, Apr 22, 2008 at 11:10 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Ping,
>
>
>  On Tue, 22 Apr 2008, Ping Yin wrote:
>
>  > On Tue, Apr 22, 2008 at 10:38 PM, Ping Yin <pkufranky@gmail.com> wrote:
>  > > >  >  Please have that kind of justification in the proposed commit log message.
>  > >  >  >  When these changes are made into history, people cannot ask you questions
>  > >  >  >  like I did and expect the history to produce such answer on demand ;-)
>  > >  >  >
>  > >  >
>  > >  >  OK, i'll resend this patch tonight.
>  > >
>  > >  See attached patch
>  >
>  > Only the commit message changes.
>  >
>  > [... only the commit message ...]
>
>  Do you realize how much work you make Junio do?  It would be definitely
>  better if you tried to relieve him of as much burden as you can.

I'm sorry about that. It's just because that i don't have a mail
client at hand. I use gmail which will wrap lines. And if i use
git-sendmail, i can't send this message as a reply to previous
messages.

So, any better way?

-- 
Ping Yin
