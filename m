From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Sun, 3 Aug 2008 09:54:42 -0700
Message-ID: <905315640808030954j7487a010p136c73406298ee29@mail.gmail.com>
References: <488772BC.80207@workspacewhiz.com>
	 <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness>
	 <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no>
	 <20080725140142.GB2925@dpotapov.dyndns.org>
	 <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no>
	 <20080729134619.GB7008@dpotapov.dyndns.org>
	 <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no>
	 <80518F08-A9A9-4190-9AC4-D24DD6A1188B@zib.de>
	 <32541b130807301133w4bfc8288oa2d15911b2317dca@mail.gmail.com>
	 <56C07978-D6C9-4219-8B92-6217BD33F6D4@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Eyvind Bernhardsen" <eyvind-git@orakel.ntnu.no>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Joshua Jensen" <jjensen@workspacewhiz.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 03 18:55:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPgrz-00059w-Fy
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 18:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbYHCQyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 12:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756446AbYHCQyp
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 12:54:45 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:23444 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277AbYHCQyp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 12:54:45 -0400
Received: by ik-out-1112.google.com with SMTP id c28so2175194ika.5
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 09:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=Ke6GoloHwCw6CZmuiutdLH2ZCEv4vsnTfSU95nThYgM=;
        b=tE+J0B5UIa3JxWfChU0xkTVJsG3zi9ooH4jGLYdI+muLY/9K7lmB2ZUFCb+tlfXdKo
         Nict5/kPZcnNxkhz+z6nmoPOWfG3eVIGi3fnFiWdIJ+paOD9s/779E76lgneNfjQtzyx
         Tud6qx2KPY3JWsNYQmqHvUXXuLeo7ScQ3JIGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=rhDYU4iyXchq5EKFhbxmDHjM8haLkBxuN62IgPY5K2mkQ3EyvbzJ9M0iZiMimZO1B6
         DJyzys3wO4EggERaWxzz//InB8CKl46dhzAB2Iu6xXepHydQpcxL0ByTy5bV3BEK+gLR
         94phhT0rD9z6MzAQRVqmXPPo6oQSxhKLgEoGE=
Received: by 10.210.25.18 with SMTP id 18mr15838201eby.152.1217782483016;
        Sun, 03 Aug 2008 09:54:43 -0700 (PDT)
Received: by 10.210.109.18 with HTTP; Sun, 3 Aug 2008 09:54:42 -0700 (PDT)
In-Reply-To: <56C07978-D6C9-4219-8B92-6217BD33F6D4@zib.de>
Content-Disposition: inline
X-Google-Sender-Auth: e0bab77a1948490c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91252>

On Wed, Jul 30, 2008 at 12:25 PM, Steffen Prohaska <prohaska@zib.de> wrote:
>
> On Jul 30, 2008, at 8:33 PM, Avery Pennarun wrote:
>
>> On 7/30/08, Steffen Prohaska <prohaska@zib.de> wrote:
>>
>>> What matters is that git gives you exactly back what you committed.  It
>>> does so with core.autocrlf=true, unless you check out with a different
>>> setting for autocrlf.
>>
>> You can tell that this statement isn't quite true because if you have
>> a file with mixed LF and CRLF line endings, which I do (thanks,
>> Windows!) then CRLF->LF conversion is not a reversible operation.
>> Interestingly LF->CRLF still is (because an LF->CRLF'd file will never
>> have a bare LF, and on such a subset of files, CRLF->LF is
>> reversible).
>>
>> Also note that core.autocrlf=input is *definitely* not a perfectly
>> reversible operation.
>
> You are absolutely right.  The files your describe are modified by git,
> because they are "invalid" text files, as git defines them.

For all I care, git can consider the files as binary, but by *default*
I should get back the same as I put in.

[For the rest of my rant, I am referring to the default configuration
of autocrlf on windows]

> For git's
> autocrlf mechanism to work, a text file is only allowed to have a
> *single* type of line endings.

Git's autocrlf mechanism can be a nice feature.  But by default it
should not be on (even on windows) because it can modify screw up my
files.

To be clear: when I say "git checkout" I want to get EXACTLY the same
bits as went in when I did "git add" and "git commit".  Any other
default is broken.

> Otherwise it is broken and git tries to
> help you fixing it.

My files were NOT broken when I put them into git.  I committed them
known good state.  If msysgit changes them by *default* , then msysgit
is broken.

IF you are working on a cross platform project, then setting autocrlf
on windows might be nice.  But having it on by *default* is broken.

Thanks,
Tarmigan
