From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 15:36:45 -0400
Message-ID: <m2g32541b131005071236u962d2c73n85d25093d1e048bb@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071529050.14468@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri May 07 21:37:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATMI-0001LH-4X
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075Ab0EGThI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 15:37:08 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:50739 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab0EGThG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 15:37:06 -0400
Received: by gxk9 with SMTP id 9so1068321gxk.8
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0Wo/PHdMLl1qKM3vDSmVcGdMciYjQqEy6Bz9xjprq7s=;
        b=meb7HiL5FdGtLXyuWD3vKzZs4Y6ybqfUda4se3/5tQHOHkxTvfeXZdNDlvs6QmwMrl
         yC6mRnJgkC1dTsk5YUZN0jkXaX7YU8FBl8HQUSSrF7QKjg3q+J4zoyYWTPey56IqDM26
         1L9xnt0ea8MUPLQaVlQvXV40EyFj50ku78frs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lOGQMW3BHlibx8obRA3spfbobrmlxcYRhYiPFoxzbKdo4uTGuzzsw4QKQZlw0bHfeV
         ce2aF00ogrDpjckQU8tKNLIqi7Afhaj6a8jyhwq2LNajGuFCnMzqLFj5JfR7P3dEEmcb
         uZXMrMv3HfATdDkIrTXLqposlQwT42j6chvOM=
Received: by 10.150.239.1 with SMTP id m1mr3542594ybh.311.1273261025192; Fri, 
	07 May 2010 12:37:05 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 12:36:45 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071529050.14468@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146563>

On Fri, May 7, 2010 at 3:31 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 7 May 2010, Linus Torvalds wrote:
>> Btw, another option might be to start searching ".gitconfig", but on=
ly
>> allow a certain "safe subset" of config options in that. Things that=
 can
>> really be about the project itself, and not per-user or per-reposito=
ry.
>>
>> And parse it before ~/.gitconfig and .git/config, so that people can
>> always override it.
>>
>> I dunno. Looking at the config options, there really aren't a lot of=
 them
>> that make sense on a project scale. There's a few, though. Things li=
ke
>>
>> =A0 =A0 =A0 core.autocrlf
>> =A0 =A0 =A0 i18n.commitEnconfig
>>
>> and possibly others..
>
> Given that only a subset of gitconfig could make sense to have
> distributed, I think the file should be named .gitparams to make the
> distinction clear.

Since the options it *does* have are exactly the same as .git/config,
however, naming it .gitconfig makes sense.  I'd say just print a
warning when reading options that are going to be ignored for security
reasons (or because they're not known at all, or whatever).

Avery
