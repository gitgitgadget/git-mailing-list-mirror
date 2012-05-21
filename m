From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v3 2/4] submodule: support superproject origin URLs of the
 form ./foo/bar or ../foo/bar
Date: Tue, 22 May 2012 08:20:07 +1000
Message-ID: <CAH3AnrrEnLEnN=EgzaDjFtN6r9RBpTmPNTX96QiMtGz9J12eCQ@mail.gmail.com>
References: <1337607102-14737-1-git-send-email-jon.seymour@gmail.com>
	<1337607102-14737-2-git-send-email-jon.seymour@gmail.com>
	<CAH3AnrqBeD3JisjoK2dqnPWcBAFTxB5NYgRkfSPqb-CS8a0hsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 00:20:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWaxb-0007Cd-QO
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757538Ab2EUWUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 18:20:10 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39252 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757326Ab2EUWUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:20:08 -0400
Received: by wgbdr13 with SMTP id dr13so5411975wgb.1
        for <git@vger.kernel.org>; Mon, 21 May 2012 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vGKySI5do9I1gThjRMTjLyAwqnUDeXJMXhyjD2accGI=;
        b=THNbSghbp3V5yLRc6j8m8zpXKRLeuLRf0FCnVpN2esWkoisvZuyC4Z35/x93z2XCgf
         EP2aGbOB1zCLTw3sShitRWfQ2rH8AZiNkq2KyCCk3Wq950lsvZfStqfN6K/8OaqSRrQH
         +EB982M3GCJorMEjJTKUuthKP/58ZSRxcvPCq5fkSPkPeTfn64Cxc5Z0eSrx8vZsGDQk
         5aJGHszJWZ5pKSBEVjh/3DRSJ5aMyRmQgIywTjrDGIZoXXZojakuaHiNaQN1RNDHkVWN
         0Vk65zGlwTr+iugfXc9HFxVwOuD7lpmeno039VtlJ5SJ2dq2kuM6EP3933TC3MnYaJdM
         leGQ==
Received: by 10.180.86.197 with SMTP id r5mr28991564wiz.21.1337638807408; Mon,
 21 May 2012 15:20:07 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Mon, 21 May 2012 15:20:07 -0700 (PDT)
In-Reply-To: <CAH3AnrqBeD3JisjoK2dqnPWcBAFTxB5NYgRkfSPqb-CS8a0hsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198140>

On Tue, May 22, 2012 at 2:35 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> On Mon, May 21, 2012 at 11:31 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
>
> Mmmm. Better hold off on this one for the moment, I have detected a
> break during a subsequent git submodule update that my selection of
> regression tests didn't pick up. The issue is that the URL used for
> cloning the submodule during the update is now not correct.
>
> jon.

I guess the issue here is that whereas the origin url of the submodule
(as in remote.origin.url in the submodule) should be relative to the
submodule's working tree, it might actually be better to keep
submodule.{modulename}.url relative to the working directory of
superproject (which is current behaviour).

Thoughts?

jon.
