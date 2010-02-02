From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 18:27:43 -0500
Message-ID: <76c5b8581002021527s446fda1dh3a5001b9a4996538@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
	 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
	 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	 <32541b131002021435kadb68ffge77ad5f4e1775418@mail.gmail.com>
	 <76c5b8581002021502i2bb34967y9a88d8b25ce7fa42@mail.gmail.com>
	 <alpine.DEB.1.00.1002030014100.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:27:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcS9u-0000P7-Ti
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 00:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956Ab0BBX1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 18:27:45 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:64074 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab0BBX1o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 18:27:44 -0500
Received: by iwn39 with SMTP id 39so812526iwn.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 15:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=qX/L+8nhOBRFnl4HCZ0ZRBqdehdPKcDX5kctSQ8DS1k=;
        b=PT3V6t3nJ8t2a2YqaQIdaGE5LkZL54Ri3cPprH7f4nVnHSJdxVAHUAMti3u/ecDfgd
         PB0xjnCYeS2Aw8we9EJfdO6jtarWCcPguy5SDAsvKtaG/NmDbiW8+VfIRqviAdQXIMSs
         sAS2adQD078shqkB0KGkIjMaBCG8Cy1f0/yBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=uUKzTZ6JWVYbaeXDeKGnuA+rqHRD+iiHZV4IutcOj5uqA564K87KG14NBo2zSwH2P4
         OIMIHgmJ4toytrn5M+9VsZ7BZJtpIt4QthesN581ZS5XORDsXQUUj0MSt2dqCQKJXHlr
         Lbmgt6T3W1iGBMJ0+vj8eojXLew6tzwaZ9Ags=
Received: by 10.231.167.65 with SMTP id p1mr1249745iby.20.1265153264097; Tue, 
	02 Feb 2010 15:27:44 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002030014100.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138780>

>> Frankly, I think that "rebase -i" is the best example when exiting
>> without save should abort, not proceed.
>
> That would be horrible! If the list of commits I want to apply happens to
> be exactly what I want without needing any reordering/removing, then it
> would abort, according to you.
>

No! It wouldn't if you save instead of simply exiting, if you type :wq
instead :q

I'm obviously failing to express my self ...;)

NOTHING is supposed to change for you except that you have to save on
exit, write the file, confirm changes or absence of such, agree with
generated content of rebase sequence. That is all i'm talking about.

You MUST save the file when you do commit - right? Because this file
COMMIT_EDITMSG is empty. It will fail to commit otherwise - right?
The problem is that this file is NOT empty when there is a
prepopulated message like rebase -i sequence of commits or message
from commit being amended.
Therefore, you can exit without saving and the action will still
happen - which is wrong and not consistent with "commit"!

Exit without saving for me means FORGET what i was doing here . So, it
is obvious, that when I'm doing rebase -i and working with the list of
commits exit without saving should mean - FORGET about rebase.

Thanks,
Eugene
