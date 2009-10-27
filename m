From: Jeffrey Middleton <jefromi@gmail.com>
Subject: Re: git update --prune issue
Date: Tue, 27 Oct 2009 10:07:27 -0500
Message-ID: <4389ce950910270807o69d51155xb083f34bb31e1dae@mail.gmail.com>
References: <4389ce950910261508p7eca354el77bad07305a80952@mail.gmail.com> 
	<4AE6B28F.9010407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 27 16:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2neT-00039z-Ag
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 16:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbZJ0PHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 11:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754346AbZJ0PHo
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 11:07:44 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:37703 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbZJ0PHn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 11:07:43 -0400
Received: by ewy4 with SMTP id 4so244943ewy.37
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=htd7cahvAxj0/OcuOFgTyC/UxCdnex/J8OvZg3Ruvkk=;
        b=uIhvDOBLhOYf8K8kutsG/1lSSser326V4RP2NPAYEeSZ81n7WvfTpOYNhk2oFqh4+Z
         okEems7E3QQBBBvdKc155/ACkhOTFTk6RG6O0RGrphFqRMSsKjzq3ASsu6+/ZO0AfW+4
         gjbUHrWrxqVDHwXk/E/PhAO3Jc2r0LYbECx3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=V5nACFTQ8/IhnqbqsbZezHp4GCGxR+wW0EnxoA41RlvJ/+DzRjWxOTGxF7nB0CllFQ
         oMAyYpuYpeIzwdlqKVFJ1kxSwIcGUbQNyNYE9QRDqZKoa6dvOe6qG5oXp/YnwO59Ep0h
         mhwxwNEUjyNb04tdbBJ0zbYYrD6HSsBMb9cmo=
Received: by 10.216.88.65 with SMTP id z43mr2263531wee.5.1256656067126; Tue, 
	27 Oct 2009 08:07:47 -0700 (PDT)
In-Reply-To: <4AE6B28F.9010407@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131347>

On Tue, Oct 27, 2009 at 3:42 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Do you get the same problem if you do the steps individually, i.e.:
>
> git remote update steph
> git remote prune steph
> git remote update kevin

I don't *think* I'll see it this way - I was doing essentially this
prior to introduction of the --prune option, and never saw it then.

> Does it depend on the order, i.e.:
>
> git remote update steph
> git remote update kevin
> git remote prune steph

I've tried once and saw no problems.  I just realized I should be
saving off all remote refs before doing a remote update --prune again
- next time I see the problem I should be able to rule out everything
for sure.  Sorry I didn't do that sooner.  However, I'm still fairly
sure it's specific to the all-at-once operation of remote update
--prune since I never saw it before that feature, and because once
that command finishes, everything is okay.

> Does "git fsck --full" say anything special?

Just 47 dangling blobs, 23 dangling trees, and 13 dangling commits.

> Michael
>
