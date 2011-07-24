From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: .gitignore for large files?
Date: Sun, 24 Jul 2011 09:59:45 +0700
Message-ID: <CACsJy8C=ks1_TdQdNi4Wq8OCSAON9rhJ88zAp1kDZy3fBg2pmQ@mail.gmail.com>
References: <B27BF8C0758741A68E1631A7308E17C6@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Jul 24 05:00:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkovc-00035b-Cc
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 05:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160Ab1GXDAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 23:00:18 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:46551 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab1GXDAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 23:00:16 -0400
Received: by fxd18 with SMTP id 18so7141693fxd.11
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 20:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0NBXXU1Nn88wdKjaQVu8XroBLMOQTaBWatbcGCa0zmI=;
        b=NI7bskjG1Uvo4E7mVerfqAvLRVBpyMWftZLZ4PNmIBQ+EbLjVkwB4Kh/S1i/Q+qs6V
         cLoVp46BYOTDZP2CTnBsLaiQ9BzdAO2D5nhOfuqsZV9dciRxGgHsriowJu7m/2Jped4c
         ezXLH5M1b2QGELkpP/i8dP71J9WCiuHz+6jFI=
Received: by 10.205.65.13 with SMTP id xk13mr882195bkb.400.1311476415172; Sat,
 23 Jul 2011 20:00:15 -0700 (PDT)
Received: by 10.204.59.83 with HTTP; Sat, 23 Jul 2011 19:59:45 -0700 (PDT)
In-Reply-To: <B27BF8C0758741A68E1631A7308E17C6@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177712>

On Sun, Jul 24, 2011 at 3:00 AM, Philip Oakley <philipoakley@iee.org> wrote:
> Has there been any discussion in the past on a method for ignoring large
> files via the .gitignore process?
>
> It does appear to be a moderately common problem for folk to accidentally
> commit a large file which bloats their repository and they want rid of it,
> which causes history re-writes and such palaver.

Once they are in, they cannot be ignored. Perhaps commit hooks at
server side is a better place?

> Perhaps a simple '>' and '<' option (the latter to cover null or minimal
> files?) with a --warn postfix may be possible. Just an initial thought.

Or you can make use of .gitattributes, more flexible syntax.

> Where would the 'right place' be for me to look at the git code if it was
> beneficial.

In dir.c, add_exlude() does the parsing, excluded_from_list() handles the logic.
-- 
Duy
