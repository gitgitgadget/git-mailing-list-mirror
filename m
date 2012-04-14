From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: Merging changes from branches where file paths have changed
Date: Sat, 14 Apr 2012 20:36:13 +0100
Message-ID: <CA+39Oz5Jc8Tj6WX+836h_fA6qHDYp6guaoniF6LX027MFHhP0A@mail.gmail.com>
References: <CA+39Oz7m1hGrTEdpSAjBP3EDFSVyKdc6T9CORcwQkjuEbvD4Ug@mail.gmail.com>
 <4F89CE36.4000607@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 21:36:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ8lw-0004Ne-9A
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 21:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322Ab2DNTgb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 15:36:31 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52457 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab2DNTga convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 15:36:30 -0400
Received: by obbta14 with SMTP id ta14so1976442obb.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NGg4V7t36XHGN6GIr3jOY6t7ipqfiTzLCMIOQ+/xiVk=;
        b=khP9/gJW4TxJsTo/6k7b1awugjXmgtGQOo/w1nLpN5AfDaatZqRbMRDco8OkNBR/Py
         Vj7FMcBQaXlcmO4flMpsgWbBYOjmYc0RhCYCriPhlOfhuLBNRokR2b9I14Ifu+2Bd9Uu
         H98WDNJHB9kUg3zRSkn/WORUG/HdM+LIfrT4M+Mu/SFAL0q0Kq5/kc4KJqZkgXqoiAAR
         YXWUcSGGSYGzk6DyaL8EAScAEaP4o1oawCIBrrsgQCEueHJibEdx+lLY9y+9NNppNHQG
         Yu3RUCG/ZLVuCbTf7HvmQDLwMZOe5aa4/6EFD3lf90+QIZOYse+VUoVy/gYehtZrmcDX
         muGg==
Received: by 10.182.139.42 with SMTP id qv10mr8263428obb.71.1334432189731;
 Sat, 14 Apr 2012 12:36:29 -0700 (PDT)
Received: by 10.182.33.41 with HTTP; Sat, 14 Apr 2012 12:36:13 -0700 (PDT)
In-Reply-To: <4F89CE36.4000607@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195509>

Hello,

On 14 April 2012 20:21, Johannes Sixt <j6t@kdbg.org> wrote:
> You have these histories
>
>
> =C2=A0A--o--B--C--o--o--D--o--E =C2=A0 <- RepoA
>
> =C2=A0A'----B'-C' =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <- RepoB
>
> and you want to cherry-pick D and E to RepoB. Right?

Yes, that's about right.

> I suggest that you install a graft in RepoB, then cherry-pick D and E=
:
>
> =C2=A0echo $(git rev-parse C' C) >> .git/info/grafts

Can you elaborate on this a little more please?  Or point me towards
some documentation.  Note that due to the way git-filter-branch works,
although the history between RepoA and RepoB are common, the commit
IDs between the two are completely different; presumably
git-filter-branch uses patch-id at some level to reform commits.
Nevertheless, if I'm understanding superficially what this graft is
supposed to do, I do not see how getting a list of commits from C' to
C is going to help in repoB when neither RepoA or RepoB have any
ancestry in common?

Kindly,

-- Thomas Adam
