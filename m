From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: How to merge in different order?
Date: Fri, 3 Apr 2009 12:30:46 -0400
Message-ID: <eaa105840904030930j7d576a61s25677c0dd5d16767@mail.gmail.com>
References: <20090403161208.GC28619@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 18:32:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpmJe-0004xs-5D
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 18:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbZDCQat convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2009 12:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755254AbZDCQat
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 12:30:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:39705 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbZDCQas convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2009 12:30:48 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1248887rvb.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2009 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=sPGmVcUoIVhCtad806ZVlidMg+Kn37+iG6K1GkYXAcw=;
        b=QR03wJlrOorZbEJ1ibIKDqN+vHptW8gCKCerpl/QD0F1d9w0ySBLRPzmdpH8mPMPbz
         q618KIj6e1Xih/6tirisDjqnfXnn1lG/C8c4wP1rXQQ7Z8AMhe68fAmNT1qt0DpnS10c
         Y6Ubs6o7uV3DCaosquQWspqgCwzNEtqldVlOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=cos7iHZxTmJRvJmyKFtu1Rstm2dTXI9wsLUoKXfCSLO53txnZfvx4Y51SW/rbHACE0
         Uh8qcwMDDNT4mWHfJGK+kTtlvGFiDzBprFLo+PJgsUZbSTqPbrqvTIwstqoSOxVyqy7b
         PNW8jfvJ60MPyDD1o7soxSBTzB8WTmIwCkRn0=
Received: by 10.140.157.1 with SMTP id f1mr617038rve.299.1238776246098; Fri, 
	03 Apr 2009 09:30:46 -0700 (PDT)
In-Reply-To: <20090403161208.GC28619@raven.wolf.lan>
X-Google-Sender-Auth: 475537f62c79a8cd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115545>

On Fri, Apr 3, 2009 at 12:12 PM, Josef Wolf wrote:
> Hello,
>
> Given a branch that looks like
>
> =A0A1 =A0A2 =A0A3 =A0A4 =A0A5
>
> I would like to merge into another branch in the order
>
> =A0A1 =A0A3 =A0A4 =A0A2 =A0A5
>
> When I merge A3, then A2 is merged also. =A0git-merge don't seem
> to have an option to omit slurping older commits?

"git merge" merges the entire branch. It sounds like you are looking
for "git cherry-pick" instead.

Alternatively, you could run "git rebase -i A1" on the branch before
merging it. (See the docs for details)

Peter Harris
