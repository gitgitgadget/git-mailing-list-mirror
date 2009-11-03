From: Adam Mercer <ramercer@gmail.com>
Subject: Re: determine if the tree is dirty
Date: Tue, 3 Nov 2009 13:30:02 -0600
Message-ID: <799406d60911031130u3e37677fi1a8dfd6f7fdfdfe9@mail.gmail.com>
References: <799406d60911031057l5dcb4d4fi3705cc66997ff7f7@mail.gmail.com> 
	<7v3a4vs9g3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, jepler@unpythonic.net
X-From: git-owner@vger.kernel.org Tue Nov 03 20:30:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5P5M-0004vj-MZ
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 20:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbZKCTaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 14:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbZKCTaS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 14:30:18 -0500
Received: from mail-qy0-f174.google.com ([209.85.221.174]:45820 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbZKCTaR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 14:30:17 -0500
Received: by qyk4 with SMTP id 4so3092639qyk.33
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 11:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=nW6icX7g613cfMkr9RYDy5sFcznAf8UnMpgvmBbKTrY=;
        b=DaZVc3po6AAc5bnT1bc08BEFHYK6ty8l4qypW3iJaJwnqS6291OEMDaeBG8iET+Csn
         3m0l1XiK//MQozmxm0Eg2u8Wro9+db4mCTpB064HOMx3OL2jmfyZm49q0d0VjnQbkZ7n
         S3sMSrj1EQFvju8z+xF9KtqwUSeZTkOb7K0ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TDoJNi/dXFd5iZvLvhUAo50YSsMktQEbqavQZClYDmjhlvrvTyB6686OGbsyta3qD2
         4EVf4r/TidT6xudUC4nPs77t+skIp2Uv5DTsM/SKgy0MLED1jZGjvQstRpV4r0yjjDX8
         pkvVc9cgrsnCdeRwrxuvNXvLCUVM+jsXUL/tc=
Received: by 10.229.13.213 with SMTP id d21mr57531qca.45.1257276622112; Tue, 
	03 Nov 2009 11:30:22 -0800 (PST)
In-Reply-To: <7v3a4vs9g3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131990>

On Tue, Nov 3, 2009 at 13:06, Jeff Epler <jepler@unpythonic.net> wrote:

> GIT-VERSION-GEN uses something like this (shell script):
>        git update-index -q --refresh
>        test -z "$(git diff-index --name-only HEAD --)" || VN="$VN-dirty" ;;

On Tue, Nov 3, 2009 at 13:19, Junio C Hamano <gitster@pobox.com> wrote:

> Use plumbing commands.
>
> "git diff-files" will show changes you have in the work tree compared to
> the index.
>
> "git diff-index HEAD" will show changes you have in the work tree compared
> to the HEAD.
>
> "git diff-index --cached HEAD" will show changes you have in the index
> compared to the HEAD.

Fantastic, this is exactly what I was after! Thanks!

Cheers

Adam
