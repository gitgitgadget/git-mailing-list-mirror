From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: git repack memory limit
Date: Wed, 19 May 2010 12:45:49 -0600
Message-ID: <AANLkTil4Mh8wMXpHpqkiUmYyLSIR2AbNaM7KvPNzdQj7@mail.gmail.com>
References: <4BF31045.1000700@l4dev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bahadir Balban <bahadir@l4dev.org>
X-From: git-owner@vger.kernel.org Wed May 19 20:46:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEoHY-0003V2-LI
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 20:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab0ESSqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 14:46:11 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:54965 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab0ESSqK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 14:46:10 -0400
Received: by gxk27 with SMTP id 27so4513008gxk.1
        for <git@vger.kernel.org>; Wed, 19 May 2010 11:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=zbwjD/fDnl1wz0SgDoNHb9TcDPflnntCE1ruNk90MeI=;
        b=q8DE7UddCi3a7Jim2gYG+5ddyVCw3K4s+VuaFc8B0urpLcUbFDb/dSQUrAwUUdzD/b
         fMA0QJ6ZRRgMfxwEXUi7mglXwMWyw9swpgdSyI68ubawl2HhqfWI8y8FlNfXwasUSkAO
         MuIQJ9Oc8zLCRwOweZUOkmEPRP9yRPTnWX8Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ExIb1pf3Z6CqvyZJAFWFD7YEfhYs909gi946YuwJpoNHxU78iI0EBBBrzrytQ4TUYE
         DGv1ZtXr+Ynhl+DnL7V7fRDL7wLlhxOa+nZ2RnvKDPVL3Ggm7YK+jpZI97fYNZBAEDvJ
         BpgGANq+2pSnETfMpSdgA9+UIgc9cGiO7IJCA=
Received: by 10.91.100.18 with SMTP id c18mr85776agm.151.1274294769275; Wed, 
	19 May 2010 11:46:09 -0700 (PDT)
Received: by 10.90.79.17 with HTTP; Wed, 19 May 2010 11:45:49 -0700 (PDT)
In-Reply-To: <4BF31045.1000700@l4dev.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147339>

On 18 May 2010 16:10, Bahadir Balban <bahadir@l4dev.org> wrote:
> I am running git-repack on a server with memory limits. I am seeing the
> repack spending 400MB and going out of memory. I could not limit repack
> memory usage in anyway. I tried:
>
> git config pack.deltaCacheLimit 1
> git config pack.deltaCacheSize 1
> git config pack.windowMemory 32m
>
> then git repack -a -f -d
>
> also I would particularly expect git repack -a -f -d --window-memory=16
> to succeed.
>
> Using git 1.6.5. Any thoughts?
>

I ran into a similar situation before.

I believe it loads the entire file to memory, so if you have a single
file that's larger than the available memory, you'll run out of
memory, no matter how you tweak your settings.
