From: Elijah Newren <newren@gmail.com>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 14:40:33 -0600
Message-ID: <51419b2c0906091340i11965efcr5cf5bb4a71108fa6@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <20090609201200.GA13781@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 09 22:40:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME87d-0001K2-E1
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 22:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061AbZFIUkd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 16:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755421AbZFIUkc
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 16:40:32 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:19142 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbZFIUkb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 16:40:31 -0400
Received: by qw-out-2122.google.com with SMTP id 5so181237qwd.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 13:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=flcJ1mDur972HYMBHUO9pkchTVgW7NtQflAeyqg2UH4=;
        b=QhvBAn1o8ivTcx/a47hiic4bn+1GEwiTBipLBK43KAx4xKDApZbcPWYEO7wr3O3E+/
         gNN7b7BfGFq+9JK+B+VW9rEHvv8oegpFfop3vKNEv0xvYQQJYs4rjjodpZUs0mzeR6Si
         BDX5LykwiJOH9nLKb+gahUIjCJNmcz/XmLvUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fBaxEKr3d+Wy5HbN2KY/y72Ig/yWR6TIK0x5ydN00qbuAzWJ8MA8s8a5WHrGdqldSY
         0nTvap4JbcYOMa24EW9gUC2Yg1mIt2ZEQl8ae+f8RoyumXBGwO+ogfwakGTyAI/VqYP6
         9FZabbMOvtCxBllfLfr+xVpZ5Mk/L5KcBMnmg=
Received: by 10.229.99.135 with SMTP id u7mr133170qcn.44.1244580033542; Tue, 
	09 Jun 2009 13:40:33 -0700 (PDT)
In-Reply-To: <20090609201200.GA13781@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121221>

Hi,

2009/6/9 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.06.09 11:59:08 -0700, Scott Chacon wrote:
>> * breaks the various things that 'checkout' does into separate
>> commands - moves 'revert' to doing what 'checkout -- path' does
>
> Looking through the "eg revert" docs [1], I can't seem to find how yo=
u can
> do "checkout -- path" with it at all. "eg revert foo" seems to be "gi=
t
> checkout HEAD -- foo".

If you want to revert only the unstaged changes to path:
  "checkout -- path" OR "revert --unstaged path"
If you want to revert both staged and unstaged changes to foo:
  "checkout HEAD -- foo" OR "revert foo"

> The "eg revert" looks really confusing to me.
> "eg revert --unstaged --in HEAD~8". Hu? Revert unstaged changes in
> HEAD~8? Am I missing something?

Hmm.  Bad ordering, I guess -- it's revert changes in HEAD~8 to the
working copy only (by default, revert tries to apply changes to both
the working copy and the index).  Yeah, it doesn't read very well.

I'm not sure I like having "--in" as part of revert, partially because
of this confusion (and partially because I don't think it's
implementation is correct anyway).  However, I do occasionally really
like being able to revert the change _to a single file_ made in some
previous commit, so I haven't removed it from eg (yet?).  *shrug*



Elijah
