From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Wed, 3 Feb 2010 10:45:54 -0500
Message-ID: <76c5b8581002030745g634d6ec1hb9e87b687e58e521@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
	 <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
	 <40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
	 <76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
	 <vpqeil2kc6b.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 03 16:46:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NchQX-0002zT-Hd
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 16:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276Ab0BCPp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 10:45:56 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:48828 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809Ab0BCPpz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 10:45:55 -0500
Received: by iwn1 with SMTP id 1so761045iwn.24
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 07:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=0ThPLGjaxCmbHO4YSrd3UUpqICzpLm7911f4bR0pVbM=;
        b=IRs1vQBxz/FrWl+Cpyp2T1Ou4TN3j7eMXCz1Ca8SwomvaLRP+JTDpJHsEXNgV0qE9n
         y9GvTLsRjLanMjAQwPQxr9yhIODqvHnR45vJc3Amxn3REHo88lIfSzpta0tlEQIB1J5n
         KpXwF7d31ZNJPVVk10laCSgZ9RRxpnsjeoHYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nFvllN86NKkfEIZqP5V1Xigx9Vrqgli25qurZUVcx+6fKS9IR/R6rjtzuPaJMsAXh3
         eIamwIYWAMrCbQkL3g61HXXTSNDDaKGWRUcX0qTX8PEnM+OhL1eJOlo8pnUjqgQrzdSj
         KUb1WYEr/SIvSCoEMZgzTE60wD6KN+8ICSsJo=
Received: by 10.231.167.65 with SMTP id p1mr3014680iby.20.1265211954533; Wed, 
	03 Feb 2010 07:45:54 -0800 (PST)
In-Reply-To: <vpqeil2kc6b.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138838>

On Wed, Feb 3, 2010 at 2:31 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> Thank you, but I'm not wrong, as i described the exact same thing
>> somewhere in my second or third message, without even knowing the
>> implementation details. I understand the reason WHY it is like it is,
>> i just don't like it as it is inconsistent and IMHO incorrect.
>
> Just try:
>
> Create a file.
> 1) Launch emacs, save and quit.
> 2) Launch emacs, don't save, and quit.
>
> From outside, it's EXACTLY the same thing. In the first case, emacs
> will just tell you "no change need to be saved" and quit, in the
> second, it'll quit. Try deleting the file in the meantime, it won't
> change the behavior.
>
> Now, what would you do about this? Ignore Emacs and force people to
> use vi?
>
> People have been spending a whole thread to explain you that it's not
> going to work. I think it'll either be time to acknowledge that, or to
> learn C and write a patch. Or perhaps try to write it in Java to
> understand why it doesn't work.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>

Tell me you're not serious, please;) I'm working with computers for
more than 20 years and I do understand how editors are opening files.
If you are serious though...:

Please, do not assume i don't understand that file opened in editor
and saved with no changes will be the same as not saved.

Please, do not assume i don't understand that current implementation
does not allow to correctly abort by simply quiting the editor,
because it uses the file content only to verify if it can proceed.


I will stop trying to explain the problem here, but the solution, that
i think should work:

The solution should be as Avery proposed - to monitor file
modification timestamp as well as the content.
Timestamp should be remembered by git when editor is fired up and then
checked when you're exiting the editor. If it is the same - it means
that user canceled the whole operation by not confirming the file
content by save. If the timestamp is bigger than the saved one and the
message is not empty - we can proceed. Something like that.

And finally:

I DO highly appreciate everybody's time spent on every discussion and
particularly this one. I ask you to excuse me if i was failing to
properly express my thoughts or if i was too emotional at times.

Thanks a lot,
Eugene
