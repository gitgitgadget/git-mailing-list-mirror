From: Chris Packham <judge.packham@gmail.com>
Subject: Re: re-running merge on a single file
Date: Thu, 11 Mar 2010 16:33:20 -0800
Message-ID: <a038bef51003111633v5d5d418bu332b63bb3874e3ef@mail.gmail.com>
References: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
	 <201003112129.52596.markus.heidelberg@web.de>
	 <a038bef51003111408g38698837ldcf1d0f5995f4f30@mail.gmail.com>
	 <m3hbomla3u.fsf@localhost.localdomain>
	 <a038bef51003111631n38f7e50cp79d8335109f3ed0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jakub Narebski <jnareb@gmail.com>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 12 01:33:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npsoj-0000PW-Iz
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 01:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492Ab0CLAdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 19:33:21 -0500
Received: from mail-px0-f198.google.com ([209.85.216.198]:36663 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab0CLAdU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Mar 2010 19:33:20 -0500
Received: by pxi36 with SMTP id 36so208065pxi.21
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 16:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=io9XzqPt/OTCqyAiSx3JKL9mX74IuD8kcHqVoMpKCaE=;
        b=lWMROMl+MehHf6NjdQgjuXDY7Nb+415TZrkmKrvMsOBti8iopnILy/UuCuDGXJC5gG
         TLRyfI8B0RLyVUAITCzaMk+E1eMSWg7KFUEBis78gj5veJLoN7gnkJ81IlGGWbBfGRFQ
         DgC9TuD5PVOoGfqDqkCbqGqy+0Qz3AYoaOduU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Ji7u8yR2ajadtsOIBBOk4hhpwE8/20EW9oJcS+dxdeMahJlTCnbliawIiQBr52G7dE
         XOu4uJUqdaGO+DDhRURI4pCvlG5ehOm12BpXd+5OKvz02qUTY2ysANBk+RGjvMrci+V4
         UanC5XcFA9zypTiOnI1A0oIrb8+sKawXClXe8=
Received: by 10.114.163.1 with SMTP id l1mr1827786wae.214.1268354000290; Thu, 
	11 Mar 2010 16:33:20 -0800 (PST)
In-Reply-To: <a038bef51003111631n38f7e50cp79d8335109f3ed0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142009>

Hi,

On Thu, Mar 11, 2010 at 3:20 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>
> First, instead of 'git cat-file blob <blob-id>' you can simply use
> 'git show <blob-id>'.
>
> Second, while in
>
> =C2=A0$ git checkout --merge -- cpu/mpc83xx/start.S
>
> the path cpu/mpc83xx/start.S is relative to your current directory,
> in
>
> =C2=A0$ git show :1:cpu/mpc83xx/start.S > start.S.base
>
> the path has to be "absolute path in repository", i.e. path relative
> to top directory of the repository.

 That is the path from the top directory (its a u-boot repository).

>
> Try
>
> =C2=A0$ git show :1:$(git rev-parse --show-prefix)cpu/mpc83xx/start.S=
 \
> =C2=A0 =C2=A0> cpu/mpc83xx/start.S.base

git show doesn't complain about the path. But I'm obviously not
setting the stage correctly

$ git checkout --merge -- cpu/mpc83xx/start.S
$ git show :1:$(git rev-parse --show-prefix)cpu/mpc83xx/start.S
fatal: Path 'cpu/mpc83xx/start.S' is in the index, but not at stage 1.
Did you mean ':0:cpu/mpc83xx/start.S'?

By now I have additional commits that touch cpu/mpc83xx/start.S so
I'll see if I can find a file that I haven't touched since the merge.
