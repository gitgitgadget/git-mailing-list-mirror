From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Wed, 3 Feb 2010 00:40:27 +0100
Message-ID: <40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>
	 <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
	 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
	 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
	 <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:40:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcSMH-0001GT-DR
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 00:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab0BBXk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 18:40:29 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:63209 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab0BBXk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 18:40:29 -0500
Received: by bwz19 with SMTP id 19so608793bwz.28
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 15:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ePlsavyUbYg91Ou7P7X9a7tZ8unS/0K7xX5h/p7HLLQ=;
        b=IOzuVl2q+HpHMPCmjmq+n+DMIRdFvL696NbrbWZ1HNBarvCb01SsWgROW6Ep6yfmGi
         TLQ1keE+xvtMipnlJSAjx0RtBnXJg+0d0P6K5I9YzIU7pPXGETVgpP7ESIN4PkmI6bzj
         wgCiHtVJLlqzutz4tXz36WC1Ad85SA+coxvbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=Fjr7QcKy5IejM5k5AFzcdOBVJRZQSaXVtSAF3nzWOg0fJqotTzNSiQF/lL+0fiHVh4
         aX1YXtcJYeTuX8t3KWw8k1I9ioDEsmHlIletrIm/LiOT07yHyeKQUbJaTCQwn2Rje6vY
         OmeGXN0S74QPQeOkKPD/RvoSfqKfFXgrSc21c=
Received: by 10.204.140.18 with SMTP id g18mr3162043bku.47.1265154027543; Tue, 
	02 Feb 2010 15:40:27 -0800 (PST)
In-Reply-To: <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138782>

On Wed, Feb 3, 2010 at 12:34 AM, Eugene Sajine <euguess@gmail.com> wrote:
>> Of course, you could come up with wonderfully complicated strategies such
>> as "if nothing was added, then an unmodified commit message means 'abort',
>> else it means 'go ahead'", but I hope that you agree that this would be
>> very bad from the users' POV: it would be utterly confusing.
>
> No complicated strategies necessary.
> I'm not talking about modified or not modified commit message. I'm not
> forcing anybody to modify commit message in order to proceed with
> commit --amend.
> I'm talking about consistent behaviour of main operations:
>
> Commit - you must save on exit from your editor, simply exiting will abort.
>

This is where you're wrong. The reason why commit (without --amend) is
aborting when you don't save is that the default commit message is
empty, not that it wasn't saved. In fact, just saving still makes in
abort. You need to add something to the commit message and then save
to get it to perform the commit.

> Same should be applied to rebase -i and of course to commit --amend as
> it is still commit operation.
>

"rebase -i" and "commit --amend" already has the exact same logic as
commit without ammend in this regard - they abort if the buffer is
empty.

-- 
Erik "kusma" Faye-Lund
