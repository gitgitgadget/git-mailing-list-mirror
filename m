From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Using format-patch and apply against files with CRLF line endings
Date: Wed, 20 Apr 2011 11:59:45 -0400
Message-ID: <BANLkTi=xNrtbwcDCHriGZ6VpxHhTfVNptA@mail.gmail.com>
References: <m2tydt5ekt.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 18:00:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCZpH-00088J-Hs
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 18:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609Ab1DTQAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 12:00:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52284 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449Ab1DTQAP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 12:00:15 -0400
Received: by iwn34 with SMTP id 34so703129iwn.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 09:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=1cs+qtge+SqYJuSzkNgi3hwoXfIWhTS57SHJUmx2fgk=;
        b=rF1Bf3K0TEhedCshtUCOpDErXO/R7u4viHNGJ5V4zZdWinN5nu+AwIag/kluRIlqRh
         fzGZP5SEMcP8rLIsRC9mgoYS5FW+G0peni8lq/8iE3PBJBFul+bwmNuchQNlKQkRjKQz
         W2RMlBg7QdTyQCmE20qt4UHK5i7anYqk70nvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=olAfz3uF3j9jv8STM0ZwlTAQeI6FIGV0B/rGpc/6llaSRhk57qefr7TxRQczOg7cBt
         uauizDY5WCjgRzlVvs5FqTVCc1+uz1kge65JnLv3AKusKbzAaq4Ln/bOLSdUt4PZP4I1
         uuEFqvlHtvAtTeqYb1c78MFLy/SyweaZD/Yq4=
Received: by 10.42.149.70 with SMTP id u6mr609544icv.416.1303315215113; Wed,
 20 Apr 2011 09:00:15 -0700 (PDT)
Received: by 10.42.196.70 with HTTP; Wed, 20 Apr 2011 08:59:45 -0700 (PDT)
In-Reply-To: <m2tydt5ekt.fsf@Spindle.sehlabs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171869>

On Wed, Apr 20, 2011 at 7:48 AM, Steven E. Harris <seh@panix.com> wrote:
> Is it the case that format-patch will always emit text with LF line
> endings, or is it respecting whatever the host platform considers to be
> the proper line ending? Is the line ending in use configurable?
>
> I ask because I see that git-p4 uses format-patch and apply internally
> to apply changes against files in the Perforce workspace, and those
> files have CRLF line endings, but it looks like format-patch is emitting
> patches with LF line endings, and none of those patches will apply
> cleanly.
>
> Perhaps I just need to pipe the output from format-patch through
> unix2dos before feeding it to apply, but I'm wondering whether I'm
> barking up the wrong tree here.

The patch emitted by format-patch should have the correct (original)
line-endings, but to preserve them when the patch is applied, git-am
needs to be called with --keep-cr (also see config option
'am.keepcr').

j.
