From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: splitting a commit that adds new files
Date: Tue, 4 Feb 2014 07:54:45 +0700
Message-ID: <CACsJy8AWHJ=FE3zQN_UUc-AnAz14OsRk8Xw36_Y8n+VujTP35A@mail.gmail.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
 <xmqqzjm9fkk4.fsf@gitster.dls.corp.google.com> <20140202231110.GC16196@sigill.intra.peff.net>
 <xmqqioswf4mh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 01:56:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAUJE-0000Pv-3w
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 01:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbaBDAzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 19:55:36 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:46658 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbaBDAzg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 19:55:36 -0500
Received: by mail-qc0-f180.google.com with SMTP id i17so12311841qcy.25
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 16:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rt+QOm1pc72cBEJxB9j7dm24LPMmyrG7tkS8NZLXeqU=;
        b=PtPYmoJf+V9zxc2jn+VRIVYB1nkJ6AWmfSRT9mnDhEmFim9z+HH5re7J/TOGI1GaOF
         MMpFxBR8hmheaWTpGbnr5RHI0ZUXZjmXHLnxGs04IGPcb+kGuGviA09VlVjj4G4i/3L0
         B5U1XqVoU9Cn8plq4fL3Cn1hFj7QmYrdKz8BmdLhOCqoV2snkTxBissB1nibMkfMxlJq
         01HppyKubyFlln4VaCWMWLDhrIcoSMQbpJZFW/Nv1VH7KaPTSpUyFhre034fPYIeSeIs
         pTVQNgPhcRKNy/mDorCKlRpO43Nfsf/BkvCz+rk2ULKX0gyKzQFX0lLJDVv6ahRU9SDs
         x2vQ==
X-Received: by 10.140.93.130 with SMTP id d2mr57256914qge.41.1391475335554;
 Mon, 03 Feb 2014 16:55:35 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Mon, 3 Feb 2014 16:54:45 -0800 (PST)
In-Reply-To: <xmqqioswf4mh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241505>

On Tue, Feb 4, 2014 at 1:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> [1] I _do_ use "reset -p" when splitting commits, but I do not think it
>>     is useful here. I use it for "oops, I staged this change, but it
>>     actually belongs in the next commit. Undo my staging, but leave the
>>     changes in the working tree for the next one".
>
> Sure.  I thought that was exactly what Duy was attempting to do when
> he splitted a commit into two (or more).

For splitting into two commits, "reset -p" or "reset @^; add -p" would
be more or less the same, although I still prefer to think "this is
what I need" than "this is what I do _not_ need". "add -p" is more
convenient when the commit is big and you need to split into more than
two because the number of revert chunks may be higher than the number
of added chunks. I recall editing a patch with "checkout -p" sometimes
does not work, not sure it happens with "reset -p" too.
-- 
Duy
