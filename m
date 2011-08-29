From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's the difference between `git show branch:file | diff -u -
 file` vs `git diff branch file`?
Date: Mon, 29 Aug 2011 14:41:45 +0700
Message-ID: <CACsJy8DMqjMfb5wVMnsrZhP8yv2rF1wyQ6LM6b-PVcYY1SXkcQ@mail.gmail.com>
References: <loom.20110823T091132-107@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 09:42:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxwUD-0006vQ-8d
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 09:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955Ab1H2HmV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Aug 2011 03:42:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33039 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab1H2HmT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 03:42:19 -0400
Received: by bke11 with SMTP id 11so3942867bke.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mwMfe5TS41yMRv8nxkme/gKJcv7qHBUOJbAnaQZvP1o=;
        b=lpy6lg0zvb/j9ceThL3y+1pGwZnBbWvGL8q/1esByuR2ZuX1cF35Gtq7F5AEFyMynT
         bqEH6PQQwOUCh4P+PP+PBqMg411trBLFkSX54Pr+SmXh2r68Bf01CSNbUryZlHZbhQiL
         W5lK9uJBCBkSO6dbHBA3aQ28yu4c9hFnszhh4=
Received: by 10.204.13.69 with SMTP id b5mr1799238bka.289.1314603736239; Mon,
 29 Aug 2011 00:42:16 -0700 (PDT)
Received: by 10.204.7.138 with HTTP; Mon, 29 Aug 2011 00:41:45 -0700 (PDT)
In-Reply-To: <loom.20110823T091132-107@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180305>

On Tue, Aug 23, 2011 at 2:25 PM, Marat Radchenko <marat@slonopotamus.or=
g> wrote:
> $ time git show branch:file | diff -u - file > /dev/null
>
> real =C2=A0 =C2=A00m0.003s
> user =C2=A0 =C2=A00m0.000s
> sys =C2=A0 =C2=A0 0m0.000s
>
> $ time git diff branch -- file > /dev/null
>
> real =C2=A0 =C2=A00m31.442s
> user =C2=A0 =C2=A00m31.040s
> sys =C2=A0 =C2=A0 0m0.380s
>
> What does git diff do so it takes that much time?

You said elsewhere in this thread this is private repo, so some more qu=
estions:

 - is "file" above at top repo, or is it actually very/deep/path/to/a/f=
ile?
 - how many entries in the tree that contain "file"?
 - how is "git ls-files | wc -l"?
 - how about "time git diff branch another-branch -- file >/dev/null"?
That'd remove unpack-trees code.
--=20
Duy
