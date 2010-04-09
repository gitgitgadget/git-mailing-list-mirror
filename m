From: Eugene Sajine <euguess@gmail.com>
Subject: git rebase command and docs questions
Date: Fri, 9 Apr 2010 14:49:52 -0400
Message-ID: <h2j76c5b8581004091149y9f5f93a8o5f11b3ffc657623@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 09 20:50:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0JHE-0004DX-6Y
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 20:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389Ab0DIStz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 14:49:55 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:62222 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab0DISty convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 14:49:54 -0400
Received: by bwz1 with SMTP id 1so2754913bwz.21
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=hYTGqRYlV8q8cNI0KBrRHgEavIr8WdmWYqZTTQ7weXQ=;
        b=teE5jJzUCLV46ncQdjaVoxJcnJP5hv1TNZ3RjCbtI2DvRt3btPsc6xQUPCYWZmF0GF
         KcnD839fLPpls4D8wZn/4JIeRlAOaNAcqoejl9wUAonBsf9QqEBF0EZwH6vNQz7gn+yE
         njKIQU0on/NznuOfkK0edWJawWPXSFxiRLZdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Rxc6BO27RWHQJAZRzjsqvGB1NAIXUsEZJMwXfJhKZpIrYWDQmu1J/XiKJ975i+rs1z
         f8DlqL2/VIQt7DQfgoFucU4rH4B0j5xFA6ewjLzGX0Dw1uzn3nKPCLvg8nguPGt9CeRj
         QcMLC5SUYQuXDI6gHgdWL4udFgLmfrRPRsQ6s=
Received: by 10.204.120.202 with HTTP; Fri, 9 Apr 2010 11:49:52 -0700 (PDT)
Received: by 10.204.161.211 with SMTP id s19mr487743bkx.129.1270838992842; 
	Fri, 09 Apr 2010 11:49:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144456>

Hi,

I have few questions about rebase and its help content:

1. In case of this situation

o---o---o---o---o =C2=A0master
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o---o---o---o---o =C2=A0next
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0o---o---o =C2=A0topic


=E2=80=9Cgit rebase master topic=E2=80=9D says:
The current branch topic is up-to-date.

This message seems to be confusing and even incorrect.
The actual problem, as I understand, is that topic branch is not a
direct descendant of the master branch, therefore
=E2=80=9Cgit rebase =E2=80=93onto master next topic=E2=80=9D should be =
used instead.
Is there a way for git to identify this problem more correctly and
print more helpful error message?

2. The rebase help is a bit confusing in its =E2=80=9C=E2=80=93onto=E2=80=
=9D option part.
Initially help says that the form:

git rebase master topic

is a shorthand for git checkout topic, git rebase master

But, in =E2=80=9Cgit rebase =E2=80=93onto master next topic=E2=80=9D th=
e meaning of the =E2=80=9Cnext
topic=E2=80=9D parameters is different: as I understand, it actually sp=
ecifies
a range of commits from next to topic, =C2=A0because =E2=80=93onto chan=
ges the way
the whole command is working, but it is not clarified in help. Is that
correct understanding?


3. The part of help from =E2=80=9CAnother example of --onto option is t=
o
rebase part of a branch.=E2=80=9D Is actually demonstrating absolutely =
the
same thing as the one before with the only difference that in the
second example the master has not advanced. There was probably some
different intention, but currently it looks like confusing
duplication.

Thanks,
Eugene
