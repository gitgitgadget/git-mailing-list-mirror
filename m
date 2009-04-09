From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [PATCH] git-add: introduce --edit (to edit the diff vs. the 
	index)
Date: Thu, 9 Apr 2009 10:00:25 +0800
Message-ID: <46dff0320904081900n7bff2280rc49315e3db427919@mail.gmail.com>
References: <cover.1239225986u.git.johannes.schindelin@gmx.de>
	 <61c07126e28aba0a36730da06112bd2d16eabc1b.1239225986u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 09 04:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrjad-00063i-GC
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 04:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756636AbZDICA2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 22:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756615AbZDICA2
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 22:00:28 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:11224 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756421AbZDICA1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 22:00:27 -0400
Received: by wa-out-1112.google.com with SMTP id j5so211234wah.21
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 19:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=49nCngW249AlqKecmcGBBm7vz/9zonWGSAYHjHlLwsI=;
        b=PbbRu4Y7wJMKWn3axB0WJ9PRoq3ioeNJWXM7IxwnVZ6bomE89zjUNEqT6zHX+Rjtx/
         7jLYUSTxVvGlyYN0cqp2iSLbrQWpZ0ZHpEJOL2Ai/vta/Z+rXLqRn4lYDDwEeJ5e1zBd
         966Qnr6VTf+3aBjclmnHSBvFPlUn4MWqe4vCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=owlLJKUjZ2iZFIHOrG0V/ZYkn5GfLIgb9Cp9vn62GOIB5I1JWtNziuGNWcE7ZD8yGz
         SmYrCP1qHWZasLEyY5IIXGeTrUsYDtZHPEv3Vs26jPO6cPzrBAQKlLPTCStsckLNX1hs
         uuhC/jt4AeY5Mhf89puaqeQmD36FEWHP4CGhY=
Received: by 10.114.39.16 with SMTP id m16mr1099898wam.147.1239242425878; Wed, 
	08 Apr 2009 19:00:25 -0700 (PDT)
In-Reply-To: <61c07126e28aba0a36730da06112bd2d16eabc1b.1239225986u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116136>

On Thu, Apr 9, 2009 at 5:30 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> With "git add -e [<files>]", Git will fire up an editor with the curr=
ent
> diff relative to the index (i.e. what you would get with "git diff
> [<files>]").
>
> Now you can edit the patch as much as you like, including adding/remo=
ving
> lines, editing the text, whatever. =C2=A0Make sure, though, that the =
first
> character of the hunk lines is still a space, a plus or a minus.
>
> After you closed the editor, Git will adjust the line counts of the h=
unks
> if necessary, thanks to the --recount option of apply, and commit the
> patch. =C2=A0Except if you deleted everything, in which case nothing =
happens
> (for obvious reasons).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0I actually promised myself not to resend t=
his patch, but a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0certain guy who has a hat now asked for it=
=2E
>

I am that guy :-). Thanks. Sometimes "add -e" is more useful than "add
-p" since i can see the full context when editing the patch. However,
sometimes the ability to edit the index directly is even more useful.
=46or example, if it's a big change (or rewritten), it is hard to edit
the patch instead of the index (in diff mode with the worktree file
side by side). I even encounter a case that i can't beat the patch
into a shape i want when using 'add -p'  ( it will fail to apply)
