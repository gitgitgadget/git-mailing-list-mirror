From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/7] remote-bzr: avoid unreferred tags
Date: Mon, 8 Apr 2013 11:30:34 -0500
Message-ID: <CAMP44s33_SrAN=RyT_8N=RTAGFGwO3FcxQPU=0aRSLCy9suVRg@mail.gmail.com>
References: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
	<1365220163-13581-6-git-send-email-felipe.contreras@gmail.com>
	<CABLWAfRfpCwxc_V1gD5QsZGgaQ7gtEfyad8dKSCNM-pA7TX6TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sandor Bodo-Merle <sbodomerle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:36:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPF2p-0004NB-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934948Ab3DHQah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 12:30:37 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:57267 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763187Ab3DHQaf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 12:30:35 -0400
Received: by mail-la0-f47.google.com with SMTP id fj20so5486727lab.6
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=HDPVA/26ENEpbVOJ/n9kYuW2dxwJEcBC+0N7RZ6Z3Ps=;
        b=DAHB2KV1MKzb6k7UVFqKsgqbzJmVSkN2q+2F+5I0qQsU8on49VOeDjTCLoXvb8gtvk
         FAFaHvA1Sym3SZo+8rkGbM/qzHvKsfxQu1kBqWy4K+gIpH608mI7JNX53lPyEREmyEMO
         MKdwaRkRWxZ/To1XlGLFF21JHOvuHpcmVT7rm2sgfwDEqR0sUK7/suYXYpaEQI6mbDcv
         i29aMS+M+FQFnVR89Sy4lxsAl9vCp9RYk5gave2n5dBIWXbOhA8FWK5QJjHEmmJAhmNq
         sut3TvvX6VNeZ72THaaT2ei+WJWu5D1zgMPhQx/7NbAzrYDSgvwPAJVm9xs8O0utSJtY
         AAKw==
X-Received: by 10.152.135.205 with SMTP id pu13mr11991004lab.48.1365438634186;
 Mon, 08 Apr 2013 09:30:34 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 8 Apr 2013 09:30:34 -0700 (PDT)
In-Reply-To: <CABLWAfRfpCwxc_V1gD5QsZGgaQ7gtEfyad8dKSCNM-pA7TX6TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220438>

Hi,

On Mon, Apr 8, 2013 at 5:33 AM, Sandor Bodo-Merle <sbodomerle@gmail.com> wrote:
> this have a regression when i try to clone the current bugzilla repository
> (previous version was ok):
>
> git clone bzr::http://bzr.mozilla.org/bugzilla/trunk bugzilla
> Cloning into 'bugzilla'...
> Traceback (most recent call last):sions:Finishing stream:Done
> 88662/886628662
>   File "/home/bms/bin/git-remote-bzr", line 745, in <module>
>     sys.exit(main(sys.argv))
>   File "/home/bms/bin/git-remote-bzr", line 734, in main
>     do_list(parser)
>   File "/home/bms/bin/git-remote-bzr", line 664, in do_list
>     history = parser.repo.revision_history()
> AttributeError: 'BzrBranch7' object has no attribute 'revision_history'

I just pushed this fix:
https://github.com/felipec/git/commit/8161a8479dfb59dfac016e3cfa292e003e7585ce

I think it would do the trick.

--
Felipe Contreras
