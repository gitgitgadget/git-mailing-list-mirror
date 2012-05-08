From: Orgad and Raizel Shaneh <orgads@gmail.com>
Subject: git-diff-tree does not use alternate objects for submodules
Date: Tue, 8 May 2012 16:42:08 +0300
Message-ID: <CAGHpTBLfbMU1WevW6XnY_N2BnfwPZ0_6jJDf45rCkVjWGwA9xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 15:42:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRkgC-00033L-V0
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 15:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab2EHNmK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 09:42:10 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35231 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab2EHNmJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 09:42:09 -0400
Received: by bkcji2 with SMTP id ji2so4620209bkc.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 06:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Kj8S7l0D4RJ6jz3fZJENvOcAVvFULwBMnBTW4nIS4AA=;
        b=zMJeZefZZGAbm+zUtXwDZtS6VkJK1tKWUU//oA+HqeN3ptbuGa/tFV5vBIEPSHkqFq
         WM2PbfuYxbJtFQ/KtPYEq/I0r1NFVZof+Efs1FWx5D52TMzw61fZcyfedu3z6M1UkqTa
         mnQLo8uJsH04ESuA0sHdfzNIQFDY39yJ/B1T6KZyMmGI+Sh1GSj1AVSv0z+Cumz/Atg/
         r8HdDwyWgqYb/8aCbYTWk0u8/827RoDX9jG+OTMD8ODjEyEbJWLj73c9cx4XMvaKbJIF
         54sqxj9jTmZqRNk2L/bv/aPDygwIfl4sgERz9CGN8II1VKr3OK8zvh8rYHQwn/7P0VXm
         C42w==
Received: by 10.204.130.194 with SMTP id u2mr6283339bks.2.1336484528093; Tue,
 08 May 2012 06:42:08 -0700 (PDT)
Received: by 10.205.82.9 with HTTP; Tue, 8 May 2012 06:42:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197364>

I have a project with a submodule. Both have objects/info/alternate
(different ones).

After running 'git gc', running gitk on the superproject results in:
=A0 Submodule sub 227e2b5...d8597e2 (commits not present)

This is the git-diff-tree command that gitk runs:
=A0=A0git diff-tree -r -p --textconv --submodule -C --cc --no-commit-id
-U6 --root d117679ef4a4fb4143401d3a4bc4a484c9bf76ff

I'm using msysGit 1.7.10

- Orgad
