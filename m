From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 1/2] War on whitespace: first, a bit of retreat.
Date: Fri, 2 Nov 2007 22:50:36 +1100
Message-ID: <ee77f5c20711020450hdfe064fsace9349fe6494ec9@mail.gmail.com>
References: <7vwst15ceq.fsf@gitster.siamese.dyndns.org>
	 <ee77f5c20711020314h43290dbs8141cb3905c867@mail.gmail.com>
	 <472AFFE4.9060004@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Brian Downing" <bdowning@lavos.net>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 02 12:51:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inv33-0007Gh-R3
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 12:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbXKBLui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 07:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762AbXKBLui
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 07:50:38 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:23421 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbXKBLuh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 07:50:37 -0400
Received: by rv-out-0910.google.com with SMTP id k20so782027rvb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 04:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qGfkTXDb11TpuGJDtxsiPitAUC5LRMzI5qqdlT7hwfU=;
        b=nR86SlHQmMbAtJdN7Aw9knD2iDDafDbXfDYw9v7OuhgIHr3O5SB8k+lzH+LX6UL6D30Gx5+jLTAp04CbxUcjV5UTICq0VQw0d6NtM53W+MIxMitcxwpJy3sOS0GqQWeFsN5Ae/d/UF8OEf52re09KtDj6lAaz3UWi0Y+oSjzs/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mAm9zxMmg1WIWf2fI3ZCtANWaToGNSGm9VLxv7cJq6mdFKunH19yGwVVVJUwusUnrnVbZM1NzJ1B1VZCI/hDQ7fyRw8b1XH2rXA5YSdQROmefo7n38b/FMaiSbhntgccPFqc/Y3XS14ZGjCJEyka1FqjUlynyFuafsRYF2czHgY=
Received: by 10.141.20.7 with SMTP id x7mr825809rvi.1194004236732;
        Fri, 02 Nov 2007 04:50:36 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Fri, 2 Nov 2007 04:50:36 -0700 (PDT)
In-Reply-To: <472AFFE4.9060004@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63107>

On 11/2/07, Andreas Ericsson <ae@op5.se> wrote:
> David Symonds wrote:
> > On 11/2/07, Junio C Hamano <gitster@pobox.com> wrote:
> >> This introduces core.whitespace configuration variable that lets
> >> you specify the definition of "whitespace error".
> >>
> >> Currently there are two kinds of whitespace errors defined:
> >>
> >>  * trailing-space: trailing whitespaces at the end of the line.
> >>
> >>  * space-before-tab: a SP appears immediately before HT in the
> >>    indent part of the line.
> >
> >>         [core]
> >>                 whitespace = -trailing-space
> >
> > Could I suggest naming the option 'whitespaceError', so it's clearer
> > that it's a negative setting?
> >
>
> Which would also open the window for "WhitespaceWarning" and "WhitespaceAutofix"
> later on, using the same semantics.

Maybe cut straight to the chase:

[core]
        whitespace.trailing = error
        whitespace.space-before-tab = error
        whitespace.8-spaces = warn

There'd be at least "error", "warn"; "okay" and "autofix" would be
other sensible values. I'm willing to help code this up if this sounds
good.


Dave.
