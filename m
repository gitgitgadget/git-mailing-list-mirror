From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] Add log.abbrevCommit config variable
Date: Sat, 14 May 2011 18:22:38 -0400
Message-ID: <BANLkTi=og+e6JW8t+sCvkFJUnR=SrFtWGg@mail.gmail.com>
References: <20110514190122.GA16851@elie> <1305406038-36435-1-git-send-email-jaysoffian@gmail.com>
 <20110514215543.GA23648@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 00:23:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLNEw-0000V9-MZ
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 00:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907Ab1ENWXK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2011 18:23:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51067 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab1ENWXI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2011 18:23:08 -0400
Received: by pzk9 with SMTP id 9so1619024pzk.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 15:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=z9ewkqyyzSinxp9st5H5t9x4ClAo1mvQXdu+WDak6HY=;
        b=czBciag+Fv2UmFbqQgHh/Z673sAi5gpAX+9jt4i3WA6kCXbFOSjr5Ua/OrZ+pu4GlX
         e0CzfeX5EqDzhdjPW7u5UrfjKAhvXg2a51HCg63RAokH4sg2NAMyOKWoGfpG0c9FHaZH
         aFC7gBN5qjDQQb6mdIwU2qYBcB8KiQ7lJqRIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ne4Egqo0NbIjM8ocO9q4AmxrVCl9LNbCgxF7PPq2YmueNys7+lLj3kOCzvDtQqhlQl
         pDvlQmSwKK9t4Sw2JXKCwVx+lNfnPC307bOE3AJhbeD8LMgzhNXTPkXeXzfWyuNbBRyW
         JgIsF8AA+VytrnbqpEPq8b0s9uLkmqm/lWFrE=
Received: by 10.142.120.15 with SMTP id s15mr1827755wfc.141.1305411788156;
 Sat, 14 May 2011 15:23:08 -0700 (PDT)
Received: by 10.142.174.16 with HTTP; Sat, 14 May 2011 15:22:38 -0700 (PDT)
In-Reply-To: <20110514215543.GA23648@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173609>

On Sat, May 14, 2011 at 5:55 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jay Soffian wrote:
>
>> Add log.abbrevCommit config variable as a convenience for users who
>> often use --abbrev-commit with git log and friends. Allow the option
>> to be overridden with --no-abbrev-commit.
>
> Based on a quick google code search, this will break scripts. :/
> For example, tig uses "git log --pretty=3Draw" to get revision lists,
> including expecting 40-digit commit ids.

Hmfph.

> But aside from that, this looks good to me. =C2=A0I'm not sure what t=
o
> suggest: go out and spread the word about diff-tree? suppress this
> configuration when --pretty or --format is passed? =C2=A0There's no o=
bvious
> good answer.

Ah, see:

- 635530a2fc (log --pretty/--oneline: ignore log.decorate, 2010-04-06)
- 4f62c2bc57 (log.decorate: only ignore it under "log --pretty=3Draw", =
2010-04-08)

So I'll do the same thing for log.abbrevCommit.

j.
