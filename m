From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Wed, 3 Feb 2010 13:49:46 -0500
Message-ID: <76c5b8581002031049t5558a700qe2e05bb70d175305@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
	 <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
	 <40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
	 <76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
	 <vpqeil2kc6b.fsf@bauges.imag.fr>
	 <76c5b8581002030745g634d6ec1hb9e87b687e58e521@mail.gmail.com>
	 <1088CD70-9D6E-4B97-9A46-BDDE1535B703@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 19:50:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NckIa-0000To-3g
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 19:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757159Ab0BCSty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 13:49:54 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:37794 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757110Ab0BCStx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 13:49:53 -0500
Received: by iwn39 with SMTP id 39so1912619iwn.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zr89HMqeVYRG5NvCZrYk9TgL2n+EDOAImx6zjy+kB9k=;
        b=jYIEH4awTYXjw91XJTfZK3pqF+1MjDshGbTksKxzIFrEh9H9WOOEBmkiF80d3Ezwtb
         zXWYODmG2JcTznZqoVyS6dUtq1YD34sAQCC0cOgLB/+An5vVuA9+oJ/GM+M6qKK3W9dp
         JWHzLzBTJuF7DC+vVKTVqXMQyYmZT1W+N1fbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lOrVf+tAHmr4+q83z0NyTap+VWI/8l4xbduNVBoyTZ8pnelnN8+XJGoMeBwmGWUlAZ
         uWK/AOWV7Wu8W1BvzvFi6dgTX/pgk9nF4gSE0+K9bQJxcb0ovGBigYdKlSHFOMMmQ3CL
         JfRkaPmNDp/+p3lVL9QsbxIj7W8LGK/TcGIos=
Received: by 10.231.149.9 with SMTP id r9mr2119602ibv.82.1265222986596; Wed, 
	03 Feb 2010 10:49:46 -0800 (PST)
In-Reply-To: <1088CD70-9D6E-4B97-9A46-BDDE1535B703@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138861>

On Wed, Feb 3, 2010 at 1:21 PM, Wincent Colaiuta <win@wincent.com> wrot=
e:
> El 03/02/2010, a las 16:45, Eugene Sajine escribi=C3=B3:
>
>> On Wed, Feb 3, 2010 at 2:31 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>
>>> Eugene Sajine <euguess@gmail.com> writes:
>>>
>>>> Thank you, but I'm not wrong, as i described the exact same thing
>>>> somewhere in my second or third message, without even knowing the
>>>> implementation details. I understand the reason WHY it is like it =
is,
>>>> i just don't like it as it is inconsistent and IMHO incorrect.
>>>
>>> Just try:
>>>
>>> Create a file.
>>> 1) Launch emacs, save and quit.
>>> 2) Launch emacs, don't save, and quit.
>>>
>>> From outside, it's EXACTLY the same thing. In the first case, emacs
>>> will just tell you "no change need to be saved" and quit, in the
>>> second, it'll quit. Try deleting the file in the meantime, it won't
>>> change the behavior.
>>>
>>> Now, what would you do about this? Ignore Emacs and force people to
>>> use vi?
>>>
>>> People have been spending a whole thread to explain you that it's n=
ot
>>> going to work. I think it'll either be time to acknowledge that, or=
 to
>>> learn C and write a patch. Or perhaps try to write it in Java to
>>> understand why it doesn't work.
>>>
>>> --
>>> Matthieu Moy
>>> http://www-verimag.imag.fr/~moy/
>>>
>>
>> Tell me you're not serious, please;) I'm working with computers for
>> more than 20 years and I do understand how editors are opening files=
=2E
>> If you are serious though...:
>>
>> Please, do not assume i don't understand that file opened in editor
>> and saved with no changes will be the same as not saved.
>>
>> Please, do not assume i don't understand that current implementation
>> does not allow to correctly abort by simply quiting the editor,
>> because it uses the file content only to verify if it can proceed.
>>
>>
>> I will stop trying to explain the problem here, but the solution, th=
at
>> i think should work:
>>
>> The solution should be as Avery proposed - to monitor file
>> modification timestamp as well as the content.
>> Timestamp should be remembered by git when editor is fired up and th=
en
>> checked when you're exiting the editor. If it is the same - it means
>> that user canceled the whole operation by not confirming the file
>> content by save. If the timestamp is bigger than the saved one and t=
he
>> message is not empty - we can proceed. Something like that.
>>
>> And finally:
>>
>> I DO highly appreciate everybody's time spent on every discussion an=
d
>> particularly this one. I ask you to excuse me if i was failing to
>> properly express my thoughts or if i was too emotional at times.
>
> Perhaps you could invest a little time actually reading what people h=
ave
> written. Your proposal won't work because in the case where the user =
wants
> to keep the commit message without any modifications many editors won=
't
> touch the file even if people explicitly save it.
>
> Wincent
>
>

Thank you for clarifying that.

OK. I admit I got confused with the fact that some editors (vi,
kwrite, gedit - i just tested them to be 100% sure) do allow you to
hit save right after the file was opened and the timestamp will be
changed, while emacs or open office writer or some others do not, if
no changes has been made. Therefore there is no way to actually change
the timestamp on the file from editors like emacs without actually
changing something.

I'm very sorry for confusion, so, please, accept my apologies for
being stubborn.

I hope it is clear that my only intention is to try to make git better
and provide useful feedback and I'm sorry i didn't succeed this time.

Thanks,
Eugene
