From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Wed, 25 Jun 2008 15:53:33 -0400
Message-ID: <32541b130806251253t3dcada10nbf94fee9e4aed9ec@mail.gmail.com>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
	 <m33an1josg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 21:54:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBb4a-0007Ce-TI
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 21:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbYFYTxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 15:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbYFYTxg
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 15:53:36 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:59027 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbYFYTxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 15:53:35 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3363278fkq.5
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 12:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CpeQpr1ZCxFwNey8Vxzzz8WXihJZzZ3gH7Gmih9kn4M=;
        b=o1ZOm8LVDe47IbAMSwEFYx/rDgxMUwUmN4f4TTQSiWkc60V7xBgZqtq2cfseVwOPgg
         OXZIICwhSgMvpndd75GxSjDMfEp+cD/q4SWZU1XIBPEdTJfbQ4L5a288NG7UL4jCgAU/
         +jrsBw3T8I+e5luh+IfYwoxTrSy5SFG8zT+6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UbsfTeVyDlJw/ODnWcGp+LS73LvwdwwyXvrSpw1bxGGr7UJiUyoPNwWBZiMPFMKoLp
         Y3BPBOhHUWN7M1WOmXEPB4eJYEv2VQ/WOCseXz3vfc3DJyyTSpJu6xuTRb9VjM7R8IiU
         wrdaXDh9f7xRY69e5DCLpet0ubg5b6qVNSgXo=
Received: by 10.82.169.4 with SMTP id r4mr667259bue.66.1214423613782;
        Wed, 25 Jun 2008 12:53:33 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Wed, 25 Jun 2008 12:53:33 -0700 (PDT)
In-Reply-To: <m33an1josg.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86332>

On 6/25/08, Jakub Narebski <jnareb@gmail.com> wrote:
> Which git version do you use? Does it have the following configuration
>  variable (also available as command option):
>
>   status.showUntrackedFiles::
> [...]

Thanks, I didn't know about that one.  Using that definitely makes
"git status" go much faster (pretty much instantaneous if I've also
used --assume-unchanged on everything).

Now the catch is, if I want to implement the daemon I was talking
about earlier, I'd like to be able to notice untracked files (or
directories with untracked files) individually.  Ideally, I guess the
best way would be to just keep a separate list of all existing files
that aren't in the index, and have git status look at that rather than
at the actual filesystem.

Are there any suggestions for how best to do this?

Thanks,

Avery
