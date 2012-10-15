From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: build deps
Date: Mon, 15 Oct 2012 17:44:46 +0200
Message-ID: <507C2F6E.9060100@drmicha.warpmail.net>
References: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com> <5072FAD1.1000807@gmail.com> <CACnwZYeJ-FKXterxd697iu+U4HobqEaP0zx_p8CZDsPZx4hbHQ@mail.gmail.com> <50735939.10604@gmail.com> <CACnwZYf56XkqW085HoWhAN2EnjCJd=VYHGAD8fZCCe6_FNhO2A@mail.gmail.com> <50776D0D.9090306@gmail.com> <CACnwZYfmz1BTo6okzFh8jXbw+0MAV0sEanYXNzAnV7L4p7nY_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andrew Wong <andrew.kw.w.lists@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 17:45:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNmqj-00089f-0Q
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 17:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571Ab2JOPot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 11:44:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53984 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751292Ab2JOPot (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 11:44:49 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A38C120D4F;
	Mon, 15 Oct 2012 11:44:48 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 15 Oct 2012 11:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=cIFouy+M68+6AH2Pd7hFwE
	V3Z1k=; b=OpMEFyPsEpSyhg0GDBr1Dl+xZHQyuL2lgF2edjrXIoROIScgnafQ+N
	1eCgkhFpuFPoT7eT2eaGGc3LRSE73uCARMIWn3bCGSlFRqBgG9lEWQh/hST9WwUC
	/Dk/DKDb+Nc7ViKIRxTrwsdrYFtsDCg/6Rup63AT+fGXO5df1TMQI=
X-Sasl-enc: KZE9bpwXYpoGIh2Is7VQqPM+HrnaV9JNWlYMC+fjRbgx 1350315888
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id BF19D4827BC;
	Mon, 15 Oct 2012 11:44:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <CACnwZYfmz1BTo6okzFh8jXbw+0MAV0sEanYXNzAnV7L4p7nY_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207755>

Thiago Farina venit, vidit, dixit 12.10.2012 06:08:
> On Thu, Oct 11, 2012 at 10:06 PM, Andrew Wong
> <andrew.kw.w.lists@gmail.com> wrote:
>> On 10/11/12 16:54, Thiago Farina wrote:
>>> Just setting CC to gcc works for me. But still, I'd like to be able to
>>> build with clang (may be as you noted is just something with the + in
>>> my PATH).
>> Oh, I just realized you were using "sudo". The PATH environment was
>> probably not inherited when you use sudo to run "make". So the
>> subsequent shells statred by "make' were not able to find "clang".
> 
> Interesting, thank you for your observation.
> 
> This worked for me now:
> 
> $ git clone  https://github.com/gitster/git
> $ cd git
> $ make configure
> $ ./configure
> $ make
> $ ./git version
> git version 1.8.0.rc2
> 
> clang reported this:
> combine-diff.c:1006:19: warning: adding 'int' to a string does not
> append to the string [-Wstring-plus-int]
>                 prefix = COLONS + offset;
>                          ~~~~~~~^~~~~~~~
> combine-diff.c:1006:19: note: use array indexing to silence this
> warning
>                 prefix = COLONS + offset;
>                                 ^
>                          &      [       ]
> 1 warning generated.

Does

&COLONS[offset]

silence that?


> grep.c:451:16: warning: comparison of unsigned enum expression < 0 is
> always false [-Wtautological-compare]
>                 if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
>                     ~~~~~~~~ ^ ~
> 1 warning generated.
> 

Right, that enum type starts at 0. Junio, you last touched this area.
Can we just dump the first comparison or did you have something else in
mind?

Michael
