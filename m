From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Is it possible to have a file shared between branches?
Date: Mon, 12 Apr 2010 09:33:46 +0000
Message-ID: <m2p51dd1af81004120233o95640769zb14a63a4bdb29a76@mail.gmail.com>
References: <alpine.OSX.2.01.1004121058390.52293@kroll.spectro.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric LEBIGOT <Eric.Lebigot@normalesup.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 11:33:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1G1l-0005gR-LC
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 11:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab0DLJdw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 05:33:52 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46862 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab0DLJdv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 05:33:51 -0400
Received: by bwz19 with SMTP id 19so24303bwz.21
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 02:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ctJ6RWCmf1RnoeVpOGVTiUKhY9xpbIT2/Od9Q6Kdfgw=;
        b=oueBJHffdEudtMidCXZPr0OjCcAaGfoyk+VT3VZevo7iADpCX+xqTDH1jsRVWzAIaR
         +Vdxh58gTLnbNGZ4VrVyn8GOImyLJfZyWFzJdaHjFigqtSFvFt1K1pUuu//sSbPps183
         XfQ3XHUfWdH7JoapUkcxW/Rdskblgi03pH0R0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R1aEyuPQzQAVGE3h++wDEpaX+Swfc2D1iE8viWgTYB4OOGes/XdtRGA7GhfcHIU3dx
         Qvbx1xyBcYjlqkk7rBV2L9MchNhSWYmwmbksLyN0JUEI26+RcKTW8kYg4vn/eGR9UMW4
         vj4LCTuZ/xfCEu8uZgoHBTO0aHDJyZvn11ELg=
Received: by 10.204.121.195 with HTTP; Mon, 12 Apr 2010 02:33:46 -0700 (PDT)
In-Reply-To: <alpine.OSX.2.01.1004121058390.52293@kroll.spectro.jussieu.fr>
Received: by 10.204.10.152 with SMTP id p24mr933294bkp.94.1271064826322; Mon, 
	12 Apr 2010 02:33:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144718>

On Mon, Apr 12, 2010 at 09:10, Eric LEBIGOT <Eric.Lebigot@normalesup.or=
g> wrote:
> Is it possible for git to track a single file that would be shared ac=
cross
> branches? =C2=A0Case in point: a to-do list file that describes what =
has to be
> done in all the branches; it can be convenient to put all the things =
that
> have to be done in a single, shared file, while keeping this to-do li=
st in
> sync with the code (so that it lists what has been done, and what rem=
ains to
> be done). =C2=A0Committing in a branch would in effect also commit th=
e shared
> file in the other branches (another possibility may be to have in eff=
ect
> many "trees" in a single git directory, with a specific tree for the =
to-do
> list).
>
> Is this something git can do?

Sure. But it doesn't do it automatically. To do it you'd write a
little script to cherry-pick any commit to the TODO across all your
branches on commit.

That's now how I'd do it. I'd just add a TODO submodule or just always
work on the TODO in one branch.
