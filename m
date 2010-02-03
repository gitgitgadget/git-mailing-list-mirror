From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 19:55:31 -0500
Message-ID: <76c5b8581002021655k5f63b81h1c55ae87625fbfc5@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
	 <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
	 <40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
	 <76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
	 <40aa078e1002021616s3098bf53la6af93ab0949e7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 03 01:56:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcTXc-0006pa-Vb
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 01:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023Ab0BCAzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 19:55:33 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:34684 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab0BCAzc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 19:55:32 -0500
Received: by iwn39 with SMTP id 39so894896iwn.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 16:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=I9HywlbnD0Cqa1bS6edv5EPqbOqveC8VZ1QrMnEQTYE=;
        b=HLslIb+5VwJNLM6fM75RHFbLlAhmiEVel6XDi/ZPPGBtx/OzxZdnWAD2Hoz5DUUBno
         6KaaLqWYzGpU7OMtTsBYOoOoPZwGuV4hn70vbhiGb3YskQ8Iw6Q5GOdOAs7NIGgBuRSw
         M/pFGFUD7L2sVKEwWoCwv9nvUn9i27eJG/uRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BxALFDcgI9ApHh339ma5rG0oFxpNDbsTgtTXz8upEUK73i1Q9PUr1MdZEyra584Uqs
         rpa3FXg8ot6Qp9SYWHTMM4wVsk5nFYKNZvatw5L1TELV0gewbCImaRzDSS6mPtDknf+S
         +BMSzZwaCljD1ED9PHx2+SyahfdI02XO7i/Dw=
Received: by 10.231.154.207 with SMTP id p15mr1005089ibw.91.1265158531428; 
	Tue, 02 Feb 2010 16:55:31 -0800 (PST)
In-Reply-To: <40aa078e1002021616s3098bf53la6af93ab0949e7e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138794>

On Tue, Feb 2, 2010 at 7:16 PM, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> On Wed, Feb 3, 2010 at 12:48 AM, Eugene Sajine <euguess@gmail.com> wrote:
>>>
>>> This is where you're wrong. The reason why commit (without --amend) is
>>> aborting when you don't save is that the default commit message is
>>> empty, not that it wasn't saved. In fact, just saving still makes in
>>> abort. You need to add something to the commit message and then save
>>> to get it to perform the commit.
>>>
>>>> Same should be applied to rebase -i and of course to commit --amend as
>>>> it is still commit operation.
>>>>
>>>
>>> "rebase -i" and "commit --amend" already has the exact same logic as
>>> commit without ammend in this regard - they abort if the buffer is
>>> empty.
>>>
>>> --
>>> Erik "kusma" Faye-Lund
>>>
>>
>> Thank you, but I'm not wrong, as i described the exact same thing
>> somewhere in my second or third message, without even knowing the
>> implementation details. I understand the reason WHY it is like it is,
>> i just don't like it as it is inconsistent and IMHO incorrect.
>>
>
> But you are. The interface isn't inconsistent. Your model of how it
> works however, is wrong.
>
> --
> Erik "kusma" Faye-Lund
>

I'm sorry, but I don't get in which part my model is so wrong? The only
difference i see between your and my explanation is that you mentioned the
fact that simply saving the pregenerated new commit message is not working
because there is no meaningful (uncommented) string inserted into the
template. But this
doesn't change the problem it self, so I don't think it is relevant.

What is relevant though is that in current workflow with "rebase -i"
you have to remove! all
commits listed for rebase and save! the file in order to cancel! rebase
operation. This is very strange user interaction model IMHO

Instead of being explicit in applying the changes, we are explicit in
cancelling the operation. Very strange...

Thanks,
Eugene
