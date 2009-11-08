From: Tim Webster <tdwebste@gmail.com>
Subject: Re: performance issue: git clone compression
Date: Sat, 7 Nov 2009 18:45:29 -0800
Message-ID: <72877ab10911071845q1c60e2b0kfe6f0509b5728912@mail.gmail.com>
References: <72877ab10911071657p568b3b98v6fd90e84e098c107@mail.gmail.com> 
	<72877ab10911071709s200696d4mf12dc797da20be18@mail.gmail.com> 
	<alpine.LFD.2.00.0911072115270.16711@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Nov 08 03:45:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6xmw-00033K-0S
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 03:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbZKHCpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Nov 2009 21:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752887AbZKHCpo
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 21:45:44 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:31842 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbZKHCpn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Nov 2009 21:45:43 -0500
Received: by qw-out-2122.google.com with SMTP id 3so415707qwe.37
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 18:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9w0ukzEqfWaoPgg7rrZKowLc+L6cIer4rL/0SmHayYc=;
        b=gnw6LWDhd6zJjE5XLQCVggIDHoiQr/vWYPoacyAr2rBHA9q1WOEWhYbJgF8q8WYkGO
         4dWdZGJ8xCppXEeJLQGhNz3gRo4amqpSIoXyHIhoVNUpUcZDJnjVZz4y+BvyY2ECBptz
         G2w9gRrYcP7UwNBqKdfWBuDU7S0zx+3u2N7D0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tTmIPz9VwPQueQ2tUfSimT/k89Q6UsO9yCVf65hAgjngQE9GbGaC9VvkLrYpcD1VKz
         S7GZmOaNdFRRwlt9/jFKAj17Zb3aapJqM+1YEe5N2g5avhZ59KA1Y6DjBUO1EqEQOAc/
         y+blWvz1c5FEdapLjNTd56OShPkAyW+ov+QvY=
Received: by 10.229.43.79 with SMTP id v15mr846165qce.40.1257648349080; Sat, 
	07 Nov 2009 18:45:49 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0911072115270.16711@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132384>

On servers with limit memory it is not piratical to run git gc.
I can run git gc on a bare mirror and rsync back to the server.

I would prefer to for go compress packing entirely for the large git
repositories containing media files.

Can I disable compression by file attribute via .gitattributes?

I am trying to use git for all repositories to avoid a mix of version
control methods.
=46or media repositories I am using

[core]
    repositoryformatversion =3D 0
    filemode =3D false
    bare =3D false
    logallrefupdates =3D true
    compression =3D 0
    loosecompression =3D 0

[pack]
    # disable delta-based packing
    depth =3D 1
    # disable compression
    compression =3D 0

There is no problem with git pull and push
Just git clone swaps the server to death



> Make sure the remote repository is fully packed. =A0To do so, just go=
 into
> the remote repository and run 'git gc'.
>
>
> Nicolas
>
