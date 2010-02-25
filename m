From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] builtin-notes: Minor (mostly parse_options-related) fixes
Date: Wed, 24 Feb 2010 19:07:26 -0800
Message-ID: <4B85E96E.1080808@gmail.com>
References: <1266096518-2104-1-git-send-email-johan@herland.net> <4B792347.8070208@gmail.com> <201002160247.49719.johan@herland.net> <201002250148.11487.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 04:07:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkU4d-0008DK-U1
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 04:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086Ab0BYDHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 22:07:31 -0500
Received: from mail-yx0-f182.google.com ([209.85.210.182]:49905 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab0BYDHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 22:07:30 -0500
Received: by yxe12 with SMTP id 12so881922yxe.33
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 19:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Uc/lZ9qSddg2C1gU0r79X3rWKLOuu1r2xvThRl89Ro8=;
        b=HEsEn+Dbke0rJIddnlfYF19vFWPt56hFURSPJBmH2qz5RVXv+AwIXEDpu0uhzHNJYs
         wAXW8TIUHMFDKR9ZOsEzxwpA/hyss3rSIEVkdvtQ1aJ4CfuhxKxUS/gxRATdTC/fD8xi
         mFISI6PTvRby4MNk6C6gR0eJBCKolB7NPD0Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KGiCtkGwLvHjNcOummhFf7kZq3IRSAEmhlqjzxu0QUiDXwuA2rwAd58l2NPdPf8ZDy
         cl3ELmdJ5u/nmh/VcRzx55hJFgaBrN5WRbG0DCQkY0D8CFgpFg2SFyeBT8i+RjoxNaPW
         Mh/GP/vAOuBGgiqRun5Uxlv2cNMsY/5dtRHyU=
Received: by 10.150.5.21 with SMTP id 21mr664078ybe.95.1267067249349;
        Wed, 24 Feb 2010 19:07:29 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 23sm1029118yxe.55.2010.02.24.19.07.27
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 19:07:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <201002250148.11487.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141022>

On 02/24/2010 04:48 PM, Johan Herland wrote:
> Use PARSE_OPT_NONEG to disallow --no-<option> for --message, --file,
> --reedit-message and --reuse-message. --no-<option> does not make sense
> for these options, and specifying PARSE_OPT_NONEG simplifies the code in
> the option-handling callbacks.
>
> Also, use strbuf_addch(... '\n') instead of strbuf_addstr(... "\n") in
> couple of places.
>
> Finally, improve the short-help by dividing the options into two OPT_GROUPs.
>
> Suggested-by: Stephen Boyd <bebarino@gmail.com>
> Signed-off-by: Johan Herland <johan@herland.net>

Acked-by: Stephen Boyd <bebarino@gmail.com>

On a related note, I spent last night splitting up cmd_notes() into
subcommands. This way it's more like builtin-remote.c with respect to
the many subcommands and allows you to do something like 'git notes add
-h' and only see the options for add. I'll send it in a few hours after
I have time to polish it up (and probably rebase onto this change).
