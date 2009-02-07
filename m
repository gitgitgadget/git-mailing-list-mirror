From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Deleting the "current" branch in remote bare repositories
Date: Sun, 8 Feb 2009 00:05:05 +0200
Message-ID: <94a0d4530902071405m33a0804er8030e14bea205898@mail.gmail.com>
References: <20090207162754.5fb8b63f@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>, obrien654j@gmail.com
To: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Feb 07 23:08:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVvLZ-0004sN-AP
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 23:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbZBGWFK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 17:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbZBGWFJ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 17:05:09 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:1980 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbZBGWFI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Feb 2009 17:05:08 -0500
Received: by fg-out-1718.google.com with SMTP id 16so803895fgg.17
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 14:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=E6Lhk2DYcR1FRRTKMUHKgPxD6e9s4fPC7PZcBxL+rpQ=;
        b=BjfJFGy0c2hMeJ5nZWyh6ahDrPlJqL8GrB3DZCXihba/is1MgTRCHPWLK/jcC0hZfq
         DokLUZy8EG30d+cO38stzd83HmJkVy+2dkd8K34SVI76L0aV2tQS9WanhXLrmN9ZH06o
         yDlVC+LQ0QClFaR671N/iJSePhEVowy7Crli0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sjOmLzUMAwR2eW5xSk3iYVSFUX6WiUP76MKpN5htOwpXsd2+y/45buxCBGocvJLksV
         ycd0y0PC6MsadPq8iozgCMcLC8hwM4VAtKr7Rdrb42k41o8fl6N1B9ZcqnoFVw5IHFNa
         DohTnzQvHBqAs4wN5BfsBPFNgE5MY0jvB+ns0=
Received: by 10.86.99.9 with SMTP id w9mr1853938fgb.12.1234044305404; Sat, 07 
	Feb 2009 14:05:05 -0800 (PST)
In-Reply-To: <20090207162754.5fb8b63f@perceptron>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108895>

On Sat, Feb 7, 2009 at 5:27 PM, Jan Kr=C3=BCger <jk@jk.gs> wrote:
> Hi everyone,
>
> recently on IRC we had a case where someone had accidentally deleted
> the "current" branch (i.e. thing pointed to by HEAD) by using "git pu=
sh
> origin :master". This broke the remote HEAD as well as the local
> refs/remotes/origin/HEAD. Not good. I think we want to make it harder
> to get into this situation.
>
> Personally, without being aware of any potential counterindications, =
I
> think the best solution from a usability point of view would
> be to have receive-pack reject deletions of what's currently in HEAD.
> The question is, of course: how do we go about situations where someo=
ne
> actually wants to delete the branch HEAD points at?
>
> 1. reject deletion and point out a command to change HEAD first (I
> don't think we've got a command to do this remotely; do we want one?)
>
> 2. automatically change HEAD to something else if there's any other
> branch (eww)
>
> 3. accept the deletion but warn the user that she just broke the
> repository (especially eww because it also breaks the local tracking
> ref)
>
> Any smart ideas?

This was brought up before:
http://marc.info/?l=3Dgit&m=3D123254293910829&w=3D2

But I don't think it reached any conclusion.

--=20
=46elipe Contreras
