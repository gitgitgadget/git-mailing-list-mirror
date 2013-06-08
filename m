From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 09:20:54 -0500
Message-ID: <CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
	<1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
	<CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
	<CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
	<CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
	<CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
	<CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 16:21:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlK13-0008FX-CO
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 16:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab3FHOU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 10:20:57 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:45344 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab3FHOU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 10:20:56 -0400
Received: by mail-lb0-f169.google.com with SMTP id d10so5108114lbj.14
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=R7nJC/g9J/vpQPcTPPsJdz/atUTB9XTOcd8k7n5OzcA=;
        b=oHyl0UbFOZi0/fVHzPprrF5uvXIIGHDyM6zAT+XFyXjEE4Hn6tkdpEuMXsCjZ3VzSE
         tILZ7kW6mNQQBRkHi8ToHkq1tGKgq1vstr7KJ5rsM8m7PXrNwno8weWQB0hrt1R6Rsfu
         FvxUtfB65ARhP1RqI21ijSiB/st6zB3DcUKzLDccAXG33sBBKgOC1yem5q7rBFNl+0ec
         bn8WA/dUvCZoHEX5Kk1tbHD4rIRxipP7NvvoD7MEx+Ge7+0fyYvN5qAm4bbBJ2dutxsL
         WgBPfyEr5asOnxPHCHlfX14wXpo5Ic8O4AliaxiARJtiLFdPGOzWe60A5obFqq4lwWzh
         NUqQ==
X-Received: by 10.112.219.133 with SMTP id po5mr3084299lbc.80.1370701254855;
 Sat, 08 Jun 2013 07:20:54 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 07:20:54 -0700 (PDT)
In-Reply-To: <CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226832>

On Sat, Jun 8, 2013 at 9:10 AM, Duy Nguyen <pclouds@gmail.com> wrote:

> Do we want to
> freeze libgit.a API so that scripts will not be audited and changed
> unncessarily?

No. Until we ship libgit.so the API remains internal, and free to change.

> I still think that binding new languages to a clean library
> like libgit2 is better than to libgit.a. Just thinking of what might
> work and what might not is already a headache.

Let the code speak. Show me a script in any language that does
something useful using libgit2, doing the equivalent to at least a
couple of 'git foo' commands.

-- 
Felipe Contreras
