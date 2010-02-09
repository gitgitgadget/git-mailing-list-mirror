From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git add -u nonexistent-file
Date: Tue, 9 Feb 2010 17:17:54 -0500
Message-ID: <a038bef51002091417o1048c098x898517596115ed90@mail.gmail.com>
References: <20100208182929.GB14355@neumann>
	 <a038bef51002081112s2d552835m4b34973f797ab4f8@mail.gmail.com>
	 <20100209003958.GA4065@coredump.intra.peff.net>
	 <7v7hqm2hs7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 23:18:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeyPA-00086Q-S9
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 23:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab0BIWRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 17:17:55 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:48312 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab0BIWRz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 17:17:55 -0500
Received: by pzk17 with SMTP id 17so419575pzk.4
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 14:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=zvofLDJ9OueTjuy2G1wP3p4w1PrM2BOluFrYY9cUMM4=;
        b=cjI8t4A/9o60x/WntakvdZxy8zR+xf8DfJq811b8dJTs2fz619QD1dxXLGc4b0EdyG
         qROH9H/i2ULEODffl57WzLjPIaKFI5lrAmnsOuHIWkICP5oJteqs1SUiv8SqHgaNusg4
         P6UX8FzPDEGZx9eJ9M4so1708GTRfGjdhakmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Ak3Q8XersiyNzDJMoiNHzZkhYYmShrta9zFisb+LiCjI6fYJcwHNmR0VZhrlwXPru7
         x/E4jrL2G37DcMNTV282AnEWn80blxaXez0/8QDYYa7OobccYSKnsvhC9KXmhkxFaYq1
         jCju4oiN4yGrsP32zLOvOau1hDXMzVPWFKfi8=
Received: by 10.114.237.24 with SMTP id k24mr5860080wah.24.1265753874293; Tue, 
	09 Feb 2010 14:17:54 -0800 (PST)
In-Reply-To: <7v7hqm2hs7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139448>

On Tue, Feb 9, 2010 at 4:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> It won't be entirely trivial to do so efficiently but it shouldn't be a
> rocket surgery.
>
> Something like this (untested of course)?
>

Passes my new test and all the rest in t2200-add-update.sh and t3700-add.sh.

Hows this for a commit message:

  git add -u: give an error if pathspec unmatched

  If a pathspec is supplied to 'git add -u' and no matching path is
  matched, fail with an approriate error message and exit code.
