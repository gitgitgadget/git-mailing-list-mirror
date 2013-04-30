From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Tue, 30 Apr 2013 07:27:12 +0700
Message-ID: <CACsJy8Bzd+K39MtiF3nWRbFfBo+kjAUmm-qLgpzeZZtSSxnqWg@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <7vliaxwa9p.fsf@alter.siamese.dyndns.org> <CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
 <51781455.9090600@gmail.com> <CACsJy8BuMsdAAxPoY_R0tOKJ9toTnDwAwOx_=vmbOOpFLWmS5A@mail.gmail.com>
 <CAKXa9=r2A7UeBV2s2H3wVGdPkS1zZ9huNJhtvTC-p0S5Ed12xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 02:27:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWyQ7-00084t-RI
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 02:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757691Ab3D3A1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 20:27:44 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:56148 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757083Ab3D3A1n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 20:27:43 -0400
Received: by mail-ob0-f179.google.com with SMTP id oi10so5980006obb.10
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 17:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=YzOqGB70tIxmTymX3KW2X2rBkBv/SC+4JzOn7HoGaWA=;
        b=NYxioMJAseIX8jm5VY24igaIJ4zzAJhUfZGV7Ure50VklLvGoo0S7Qt0EVVQiBJjFg
         7fUmlK6IbGp483BqLqo20IG3msFEEN6niepq1yxtoLF7+JGN+qdHP0AnsHzrF80pqjuN
         y1YdKxsAf6PPknpE1XjbZvyNTZCyskCJ/Sm3QlKr9OsgTYUJWEoCBscmxRl6p7ze2Irl
         WVZLmvO/2Jrk2mhq+84kWrT5DyJ6VoHUd74Nnjxpt5l4I0+SSZz8pwl0BPhKXjctRfG9
         hRMuncgXvmPKBBGYiuNLoYlxY6L1QZ6KUBfosaEmZYjdX3Spu7T8F/ObkLfJJ3sEsx7/
         Y56w==
X-Received: by 10.60.57.3 with SMTP id e3mr3185378oeq.101.1367281662739; Mon,
 29 Apr 2013 17:27:42 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Mon, 29 Apr 2013 17:27:12 -0700 (PDT)
In-Reply-To: <CAKXa9=r2A7UeBV2s2H3wVGdPkS1zZ9huNJhtvTC-p0S5Ed12xA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222888>

On Tue, Apr 30, 2013 at 1:05 AM, Robert Zeh <robert.allan.zeh@gmail.com> wrote:
> The call to lstat is only there for testing and should not be in there for
> the final version. Is there an easy way to only enable it for tests?

The usual trick is invent a new GIT_ environment variable. Then check
it and do something different. Then you can set the env in tests only.
--
Duy
