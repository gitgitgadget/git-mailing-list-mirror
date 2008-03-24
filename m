From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: Re: thread-safe libgit.a as a GSoC project, was Re: [SoC RFC] libsvn-fs-git: A git backend for the subversion filesystem
Date: Mon, 24 Mar 2008 15:50:04 -0400
Message-ID: <3e8340490803241250w186d6ae2l38031521c2d5c6c2@mail.gmail.com>
References: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com>
	 <3e8340490803212202r6dbaa9eel544ba2b4b8e8d0c7@mail.gmail.com>
	 <alpine.LSU.1.00.0803221229410.4124@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 20:50:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdsh1-0001yc-0R
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 20:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbYCXTuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 15:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbYCXTuI
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 15:50:08 -0400
Received: from rn-out-0910.google.com ([64.233.170.189]:35950 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbYCXTuF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 15:50:05 -0400
Received: by rn-out-0910.google.com with SMTP id v46so1474974rnb.15
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0Y9WXFUWLXtwzUgznz8XiNDm7oO6JRG1MKIUSJAYHFA=;
        b=oHT6bL6R33f43bJI62yGT9bkCl/2avFy3+rvZa8UFKSiDKh5n4cPYcugjFSQLLyG0CjjjmRxf+XpNhLI8K5zro3bdLRso2yjI1+XKvQy06UmlrNw5d3WG2H5oS0MsEufEh1ndCeUk0EdB20X5UOJgKAQcxI5QZxykKCMD98nUSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nZkqOSbMFw1HwobiUHNc9kGga78i1VP6tqUN6dp6skdspa+E5dXakfp4+ahZppqTKhsAUx5/Z1OYKrcSZa3kVt06ayNn+JkVuFShn9+jEAjnvmNU52TbFRasJ58/0oheh/S6WY6FY2A4RCYKeBg0Vr+S2qr9CCASoSiOcANudHY=
Received: by 10.115.108.1 with SMTP id k1mr12568924wam.14.1206388204084;
        Mon, 24 Mar 2008 12:50:04 -0700 (PDT)
Received: by 10.64.49.9 with HTTP; Mon, 24 Mar 2008 12:50:04 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803221229410.4124@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78085>

On Sat, Mar 22, 2008 at 7:35 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  On Sat, 22 Mar 2008, Bryan Donlan wrote:
>
>  > On Wed, Mar 19, 2008 at 12:08 AM, Bryan Donlan <bdonlan@gmail.com> wrote:
>  >
>  > >  I'm planning to apply for the git summer of code project. My proposal
>  > >  is based on the project idea of a subversion gateway for git,
>  > >  implemented with a new subversion filesystem layer. A draft of my
>  > >  proposal follows; I'd appreciate any comments/questions on it before
>  > >  the application period proper begins.
>  >
>  > Thanks for all the comments. To try to avoid spamming the list, I've
>  > replied in a single message, if it'd be better to reply individually
>  > in the future please let me know.
>
>  My preference is to have single replies, possibly changing the subject
>  ("xyz, was Re: blabla"), but it is maybe just me.
>
>  > Also, after looking at libgit in a bit more detail, I think it might be
>  > necessary to not use it after all, as subversion requires support for
>  > multiple open repositories, as well as thread safety (at least when
>  > accessing different open repo from different threads). Perhaps a
>  > thread-safe git library would be a nice SoC project as well?
>
>  As I said on IRC yesterday, I think that such a libgit.a would be nice,
>  _but_
>
>  - a lot of git programs expect to be one-shot, and libgit.a shows that,
>
>  - not many people will help you with your effort, but just ignore it and
>   actively introduce things that do not help libification (at least that's
>   my experience),
>
>  - unless you have a proper need for such a library, I do not think there
>   is enough motivation to actually get it to completion.
>
>  I once thought that libification would be nice, and important, but as I do
>  not need it myself, I reversed my opinion.

All right. If I do end up having to recreate (thread-safe,
multiple-git-dir-safe) logic for my project, I'll try to keep in mind
the possibility of spinning it off into a proper library later though
:)
