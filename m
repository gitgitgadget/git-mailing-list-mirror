From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: CR codes from git commands
Date: Sun, 1 Feb 2009 23:09:38 -0800
Message-ID: <e38bce640902012309o25d64d1fs6c0bed04169a44e6@mail.gmail.com>
References: <18805.64312.289059.660023@hungover.brentg.com>
	 <alpine.DEB.1.00.0901231747340.21467@intel-tinevez-2-302>
	 <18811.32772.728276.923430@hungover.brentg.com>
	 <200901250319.05665.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 08:12:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTsyQ-0004r0-9p
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 08:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbZBBHJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 02:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbZBBHJl
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 02:09:41 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:30445 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbZBBHJk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 02:09:40 -0500
Received: by yx-out-2324.google.com with SMTP id 8so490194yxm.1
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 23:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=kPjBqnwsMsMd2nckChbg8Xb/9+0ojm5aqRGIz5x+ErM=;
        b=GsIAMvpdW6TY7fPem1rw0AQ3gYyxbOul8oL+XTykrLxJxsfiyIK3xrIgg0gWGAmy/X
         r1RTlGlDqDFLmG2xQAiZhRNVGqtTfOMTEJwxcnGGDlRwjfdgrjWqtkoMM78/u1AK3JuY
         R5zkuMpgY5AzWCPsSQKdtlfouvE14itVW0Glo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ERETiNdcka2dNJpSueMANcpirxWMtqGbaG//PsBt32h3NPc2NkcxmqH5uGXbi8mEg/
         883BJt2QFglJtbJmq+w6P3PlUnPlVicgGYkjwHhj/dtrdE+5vZx2Iyc5PJnUJ31h5Ete
         +TZ7fVYNURusqG52cdbSmbcOgo4FSS9Fjuoo4=
Received: by 10.90.66.14 with SMTP id o14mr300280aga.63.1233558579020; Sun, 01 
	Feb 2009 23:09:39 -0800 (PST)
In-Reply-To: <200901250319.05665.bss@iguanasuicide.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108057>

I'm nearing completion on the patch for the --progress and
--no-progress command-line options.  I am able to manually validate
the behavior, but am a bit stumped as to how to efficiently code up
the test script.  My manual test involves doing a git clone of the git
repository, which produces the volume of I/O sufficiently bulky to
trigger the progress message code.  But that bulk means that the test
case will take a long time to complete, hence making using a git clone
of the git code in the test case impractical.

Also, in order for the script to do its job, it will need to tell the
difference between a git run that has progress from one that does not.
 The first idea would be to simply use shell command redirection on
the git command itself, but that defeats the tty detection logic, so I
don't think that is an option either.

Does anyone have any recommendations here? If not, then I guess I will
have to forgo the test script and just submit the patch without it.

Thanks,
Brent

On Sun, Jan 25, 2009 at 1:19 AM, Boyd Stephen Smith Jr.
<bss@iguanasuicide.net> wrote:
>
> On Saturday 24 January 2009, Brent Goodrick <bgoodr@gmail.com> wrote
> about 'Re: CR codes from git commands':
> >While I'm at it, what is the standard procedure for submitting git
> >patches for review once I've cooked up and validated it on my end? I'm
> >guessing posting the patch into this mailing list is part of the
> >answer to that question.
>
> If you've got a patch, I assume you've got a checkout.  Look in
> Documentation/SubmittingPatches.
> --
> Boyd Stephen Smith Jr.                     ,= ,-_-. =.
> bss@iguanasuicide.net                     ((_/)o o(\_))
> ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'
> http://iguanasuicide.net/                      \_/
