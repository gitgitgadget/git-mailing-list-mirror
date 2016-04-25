From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Silent failure to add Windows-style paths in Cygwin Git
Date: Mon, 25 Apr 2016 19:18:14 +0700
Message-ID: <CACsJy8CDbfKWYdXg1WtcCeZMGV2OwjgBzBgj56h87hes5Dom4g@mail.gmail.com>
References: <20160425120705.GN2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Adam Dinwoodie <adam@dinwoodie.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 14:18:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aufTa-0003Go-QX
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 14:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbcDYMSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 08:18:47 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33389 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370AbcDYMSp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 08:18:45 -0400
Received: by mail-lf0-f43.google.com with SMTP id y84so17719700lfc.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7MNitBWLgavU0Gze8Tzi8j0eQTI8oXYXePJt9Ai0P4I=;
        b=lISxeAVGIAj5v/FvDdqJ1ynsv5savEKW8nkA6ar+W1P2EZ53H6+tw58WV8fxpcp3aa
         A2SlR8X4FGvqzanZqolGM6hrsWCPREcN56Y715XHRGLRxNR5Xrcoy/yDKN5j9xhtnzT5
         3vP+fY9seSCy8hunc3190z7HpMc9+3lJ5pIEprgkct3t/8XCku5gyv9DN4IaN4iqcR+W
         /bAdLPhXGGXdydi8uUJT/EZPk/JB9iAQ3d4RBOS01FItOfk0TzKqjMr5/E6SQEUVUZ1S
         vV4PtWLdqrsw2sR8MaC7tnJwxgWhU8Kv54YxrHcI59Z7FIN1tNZHCYzpVBaYwq+0dWZP
         8j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7MNitBWLgavU0Gze8Tzi8j0eQTI8oXYXePJt9Ai0P4I=;
        b=k3CWOkWmlfJzHA7Ab3yR0jJ+HcmEGRYTcxfXoRcaV6hdaWfsoDVnTvxw6LdiTc3LVJ
         ACo9ez7ig9dELF8/UKHuFZkojpd2v/aOPba9QRWNhgDLg36e2HYZio11vVE9t08y+N4s
         ivU2vBINqYCYoXV96lpMJV6iuXMVkhOg8xJ2e1VVqta+RgbQgbDrzbXtIrx1hlSJNSTs
         5UdYpR38IoXSm7zp+W4DyK7uORGlt4M3AfZnqYuvlJhdK9zR/ymdz4GQV84AGVjZGVek
         NTpgXEbTJJTnthkQLbtnCVPjmBKPVQmSWoGW6Bag0cO/JtgXEjbLYMRbaliGALcXOG0x
         L70Q==
X-Gm-Message-State: AOPr4FWDOpQxh34H2YQ06p+iMUik1kQUg2tu1/7/0zLYWNZtF9aUQNyU35OzayaMfOnfBNBvaFlXgL2KkFqVAA==
X-Received: by 10.25.165.135 with SMTP id o129mr2794548lfe.162.1461586723878;
 Mon, 25 Apr 2016 05:18:43 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 25 Apr 2016 05:18:14 -0700 (PDT)
In-Reply-To: <20160425120705.GN2345@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292470>

On Mon, Apr 25, 2016 at 7:07 PM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> [Resending as my initial attempt appears to have not made it to the
> list.  Apologies if this results in a double-post.]
>
> If I attempt to `git add` an extant file specified using a Windows-style
> path on Cygwin Git, this doesn't add the file, and produces no error
> message:
>
>     ...
>
> I wouldn't expect adding the file to actually succeed, but I would
> expect it to either succeed or produce an error, rather than silently
> failing.
>
> Experimentation shows I get the same behaviour for 'c:\tmp\file',
> 'c:/tmp/file' and 'subdir\file'.  I'm seeing this on v2.8.0; the
> downstream report says the same behaviour occurs on v2.7.4[0], and I've
> also seen what appears to be the same behaviour on a v2.0.5 build I
> produced to check.

Can you try git-bisect if possible? An strace log may be helpful
otherwise (looks like strace is supported on cygwin, but I don't know
to what level)
-- 
Duy
