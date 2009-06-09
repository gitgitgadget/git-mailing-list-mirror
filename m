From: Elijah Newren <newren@gmail.com>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 14:49:41 -0600
Message-ID: <51419b2c0906091349j6ecd7d34x10ef92d42fee4a1e@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <32541b130906091252i6c96c44buc148bb525d7cde14@mail.gmail.com>
	 <20090609203747.GB13781@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 09 22:49:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME8GT-0005EI-D4
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 22:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbZFIUtl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 16:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755729AbZFIUtk
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 16:49:40 -0400
Received: from mail-qy0-f190.google.com ([209.85.221.190]:46239 "EHLO
	mail-qy0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660AbZFIUtj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 16:49:39 -0400
Received: by qyk28 with SMTP id 28so414452qyk.33
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 13:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZOzH9G2ZWNCWaYvmRLnYivtO5dRfNrp0vUih7oWy7yo=;
        b=LSKf1j8T/ptGyDeKG93TJ3X1e4UrsLw6cBC9Yw29FPyKR6fzF49LvTgwRNRYG88PzQ
         669ZbrxfWn6SPxGzeEOX0zbqG01J0UTRoKXgQsoP11xJAUkmqivnSTCKy3y9EyCe2vCz
         +r97bgcMIi1/5pslt6oTMXtBPut73pjY2r8GI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mYUQRB6zIFc5HESIQV6imlKs4m4ZnKfyl7VZyTdbXs7QrPx4W7JQ7NQgqz9TFhVI8T
         9OtTy7S0eekuxSsZLy3T6onp+x0kQi8NFPD+8pB1HsaYnuWtdjO60Bf7kCGVUl3fxxTV
         YCpAO37OTaCuf4RfNuF9B6tzINiX5K4zFX65s=
Received: by 10.229.81.136 with SMTP id x8mr123782qck.95.1244580581637; Tue, 
	09 Jun 2009 13:49:41 -0700 (PDT)
In-Reply-To: <20090609203747.GB13781@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121223>

2009/6/9 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
>> Crazy idea: we could actually make 'git revert' do both: given a
>> commit, it applies the reverse as it does now. =C2=A0Given filenames=
, it
>> simply brings them back to HEAD. =C2=A0But maybe that's too crazy.

Probably too crazy (too much potential for confusion), but an
interesting thing about the way eg revert was written is that any
valid git revert command passed to eg revert is invalid syntax, so I
can print the simple error message:
  If you are used to git revert, try 'eg cherry-pick -R <ARGS>'...

That prevents accidental misuse and misunderstandings, such as these:

> Doesn't seem that crazy to me. But maybe a bit problematic if you wan=
t
> to support both, "git checkout -- ." and "git checkout HEAD -- .". An=
d
> adding DWIMmery there seems dangerous, as in:
>
> git revert =3D=3D git checkout -- .
>
> git revert HEAD =3D=3D
> =C2=A0no uncommitted changes =3D revert commit HEAD
> =C2=A0uncommitted changes =3D revert to HEAD

I was thinking that if people had too much heartburn over changing the
meaning of revert from "revert-commit" to "revert-edits", then we
could always submit the eg revert functionality as git-revert-edits.
