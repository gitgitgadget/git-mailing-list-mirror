From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] - Updated usage and simplified sub-command action invocation
Date: Thu, 10 Jan 2008 13:41:08 +0600
Message-ID: <7bfdc29a0801092341j60dcb081xe4bf6c22cbaf30f2@mail.gmail.com>
References: <1199938045-16289-1-git-send-email-imyousuf@gmail.com>
	 <7v8x2y8ahw.fsf@gitster.siamese.dyndns.org>
	 <7bfdc29a0801092251p3d46a3cau3db4d57c4f705043@mail.gmail.com>
	 <7vzlve6t69.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 08:41:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCs2l-0005my-Gg
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 08:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbYAJHlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 02:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbYAJHlL
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 02:41:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:1069 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbYAJHlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 02:41:09 -0500
Received: by fg-out-1718.google.com with SMTP id e21so581598fga.17
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 23:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=h9Dl5ZRnh0BIRoYTYa/9aOBAtlG3EGfQAJaA7vcZtRI=;
        b=jGxe67qpOQSkgMI9F2e8LmPbgbyRJ9IBmMGMT7QUuNueu1MNPzi+5MRiQg2U8wGkOAinbg9jf6zp73n3Uh/N6xlSNle5wqSXoOO+pNHm0ESoaqpG0Rd1GHSkwyfmu48wOIsHHLo+bYpgTGH/5zIF9isXRSXL9i154IHZGikZuJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UShHXsuJXq/x1kOKwRI80KSJI1rBIwZvaSsC38tc+XL2Mq1QcBkulc3jAznUCzp0+SqV1ZncDZO3V7hWUYOM4nloq1anCpkPlt0mOT/PNs/MEonej2NljFiffR4sIlMDiiXwQqqrVDRFA6EmQfUWzYMlWZmUpJBJeShr+iOVRJI=
Received: by 10.78.172.20 with SMTP id u20mr1742368hue.3.1199950868347;
        Wed, 09 Jan 2008 23:41:08 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Wed, 9 Jan 2008 23:41:08 -0800 (PST)
In-Reply-To: <7vzlve6t69.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70048>

On Jan 10, 2008 1:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Imran M Yousuf" <imyousuf@gmail.com> writes:
>
> > On Jan 10, 2008 12:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > ...
> >> I somehow feel that syntactically the original implementation
> >> that allowed subcommand specific options to come before the
> >> subcommand name was a mistake.  It may be easier for users that
> >> both "-b branch add" and "add -b branch" are accepted, but I
> >> have to wonder if it would really hurt if we made "-b branch
> >> add" a syntax error.
> >
> > I will recode it to have all options except for --quiet (which is
> > inverse of -v or --verbose) be mentioned after the subcommand.
>
> Just a word of caution when dealing with me.
>
> Unlike Linus, I am not always right.  And other people on the

I will cautiously remember the caution :).

> list who are here longer already know this. I am reasonably sure
> that some of them will disagree with me on design issues like
> this one; I mildly suspect that this forbidding "-b branch add"
> might be met with resistance from existing users.
>
> You do not have to agree with me on every little detail I
> mention.  If you feel a design issue might be contentious, it
> could turn out to be a better use of your time to keep the code
> as it is while waiting to see if other people would offer better
> alternatives.

Actually the best design, IMHO, is to have separate commands itself
for them, that is submodule-add, submodule-init, submodule-update,
submodule-status or submodule. I think this would also make it
coherent with other commands such as git-ls, git-merge, git-show. In
that way we could have a common .sh file that will contain the common
functions and can be accessed from the command shell scripts. This
would also make it quite simple.

>
> > Actually module_$command is not possible because only add's module is
> > module_add rest are modules_$command....
>
> Is there a fundamental reason why you cannot rename them to be
> more consistent?

In fact it is consistent, add works on a single module only, whereas
rest of the command works either on 1 or more. Thus having plural
(modules) is logical.

>

Best regards,

-- 
Imran M Yousuf
