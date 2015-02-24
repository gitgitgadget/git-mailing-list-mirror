From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Tue, 24 Feb 2015 11:02:05 +0700
Message-ID: <CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 05:02:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQ6hl-0006lS-Uo
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 05:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbbBXECh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 23:02:37 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:46134 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbBXECg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 23:02:36 -0500
Received: by mail-ig0-f173.google.com with SMTP id a13so23783498igq.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 20:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Xfa4cQqXQL6TIdTNFoT43SjPqe0gROMspN8FRN5Ye6o=;
        b=toI40Ei+OMhQDfgRPvlUz19m0mfhVmZkwkTPMdOKIStwrfChzSXpybuUT59wz/U56b
         rZD4YHHuhg1KYSNzSwrB3qSwfGHfz2FbMK+loL8+QKSl2VK2Bs47j+Vy1BZJMTBraGyi
         feoeeNg9V3Bk3Uv11tfTmDkrsfaJPgem+1coerrBYi4gccqXVhy7yWbEQNOxxPrrNstf
         S5LGCj5TAJmDBmiIOB8LeC0Tjtdem4+0fdl1j+OOgY42v39x1LkX+HLC3lRvMBAveV7k
         oxZuSHByd7KIB9aZHXDouaW6GlHIOfv6VSUYzfxBSo7FvyS3amy3J8B45u4Aj73KBC73
         eXRQ==
X-Received: by 10.42.66.84 with SMTP id o20mr6321001ici.29.1424750556121; Mon,
 23 Feb 2015 20:02:36 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 23 Feb 2015 20:02:05 -0800 (PST)
In-Reply-To: <1424747562-5446-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264309>

On Tue, Feb 24, 2015 at 10:12 AM, Stefan Beller <sbeller@google.com> wrote:
> One of the biggest problems of a new protocol would be deployment
> as the users probably would not care too deeply. It should just
> work in the sense that the user should not even sense that the
> protocol changed.

Agreed.

> To do so we need to make sure the protocol
> is backwards compatible and works if an old client talks to
> a new server as well as the other way round.

It's very hard to keep backward compatibility if you want to stop the
initial ref adverstisement, costly when there are lots of refs. But we
can let both protocols run in parallel, with the old one advertise the
presence of the new one. Then the client could switch to new protocol
gradually. This way new protocol could forget about backward
compatibility. See

http://thread.gmane.org/gmane.comp.version-control.git/215054/focus=244325
-- 
Duy
