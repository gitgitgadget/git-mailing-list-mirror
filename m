From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Fwd: [RFC/FR] Should "git checkout (-B|-b) branch master...branch" work?
Date: Fri, 21 Dec 2012 08:55:43 -0800
Message-ID: <CANiSa6ibS7ORY=QMS3WQzXYJQQH4ZYvPO75qgLgv-oWGMSBBrw@mail.gmail.com>
References: <7v8v8r2y8s.fsf@alter.siamese.dyndns.org>
	<CANiSa6jP_JN+DpDgYpWA9Aky9REJvFq3aR3Yj0vF3+axWvtmsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 17:56:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm5tB-00036a-UX
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 17:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869Ab2LUQzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 11:55:45 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:39800 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab2LUQzn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 11:55:43 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so6485526ieb.17
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 08:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=v37+Xu/V464lc7v2XobcqIQbvPg9ylQhcqt2luHCX+k=;
        b=pkJsaX3OGoP+aX0aWByxORNMMGrmxjnOInsHs8ahaSqW+gRJ4tTUxUIykGpi6w/Ce1
         eB98wgb/9v9jSOFrlvOiQnaz2l7Zc00kmi4YTMt4ZplA+6DC91BccoyYPRHWb2mQRkbT
         3A44MyBPGhU0G+/3oxJxd8qptBvuXK2QX1lnpL3ANsfo2KnumZiPDIV2hN4U9vosnr7q
         +Ut6adYxt2lSIpxmdBl1NSMN645SoTtsnoKS63dQhIzoPaBdY/eaB4TSozfPubHuu0ZX
         ZJ8mxFd99nZpxWORIYLDFli3x31+3yTi9+szZDA8mpD+iJw9Au9/TkZG5VxB2R5o/O+X
         i9/w==
Received: by 10.42.153.70 with SMTP id l6mr12239462icw.50.1356108943154; Fri,
 21 Dec 2012 08:55:43 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Fri, 21 Dec 2012 08:55:43 -0800 (PST)
In-Reply-To: <CANiSa6jP_JN+DpDgYpWA9Aky9REJvFq3aR3Yj0vF3+axWvtmsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211983>

Oops, meant for all of you.


---------- Forwarded message ----------
From: Martin von Zweigbergk <martinvonz@gmail.com>
Date: Fri, Dec 21, 2012 at 8:45 AM
Subject: Re: [RFC/FR] Should "git checkout (-B|-b) branch master...branch" work?
To: Junio C Hamano <gitster@pobox.com>


On Fri, Dec 21, 2012 at 7:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>     $ git checkout -B branch <old fork point>
>
> Unfortunately, master...branch syntax does not seem to work for
> specifying the "old fork point" for this purpose

I have personally always found it confusing to use the same syntax for
specifying ranges/sets and single revisions. I keep forgetting what
"git diff A..B" does. I know it doesn't do what I expect (i.e. "git
diff $(git merge-base A B) B"), but I don't know what it does (maybe
same as "git diff A B" (?), but that's besides the point). Having
worked a bit on rebase, I know that $onto can also take the "A...B"
form. So there is clearly some precedence for the "..." syntax to
refer to a revision in some contexts. I would have much preferred if
it was possible to make the revision parser generally interpret e.g.
"A.^.B" as "the merge base of A and B" (failing if not exactly one).
It seems like something that must have come up before. Is there a
particular reason this would not be a good idea?
