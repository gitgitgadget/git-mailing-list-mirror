From: Herry Wang <tech.herry@gmail.com>
Subject: [BUG]:Git doesn't work with Sock5 proxy on MAC
Date: Fri, 11 Jan 2013 12:22:45 -0800
Message-ID: <CAHNFYON4rqs2Pu+qFoWjszH-eReLZKqzsFuZQebh2qVTcxN+_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 21:23:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttl86-0000RK-8W
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 21:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab3AKUWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 15:22:46 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:56743 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab3AKUWq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 15:22:46 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so142101qad.5
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 12:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=wgqYKtjhQQgz34acBEVUF0Oz+8+IsK8kgr1+ceTASiA=;
        b=C+t/qFpFGrNrfo/6aXGEwlSjLI7mQC+JUmZBJP6oY5EnyJ7IEtQronxvrEipJLcgYp
         Ciz67ZApmal3tzGJEBVLnNe9o9elxkK+gAeRSbxCJLL3VaggxKzERCeL+IfHHgSyDOZc
         fJKWtSvUOVPmymfB1e2rYDnJhL3eMJ6OwQb4NJKe45Kbpg8OGfczwU3U9+WnsfDNNHea
         EmQiCRMwQaUw//x+WjJG3Sv1kzLXJWH55mrhub4BXyz88HJc7e/+WqIsVRe2WTrSGXvI
         78DY+YTKnCvWygAqFBva0B+nfnVMHZv0iiuKsezh2d1+VsYer08fqJY31bjQFzNKTL+Q
         vV3w==
Received: by 10.49.2.35 with SMTP id 3mr72227046qer.36.1357935765595; Fri, 11
 Jan 2013 12:22:45 -0800 (PST)
Received: by 10.49.121.197 with HTTP; Fri, 11 Jan 2013 12:22:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213241>

On Thu, Jan 10, 2013 at 9:51 PM, Herry Wang <tech.herry@gmail.com> wrote:
>
> OS:
>
> Darwin ... 11.4.2 Darwin Kernel Version 11.4.2: Thu Aug 23 16:25:48 PDT
> 2012; root:xnu-1699.32.7~1/RELEASE_X86_64 x86_64
>
> Git: version: (via homebrew)
>
>  git --version
> git version 1.8.0
>
> curl version:
>
> curl --version
> curl 7.28.1 (x86_64-apple-darwin11.4.2)
>
>
> git clone http://herry@stash.somesite/a.git
> Cloning into 'a'...
> error: Empty reply from server while accessing
> ....git/info/refs?service=git-upload-pack
> fatal: HTTP request failed
>
> i tried export http_proxy=socks5://ip:port, all_proxy=socks5://, neither
> of them works.
> I also configure socks proxy in ~/.curlrc,  git is not working well.
> However, curl is doing well with curlrc config.
> From the trace, looks like git is just put the http request via proxy
> host. But according with socks protocol, it should have some headers.
>
>
> Interesting thing is, http_proxy way is working perfectly on my Ubuntu
> enviroment.
>
>
> Thanks
> Herry
>
