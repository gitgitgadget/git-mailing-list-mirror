From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCH] Add a post-tag hook
Date: Fri, 24 Apr 2009 10:41:47 -0600
Message-ID: <1cd1989b0904240941o3d80bdbby19fb02093c887af@mail.gmail.com>
References: <cd3664ac0904171515u1e2fce41ubd34f60ec43fcafd@mail.gmail.com>
	 <20090417221944.GS23604@spearce.org>
	 <cd3664ac0904171528p3ed55071p4e098f5181fb0b27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Ammon Riley <ammon.riley@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 18:44:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxOUo-0002CJ-Or
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 18:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757274AbZDXQlu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 12:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758755AbZDXQlt
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 12:41:49 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:62860 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758013AbZDXQls convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 12:41:48 -0400
Received: by qw-out-2122.google.com with SMTP id 5so994730qwd.37
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vp/j/Wgt3y4zttrJklFhENPdBlNS+j5DtZvihWt0b1k=;
        b=KH0EMsEsvo1z3Ufj92DAbJbjWkeSOsyRL75EThxS6NpL5s3mrRIFpVSQA6eHhBw4JO
         FObVE68Xt+4yugyaa5rgNSLg6Rr4f2AoIdWuHSfjVxFzZj+NhVelUHyj7zYetuKSkCXO
         ZJzUp9clNYMStu4uU76yNwuqhR3ocF2d9gLYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qv9hSpX2HcisG1ttumtp/blR7aY4fNGss+B6pdTpJ6m8+GHeCi7S8eE8lKDYla3joG
         /XB7hy0ZmIJ9EiCApJ16sdIy/Exp10gEKLjjHdXqWkDV7hPQ0+6D6OYPfK1/PE0JwLvY
         OCD33/1zFuYgRJUQ96gM8K3cm0lZY0XRrqGNw=
Received: by 10.229.110.21 with SMTP id l21mr1556478qcp.26.1240591307200; Fri, 
	24 Apr 2009 09:41:47 -0700 (PDT)
In-Reply-To: <cd3664ac0904171528p3ed55071p4e098f5181fb0b27@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117470>

On Fri, Apr 17, 2009 at 4:28 PM, Ammon Riley <ammon.riley@gmail.com> wr=
ote:
>
> On Fri, Apr 17, 2009 at 3:19 PM, Shawn O. Pearce <spearce@spearce.org=
> wrote:
> > Ammon Riley <ammon.riley@gmail.com> wrote:
> >> Add a post-tag hook, to allow notifications when a tag is created.
> >> The hook is given the name of the newly created tag.
> >
> > Why would you want to send notifications upon creating a tag in
> > your local repository?
> >
> > Usually a tag is only interesting when it has been sent to a shared
> > public repository, which is by git push, and thus is caught by a
> > git receive-pack hook like post-update or post-receive.
>
> On the particular project I'm working on, we're not really using git
> in the most distributed fashion -- it's completely internal to the
> company. In our case, the tags are being created directly on
> the shared repository, rather than on a local repository and being
> pushed.

Today, this same situation came up in my organization.  It seem like a
natural partner of the post-commit hook.

>
> Cheers,
> Ammon
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
