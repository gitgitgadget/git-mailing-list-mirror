From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Mon, 15 Apr 2013 18:30:45 -0500
Message-ID: <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 01:31:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URsrV-0006wq-HQ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 01:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934405Ab3DOXas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 19:30:48 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:44945 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934113Ab3DOXar (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 19:30:47 -0400
Received: by mail-la0-f43.google.com with SMTP id eg20so4095905lab.16
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 16:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=k48xYP8pI/8P7h7mn51wKSIkNKhLhvXX5Z60PqX5jRE=;
        b=VRSvrVDCrphRjdu79sMwdrAQAzCj1i3M77CTqweX6v4lpr01nOHdZ4cD/h2bB9FUq4
         6fxfGxuBX7jgTa8q5+VNAUP5qKu4kRD0GNHYeqjfd6KSTL5kur6/iwTASQv6LyPSig84
         BeMm5//a31M53uQ+pvYNGOQrfRT48zGVB3ZTQMtZ1Fudfq6NzkVvbuoGIL3QJZyPEdTG
         Ife8E0BYKKI/3DQ7jvB5Y6hF4T4aSdBylumnvS+GDt+tlq+YDbY8XNcmjmf6J2ZXYvbJ
         nN2n+dauVzlf1OazZ/vf6XSAEEzB+GVb0n8c44rlQhPAodiPavm7UYvmudwNlyv9oQ85
         qEkg==
X-Received: by 10.112.131.71 with SMTP id ok7mr133350lbb.135.1366068645733;
 Mon, 15 Apr 2013 16:30:45 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Mon, 15 Apr 2013 16:30:45 -0700 (PDT)
In-Reply-To: <7vip3npet0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221331>

On Mon, Apr 15, 2013 at 6:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> And about this:
>> http://mid.gmane.org/1365638832-9000-3-git-send-email-felipe.contreras@gmail.com
>
> What about it?  Is that the one you said you are going to reroll?

At first, but then I changed my mind.

> I do not recall the details of Peff's complaints, but re-reading the
> log message of the patch itself, seeing "correctly" twice is not
> satisfactory.  As you very well know, a bug description that says
> "This does not correctly work!" and stops there is not as useful as
> a description that defines what "correct" behaviour is expected.

  The subject is: transport-helper: update remote helper namespace

Clearly, that's the correct behavior. Why would anybody send a change
that does something other than the correct behavior?

---
When pushing, the remote namespace is updated correctly
(e.g. refs/origin/master), but not the remote helper's
(e.g. refs/testgit/origin/master).
---

So it should be clear now: the remote namespace refs/origin/master is
updated, but not the remote helper's namespace
refs/testgit/origin/master, which is what I already said. I don't know
what more do you expect. When you push 'refs/heads/master' to origin,
you expect 'refs/remotes/origin/master' to point to the same commit,
same with 'refs/testgit/origin/master', why would you expect to point
somewhere else?

> If one of them said "update correctly to record what was pushed" or
> something like that, that should be sufficient.

Sure, it's still under the definition of "cooking" in my mind. Anyway,
I'm not feeling a great urge to resubmit this patch just because of
the commit message, which I think it's perfectly fine. There's more
interesting things work on.

Personally I feel it's preferable to fix the actual issue that is
already present rather than hold it because the commit message might
or might not be enough for hypothetical point in the future.

Cheers.

-- 
Felipe Contreras
