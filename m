From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] GIT-VERSION-GEN: make use of git describe --dirty
Date: Fri, 22 Oct 2010 10:11:40 -0500
Message-ID: <20101022151140.GC9224@burratino>
References: <cover.1287746107.git.misfire@debugon.org>
 <4CC1745C.70506@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Fri Oct 22 17:15:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9JLA-0004xA-My
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 17:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369Ab0JVPP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 11:15:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45262 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757364Ab0JVPP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 11:15:28 -0400
Received: by gyg4 with SMTP id 4so696097gyg.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qxxc/TvCKc2x/0F4HGhe5B1celW6OLocNOK8tcDWesE=;
        b=iAyj1bEfuGzjUO3VBD9oSW7wyInprCtgA1kUaCjttyrIorXES87LvziGnR18YQFYS1
         h7EGVNgz4ZYUcdC7oMLw37g2S23CfsRBnWWCl/EyLVYdbt7wMNZeSNS8T5IbH1WUb+TC
         /s9IeC2SI3HPgR5qJNXFwkemUhlCIJNyFaCa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MJsWVIxxpd0vqrTq9IHtg5MNJ8/bM4IIc7fRwXCYwoE7Ly7/ZrF3IP8vUXjnQAWWsO
         UEPVSxN3aFJfC7KR7VKUqLGRDB4UWihJtUF0ZcIR+sDc0NExYovgjZB6llOuMLT59xZ9
         c2egWdgpLUYLZiQR9j5GHOZYP/4tGk64W+k5M=
Received: by 10.42.214.138 with SMTP id ha10mr139158icb.401.1287760527648;
        Fri, 22 Oct 2010 08:15:27 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x9sm2678224qco.46.2010.10.22.08.15.26
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 08:15:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CC1745C.70506@debugon.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159697>

Mathias Lafeldt wrote:

> Currently, GIT-VERSION-GEN invokes the plumbing commands "git update-index" and
> "git diff-index" to determine if the working tree is dirty. It then appends
> "-dirty" to the version string returned by "git describe".
> 
> However, as of Git v1.6.6, "git describe" can be told to do all that with the
> "--dirty" option, saving us the plumbing.

This has a minor downside, which is avoiding the nice version numbers when
building Git with git 1.5.6 installed.  What is the upside?
