From: David Michael Barr <b@rr-dav.id.au>
Subject: Re: [RFC 1/5] GSOC: prepare svndump for branch detection
Date: Sun, 19 Aug 2012 04:37:35 +1000
Message-ID: <CACPE+fvkTNNHXbFTwhoH7=aQKoc9YqtfTBOkJDugUogni0sYww@mail.gmail.com>
References: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 20:37:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2nu4-0005Z6-Ev
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 20:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab2HRShk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 14:37:40 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:62516 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600Ab2HRShg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 14:37:36 -0400
Received: by qcro28 with SMTP id o28so3745818qcr.19
        for <git@vger.kernel.org>; Sat, 18 Aug 2012 11:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=awl2GLJjXJFE17oqVeaBEQ0NLCY+2R13Qnv25DoQziQ=;
        b=JIlrAyCu0pt639eXYbUMwhg+p3lE5eKVwacnO0BDQzEtRmzkYY/qZUDJWgfwCifNzq
         GFpv0k7OiSqumVBhi3YhlOZIU/wjBQ1wxJxA13V9txTwHiipBWuVcmKyOJ9FrqInwNGt
         d9u6ryLjZBBbiegImeLkn8tpfdm/krMUt+Fh6EL4Z83BoIO1FIOxDvf1rOtbS5B00oMe
         5dssTf22ud2lGCfcr0iWhGre8YIVRTmylbkbpe4Bv6A1ywcziO1QCXbleVHYcLhn/OAb
         J59CBkTkBaAdruLrFNCVKRqMGi1Ek0S/ZZdCc5Cj9mJq+jvZR1yACQgvb6xGojybvDn1
         2pMA==
Received: by 10.229.102.67 with SMTP id f3mr7106656qco.137.1345315055646; Sat,
 18 Aug 2012 11:37:35 -0700 (PDT)
Received: by 10.49.36.166 with HTTP; Sat, 18 Aug 2012 11:37:35 -0700 (PDT)
X-Originating-IP: [122.107.58.35]
In-Reply-To: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
X-Gm-Message-State: ALoCoQkB9jQ529Fmv/e3zckKr65u2nOfNU9V1q8GTQLQhN3N6Wl+wbxFpZE5nhDZMBDQCkyy/ghN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203688>

On Sat, Aug 18, 2012 at 6:40 AM, Florian Achleitner
<florian.achleitner.2.6.31@gmail.com> wrote:
> Hi!
>
> This patch series should prepare vcs-svn/svndump.* for branch
> detection. When starting with this feature I found that the existing
> functions are not yet appropriate for that.
> These rewrites the node handling part of svndump.c, it is very
> invasive. The logic in handle_node is not simple, I hope that I
> understood every case the existing code tries to adress.
> At least it doesn't break an existing testcase.
>
> The series applies on top of:
> [PATCH/RFC v4 16/16] Add a test script for remote-svn.
> I could also rebase it onto master if you think it makes sense.
>
> Florian
>
>  [RFC 1/5] vcs-svn: Add sha1 calculaton to fast_export and

This change makes me uncomfortable.
We are doubling up on hashing with fast-import.
This introduces git-specific logic into vcs-svn.

>  [RFC 2/5] svndump: move struct definitions to .h.
>  [RFC 3/5] vcs-svn/svndump: restructure node_ctx, rev_ctx handling
>  [RFC 4/5] vcs-svn/svndump: rewrite handle_node(),
>  [RFC 5/5] vcs-svn: remove repo_tree

I haven't read the rest of the series yet but I expect
it is less controversial than the first patch.

--
David Michael Barr
