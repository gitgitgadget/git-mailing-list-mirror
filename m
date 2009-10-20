From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: ident hash usage question
Date: Tue, 20 Oct 2009 20:19:30 +0200
Message-ID: <81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
	 <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 20:19:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0JJ2-0005a7-7c
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 20:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbZJTST1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 14:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbZJTST0
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 14:19:26 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:37553 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbZJTST0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 14:19:26 -0400
Received: by fxm18 with SMTP id 18so6744219fxm.37
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m4d1oquVZxwUrAWMoJkq+dj19scoeohkf+85zXB8tyA=;
        b=vJNeSTP9QdZAbwZE6DPOGp1ssph9w6d4c/xejRjqGVnccOuETVyRtiefFQN/bXR68m
         s0OYxCcCYvAgyq9e1D/pCS6vvHzyr/MGYpOuJVVXjU8rjQc+3R66wVhlIcdkiwTKemaq
         QlZVYD0QE2thya38rJKfWeG0PTXFpQXAmg3Xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oxClSyTWoupJI/DuQur8jYvGX7XiSytDLPB8HZVJX8d/pFhwdWGwz7a78aX4ww8Sb7
         Kk1yUe/4J0sOcioSo6GoTOrpJj1JmSFpYCxI7NJCFFuijN6leaH3WymYHM2NrGOCeWi8
         4UF7f51hHfTa/J1giMojoAy1xnpOQjqdT6AmI=
Received: by 10.204.10.2 with SMTP id n2mr6713213bkn.91.1256062770111; Tue, 20 
	Oct 2009 11:19:30 -0700 (PDT)
In-Reply-To: <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130821>

On Tue, Oct 20, 2009 at 20:16, Alex Riesen <raa.lkml@gmail.com> wrote:
> On Tue, Oct 20, 2009 at 19:24, Eugene Sajine <euguess@gmail.com> wrot=
e:
>> I was able to get the $Id$ keyword to show the SHA-1 hash of the fil=
e
>> content, which is done using ident in gitattributes. Now I=E2=80=99m=
 trying to
>> find a way to get more info about the file using only this hash.
>>
>> Could you , please, advise if there is a way to get file name and pa=
th
>> inside the repo by having only this Blob hash?
>
> It is not possible.
>

Well, not exactly impossible, but you can end up with multiple paths,
some of which may not have anything to do the original path.

Just run git log --no-abbrev --raw --all and grep for the SHA-1
