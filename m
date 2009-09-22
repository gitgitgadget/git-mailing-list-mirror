From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: [PATCH] compat/mingw.c: MSVC build must use ANSI Win32 API's
Date: Tue, 22 Sep 2009 19:54:34 +1000
Message-ID: <d2e97e800909220254sc677abeia220c19f6ef5bd28@mail.gmail.com>
References: <d2e97e800909212110w423e3b2fm85ac6f76439e0591@mail.gmail.com> 
	<4AB869EE.1020200@viscovery.net> <4AB87B6B.1070808@gmail.com> 
	<d2e97e800909220217y5bda4698pc286711a3535f87d@mail.gmail.com> 
	<4AB89B7F.3050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 11:55:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq25O-0002cA-7Z
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 11:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868AbZIVJyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 05:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755521AbZIVJyw
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 05:54:52 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:61161 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548AbZIVJyv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 05:54:51 -0400
Received: by yxe37 with SMTP id 37so4059643yxe.33
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 02:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=vYe99RXuz5frJQLevtUzX27l0odc+L1hmkcIT/wgCHw=;
        b=aYozmH9Ol2ZW8cYlhcUCTOHYnvWPNw1Y7g0xzGjSgeAEfscTkn1+q0rlkFvnz4ux4r
         TpuuYxkIEPghlzAfoGSyHgciT3KChpzovxvOI+RmWKN045s4BLFKmtNT4Re3Dx8zfBHJ
         UbHoSqW1oNr1Dw4x16q92G+Edjnb9A/wV48uA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=woLIfyXZczsiFcqA6g1pocll9omV4ObVpCUgx9X9bhJVZI0l00qt5JrUQkuB1k1Xp8
         z5RQYZMNnxUKyf9ITLTxa7+qBp+gfStuOFi0srz7Q3mrZMpHcGQUHdqN33dAnI2Kifld
         psBUx6gN18hdn7+61GpZjFEtCfLdrFcjPnwvo=
Received: by 10.100.75.15 with SMTP id x15mr736753ana.58.1253613294155; Tue, 
	22 Sep 2009 02:54:54 -0700 (PDT)
In-Reply-To: <4AB89B7F.3050902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128928>

2009/9/22 Marius Storm-Olsen <mstormo@gmail.com>:
> Michael Wookey said the following on 22.09.2009 11:17:
>>
>> 2009/9/22 Marius Storm-Olsen <mstormo@gmail.com>:
>>>
>>> Michael, how are you trying to compile git? With the IDE or the
>>> GNU Make? Which version of MSVC? If you use the IDE, can you make
>>> sure it doesn't contain the UNICODE define in the compiler
>>> section of the properties of the projects?
>>
>> I'm using the VS 2008 Professional IDE (the solution doesn't open
>> in VS 2005). I made no changes to the build settings. In the
>> Preprocessor section of the project, UNICODE is defined.
>
> Were these projects generated with the Vcproj generator in
> contrib/buildsystem, with the Qmake generator, or the projects from Frank's
> repo?

The project was generated from the vcproj generator in
contrib/buildsystem from git.git/master.

>> On another note, I see *many* build warnings for things like
>> "signed/unsigned compares". I'd be willing to work through these warnings
>> and fix them. Thoughts?
>
> Well, first find out why these are a problem with MSVC and not GCC. Are the
> types different on these platforms? signed vs unsigned should show up with
> GCC as well. We need to make sure that we don't fix signed/unsigned issues
> on one platform, just to introduce it to another platform.
> In any case, it would be good for someone to have a look at these, just so
> we can determine the cause for most of them, and then we should figure out
> on the list how to deal with them.

Well, at warning level 4, MSVC is quite verbose. Perhaps the current
gcc build flags are more forgiving?
