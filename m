From: Egor Ryabkov <egor.ryabkov@gmail.com>
Subject: Re: Git fetch/pull stopped working
Date: Tue, 8 May 2012 17:59:05 +0400
Message-ID: <CADB4Qb35FfTL=XX04iR71+2Rg8p4s2roqAF8b_BdFNP9YN=sfA@mail.gmail.com>
References: <CADB4Qb1BhWpm1mAwiHy+edySvo7P+YcvrSiTSc8dVzKQsnNCfQ@mail.gmail.com>
 <7vehqv36aw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 15:59:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRkwp-0002w4-C3
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 15:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296Ab2EHN7X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 09:59:23 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:44329 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab2EHN7W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 09:59:22 -0400
Received: by werb10 with SMTP id b10so1933656wer.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=u36oxVyaeVYgWzSeFPN9K4AWwvO5+dZ1K/WwV9xT624=;
        b=J9X9UM6qoLTK3vO3/bGvpUFNSnolObDqDmTU5zJPHDUBINoVlbDWihZxay6DIPXvwN
         MrQ6orjDd5qG8ycCsF/kGphjq1XsgRVZwWeogrdbtkWbh0LWbM0oZhsV1WexwiB0KZFz
         KIdboMyWxaFweE2cHMrd+3tBjJ/n+kqSkoZHmxEWfrwHakHysX2m/0eFsdmhas92eUA4
         0lUAK9uL71zwMr+Y51Kfk0FClFSf192T0gOd+4XQidtf+J9Eql5+g9ARHO3evk15NV4M
         IC1jY36gTc9DS5q5sckAL2juMmV4tyOGfIG8YGo+PfTzry0YfYex4sHs1epEsdN41RRA
         zMdw==
Received: by 10.50.153.165 with SMTP id vh5mr11130972igb.4.1336485560242; Tue,
 08 May 2012 06:59:20 -0700 (PDT)
Received: by 10.42.60.200 with HTTP; Tue, 8 May 2012 06:59:05 -0700 (PDT)
In-Reply-To: <7vehqv36aw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197365>

> Are you sure it is an error on the remote side (presumably on GitHub)=
?

No, I'm pretty sure it's something on my side, as clones on other PCs
still work.


>> "$ GIT_TRACE=3D1 git fetch" gives somewhat different output on local=
 PC
>> and server:
>> http://pastecode.com/bd3fc1a79f8e9d1eaf30911d9895938051c472f4
>
> So you are going over http:// after all. =A0But it does not look like=
 github
> to me

No, I'm using SSH connection.
Did you imply that it's better to paste logs directly in the email?
Here they go:

############# Local results #############

$ GIT_TRACE=3D1 git fetch
setup: git_dir: .git
setup: worktree: c:/Projects/(local_path)
setup: cwd: c:/Projects/(local_path)
setup: prefix: (null)
trace: built-in: git 'fetch'
trace: run_command: 'ssh' 'git@github.com' 'git-upload-pack
'\''(username)/(reponame).git'\'''
Enter passphrase for key '(keyname)':
trace: run_command: 'rev-list' '--quiet' '--objects' '--stdin' '--not' =
'--all'


############# AWS results #############

$ GIT_TRACE=3D1 git fetch
trace: built-in: git 'fetch'
trace: run_command: 'ssh' 'git@github.com' 'git-upload-pack
'\''(username)/(reponame).git'\'''
ERROR: Repository not found.
fatal: The remote end hung up unexpectedly



I tried re-adding remote: SSH version fails with the same error, but
HTTP version works. I'd rather have SSH working, though.
And ideas about what could've caused it, or how to diagnose it further?
