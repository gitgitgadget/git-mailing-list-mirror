From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 10:11:51 +0000
Message-ID: <AANLkTimcb92zD-bcguV65qnhLN+oCaJRi7SZq1GFw4hd@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net>
	<AANLkTi=MenKX7Eh5PTpjfiYirrgLBCamWgorA35rx-Fy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Greg Brockman <gdb@mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 12 12:12:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjUlU-0002ZG-21
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 12:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720Ab0HLKLy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 06:11:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38736 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab0HLKLx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 06:11:53 -0400
Received: by fxm13 with SMTP id 13so608644fxm.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CaomAe8rQIJEvuH2BACN4PWpMP9Az4yzBF8EwkdhqHo=;
        b=g2YVnIkrbK1FOC33xh+Wkez/VVI/sHk9QJoFzuP0IdmwBsT/Z/oNnBRh0C8ACIPYPu
         TUuAankFFjI0/GqFl7PoWn7hFHuEBuXDI8QmigZ/uoHdYLaFZyI/O2QIWdl2lCJidfT4
         VVHuoq4k+1sxm494lRbdc2Lgn0WZbx5iZ5oJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k9adEESzGxExQrv8pqpJ5lS3xJgrnaObcGOuztxcy3nbD6v/pSJbwxiHxmgsj48bbv
         R7jUIiSTgSte6fwKI3CveN3nAgnpKMYW5rLTEpgumP8cr0mXIupZUetY0LVbf7l5+vNT
         ZEwETqHDMJAP1w1k6v+y/oulrwqradtHwfqkc=
Received: by 10.223.124.145 with SMTP id u17mr21342428far.92.1281607911656; 
	Thu, 12 Aug 2010 03:11:51 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 12 Aug 2010 03:11:51 -0700 (PDT)
In-Reply-To: <AANLkTi=MenKX7Eh5PTpjfiYirrgLBCamWgorA35rx-Fy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153360>

On Thu, Aug 12, 2010 at 09:37, Greg Brockman <gdb@mit.edu> wrote:
>>> * gb/shell-ext (2010-07-28) 3 commits
>>> =C2=A0- Add sample commands for git-shell
>>> =C2=A0- Add interactive mode to git-shell for user-friendliness
>>> =C2=A0- Allow creation of arbitrary git-shell commands
>>
>> This needs work on Windows because we do not have geteuid(), perhaps=
 just
>> a compiler flag -Dgeteuid=3Dgetuid
> I had a submitted a revised patch that just uses HOME, see
> http://thread.gmane.org/gmane.comp.version-control.git/152050/focus=3D=
152135.
> =C2=A0I guess that didn't make it in yet.

Maybe that should be (untested):

    char* home =3D expand_user_path("~");

To avoid duplicating the getenv("HOME") code (e.g. if someone wants to
make a getpwuid fallback in the future).
