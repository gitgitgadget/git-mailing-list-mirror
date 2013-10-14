From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Re: [PATCH] rev-parse doc: clarify use of optional / required
 arguments
Date: Mon, 14 Oct 2013 17:25:29 +0200
Message-ID: <20131014152529.GU4589@mars-attacks.org>
References: <1381760611-9573-1-git-send-email-boklm@mars-attacks.org>
 <20131014143632.GD21200@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 17:25:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVk1i-0004bP-SV
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 17:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923Ab3JNPZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 11:25:33 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:46169 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753Ab3JNPZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 11:25:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 8571E4E65;
	Mon, 14 Oct 2013 17:25:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8nMlCa4_x_IN; Mon, 14 Oct 2013 17:25:44 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id F36D14238;
	Mon, 14 Oct 2013 17:25:43 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 918A643920; Mon, 14 Oct 2013 17:25:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131014143632.GD21200@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236104>

On Mon, 14 Oct 2013, Jonathan Nieder wrote:

> Nicolas Vigier wrote:
> 
> > "the option is optional" was confusing as it is not the option but its
> > argument which is optional.
> >
> > Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
> 
> Thanks.
> 
> [...]
> > --- a/Documentation/git-rev-parse.txt
> > +++ b/Documentation/git-rev-parse.txt
> > @@ -259,9 +259,10 @@ Each line of options has this format:
> [...]
> > -	* Use `?` to mean that the option is optional (though its use is discouraged).
> > +	* Use `?` if the option takes an optional argument (though its use is
> > +	  discouraged).
> 
> This still seems confusing: the argument's use is discouraged?
> 
> Would something like the following make sense?
> 
> 	* Use `?` if [...]. This is used for historical options
> 	  that once took no argument and later gained an optional
> 	  argument. Use of this feature for new options is
> 	  discouraged.

Actually I don't know why it is discouraged, and I'm not sure that
it should be. It was listed as discouraged since commit 21d47835 adding
parseopt to git-rev-parse, but I have no idea why. I'm adding the author
of this commit in Cc.

The reason that I looked at this documentation in the first place was
that I was looking at adding an option '-S[<keyid>], --gpg-sign[=<keyid>]'
to git-rebase, similar to the option in git-commit, so that rebased
commits can be signed. In git-commit this option takes an optional argument,
so I think it would make sense to make it optional in git-rebase too.
