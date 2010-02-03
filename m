From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor
 with no changes written
Date: Wed, 3 Feb 2010 11:51:19 -0600
Message-ID: <20100203175118.GA2982@progeny.tock>
References: <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
 <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
 <40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
 <76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
 <vpqeil2kc6b.fsf@bauges.imag.fr>
 <76c5b8581002030745g634d6ec1hb9e87b687e58e521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 18:51:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcjO1-0004pY-Ni
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 18:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932786Ab0BCRv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 12:51:29 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:64976 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932729Ab0BCRv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 12:51:28 -0500
Received: by fxm7 with SMTP id 7so1847116fxm.28
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=L6QsHBEanA4NRZGV7b0RcGmatubqOAsNGcN3etbVlsY=;
        b=CHbmOIbGJwjhmYkNL1kpMV7AHaTIGR9d4jollB2zGe8APUyPrq+iUwYfST0TF0/3DO
         N4RVaZkxZ8u2vyi7N535eWmWWG1+KANwIJzuN9q2GYlTnlEICDMULDu2OJd/2gZ5LLuA
         nf14WL4qN5ln+T++kaboi/1Lw8PbcoKtQfoLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=G/+GJgOfRydScRuot5wsyS2LvxPqotsitwRkAdnPvLOJqe5Iaar6D2fQkXV52hGwjp
         lHW7FlLUTJBfbu4UkFLgN7SEieJ8BsKgvp7jr8XafM2p/9nIJl4UVSN51oaxGztU9qTa
         JqamhRSdf4STWw75L57JuGSz/GMikkXUEF2xo=
Received: by 10.223.4.145 with SMTP id 17mr495151far.17.1265219486552;
        Wed, 03 Feb 2010 09:51:26 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f31sm5197806fkf.12.2010.02.03.09.51.23
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 09:51:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <76c5b8581002030745g634d6ec1hb9e87b687e58e521@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138850>

Eugene Sajine wrote:
> On Wed, Feb 3, 2010 at 2:31 AM, Matthieu Moy

>> Just try:
>>
>> Create a file.
>> 1) Launch emacs, save and quit.
>> 2) Launch emacs, don't save, and quit.
>>
>> From outside, it's EXACTLY the same thing. In the first case, emacs
>> will just tell you "no change need to be saved" and quit, in the
>> second, it'll quit. Try deleting the file in the meantime, it won't
>> change the behavior.

> Please, do not assume i don't understand that file opened in editor
> and saved with no changes will be the same as not saved.
>=20
> Please, do not assume i don't understand that current implementation
> does not allow to correctly abort by simply quiting the editor,
> because it uses the file content only to verify if it can proceed.

I=E2=80=99ll bite.  Please reread Mattheiu=E2=80=99s message.  Pay part=
icular attention
to the lines

	In the first case, emacs
	will just tell you "no change need to be saved" and quit, in the
	second, it'll quit.

and

	Try deleting the file in the meantime, it won't
	change the behavior.

and consider what this means about what is happening and the resulting
stat() information.

It is a bit frustrating to read this thread because Mattheiu was not th=
e
first thing to say this (and many have mentioned other problems, too,
such as people=E2=80=99s muscle memory), but you do not seem to respond=
 to them.
Instead, you keep repeating the same thing...

Hope that helps,
Jonathan
