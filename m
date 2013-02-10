From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git prompt
Date: Sun, 10 Feb 2013 13:25:38 -0800
Message-ID: <20130210212538.GA11720@elie.Belkin>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@MIT.EDU>
To: Ethan Reesor <firelizzard@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:26:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4ePc-0007Iu-Op
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 22:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748Ab3BJVZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 16:25:50 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:45696 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586Ab3BJVZt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 16:25:49 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so2516823dak.30
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 13:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4OzpkI6TPzJGIh+8QrdZiS8dK//atYn79Zc2t/rMuwM=;
        b=OiBtO6kA1ZuRnusuSuRRoqOU0l/9iYjLDZhSlP6dIm16eChnWKJvS0g6GvxM8+0+IS
         uuvyv/fH7B2NevWsQ7ipdm3GcI5Ovgy3U/BMDm/XxFLaWDIINTS4O3WlAM4JvJvtNLV2
         LIOWmjQYOjtBw9i9O+CQDtLF0cEr82gX0Czw/NcMwgpXvrnue75bVX34pju11QfvDKRb
         vaEe2VNv/y2o8bgwg+OSzpsCqtmKmgplQzdcKJ3ZWwMCsmscbh8yO6MA7BhZy/Iz2FrJ
         4pgkW7lcc0vbbr8J6An56rCfNfH1szIgbG4VeRfiDfJW4IItik1HJ78aNbosmx04q/Ma
         JSFw==
X-Received: by 10.66.73.138 with SMTP id l10mr36596214pav.44.1360531549161;
        Sun, 10 Feb 2013 13:25:49 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ix7sm5428280pbc.25.2013.02.10.13.25.46
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 13:25:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215936>

Ethan Reesor wrote:

> I have a git user set up on my server. It's prompt is set to
> git-prompt and it's git-shell-commands is empty.
[...]
> How do I make the git user work like github where, upon attempting to
> get a prompt, the connection is closed?

I assume you mean that the user's login shell is git-shell.

You can disable interactive logins by removing the
~/git-shell-commands/ directory.  Unfortunately that doesn't let you
customize the message.  Perhaps it would make sense to teach shell.c
to look for a

	[shell]
		greeting = 'Hi %(username)! You've successfully authenticated, but I do not provide interactive shell access.'

setting in git's config file.  What do you think?

Thanks,
Jonathan
