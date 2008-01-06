From: "James Bowes" <jbowes@dangerouslyinc.com>
Subject: Re: [PATCH] Make the git metapackage require the same version of the subpackages.
Date: Sun, 6 Jan 2008 16:13:26 -0500
Message-ID: <3f80363f0801061313o514fa01bje354503483db47ab@mail.gmail.com>
References: <20080106173501.GB9349@spitfire>
	 <7vprwe4s8e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 22:14:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBcoi-0000YL-0c
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 22:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbYAFVNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 16:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbYAFVNa
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 16:13:30 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:32573 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbYAFVNa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 16:13:30 -0500
Received: by py-out-1112.google.com with SMTP id u52so12209451pyb.10
        for <git@vger.kernel.org>; Sun, 06 Jan 2008 13:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=VTujILDCKqD9rltvrebQjGN4reWdKYc9MyT2HAqkV+Q=;
        b=c7fdSQ60W4K1DWkSdI/KK9aHs3+NacaUZa4Z6PmMfaHbW6yBIMvoD0d09Zh2uWoocj4s0l2pX7jlb7ERCNt6L+D2JbKc1rubH031hJI0lYBTd3+LMIva5P5GI1h60H+Xe+BBOMa+wF6MqjZzL3IwiJAdD6NTXdd+u1vGcKWXvfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=r86FFJdWLPfMvj1mtarPWvhe4esCcVpD1Jpd1OJwzCbEy2DgU++fN+jiDbooCkVufpEf4Z/LTaqCWs/MgMDOm6+WZhX/cPnqxHQuwnPfcR6BgF8SWpj7/p94D/eDAGbQFJ2ltdI3xlHQAmuKOHq6lqupv8NKtFAIN1YMOn7cWzc=
Received: by 10.65.115.4 with SMTP id s4mr17361901qbm.47.1199654006833;
        Sun, 06 Jan 2008 13:13:26 -0800 (PST)
Received: by 10.64.149.10 with HTTP; Sun, 6 Jan 2008 13:13:26 -0800 (PST)
In-Reply-To: <7vprwe4s8e.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 8ec8f169c5ae18de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69745>

On Jan 6, 2008 3:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> James Bowes <jbowes@dangerouslyinc.com> writes:
>
> > Without explicit version deps in the rpm spec file, 'yum update git'
> > effectively does nothing. Require explicit versions of the subpackages, so that
> > they get pulled in on an update.
> >
> > Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
>
> I am asking as an RPM illiterate, not questioning the validity
> of what your patch does.
>
> The approach your patch takes feels like the right way we should
> have taken from the beginning.  Does this supersede the "fix" in
> 5587cac28be66acf5edc2a4b83b67c8cfffbc5e9 (GIT 1.5.3.1: obsolete
> git-p4 in RPM spec file)?  IOW, if we had Requires for the same
> version from the beginning, we wouldn't have had the problem
> when we dropped git-p4 package?

I believe the obsolete is still needed, as you'd need a way to tell
rpm to just get rid of git-p4 entirely.

-James
