From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH] run-command.c: Accept EACCES as command not found
Date: Wed, 23 Nov 2011 09:17:43 +0100
Message-ID: <CAH6sp9N2ycsoU=is3BVanH33CowD+sMNmWq=Z1MsPJX=HGYY+g@mail.gmail.com>
References: <1321912387-4569-1-git-send-email-fransklaver@gmail.com>
	<7vbos5f7ix.fsf@alter.siamese.dyndns.org>
	<op.v5bjtk1r0aolir@keputer>
	<7v62idf2vy.fsf@alter.siamese.dyndns.org>
	<CAH6sp9MxbDhQ3RiA6jO1fswAZX3R6C2fv0gzJdpGp432ovWsjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 09:17:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT81d-0007lt-E8
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 09:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165Ab1KWIRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 03:17:44 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53174 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab1KWIRn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 03:17:43 -0500
Received: by qadc14 with SMTP id c14so2192819qad.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 00:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/eI+Pn6qjMe/BCALDzRAGddZ/RvnqG26OZVputDvrnY=;
        b=OFO5xjghaqtZyQzNMC8/9Epbw2+DAxUFQhKPj6Rv4FyqMQJqLLIsVrql57+UX3FbPa
         r4MTtJz3lDyh330ZFCMG25LiMPCIXLLCcvWp+BhLZl0aT2/56DltDkBe5Cpp4lVWoqCI
         VM/wxJ2yiVuXh5cKv/pnAliz8VDUmTALK2E1E=
Received: by 10.224.76.141 with SMTP id c13mr9934560qak.97.1322036263193; Wed,
 23 Nov 2011 00:17:43 -0800 (PST)
Received: by 10.224.86.11 with HTTP; Wed, 23 Nov 2011 00:17:43 -0800 (PST)
In-Reply-To: <CAH6sp9MxbDhQ3RiA6jO1fswAZX3R6C2fv0gzJdpGp432ovWsjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185824>

On Tue, Nov 22, 2011 at 10:31 AM, Frans Klaver <fransklaver@gmail.com> wrote:

> If git is going to do some diagnostics on why the execvp returned
> EACCES, it can still give a few hints. Most of the more likely options
> are then ruled out.

If there are no objections, I'm going to cook up a patch that

- Keeps the current behavior (bail on EACCES)
- Adds a more helpful diagnostic message somewhat like libexplain's,
but more terse and if possible with slightly more domain knowledge
- Takes into account the notes made following
http://article.gmane.org/gmane.comp.version-control.git/171838

Frans
