From: "Thanassis Tsiodras" <ttsiodras@gmail.com>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Sat, 1 Nov 2008 13:54:53 +0200
Message-ID: <f1d2d9ca0811010454u203a7c88x1e09735b3fc1358f@mail.gmail.com>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
	 <m37i7pggnk.fsf@localhost.localdomain>
	 <f1d2d9ca0810310428o166dc075wbb43c00c1a555350@mail.gmail.com>
	 <200810311726.57122.jnareb@gmail.com> <vpqej1wra1c.fsf@bauges.imag.fr>
	 <alpine.LFD.2.00.0810311549570.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 12:56:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwF5Z-0001lX-Cb
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 12:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbYKALy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 07:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbYKALy5
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 07:54:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:52123 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbYKALy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 07:54:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1336910fgg.17
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 04:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LO5//S9jliyA/ixakRoOoZ7KYwZnbFvRg7pWRjDoCYs=;
        b=D2UyPUqWy9wSqvsf+gaNZ0pU5nQitX28hkT9B7FWSoY53neDnNWOOrR6vz3uAqqvxf
         oSQ56Ld0iea4JacpNNUbttQsah4uKA/iFGidE8XcR0HFBn7AF9IoEk3mAysIyo+RGOZ1
         zondQlPWnCzydqNR/RY6pXHVlM0pqXJI0n46Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FdD98HuoNsQZQ35HxkHNx9m4Uo0ItwVBaUuY0Pwpwtamtxv8OggDy46dR6CfgWGm9X
         ygK+qoZma4fUABroYIYvGGMEN98W57Zhs3MbOoN0GFUhOk82NQcKcBmmnoOc62iRUAUn
         ko8eZhZNjcZIv5BhAnJIz0MYUZ61VICHA+54o=
Received: by 10.181.17.13 with SMTP id u13mr887978bki.152.1225540493742;
        Sat, 01 Nov 2008 04:54:53 -0700 (PDT)
Received: by 10.181.5.13 with HTTP; Sat, 1 Nov 2008 04:54:53 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0810311549570.13034@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99738>

Thanks to everybody for your help.

I will setup an alias to always use "git push --thin".
For the reverse direction, I don't see a --thin for "git pull",

My understanding is that "git pull" is optimal,
and does what --thin does for push anyway, right?

On 10/31/08, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 31 Oct 2008, Matthieu Moy wrote:
>
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>> > Thanassis Tsiodras wrote:
>> >
>> >> So I have to git-gc on my side (after the commits), git-gc on the
>> >> remote,
>> >> and then git-push?
>> >
>> > Perhaps I haven't made myself clear.
>> >
>> > On the local side: git-commit creates loose (compressed, but not
>> > deltified) objects. git-gc packs and deltifies.
>> >
>> > On the remote side (for smart protocols, i.e. git and ssh): git
>> > creates _thin_ pack, deltified;
>>
>> I don't understand this point: the OP talks about pushing, so isn't
>> the pack created on the _local_ machine (and then sent to the remote)?
>
> Yes, the pack is created on the fly when pushing, regardless if the repo
> is already packed or not locally.  The only difference a locally packed
> repo provides is a shorter "Compressing objects" phase when pushing
> that's all. The packedness of the remote has no effect at all.
>
>
> Nicolas
>


-- 
What I gave, I have; what I spent, I had; what I kept, I lost. -Old Epitaph
