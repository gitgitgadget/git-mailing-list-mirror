From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 25 Mar 2016 04:44:18 -0400
Message-ID: <CAPig+cTH-3PqZFyP_R1FyTPKhRhbbLRDeYfv2TcVq=gq=ZpRcQ@mail.gmail.com>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
	<1458591170-28079-1-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cSdegoGNCMBMcHyEYiE+LUzixvdk-qu0Q-zbFvatX2=KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 09:44:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajNM3-00085B-6V
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 09:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbcCYIoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 04:44:23 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:32818 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbcCYIoT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 04:44:19 -0400
Received: by mail-vk0-f68.google.com with SMTP id a62so6844398vkh.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Ctq+WYPjgX/qwrclefEiAsXOAzbQJC+093lhyk0Cwms=;
        b=tLqTmdgLU/7VVoLpYRjA+jpOamSSgGncb4bWVz5iq1P1yHN3RllReZbeTUh+rHbxh1
         +FxAMf8kPLKHlTRt2nRUCgucnafPFO7YZlPBllLPnCNOPejB6plklGbOudNHr9QW8Zxs
         NW7xj04FdlqqFxcLkkZG1MrUnnIvP4C0VaoUqrjjzlfYK7VmRdflHLOw0ozuK7iucSWf
         ufyMdZj4bP66X3CDFgsgKvQUnBQpCBZn30pOdGvCILj1MqRzv3IczrodCLle4QL12KEW
         gKcAYNhncnq7L8FVKvmVNZqp/GdHBXq1cxLR679UB8OPPeWrmK/RM9cL8TYIpu18pguG
         s/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Ctq+WYPjgX/qwrclefEiAsXOAzbQJC+093lhyk0Cwms=;
        b=NA3ERDtJtsx/q83qlQxNczdflT8tSjv4atYcCtHG0YmqVmTQSQ2I0muGLvb561wzCs
         Kew/hRC51HN3y/09/o/ss7puPb6zg94q0aqjrpRTKY/2d7g9zR+dIlUrrcWE1S3KQD6y
         INUs0jLfTpatr4CF+KPXSncfu6TE77MMJTFrHAaDQ+W1FkIkXFdhlPM/qEUL0SqBgndB
         fiBevfBLrST1irNfuoYcLwOIcIls6Uta5cG2QAoXpy7nnIrt1HLG8+k6fBv3S+PX6uEJ
         vmtOQACUNFQ2BwXZI1q1wKn1JPsnNfnGaZTBO54ihX2/D5ilamCU6fu6Y/P104I5Z6Sn
         tkow==
X-Gm-Message-State: AD7BkJJE264NQzjoGlyreoXE3Hfg6FHYkKr2XHWTOkms0R7hqw07iUDq4rJeT8lFvL/I577ETmrn7dLf11hH2g==
X-Received: by 10.159.37.101 with SMTP id 92mr6682303uaz.66.1458895458339;
 Fri, 25 Mar 2016 01:44:18 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 25 Mar 2016 01:44:18 -0700 (PDT)
In-Reply-To: <CAPig+cSdegoGNCMBMcHyEYiE+LUzixvdk-qu0Q-zbFvatX2=KA@mail.gmail.com>
X-Google-Sender-Auth: Yxi-5BX42QZbMWVgWWuhfogeVJs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289861>

On Fri, Mar 25, 2016 at 4:31 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>     for i in --autostash --no-autostash
>     do
>         test_expect_success "pull $i (without --rebase) is illegal" "
>            test_must_fail git pull $i . copy 2>actual &&
>            test_i18ngrep 'only valid with --rebase' actual
>         "
>     done
>
> Take special note of how use of double (") and single (') quotes
> differ in this case from other tests since $i needs to be interpolated
> into the test body.

That's not accurate. Since $i will be visible when the test body is
actually evaluated, it will work correctly even with the body
single-quoted as usual (like all other tests), so swapping the quotes
around like this is unnecessary (and Junio would prefer[1] they not be
swapped).

[1]: http://article.gmane.org/gmane.comp.version-control.git/284769
