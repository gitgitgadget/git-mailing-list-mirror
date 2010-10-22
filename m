From: Jonathan Nieder <jrnieder@gmail.com>
Subject: .git file (Re: [long] worktree setup cases)
Date: Fri, 22 Oct 2010 00:28:55 -0500
Message-ID: <20101022052855.GA786@burratino>
References: <20101020085859.GA13135@do>
 <20101020190709.GB10537@burratino>
 <AANLkTimzfxJFz2FRVCJ7b4+icXMxpQGNo0WGm_BXzXNy@mail.gmail.com>
 <20101021033042.GA1891@burratino>
 <AANLkTikwApJ2EtJNiOZPHVrz6seJNP-zEqzH_b62ksLf@mail.gmail.com>
 <20101021185132.GB28700@nibiru.local>
 <AANLkTinS0co8TMmyRCQ4Xe9+pDR-uUn20WNQwYJEAQea@mail.gmail.com>
 <20101022050011.GA27179@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Fri Oct 22 07:32:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9AFH-0004Zz-BB
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 07:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab0JVFco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 01:32:44 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53119 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab0JVFcn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 01:32:43 -0400
Received: by yxn35 with SMTP id 35so322608yxn.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 22:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7DfBKnDJ/Z5iGgyXH/+GJUMrlDvwPHXiu+X95cRzhFg=;
        b=QAtr8MTlcMuy4AL0dHIUitT4HUvopBphhjxRNTOMwY9BWJIGZfHVZwF8P5109uLJds
         QdBhHMvCaYJKnxfYE/GM9PFRbWP1Uy2NMt6vfdtbtxdvn+zQJm7Z8Wm9iaykgrSZQxtz
         yn3Bwa9eKOQJPkBnWgSzxIBpc7du3lYXPHi0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ezjl1y4DYK2CF2YpuQxFPY6FD9LfenSt8naVfWt45WWne6B5AYnDxwurpBuTqF7acA
         g0Is9gnwi61aHkzrAhQjXX+FdYL8uHCOeeCXDmyA6ZVJFtJ1sUXAR64cnwhtFd7gtPXI
         nd7wyH+qoFQnEtgs254cTUqRjAx6zHTapio1A=
Received: by 10.101.180.32 with SMTP id h32mr1706541anp.105.1287725562840;
        Thu, 21 Oct 2010 22:32:42 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id g29sm2950976anh.36.2010.10.21.22.32.41
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 22:32:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101022050011.GA27179@nibiru.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159645>

Enrico Weigelt wrote:

> Why not using a symlink here ?

Suppose I wonder just that.  grepping through setup.c for ".git file",
I find the function read_gitfile_gently() --- why was that added?

$ git log -Sread_gitfile_gently setup.c
commit b44ebb19e3234c5dffe9869ceac5408bb44c2e20
Author: Lars Hjemli <hjemli@gmail.com>
Date:   Wed Feb 20 23:13:13 2008 +0100

    Add platform-independent .git "symlink"
    
    This patch allows .git to be a regular textfile containing the path of
    the real git directory (prefixed with "gitdir: "), which can be useful on
    platforms lacking support for real symlinks.
    
    Signed-off-by: Lars Hjemli <hjemli@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Hope that helps.
