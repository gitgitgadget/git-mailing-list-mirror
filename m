From: Adam Mercer <ramercer@gmail.com>
Subject: Re: Determining if a file exists in a bare repo
Date: Tue, 4 May 2010 11:57:12 -0500
Message-ID: <z2p799406d61005040957j93f8f4a3zfb8a9f38dbe7c72c@mail.gmail.com>
References: <w2q799406d61005040911p8fd7c234s5e6382298129985f@mail.gmail.com> 
	<7v7hnjoc3i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 04 18:57:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9LRE-0007OD-04
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 18:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759251Ab0EDQ5e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 12:57:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60862 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873Ab0EDQ5d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 12:57:33 -0400
Received: by gwj19 with SMTP id 19so1713677gwj.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8Oghqu+tM3E6ZlDUhPgCg/HmrPgIf48K4bCrnsZyNC0=;
        b=TVWldg4vKmNJ6CKC9QewrwlLDsOJ+bysk1IlcSeA9EEzP2dBG5CFE+70HtfWPkaM53
         YKWhkE1hhDddSH0/ydkvUMId9nLRU/kRltcB70Gvk8XEBT5ppVEUk04HeuA+MGnC96t2
         C1BF7qijAoIayGwj+WWBvpoaq7nZthc+5tlZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lzkMSY4CUNG+H69dNo/2azWSzCzDdMPWtoqGbZZqW+r//O+gRkOwxggr7hIbOHyoka
         +iuYILA7rQXOLRBta7kSZetoxS9fa170CkHbmxor8JJ+zeIlsKNCuyV1/oNTzwFB9rKT
         RF1zJEnprs6L4m4sdpEpZ3PCTw8OPZqv4+TKk=
Received: by 10.91.183.7 with SMTP id k7mr2718396agp.32.1272992252329; Tue, 04 
	May 2010 09:57:32 -0700 (PDT)
Received: by 10.90.97.8 with HTTP; Tue, 4 May 2010 09:57:12 -0700 (PDT)
In-Reply-To: <7v7hnjoc3i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146328>

On Tue, May 4, 2010 at 11:39, Junio C Hamano <gitster@pobox.com> wrote:

> Even if it returned an error status, you are discarding it by placing=
 the
> process on the upstream side of the pipe, so your command line above =
won't
> be able to catch an error anyway.

Sorry I wasn't very clear, first I trying to use git-show if the file
existed and then piping the output to rst2html...

> I would probably do something like this
> if I were you:
>
> =A0 =A0git rev-parse --verify master:INSTALL >/dev/null 2>&1 &&
> =A0 =A0git cat-file blob master:INSTALL | rst2...

Thanks, thats a better approach!

Cheers

Adam
