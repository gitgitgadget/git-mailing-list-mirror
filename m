From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] gitweb: Provide title attributes for abbreviated author names.
Date: Sun, 21 Oct 2007 14:29:16 +1000
Message-ID: <ee77f5c20710202129t7f60aebbib24d91ba360f64a2@mail.gmail.com>
References: <1192581277533-git-send-email-dsymonds@gmail.com>
	 <20071021032533.GA30717@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: pasky@suse.cz, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 06:29:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjSRV-0001vd-H3
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 06:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbXJUE3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 00:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbXJUE3R
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 00:29:17 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:15666 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbXJUE3R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 00:29:17 -0400
Received: by rv-out-0910.google.com with SMTP id k20so853819rvb
        for <git@vger.kernel.org>; Sat, 20 Oct 2007 21:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KY/KxpbSFg7VKiPqqlD7PdjLl3MQ4jGfVLdaLGKlDAY=;
        b=YU+L41qUZttGEV0TMiRDDJvcz5H0Ts1ordZ07710NgOCcHGFk/FJn3eL9WXl23KGuT+yR2AZYic/djBRQbluOKpthFUfhCFR6R/m3uOIaiKxce50ZMcy0GotrioF/5jOvBTJ73PSMCNwka67fMWSeR6N8EInsCCQgW5ovkQeyzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ghf003xaKZcDlB9INrkbQHvNvWqi9VD47eBJ3wpH/BDtRsA3VVD6AdoXpf0+Hh/ydg2UCLqWTLVRSDKY8WK4rxonDtRYgQJwDmON6AWrvmc+0rO0LKV/yc+IMUOGpAge+EJ1s8RKnMgIJlCDVd6tuEbSqaqKtbWhUU1TsD2qHoE=
Received: by 10.140.207.2 with SMTP id e2mr1728442rvg.1192940956442;
        Sat, 20 Oct 2007 21:29:16 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Sat, 20 Oct 2007 21:29:16 -0700 (PDT)
In-Reply-To: <20071021032533.GA30717@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61876>

On 21/10/2007, Shawn O. Pearce <spearce@spearce.org> wrote:
> Nice, but...
>
> David Symonds <dsymonds@gmail.com> wrote:
> > +++ b/gitweb/gitweb.perl
> > @@ -3461,9 +3461,15 @@ sub git_shortlog_body {
> >                       print "<tr class=\"light\">\n";
> >               }
> >               $alternate ^= 1;
> > +             my $author = chop_str($co{'author_name'}, 10);
> > +             if ($author ne $co{'author_name'}) {
> > +                     $author = "<span title=\"$co{'author_name'}\">" . esc_html($author) . "</span>";
>
> Doesn't this produce invalid HTML if $co{'author_name'} has a special
> HTML character in it such as & or "?  Note that " is much more likely
> as it is often used for nicknames.  The old code properly escaped
> the author name, and indeed you are doing it for the abbreviated
> version but not the full version.

Sure, I'll fix it up and resend. I might even refactor some code at
the same time.


Dave.
