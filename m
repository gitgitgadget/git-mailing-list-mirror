From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: git-svn and comitter names
Date: Tue, 2 Aug 2011 16:59:36 +0200
Message-ID: <CAEcj5uWO+ydhQFScCirfQeXnOFPget6O7n6PHygCUm8ytwLFsA@mail.gmail.com>
References: <6517-1311952613-96947@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 16:59:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoGRa-00049z-Lq
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 16:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775Ab1HBO7i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 10:59:38 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42603 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab1HBO7h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2011 10:59:37 -0400
Received: by iyb12 with SMTP id 12so8143568iyb.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=En2ZiiXdtVX1KrTJV99Bpd5SyeeC3NyO0vbKoTZQ3FQ=;
        b=BoGvlh7GmBVoIvtX4aejpLukti7kPFCJysWk42HlvQevSEVWHvCUggQIjCSMmAGKg8
         oLx32eCcrDphkt0k9zE7YOqFzz64ir4gfmf9OY4+mkaTUaFia2g14Ob8Ky7EDHPEua6n
         KbB9uDUep297VAQ+3h9n4eBLHU8pWLss5LVeY=
Received: by 10.231.111.39 with SMTP id q39mr3814283ibp.106.1312297176624;
 Tue, 02 Aug 2011 07:59:36 -0700 (PDT)
Received: by 10.231.160.68 with HTTP; Tue, 2 Aug 2011 07:59:36 -0700 (PDT)
In-Reply-To: <6517-1311952613-96947@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178472>

On Fri, Jul 29, 2011 at 5:16 PM, John M. Dlugosz
<ngnr63q02@sneakemail.com> wrote:
> I just grabbed a repository using git-svn, and the commiter name show=
s a
> GUID for the domain name. =A0For example,
>
> =A0 =A0first.last <first.last@5ab5abacd-6ff9-f940-aeea-106a2a325327>
>
> I set my git name and email address to show what I want in the end, t=
he real
> company email address. =A0Will this apparent mapping be a problem whe=
n I
> dcommit?

Hi John,

No, it won't be a problem. This is the default "mapping" in git-svn.

The committer name is only visible in your git-svn clone. When you
dcommit, it will use your normal SVN username, the same one which is
used when you use SVN normally.

Your configured git name and email will be used in your local commits,
but as soon as you dcommit, those commits are rewritten to use this
username@uuid style.

If you think this is really annoying, or you are planning to make a
permanent migration away from SVN, you can use an authors-file when
doing the initial git-svn clone. See
http://www.kernel.org/pub/software/scm/git/docs/git-svn.html for more
info on the --authors-file option.
