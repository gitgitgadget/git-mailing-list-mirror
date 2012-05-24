From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Add persistent-https to contrib
Date: Thu, 24 May 2012 13:42:35 -0700
Message-ID: <CAJo=hJsfRr7MKcmn8owuyYf7LJ2jzpqgCfkijQ6ahrZfz3CDpw@mail.gmail.com>
References: <1337792767-18914-1-git-send-email-cranger@google.com>
 <7v62blxx2m.fsf@alter.siamese.dyndns.org> <CAJo=hJt=q-ZnLrqzcfGrKNcao2MPDSRt3Y_r2OOfu75++N+3zw@mail.gmail.com>
 <20120524202930.GB18936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Stenberg <daniel@haxx.se>,
	Junio C Hamano <gitster@pobox.com>,
	Colby Ranger <cranger@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 24 22:43:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXesK-00081A-NA
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758965Ab2EXUm7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 16:42:59 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57964 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756374Ab2EXUm4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 16:42:56 -0400
Received: by dady13 with SMTP id y13so257350dad.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lCqBch+sLFeLHHDAD1X7Z4Xr6Gq40rZOHyfR6M9WeII=;
        b=KevfDAuyabJN+3eac/6g4nm5YpS6zB0KJhgfIF0P3y5+Ezt30GZkF0Adlb9HKRG7fp
         s37vdQEEbIOR9FUNN0PVcuFxy1sAl5pCouAewj9OcPpAHGhVrEKPE3mOEb+qCP3585pl
         kORneGZ82DQfHVP64DXg2PMFlocz0cZdE6Sdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=lCqBch+sLFeLHHDAD1X7Z4Xr6Gq40rZOHyfR6M9WeII=;
        b=CZ9KQyhcCvwgxpMxTY8XX/O30NfNnZhm9wTFBXZIwBzFD5sbqUaQYSxa4uOzI/CS57
         wsuuerA4BUfpEtGB+/gwPp6OKZKvgIsb2PaGoIXR31wdQBrDU9XVKH+4HWIM7nlMDV5d
         sN+FnSanUq+zeLd2wJs341Z0vu0EP+RJgEvUQqmetwSVJ2ZKq5vbcJgM294R7MPe/pKO
         ANOtFhjQn9Uwp5mC7ei5AEmzUnCv+1fFx1djEtPvuHyo4sMJLsp5JNSvSMeVB1o53Esx
         0DkRKxq9wp5HLY7n12+KBqsbYPewMPSivPRV+ZN5+2atHvq2t648YCYkvOBS1gjukpFn
         Bn+A==
Received: by 10.68.219.135 with SMTP id po7mr18807688pbc.149.1337892175748;
 Thu, 24 May 2012 13:42:55 -0700 (PDT)
Received: by 10.68.52.169 with HTTP; Thu, 24 May 2012 13:42:35 -0700 (PDT)
In-Reply-To: <20120524202930.GB18936@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmUrTpi+ALQC+2Nvx15TsrwT8FsCtVRZd6dtD7tXfOV93kvGtCJJ9rkMNa+FV34SCb/kJMY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198421>

On Thu, May 24, 2012 at 1:29 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 24, 2012 at 12:33:08PM -0700, Shawn O. Pearce wrote:
>
>> $ (for i in {1..5}; do time git ls-remote
>> persistent-https://kernel.googlesource.com/pub/scm/linux/kernel/git/=
torvalds/linux
>> >/dev/null;done) 2>&1 | grep real
>> real =A00m0.208s
>> real =A00m0.085s
>> real =A00m0.079s
>> real =A00m0.067s
>> real =A00m0.059s
>
> Nice numbers. And as clever as I find this helper-wrapping-a-helper
> solution, I wonder if the right layer for a fix isn't inside curl. It
> already keeps an ssl session-id cache in memory; how hard would it be=
 to
> turn that into an on-disk cache?
>
> I don't think that is grounds for rejecting this patch; obviously it =
is
> working for you guys, and it is available right now, and it is only
> going into contrib/ anyway. But a curl solution seems like a cleaner
> long-term fix, and would benefit all curl users. It is even mentioned=
 in
> curl's doc/TODO file. :)

Well, this helper "solution" also has the benefit of HTTP keep-alive
working across Git command invocations. Its common for servers to use
a 5 minute keep-alive on an HTTP 1.1 connection. Git-over-HTTP
commonly uses Transfer-Encoding: chunked on replies, so keep-alive
will generally just work, even though a pack stream's length isn't
known in advance. Because the helper is an external process holding
that connection open, we also benefit from being able to reuse an
existing TCP connection to the server.

But sure, it would be nice if libcurl was able to share SSL sessions
across Git command invocations without this black magic proxy thing.
