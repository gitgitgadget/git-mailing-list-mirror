From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Add support for limiting number of lines generated in 
	messages by post-receive-email
Date: Mon, 12 Jul 2010 17:10:06 +0000
Message-ID: <AANLkTilVNhDl5OurCPpB68buvQZPAulkuEye0FUTyThP@mail.gmail.com>
References: <1278615790-5433-1-git-send-email-kpfleming@digium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Kevin P. Fleming" <kpfleming@digium.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 19:10:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYMWF-0007WL-Ag
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 19:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086Ab0GLRKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 13:10:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50631 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab0GLRKH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 13:10:07 -0400
Received: by iwn7 with SMTP id 7so4838987iwn.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 10:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=tOZ97gHF5ewT++3C9ZxsTk+Tpq9zeC6lvz0lPGChpUc=;
        b=eqd0cluCOstrSu32IZoHN/p2H6Q8msnFVqRr9HgIMIIFhlPD8RLJB+KwL3OrycSc5s
         y3zthRXPvqe//6z7UOEfY+5y9/ffsmLoHGmgiT3e/4LH5WamUv2bDKiCh4KoaPjiYH5o
         yqJW+OwW9v1kHuS6ttrRXkNAMdeP3+WYxanl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TgmQDLJ5MJ+grw7uruagmcBxu9MIHSIUtIMum28pnUb/Q6yURN5gsbQeeTs9MhOVmj
         ENc248r4mJI6hWXayAPud2gYDp+oonDTVIlW5iAckGRfoUj/HPxP39262JnVAkFEJOGa
         /W3wZkmy2n4BnR6JHBtq14+LfITmbqcMRZkfU=
Received: by 10.231.171.3 with SMTP id f3mr9874082ibz.145.1278954606709; Mon, 
	12 Jul 2010 10:10:06 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 12 Jul 2010 10:10:06 -0700 (PDT)
In-Reply-To: <1278615790-5433-1-git-send-email-kpfleming@digium.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150831>

Just a nit on the format, which might help to get this accepted.

This patch has a 84 char subject line, the recommended maximum is 50
(used for --oneline). See Documents/SubmittingPatches.

On Thu, Jul 8, 2010 at 19:03, Kevin P. Fleming <kpfleming@digium.com> wrote:
> We have become used to the features of svnmailer when used with Subversion,
> and one of those useful features is that it can limit the maximum length
> (in lines) of a commit email message. This is terribly useful since once the
> goes beyond a reasonable number of lines, nobody is going to read the remainder,
> and if they really want the entire contents of the commits, they can use
> git itself to get them using the revision IDs present in the message already.
>
> This patch adds a new parameter to the post-receive-email hook script called
> 'maxlines', that defaults to 2048 if not specified. The entire message is
> filtered through a function that counts the number of lines generated
> (including headers), and any lines beyond the limit are suppressed; if any
> lines are suppressed, a final line is added indicating the number that
> were suppressed.

Maybe change the "We have", "This patch" etc. to use the "Changed"
wording recommended by Documents/SubmittingPatches?
