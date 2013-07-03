From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Feature request: "author branch" in commit object
Date: Wed, 3 Jul 2013 18:16:41 +0200
Message-ID: <CALWbr2zJFjbaCdA3d1eaFuP4HGShAwnK=gisRD=KHKWWi-XuTg@mail.gmail.com>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
	<7v38rwlola.fsf@alter.siamese.dyndns.org>
	<CADL+T9ax0maws3GR24YV77Yge7knqHd5mfuPd_AqE9b4UmvYPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Ed Hutchins <eh@demeterr.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 18:17:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuPjm-0007xn-VX
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 18:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933012Ab3GCQQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 12:16:43 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:54894 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932915Ab3GCQQm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 12:16:42 -0400
Received: by mail-qc0-f178.google.com with SMTP id c11so204343qcv.37
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=R058NZf20yZAz9U+UHOg/L93wEUNFG6rGPasKAdyBpA=;
        b=vmyGDTAISHx0DaC1+/bJpYP0M8RwFBMDXiil2U5utP0v3ei2zAJIPjNvx+gOxdvcWC
         ekKCk2Kf8fbk7qbxZqETZTjY4L1cyvh86RgxW2kdJ6RSCmdMl3f0IyLjmR2z9RCdewzp
         5REfxgxhNf9fFSNmqurSMNNrYg0OLiZsVftTxTCenPBhcPzUo8hUYPlxy7Nt1PJgBAQU
         nvy/gG+dosif4K9UFoUDHhvqea4/febLkYQ4UMATYC/w0HbjcYgwK2+asfU/IhK7oHLv
         ak7Ht9xFx/DOQ29tK6NVYAP+RsbcdnwCrrml9uSPKRD6l3Az66We+xZGOz5nPfgu1hOZ
         xVug==
X-Received: by 10.229.106.163 with SMTP id x35mr525121qco.70.1372868201764;
 Wed, 03 Jul 2013 09:16:41 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Wed, 3 Jul 2013 09:16:41 -0700 (PDT)
In-Reply-To: <CADL+T9ax0maws3GR24YV77Yge7knqHd5mfuPd_AqE9b4UmvYPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229496>

On Tue, Jul 2, 2013 at 10:34 PM, Ed Hutchins <eh@demeterr.com> wrote:
> On the other hand
> trying to figure
> out the history of events from a large directed graph of commits
> without any clue about
> what topics first spawned each commit is actively harmful in many
> cases (trying to display
> a clear history of who did what for what reasons, for example).

I think this is exactly what Junio does with git.git:
- Each branch is named "$initials/$topicname" before being merged.
- Branches are always merged with --no-ff.

I think it answers your question: Who (initials) does what (topic)
The name of the branch is also stuck as part of the history as the
merge reads the name of the merged branch:

e.g. Merge branch 'rr/remote-branch-config-refresh'

You can of course provide more information than the simple commit
header line (that would give the "what reasons").

Of course, it's even easier to read if you always merge in the same
direction (that allows you to easily find the first commit of the
branch).

Hope that helps,
Antoine
