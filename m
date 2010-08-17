From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] t/t5800: skip if python version is older than 2.5
Date: Tue, 17 Aug 2010 18:15:46 -0500
Message-ID: <AANLkTimwNBAKwhKwsquDS4k3x0_iDo3rEyqFfhMcsb38@mail.gmail.com>
References: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com> <injaoVtrfs7Li4aYBNxEQeawf3YbhxcYbL79Jvef2ML9502YRtjqEol2RVKBzXfH_PfbMep0lvU@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 18 01:16:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlVOC-0004IO-CL
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 01:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab0HQXQK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 19:16:10 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33816 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab0HQXQI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 19:16:08 -0400
Received: by gxk23 with SMTP id 23so2828063gxk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 16:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EiDuKzr4cLQKuAXkynZQ4gmns0buKpaaJpUr7Ot7tfg=;
        b=KaauH3eC8R1XjWzBXUv2gXVrTZWmAiJkSPmQwPcADAWkb51OkMYja9CjsAbEZMBDXk
         S1u+IGpvdBszn5ynFYhY+KTh48WlypgoziLN6tXenejMTH6cGMWZJbnBw6mP+TQ9LQcX
         9cK2l7aKLXjRI4mB1QFliwWzq//2+J3wX+2rM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mIL1mPNAQ6cnzajzfLsH4K5FK3A1HK8um8EGEIKbFk241wns+L9Xl0+ysGatH2sXm3
         3OAs50QjEGN55mZvS7/izdGKSAcTAyW/rKbpfO2UUB70u7idcWBA0TOkdKa2x753J+B8
         1bnc2Tw+OB7EuhYr7ebFN5zn62EtDsns+G8ss=
Received: by 10.151.111.1 with SMTP id o1mr8292585ybm.26.1282086967271; Tue,
 17 Aug 2010 16:16:07 -0700 (PDT)
Received: by 10.150.98.8 with HTTP; Tue, 17 Aug 2010 16:15:46 -0700 (PDT)
In-Reply-To: <injaoVtrfs7Li4aYBNxEQeawf3YbhxcYbL79Jvef2ML9502YRtjqEol2RVKBzXfH_PfbMep0lvU@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153786>

Heya,

On Wed, Jun 2, 2010 at 18:23, Brandon Casey <casey@nrlssc.navy.mil> wro=
te:
> -if ! test_have_prereq PYTHON
> +if ! test_have_prereq PYTHON || ! "$PYTHON_PATH" -c '
> +import sys
> +if sys.hexversion < 0x02050000:
> + =C2=A0 =C2=A0sys.exit(1)
> +'

I just checkout out this revision, there is no PYTHON_PATH variable. So=
:

sverre@laptop-sverre:~/code/git/t$ make t5800-remote-helpers.sh
*** t5800-remote-helpers.sh ***
t5800-remote-helpers.sh: line 10: : command not found
* skipping git remote-testgit tests: requires Python 2.5 or newer
* passed all 0 test(s)

I'm not sure what is wrong here, but somehow the PYTHON_PATH variable
is not propagated to the script?

--=20
Cheers,

Sverre Rabbelier
