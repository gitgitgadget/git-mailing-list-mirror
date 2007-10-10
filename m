From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [msysGit] Re: [PATCH] git-gui: offer a list of recent repositories on startup
Date: Wed, 10 Oct 2007 10:13:27 +0200
Message-ID: <B1EFFED4-1DF7-4A0A-93E2-F21812E7AF6B@zib.de>
References: <11917925011987-git-send-email-prohaska@zib.de> <20071007233023.GE2137@spearce.org> <BE872860-40AD-4BBA-BDD5-0EC8CB9AC4B5@zib.de> <20071010073053.GQ2137@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 10:14:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfWi9-0006rK-Jb
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 10:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbXJJIMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 04:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbXJJIMA
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 04:12:00 -0400
Received: from mailer.zib.de ([130.73.108.11]:40526 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123AbXJJIL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 04:11:59 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9A8BsoQ018574;
	Wed, 10 Oct 2007 10:11:54 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9A8Bswp022075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 10 Oct 2007 10:11:54 +0200 (MEST)
In-Reply-To: <20071010073053.GQ2137@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60479>

Shawn,

On Oct 10, 2007, at 9:30 AM, Shawn O. Pearce wrote:

>
> Steffen Prohaska <prohaska@zib.de> wrote:
>> Shawn,
>> I attached two patches. They should eventually be both squashed into
>> one.
>
> Thanks.  I'm applying the patch below over both of yours, and
> then squashing them all together and keeping you as the author.
>
> I did not like how the listbox looked (or worked!) on Mac OS X.
> Clicking on the item was at first a very non-obvious action, and
> then when I did do it I was very shocked to see the repository open
> immediately.  My brain knew the action was wired to the selection
> event (I obviously read the two patches before applying them),
> but it didn't expect that behavior.  Clearly the wrong UI model.
>
> The patch below uses a text widget instead and renders each of
> the repositories as a blue underlined link.  Users will generally
> assume that clicking on such links will take them immediately to
> that repository (much as it would take them to another webpage if
> this was a web browser)

This is similar to what I had in mind, but was lacking tk knowledge
to implement it.


> The "Open Recent Repositories" is not even shown in the UI if there
> aren't any to offer to the user.  Showing them this area just looks
> silly if they haven't opened or cloned anything yet.
>
> We now add freshly created or cloned repositories to the list of
> recently opened repositories.  These are just as fair game for
> being recently accessed as any others.  Perhaps even more so as
> users may wonder where they cloned that repository to the last time
> they started git-gui.
>
> We always store the absolute path of a repository into the config.
> This avoids the mess of opening a repository twice using say a
> relative path entered into the text entry field and then opening
> it later via a file browser, only to find out you now have the same
> repository in the recent list twice.
>
> I fixed the --unset-all bug and also avoided the --unset-all/--add
> loop you were using.  We convert the value into a "safe" expression
> and then try to match on it.

That all sound very reasonable to me.

I haven't applied your patch but only read through it. Looks good to me.

Thanks,
Steffen
