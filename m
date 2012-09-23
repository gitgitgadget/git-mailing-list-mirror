From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git clone over http with basic auth bug?
Date: Sun, 23 Sep 2012 10:21:55 -0700
Message-ID: <CAJo=hJt7d_qzR_RP-Fu=h1iMD-jOgAvgXqGwGX2JQrMHA0+jYQ@mail.gmail.com>
References: <505CFA42.9090504@pjr.cc> <20120922050935.GA4542@sigill.intra.peff.net>
 <505E22EC.1060208@pjr.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Paul J R <me@pjr.cc>
X-From: git-owner@vger.kernel.org Sun Sep 23 19:22:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFptQ-0002oB-T0
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 19:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147Ab2IWRWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2012 13:22:17 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:40081 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab2IWRWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 13:22:16 -0400
Received: by qcro28 with SMTP id o28so3789377qcr.19
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zJ1g5UE6z7VskPuqIX3xR/Rr/MEb/k4T/iYPN2pIsWg=;
        b=KCZ1wlJCm14nvdqAkNbYaBAB0o4UWDVjseFNHTC6GWJnJG1vDXyPDH0VtWfTOzMXLl
         eqsfT7ZiuVCtGJ1mknu8/x98MHigSzNWIV0VZu059BTZvakFEiS6kctRA2t9DXnSEpCE
         dEK4Wdx0F5Td+Mk00YELmGr3GhS+0igZJqJFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=zJ1g5UE6z7VskPuqIX3xR/Rr/MEb/k4T/iYPN2pIsWg=;
        b=hSO5pPKRT/8GLdQF/VGNbuXe+FwHoeMt+/hDkx2jpa4oXR9EDBATLgUV7JljwI/BC/
         S3TWTtVXOzE1IyThTkHvN0AubWrPhhQm6RRdcZphOhfWI99FOGnGXdKbiqxhEM9RljJk
         wx/ziNgj5StT5LxFJ9DJtWfJ2Lt6Kswifo8b4xREUIsAiFSDL65mDt6DjWLB04Q2JkPA
         7hpcL9jmtLBMfbvME23cRF0EXVVTF6Hhzv7ksTCEf5S7vNJjiplLnBXuWNUETAIc+9Wo
         M83sP6YLnTiw1z8+5/9ecLGw2fCwtULob4oqOwIWxymYxyeILqMd8X9IhSUs8RE5Ughe
         ONgg==
Received: by 10.224.175.204 with SMTP id bb12mr26961822qab.14.1348420935635;
 Sun, 23 Sep 2012 10:22:15 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Sun, 23 Sep 2012 10:21:55 -0700 (PDT)
In-Reply-To: <505E22EC.1060208@pjr.cc>
X-Gm-Message-State: ALoCoQluesJINSlulaIBESBBNDVtx1KsHCmB6g1nnyXtdRoAZL5pcOZfDnPDMk2iPv7U29SmkJmk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206245>

On Sat, Sep 22, 2012 at 1:43 PM, Paul J R <me@pjr.cc> wrote:
> It hadnt occured to me that git-http-backend behaves differently to the
> "dumb" http protocol on read (though that was from reading the git source so
> i obviously missed what was going on there). Ultimately im writing a little
> webapp that wraps around git-http-backend for some git repository management
> and on reads i've been just "acting like webserver" but on writes i throw
> off to git-http-backend. But seeing it do authenticated reads properly via
> git-http-backend im going to change how it functions, cause that does work
> with older clients.

It works back as far as 1.6.6 as a client. Clients before 1.6.6 can't
use git-http-backend. Fortunately 1.6.6 is pretty old, its nearly 3
years ago (Dec 23, 2009).
