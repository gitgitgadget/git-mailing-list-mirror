From: Shawn Pearce <spearce@spearce.org>
Subject: Re: In tree object, Must the
Date: Mon, 9 Apr 2012 11:29:46 -0700
Message-ID: <CAJo=hJv==GrxLH6U9MAwckcEXiYtKeMEpEMNVTJLcSKro2QV_w@mail.gmail.com>
References: <CAFT+Tg-+s5=pFNwY7ZMxem4z6YHu53kyOs0B_rkmphq=mEtpTg@mail.gmail.com>
 <7vobr0wyml.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 09 20:30:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHJLz-0004xG-7J
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 20:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093Ab2DISaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 14:30:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36940 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab2DISaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 14:30:07 -0400
Received: by pbcun15 with SMTP id un15so5290661pbc.19
        for <git@vger.kernel.org>; Mon, 09 Apr 2012 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/ZFN0CNwAh7zPgaic1FT1mjrtIfWFFgxCdwh002mURg=;
        b=OXmVV1WrvppqwhGvVRHvxNMnMC7JNX3EKsQj69fH449WXpp8HlbMJAqki7giIEsReQ
         yLLYVUOUvZ/RLr4riz3H8GZXxKSBA4PlySo4TovsOU5YE1jmaKsbMIaxvttZ3+uLKz7f
         S64PRIg8XMPKKE6AUJ7UZZ+MIvIoMhwNitzvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=/ZFN0CNwAh7zPgaic1FT1mjrtIfWFFgxCdwh002mURg=;
        b=pJCwgTOVf0rkBiP/hqEjAycvqua65Uv8YGF6X9awSoGccX5h5n5s6C9oyI361IOEwl
         614libV4oWJ4HkCPZd8qrptFouUwluxJIdu2YxPr6kDWpzI8pO4P2B6U5QTa+EJODkjr
         +bGZ7GPbLMu6vsyLGS0uXPF5zJBfFCaB4RLNCooiJI5NPsZuDCoyLf32+JCBvlvueNk9
         YTLAa2RTCpGf9bFRJ48mI5naGOoXhmMcGIMdc7PdTYLaOXA9jehfHdxyoTUDlH/lR9qa
         PTJ6XQBD+HjhiX4RTyJbHbYCIOaTT6YmFUVurVR/aZds5bo1BLofMty/soYxs7gPlUiX
         akvg==
Received: by 10.68.220.134 with SMTP id pw6mr21332521pbc.149.1333996206930;
 Mon, 09 Apr 2012 11:30:06 -0700 (PDT)
Received: by 10.68.55.68 with HTTP; Mon, 9 Apr 2012 11:29:46 -0700 (PDT)
In-Reply-To: <7vobr0wyml.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkj+T/p2TakwzEBrEle/qFxpB+hBFvseGnAolB/wutKnD1qxPN7+tH4VKt3p4t4BMLgn7nQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195024>

On Mon, Apr 9, 2012 at 11:25, Junio C Hamano <gitster@pobox.com> wrote:
> "Yi, EungJun" <semtlenori@gmail.com> writes:
>
>> If it is true, what happens if it is not ordered?
>
> "git diff-tree" and "git diff-index" (hence "git diff" frontend when it
> walks the tree for comparison) will fail.

And JGit and any JGit derived tool (e.g. EGit, Gerrit Code Review)
will fail horribly and refuse to process that tree, or worse, will
produce incorrect results when fed garbage like an unsorted or
incorrectly sorted tree.

Tree ordering matters. And that niggly bit about subtrees sorting as
though their names end in '/' even though they don't really matters.
