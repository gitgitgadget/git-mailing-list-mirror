From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: gmail screws up patches looking for workable workaround
Date: Fri, 13 Feb 2009 09:26:21 -0800
Message-ID: <8c9a060902130926j48b59785l624a3966254517e5@mail.gmail.com>
References: <81bfc67a0902130909i154a7c2epeff98347985c3fb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dan Robbins <drobbins@funtoo.org>
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 18:28:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY1pS-0001E9-Qy
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 18:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbZBMR0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 12:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbZBMR0Y
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 12:26:24 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:39810 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbZBMR0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 12:26:23 -0500
Received: by qyk4 with SMTP id 4so1758290qyk.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 09:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eYfwHa0lZCDFbRFu4uAH8h+k+8tVn8/ozc8qB3GRKp0=;
        b=dfS+wDgLQUk2DMo0IHwq4Z3V/OYOGmvSNYFOyGXt8KxZ85TJAeG+7aGRT1GBSWCmk3
         xdDVYEbd1NbrVgbIQ2tV8V1H+naYaSwEdtGyqioioY7f10cFGPVU3+Y+Y54LS7LfzMEm
         kFcLBtezfm6A7SVJ9GdJitXf5svMrRwLxynbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HB2QWX6fxdlcUBkKis2oDZms/sEQqu/zB4VWF0ewIcozBx5CcSDuDLrNWAWpAToD8j
         rwZsFFHWjZRl4wXLnoDOGTivG5+fJWKzfUQNHuSIN6Yv4YCnS4HMEjLM8NZ0koKQDAIz
         ub+xs635lS8gn3xZ439cdQXSlnHaloRTC5IF8=
Received: by 10.224.89.75 with SMTP id d11mr2310708qam.383.1234545981560; Fri, 
	13 Feb 2009 09:26:21 -0800 (PST)
In-Reply-To: <81bfc67a0902130909i154a7c2epeff98347985c3fb8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109762>

On Fri, Feb 13, 2009 at 09:09, Caleb Cushing <xenoterracide@gmail.com> wrote:
> I've followed all the steps in the git Submitting patches guide. In
> fact it works fine for any patch where all lines are less than 80?
> chars. however, some of the patches store sha256 hashes (and the like)
> and have really long lines and gmail word wraps them.
>
> I've tried submitting patches as follows.
>
> git format-patch -1 -M --stdout | git imap-send
>
> git format-patch -1 -M --stdout --attach | git imap-send
>
> git format-patch -1 -M --stdout --inline | git imap-send
>
>
> we know the first corrupts the patches. but what I can't figure out is
> why the next 2 don't work on the receiving end. The comment was.
>
>
> git am -3 -i, when I choose [v]iew patch, I get a binary output.
>
>
> I'm trying to figure out how I can submit patches via gmail for
> someone that uses git am. what is being done wrong?
>
> --
> Caleb Cushing
>
> http://xenoterracide.blogspot.com
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

This is the setup I use for emailing patches using git:

~/.gitconfig
[sendemail]
    smtpserver = smtp.gmail.com
    smtpserverport = 587
    smtpuser = your.email@gmail.com
    smtppass = yourPassword
    smtpencryption = tls

$ git format-patch <options>
# add comments to 00*.patch files.
$ git send-email 00*

I've never seen any mangling using send-email, and the gmail SMTP
server.  I've never actually tried using imap-send.  Not quite the
answer to your question, but hopefully, it's another option.
