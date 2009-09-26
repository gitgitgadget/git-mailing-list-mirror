From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: git clone sending unneeded objects
Date: Sat, 26 Sep 2009 01:43:57 +0100
Message-ID: <3ace41890909251743v7a51027agb039514dd0636058@mail.gmail.com>
References: <m2tz0j154o.fsf@igel.home>
	 <alpine.LFD.2.00.0908082246020.440@xanadu.home>
	 <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com>
	 <vpqvdj6izt6.fsf@bauges.imag.fr>
	 <alpine.LFD.2.00.0909251551290.4997@xanadu.home>
	 <4ABD25FE.2040902@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jason Merrill <jason@redhat.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 02:44:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrLOP-0001MG-Gz
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 02:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbZIZAnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 20:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752840AbZIZAny
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 20:43:54 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:32937 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbZIZAny (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 20:43:54 -0400
Received: by fxm18 with SMTP id 18so2594952fxm.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 17:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=7l7BCGtSmCCv3jZRQ0JYDowU4hrZlKTvOm0ogYLybas=;
        b=grcMPtygo840xbQVqwQL36p49TjGBiE4Ts1J3ygX/lRrnuGvaJ6JQWQII8yKxj8bxr
         T/f7Lkvh24aED33xBDFa60KqtSqQGt9tgXrRBV0Fwr+wPzOOEx7nNd3iRviqqFyYcq0m
         GnJtCxfOlhnRoVL9imLTMLhg9LfqpnRGNvbI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VqKkajRvvma5ZBWA2wZUvN/QbUXbA9+Si1NmLyK2mFDQYeW2oE6TY9LfN9cLs9khPz
         HXJbJVVpgK8VRvpu6AMGrfPsvAwRcOkPp0rS3tLux5Vbw6O/ebrpHes78wrQo4Tjt231
         6+xBCEK0VfR+Y88GO5dTHwBV2V0dDAa01ksyg=
Received: by 10.223.23.74 with SMTP id q10mr250533fab.14.1253925837451; Fri, 
	25 Sep 2009 17:43:57 -0700 (PDT)
In-Reply-To: <4ABD25FE.2040902@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129138>

On Fri, Sep 25, 2009 at 9:20 PM, Jason Merrill <jason@redhat.com> wrote:
> On 09/25/2009 03:53 PM, Nicolas Pitre wrote:
>>
>> I did reproduce the issue with git:// back when this discussion started.
>> I also asked for more information about the remote which didn't come
>> forth.
>
> Looking back, I only see you asking about the git version on the server,
> which is 1.6.4.

Hmm, I was under the impression from the previous thread that the
server is a bit older and/or have more backward compatible settings to
cater for older git clients?

>
> So again:
>
> git clone git://gcc.gnu.org/git/gcc.git
>  (1399509 objects, ~600MB .git dir)
> git gc --prune=now (988906 objects, ~450MB .git dir)
>
> ...then
>
> git clone git://gcc.gnu.org/git/gcc.git --reference $firstclone
>  (573401 objects, ~550MB .git dir)
> git fsck (clean)
> git gc --prune=now (5 objects, ~7MB .git dir)
>
> What's going on here?

FWIW, I still have my clone (git://) and do my periodic 'git fetch'
and 'git gc prune=now' (learned my lessons!) and it is currently .git
dir is about 350MB. (from previous discussion the optimal at the time
was about 300MB, so it has grown a bit in the last couple of months).

And thanks everybody for all the discussion and advice. git is a great
tool. (and I have essentially stopped using svn, prefering git-svn!).
