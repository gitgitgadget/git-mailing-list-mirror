From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Makefile: Remove excess backslashes from sed
Date: Fri, 9 Apr 2010 17:34:15 +0200
Message-ID: <g2xfabb9a1e1004090834y7d9c05f0xf09ef7f5c34c3ab7@mail.gmail.com>
References: <1270783330-35215-1-git-send-email-brian@gernhardtsoftware.com>
	 <7vvdc12mmz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 17:35:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0GEj-0000fO-Ds
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 17:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab0DIPe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 11:34:26 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:56820 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208Ab0DIPeQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 11:34:16 -0400
Received: by qyk9 with SMTP id 9so1476365qyk.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/pXU77spSx7TQjM6bqmmQI6A+Fj+JCk60L1g8+W+ry4=;
        b=dB5/B3oVHkekvSJT+BdqRRlYkKgEnCKR8yHIG66ZWD/btvhdgD9etqkYNfrxmMDhjm
         a+TjLWWIseOJvbyYiM5OwFzzxSrXlD7aIcwwrzYKrXxP3Rkp6RV7mnW449IZuuq/2oHh
         PllBFmeAI7ubtSsGWWkzlQo0UGsUaOdFUBULE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AgUtcJhUHybA80afvjboBSNKK0nNhWcO8q73KRHfg9QreihnfhULnbfNhCzJ9eTAR/
         TouATzFynVT0qp1qxR3Q77rj9K15adXL3OnB4o+PSag1zhVP6H8UCZQz7YKkWoNKq457
         nbMxRQnp+9cGT5XSum49Nuoay4er+oXSw+rcQ=
Received: by 10.224.74.3 with HTTP; Fri, 9 Apr 2010 08:34:15 -0700 (PDT)
In-Reply-To: <7vvdc12mmz.fsf@alter.siamese.dyndns.org>
Received: by 10.224.96.27 with SMTP id f27mr75625qan.198.1270827255917; Fri, 
	09 Apr 2010 08:34:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144442>

Heya,

On Fri, Apr 9, 2010 at 07:57, Junio C Hamano <gitster@pobox.com> wrote:
> I wonder if we can make this a lot simpler to avoid multi-line sed sc=
ript.
> For example, we could write the source Python script to always begin =
with:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#!/usr/bin/python
> =C2=A0 =C2=A0 =C2=A0 =C2=A0import sys;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0import os;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.path.insert(0, os.getenv("GITPYTHONLIB=
","."));

Thank you, I like this a lot better than our current approach. I think
it's very ugly that git (needs to) mangle(s) the python files when
installing, since that means that line-numbers don't match in
stacktraces. I'd definitely prefer using this.

--=20
Cheers,

Sverre Rabbelier
