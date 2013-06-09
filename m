From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 07:09:27 -0500
Message-ID: <CAMP44s04nU+GBQchK0D0ExKTCp_B0oitSxzGUo++3Q_XbGv9sw@mail.gmail.com>
References: <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
	<CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
	<CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
	<CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
	<CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
	<CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
	<CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com>
	<20130609043444.GA561@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 14:09:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UleRE-0002pn-Jt
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 14:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab3FIMJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 08:09:32 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:55492 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab3FIMJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 08:09:31 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so4958148lab.18
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 05:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iAZ5vXvGWYP7DXUIGXExn0gC5Ioq2UGB309GSKYDPck=;
        b=w3LkDhNBRl1H3UpgqzX0wExaHZud744NMSeHlHBJUHCiBJswwM/+Yl/0th8tbJ37Si
         VwOe2oxPWCUZtbxcG14C5aQfN/Y5IcPNoAZ6aQJ+5A0RBhjyYRemuGinUPRUi8q8dfSc
         6rqs5AtJ8ebiR2r9DFtgQjsMaUSltG1nE5vFssSs/0/vqsut9L5W/Ao4x1U3eVjFwkL5
         oCqIQ/+67eo1RWjd3s+6FuZtGt+NOjay6KTJyN29T60CnM56b/7S1sjzrBL/gVbCE2ve
         o1bscnSoa/A+E5TveWs1eEP/pDQtwLeT6a7d/CMDyJLRwL9SKaeYDw5uP4yQZl6Y7kXm
         nLiA==
X-Received: by 10.152.26.225 with SMTP id o1mr2892654lag.43.1370779768509;
 Sun, 09 Jun 2013 05:09:28 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 05:09:27 -0700 (PDT)
In-Reply-To: <20130609043444.GA561@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226955>

On Sat, Jun 8, 2013 at 11:34 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 08, 2013 at 09:20:54AM -0500, Felipe Contreras wrote:
>
>> Let the code speak. Show me a script in any language that does
>> something useful using libgit2, doing the equivalent to at least a
>> couple of 'git foo' commands.
>
> Sorry that I cannot show you the source code, but you may interested to
> know that libgit2 powers:
>
>   1. Microsoft's "Visual Studio Tools for Git" plugin
>
>   2. GitHub's native Mac and Windows clients (using Objective C and C#
>      bindings); some operations still shell out to git where the
>      functionality is not yet implemented in libgit2.
>
>   3. Parts of the web view of GitHub.com via Ruby bindings
>
> It is definitely not feature-complete when compared with git.git. But I
> do think it is in a state that is usable for quite a few tasks.

That's not what a I asked. We have perl, and shell, and python, and
ruby scripts in git.git, they all use 'git foo' commands to get things
done. But to do that, forks are needed, many of them, constantly. The
proposal was to use libgit2 to avoid such forks. Well, show me a
*script* that does that and is worthy of inclusion to git.git, even if
it's to contrib.

I didn't ask for irrelevant 3rd parties, I asked for something worthy
of inclusion into git.git, a script that does something useful using
libgit2.

Duy Nguyen seems to think it's easy to do that. I'm waiting.

-- 
Felipe Contreras
