From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bugreport: stgit cannot export empty patch
Date: Fri, 18 May 2012 14:20:27 -0700
Message-ID: <xmqqboll2nl0.fsf@junio.mtv.corp.google.com>
References: <CAPk5vtzpUHgL_dfJLJHgKsaNPZodx1jbTRQpRdoj01RRPRoBfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stepan Koltsov <stepan.koltsov@jetbrains.com>
X-From: git-owner@vger.kernel.org Fri May 18 23:20:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVUbC-0005nH-Ac
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 23:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967530Ab2ERVU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 17:20:29 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:50118 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933132Ab2ERVU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 17:20:29 -0400
Received: by qcsp5 with SMTP id p5so421869qcs.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 14:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=yvlSaYm63efk50PTPucQPd2X7B8SU5zXPX2LkMTw44Q=;
        b=BIBWlkllmuCxbf0+f49iSbOGcT5Az0uUX3te1xtAojDiV2weKSyzldVR8DfBhOyAAn
         HOvnO+S1qkUkG6UXjywxuspPoEPWx4tgI3M4EgCKYIPqlE+uwfzViMeg4i5t0oRGJwN6
         VEYSsw5FBHVlxniywZyUvxajInTp3mY6UWX+h2NkHPojD727bE63Z9CSZ7ZorBV5tAuy
         LyoCHhuV+hlalkyVRPWFMonk218fj194HxAzcwTR2daRsgu4tbgPL9MW5eMwyUjqzwnZ
         Fw+EMnG5bMsaft2APv6/c5ypGg0c7j9OCOB4R7oQJyYgQHVKKAWiL2bvx4uvcg6OoyQw
         fX+w==
Received: by 10.101.179.3 with SMTP id g3mr5830828anp.2.1337376028459;
        Fri, 18 May 2012 14:20:28 -0700 (PDT)
Received: by 10.101.179.3 with SMTP id g3mr5830823anp.2.1337376028390;
        Fri, 18 May 2012 14:20:28 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id y36si8856605yhg.2.2012.05.18.14.20.28
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 18 May 2012 14:20:28 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 4B0541E0058;
	Fri, 18 May 2012 14:20:28 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id E8254E1772; Fri, 18 May 2012 14:20:27 -0700 (PDT)
In-Reply-To: <CAPk5vtzpUHgL_dfJLJHgKsaNPZodx1jbTRQpRdoj01RRPRoBfg@mail.gmail.com>
	(Stepan Koltsov's message of "Sat, 19 May 2012 00:57:56 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnF5w10ZEMgggjjtb8BGJoJOdOt6c+bpGpC5iSOyOcnFtyxdCd0bKc882+QLb7XjGLPCgPv4HE2nz8u1BfiaWVXl/Uxct0ZCHWvQp0roXWhcVR0M/aKKBq8uVkT75/T7PkYxQ3tMrhaTNM8hMDx1LofCCsa3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197975>

Stepan Koltsov <stepan.koltsov@jetbrains.com> writes:

> stgit fails to export empty patches:
>
> % stg new empty-patch -m 'asasas'
> Now at patch "empty-patch"
> % stg export empty-patch
> Checking for changes in the working directory ... done
> fatal: unrecognized input
> stg export: git failed with code 128
> zsh: exit 2     stg export empty-patch
>
> % stg --version
> Stacked GIT 0.16-3-g67cf
> git version 1.7.9.1
> Python version 2.7.1 (r271:86832, Jul 31 2011, 19:30:53)
> [GCC 4.2.1 (Based on Apple Inc. build 5658) (LLVM build 2335.15.00)]

I don't use (or read the sources to) StGIT, but isn't the whole point of
"stg export" to "convert your StGIT patches into patch files"?  For an
empty commit, what is an appropriate output?  IOW, is it reasonable to
have an empty commit in your history if you are planning to "stg export"
it?
