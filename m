From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: RFC: checkout/temporary branch switch restoring modification times
Date: Mon, 4 Oct 2010 05:00:32 +0000
Message-ID: <AANLkTinXbwtv=6TMeu0nA=jV4u7zGXE_56791ky_=93b@mail.gmail.com>
References: <4CA95B18.5090008@cockos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Justin Frankel <justin@cockos.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 07:00:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2dAP-00043M-LQ
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 07:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083Ab0JDFAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 01:00:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40068 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab0JDFAc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 01:00:32 -0400
Received: by iwn5 with SMTP id 5so6444802iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 22:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=v7TvEejW0m1A3BNfs7FBDO/uOu62zIQ8G1w5BdzKquY=;
        b=wf+/378JPY4+d88MMkjVbcwSTcjehO1iFqy4ctzipFJvXv/me+PX+DrVzzl70qRmCW
         TRV1/kHYc2rSiUzBJFQulnzWZ/RXtjGcpZwmAa9apHkUUmeXnutROYHRdQ/IFR6QNqAa
         FR2ljnzKpEy6okOlj6sPp6gsJ6uJrxbCB8q28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hvotS3VCP8I5IS7HM5xkghBDPbhIysgJKSRj0YSn8oQjSqO8Lrp/X9G1EFqeruPd9q
         6hjL4xEaS4n20WThoCw+oAjzBaHZRu9EJLmAyMajTkED/oWxzMjeX1iTflEhnANiW50e
         vS+jrOgiv/JoiobTi7e8Z84VMd4lpxYsvD6Nw=
Received: by 10.231.10.200 with SMTP id q8mr9561344ibq.83.1286168432086; Sun,
 03 Oct 2010 22:00:32 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 3 Oct 2010 22:00:32 -0700 (PDT)
In-Reply-To: <4CA95B18.5090008@cockos.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157977>

On Mon, Oct 4, 2010 at 04:42, Justin Frankel <justin@cockos.com> wrote:
> I often find myself wanting to switch temporarily to another branch, and
> then back to my original branch, but what I find is that my build tools
> such as MSVC or Xcode) notice the file modification times changed on
> the changed files, and then want to rebuild, even though the contents of
> the files are the same.
>
> I've implemented a perl script (tested on OSX and msysGit), which I've
> named "git-cop" (so I can use via "git cop") to checkout,
> preserving file modification times.

Maybe something like this is a worthwhile feature, although perhaps it
would be better to give each file a timestamp corresponding to when it
was last modified in Git? That would break in many cases, but a scheme
like this inherently does.

Have you tried to use ccache? It should reduce your build times by a
lot, so perhaps if you use it you won't need this anymore.
