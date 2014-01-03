From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH/RFC] Introduce git submodule add|update --attach
Date: Fri, 3 Jan 2014 01:26:44 +0100
Message-ID: <CALas-ij4b-y0=6wa+VnEmnyq9a0c3ACQ+yOgESBeXOy32mm_MQ@mail.gmail.com>
References: <1388368184-18418-1-git-send-email-ceztko@gmail.com>
 <xmqqppoap2qb.fsf@gitster.dls.corp.google.com> <CALas-ihAkUGOZsmWRHN7fG+5D0OnpWmSNtrMH2mwNm51gcYdRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 01:27:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vysbi-00088s-0L
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 01:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbaACA1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 19:27:12 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:46396 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbaACA1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 19:27:05 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so15019027obc.35
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 16:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UmGJigl/yREk2+GsWjPXKhi0euKpDzYtPNBJ8xldBDo=;
        b=jfDKVZi5K80tsGHiOCnFRVTxU6K9zs64npuj0xKQJdQYiZ8RcyV1nWm4uzItFBjYcR
         bR+n5cp8YC/H8RRdWqkq7RX8QZmNaSGzJHt+h7FYejEWs8rhMj9GxIwmzPtAOF4Cdlqw
         1iHISEkCTWiLaJ6S9oUgO83uQK0k0cdUjhnzJVcikNG+IQJn8FEqgXeSaWcTsc4+H0/o
         r4QIsKRl4M8lcbj/2lmZfHlzE1+v1dbkXMZIe0/oziBuCoao9Hdnbpo3yvvFtUHrTeU2
         AO9tce+I78whHWufW4ppO9SQfST9efD7NafFlJHTXWybCNO7zJFWiP24i+QKEAVSUN+G
         RA6Q==
X-Received: by 10.60.47.116 with SMTP id c20mr129979oen.60.1388708824486; Thu,
 02 Jan 2014 16:27:04 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Thu, 2 Jan 2014 16:26:44 -0800 (PST)
In-Reply-To: <CALas-ihAkUGOZsmWRHN7fG+5D0OnpWmSNtrMH2mwNm51gcYdRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239899>

2014/1/3 Francesco Pretto <ceztko@gmail.com>:
> Concluding, my point is that at the current state submodules in git
> seem to be flawed because of the inconsistent HEAD state between "add"
> and "update" users. With my patch applied the attached HEAD behavior
> would be fully supported. At some point "git submodule add" (without
> the "--attached" switch) could be also modified to produce a detached
> HEAD by default, removing any remaining inconsistency.
>

Also consider that ultimately my desired behavior for submodules is
the following:
1) I'd like cloning users to have an attached HEAD by default when
doing "git submodule update";
2) when using an attached HEAD, I'd like "git submodule update" to
also imply "--remote".

An alternative approach would be, for example, make "git submodule
update" honor the current documentation about the behavior of "merge"
and "rebase" update operations, if confirmed to be wrong, really
keeping the HEAD attached. That would be a breaking change, but at
least it would reflect currently documented behavior. I prefer my
original approach, because it adds more feasibility and it's not
breaking in the short time, but I'm open to that and other solutions.

Please let me know, what do you think about it.

Thank you,
Francesco
