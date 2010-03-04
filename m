From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2010, #01; Wed, 03)
Date: Thu, 4 Mar 2010 09:26:56 +0100
Message-ID: <6672d0161003040026u6d1f7a69h20566924b9ade43@mail.gmail.com>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 09:27:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn6Op-00033p-NZ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 09:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368Ab0CDI06 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Mar 2010 03:26:58 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:48214 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab0CDI05 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 03:26:57 -0500
Received: by wwa36 with SMTP id 36so1282210wwa.19
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 00:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b6XmyoCjRypZyrJrWft6jZpZWIlbYIpDsTNK1iEP1n4=;
        b=xYeTy6aOddnW9NNQNsFL2vvYSOtscAAKwCaenluUBiw3vz/xz+ze0/Ls1kf/RF7fSv
         Xy0irgws8Ij2eA9xVEk+VShYc01SEhkwNyCmcBtyb1bmjxj1vcrgUVckkAS3NFy8nYzV
         PZwxDlLh8R9oG1REk/iwZhEppcvy7chXjc/hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kFlsNHQEVTvbCnE6w8nnVB+TbWwGrJnS+xObibD8qxKyEyUZSZAjKLRdVyB2DWOWZ6
         Ny8y1FGWS7NhTP8mNUIj/3C97DIfSZ4PSCl88uRObZghkTixZu0IzGSP8pyzc+13oaZH
         XGOrcFhaBO7FQFhgwWuXhwv/BkiPR1k0uU9dM=
Received: by 10.216.171.138 with SMTP id r10mr703281wel.153.1267691216142; 
	Thu, 04 Mar 2010 00:26:56 -0800 (PST)
In-Reply-To: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141516>

On Thu, Mar 4, 2010 at 1:02 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:

> * bg/apply-fix-blank-at-eof (2010-02-27) 5 commits
> =C2=A0- t3417: Add test cases for "rebase --whitespace=3Dfix"
> =C2=A0- t4124: Add additional tests of --whitespace=3Dfix
> =C2=A0- apply: Allow blank context lines to match beyond EOF
> =C2=A0- apply: Remove the quick rejection test
> =C2=A0- apply: Don't unnecessarily update line lengths in the preimag=
e
>
> Probably ready for 'next'.

I have realized that there is one remaining minor issue.

If both --whitespace=3Dfix and --ignore-space-change are given,
new blank lines ending in LF may be added to the end of the file.
That is the expected behavior if the rest of the file has
LF line endings, but not if the rest of the file has CR-LF
line endings.

I think I have figured out how to fix it and I will send
a patch as soon as I have actually implemented it.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
