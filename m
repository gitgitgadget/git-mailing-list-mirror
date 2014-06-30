From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: Re: How to populate index/worktree when recursive merge merges
 multiple common ancestors?
Date: Mon, 30 Jun 2014 14:48:44 +0200
Message-ID: <CAENte7i3f_zvPmnPZe2s7guPv03o1d_Ln+nVaj5PYmP8uoK=rw@mail.gmail.com>
References: <CAENte7jg7RnpEFmZ0QWGw=a-AvAN6AF=cknHXWyTEuo9zq7ERg@mail.gmail.com>
 <CAJo=hJtLzMqrBf5Y1dzUxi_0nGmY72xURRmcvmjoFD+=j0FCwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 14:49:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1b1F-0000gq-6W
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 14:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595AbaF3MtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 08:49:07 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:46921 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350AbaF3MtE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 08:49:04 -0400
Received: by mail-qg0-f42.google.com with SMTP id e89so1908448qgf.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JTAl7mMa6dXnQnoTu3y7y9Ykr33A6cTdtiudkdlxhgQ=;
        b=WHtiMdhaKSls0Wtu8d8H82v3I6pOJ8nq9iL7fqMlssC8CXYry35a4daPmPwaV/OCC1
         TNusez2d3H+91UjCr8LQkWvghgGWHCL8GBvnOax2hYUF2mVfjHzBCviMfzco12fIuivd
         jFwXULeX8VbHGAngARWqhcOT9+O1FwscCUVETNK5hVQwKSiz+mvXOoDGBaqasA6XYnsJ
         +3cxNvft+lRJ22C8vmx1Yb2rC0qqMV0KhzPyDh8joUp9bYxO/R29TPIdz0qfcrvo9kFi
         KyF2fPEM/W9CGtFRBVHOeiZ/IlQ/vA1Yftc7D8R1UbDkaweWYbVpnKCyFp5OpFQGzfYH
         ryMA==
X-Received: by 10.224.13.139 with SMTP id c11mr60989647qaa.77.1404132544080;
 Mon, 30 Jun 2014 05:49:04 -0700 (PDT)
Received: by 10.96.179.199 with HTTP; Mon, 30 Jun 2014 05:48:44 -0700 (PDT)
In-Reply-To: <CAJo=hJtLzMqrBf5Y1dzUxi_0nGmY72xURRmcvmjoFD+=j0FCwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252664>

> They don't. The conflicts are preserved into the virtual ancestor. The
> user only sees the final conflicts during merging of A and B with
> virtual X3 as the common ancestor.

Ah, now I understand. When I merge X1 and X2 into the virtual X3
I should not stop if this is not doable without conflict resolution. I
should store in memory the X3 content, including all the conflict
markers. If I finally merge A and B I will specify a common base
content which may contain conflict markers. Right?
Are git config param's like merge.conflictstyle=diff3 are also
effective when creating the virtual X3 content? Couldn't that lead to
complicated conflict marker situations? In the area where you expect
common base content you again see conflict markers in diff3 style.
