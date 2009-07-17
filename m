From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v6] Re: mailinfo: allow e-mail files as input
Date: Fri, 17 Jul 2009 04:20:48 +0200
Message-ID: <20090717022048.GA12945@vidovic>
References: <7v8wip9jjw.fsf@alter.siamese.dyndns.org> <f006bbb9c754c80c133798ff70db5b5291dae060.1247766192.git.nicolas.s.dev@gmx.fr> <7v1vog6rw9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 04:21:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRd4L-0002Sk-Gi
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 04:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933971AbZGQCU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 22:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933969AbZGQCU5
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 22:20:57 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:64083 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933942AbZGQCU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 22:20:56 -0400
Received: by ewy26 with SMTP id 26so571584ewy.37
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 19:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=OP9H8NsO2db9uRptr2h5r3VOYPlMTA9hnTaoZvrk71U=;
        b=AH9Itp9b/HEQWBTzDlZXq+lKW8osHgEdPmdM17j6uzft62OA1Y5NlNywgRzxEnXBv1
         utS9ZKdjZH50AOnz4+t9O3HNh+TAmPqL4OyG9OaAyz4AC6bKQjjGLhMmXbaA2+99ea0H
         IutIW6Uj5/s84C36QywVs0ySm6aznGZBsHRCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uaE93rSCTJCDiUmc78eMdSXSZkWdniI8N68bZnMN2LjLTwbh3wU4bcqD9Z3rpkU4Br
         AZmOlhZ6bMKSwesZe1yEUZmhZRiLmrRz2bA77U4/w+EuRKO5J10MXnK3bE6paCGUkCCG
         yc0+ggm+e7XKkquHwRdRU5be4xMm6Hi9Sdt7k=
Received: by 10.210.110.5 with SMTP id i5mr655770ebc.3.1247797254358;
        Thu, 16 Jul 2009 19:20:54 -0700 (PDT)
Received: from @ (88-121-124-61.rev.libertysurf.net [88.121.124.61])
        by mx.google.com with ESMTPS id 5sm857396eyh.40.2009.07.16.19.20.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Jul 2009 19:20:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1vog6rw9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123440>

The 16/07/09, Junio C Hamano wrote:
> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
> 
> > We traditionally allowed a mbox file or a directory name of a maildir to be
> > ...
> > Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
> 
> Thanks.

Thank you in first place. I appreciate your patience and explanations.

> I have one more comment on the test script, but it's something I can
> locally fix (iow, there is no need to resend your patch if there is no
> other issue pointed out by others, and if you agree to my suggested
> improvements).

... and thank you for leting the door open to agreements.

> > +cat >rfc2822_email <<EOF
> > +Return-Path: <user@domain.name>
> > +X-Flags: 0000
> > +	999
> 
> The headers look a bit too excessive to my taste, but probably you wanted
> to take a real-life example.

Yes.

>                               If that is the case, I suspect the manually
> added X-Flags: at the beginning defeats that purpose, though.

I don't see what purpose it defeats. What am I missing?

>                                                                I'd suggest
> either removing the hand-munging, or triming the Received: sequence to
> make it a bit shorter.

It's fine here.

> These days we tend to write the last step
> 
> 	git diff --exit-code master^ HEAD
> 
> which allows "sh t4150-am.sh -i -v" to be more useful when debugging.

I'll look at that closer.

-- 
Nicolas Sebrecht
