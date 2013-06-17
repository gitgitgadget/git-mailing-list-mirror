From: William Swanson <swansontec@gmail.com>
Subject: Re: New User Question
Date: Mon, 17 Jun 2013 10:19:50 -0700
Message-ID: <CABjHNoQ5DTHtxXueHRutdkK5wBGfaNO9Ki3aJTa1Khh-x422QQ@mail.gmail.com>
References: <F201B6D6-7A69-4DD6-BDF5-5AE12E3A176C@me.com>
	<CABjHNoSfLGW_D8RM8+LghP8kKYsYhZKi=7k4kEJSNEX=PDe2XQ@mail.gmail.com>
	<1786A257-B21A-46CC-8F41-31AE9B948C00@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Joel McGahen <vin4bacchus@me.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 19:19:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uod5w-0000uI-53
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 19:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab3FQRTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 13:19:52 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:64305 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab3FQRTv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 13:19:51 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so2684550wgg.32
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z4Er1qCNvf6P8pF4OCoWmBk+WBJx1APXMYpuza90LDk=;
        b=QAhA6A7MvfpuRTLPrF3I7VzIQyWSyRxFz60NV97ot/DMtMFARhf0SDeCdhKp5KKeif
         ARZhCAw35eoYxsDf7Qugtte0vW2Y/d8aeC9azsLw6y3+H2EE9tpZfg6TTM+GGvWY5hgP
         U/TPB57ia00A7HeTVBenLdUaVBnXC9nCw1xYFx/9BIZQ8MPi+i1JYNXkjjhRTDF6N6Fi
         cADpE1N9qfR16APqAu24RaJkxYUNEgPf5Fn2HACZpqJCPxooSPphC4KQCmKd5/NLyB3P
         l+OKwRPFGlm1wWVgjO+YQoUbS9v3mIyRZVWhE5nQKRMjQucRpggICmzPwHD4Iwe8AH2J
         +g4w==
X-Received: by 10.194.242.229 with SMTP id wt5mr8284806wjc.36.1371489590325;
 Mon, 17 Jun 2013 10:19:50 -0700 (PDT)
Received: by 10.217.93.68 with HTTP; Mon, 17 Jun 2013 10:19:50 -0700 (PDT)
In-Reply-To: <1786A257-B21A-46CC-8F41-31AE9B948C00@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228087>

On Mon, Jun 17, 2013 at 9:56 AM, Joel McGahen <vin4bacchus@me.com> wrote:
> Should I have just changed the origin URL in the first place to point to my new local repo? What I did was to just add another remote with a different name (temp_repo). So if I do "git remote" I see origin and temp_repo. I then pushed to "temp_repo".

A remote is just a shorthand for a specific URL. All the commands that
take remote names, like "push", work just as well with raw URL's.
Configuring a remote is basically a way to save time typing the URL.

As Fredrik pointed out, Git is completely decentralized, so there is
nothing special about the remote repositories. When you do a fetch,
the local repository basically says, "Hello remote, please send me all
the commits you have that I don't have." When you do a push, the local
repository basically says, "here are all the commits I have. Please
take any ones you don't have." The two repositories simply act as
peers.

> Or should I have pushed as I did and then change the origin to the new repo location? So If I would "git remote" i would still only see one (origin) but it would point towards the temp_repo location?

If you look in a repository's ".git/config" file, you may see some
per-branch config options that refer to specific remotes, like this:

[branch "master"]
    remote = origin

In this case, you can just edit the config file to point to temp_repo,
either by hand or by using a command like "git config". Or, if you
prefer, you could change "origin" to point to your new server. How you
configure things is up to you and what works best for your workflow;
git is happy either way.
