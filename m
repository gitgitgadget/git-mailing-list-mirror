From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 5/9] sequencer: run post-rewrite hook
Date: Sun, 9 Jun 2013 10:19:03 -0500
Message-ID: <CAMP44s1-d4XrKjy7dcLq=6jDeOGaj=TL0MQa9FdEHgXmRVQr=Q@mail.gmail.com>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
	<1370509144-31974-6-git-send-email-felipe.contreras@gmail.com>
	<7v7gi7yteu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 17:19:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlhOi-0002gu-GW
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 17:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab3FIPTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 11:19:07 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:51049 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab3FIPTG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 11:19:06 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so4992196lab.4
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Tali/0TX6EsEY0dEnVMkUGqaMv/3BrN/RlhZ1FjBOsc=;
        b=fV66V/BGWCEL0xmknVQ5TCos5a4GHCm4E4ONDTo+1zZ0PzfsMsvO9pi8xjzLdrgzmA
         rq/49nNrEQM9VSITskYFG0oAvsVzbzv0oGHpVpamDX6uwsS+Ovqo74ow7wZ6fYMBbODE
         evuIpk6iuX3iIgV1KMdLPucWANRdDf2r6UlU4ieSPd95q+EYWNDua7u4IgsZm1qZDzE6
         7ag1EgFpB6tDLwu1SJbt1A+MtB+Qa22ZX59MpA6qOLBHLPlKweaLE3QWoYBu04IOLoLQ
         Kd8NG4Zwu97n/0c7tqWNYkHEnuJ4pe+w1+GTj5JCfpnHypYxXvEWaEbH0GhfIXY5jVgY
         ddlQ==
X-Received: by 10.112.219.133 with SMTP id po5mr4656042lbc.80.1370791143490;
 Sun, 09 Jun 2013 08:19:03 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 08:19:03 -0700 (PDT)
In-Reply-To: <7v7gi7yteu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226965>

On Thu, Jun 6, 2013 at 1:40 PM, Junio C Hamano <gitster@pobox.com> wrote:

> It probably is worth inserting a commit before 4/9 that adds
> rewrite.[ch], and
>
>  - introduces "struct rewritten_list[_item]";
>
>  - moves run_rewrite_hook() in builtin/commit.c to rewrite.c;
>
>  - changes its function signature so that it takes "char
>    *action_name" and "struct rewritten *" as parameters; and
>
>  - adjust its sole call site in cmd_commit() to feed a single-item
>    rewritten_list to it.
>
> Then 4/9 can teach cherry-pick to prepare the rewritten-list and
> probably this commit can be part of that to call run_rewrite_hook().

Done. I'll send the patches in a moment.

-- 
Felipe Contreras
