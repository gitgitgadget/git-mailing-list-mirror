From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC PATCH v2 2/3] Introduce git-discard
Date: Fri, 24 Jul 2009 20:12:56 +0200
Message-ID: <36ca99e90907241112p6cc2c875q5fa4becd1169bfd3@mail.gmail.com>
References: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
	 <cf51e6aa92ea98fc9409826cc0468a01fdf7b01e.1248452530.git.trast@student.ethz.ch>
	 <51419b2c0907241102s31c2fbaeof81e2fb053465c89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 20:13:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUPGT-0002yJ-14
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 20:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbZGXSM6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 14:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbZGXSM6
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 14:12:58 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:63552 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbZGXSM5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 14:12:57 -0400
Received: by fxm18 with SMTP id 18so1585855fxm.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Yhn9wQMDnZt6+MBR7kxbOBCftr2v2xgw1loAmrsh0sY=;
        b=Q36R7cov7r/k5MbI8LVNtFRRkddIh2lgDf2KKz8JGFkTJdUxJYMdDbV8kIVqi2WUwL
         Rt9oX7q9Qj2IULtHiiS0YsfApeCKQxTRPNPxDLJVZY8y8oMEkbMAWcAQtqhtC6pNDjEu
         caW84R4uBl36bpax2JddJRf3VGd5r72nACacg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BULD+kMyxGLTx+zpChoAlHoZepvAO+AyuJHmX11yNuyo6QX+auoIb2TsQBvoLi+Prs
         6kVqStj6ma+KVii2zUs8itFUuM4NfR2Fy+7FJh4nZ6B1dTnuqDGVBWq6qWgdtF7icSAb
         O+Cx7dHAkdLFaeFyqTfYs6zwEQST/ff/EyDiY=
Received: by 10.223.119.198 with SMTP id a6mr1886110far.42.1248459176881; Fri, 
	24 Jul 2009 11:12:56 -0700 (PDT)
In-Reply-To: <51419b2c0907241102s31c2fbaeof81e2fb053465c89@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123938>

On Fri, Jul 24, 2009 at 20:02, Elijah Newren<newren@gmail.com> wrote:
> On Fri, Jul 24, 2009 at 10:24 AM, Thomas Rast<trast@student.ethz.ch> =
wrote:
>> The new command 'git discard' is precisely the same as 'git checkout=
 --'.
>> +(This is the same as `git checkout \-- <paths>`.)
>
> Actually, there's an important difference:
>
>> + =C2=A0 =C2=A0 =C2=A0 exec git checkout "$@"
>
> $ git branch foo HEAD~20
> $ touch foo && git add foo
> $ echo hi >> foo
> $ git discard foo
> A =C2=A0 =C2=A0 foo
> Switched to branch "foo"
>
> You really do need that "--".
You fall into the same trap as me for patch 1/3. He does not shift
away the '--', so it is still in "$@".

Bert.
