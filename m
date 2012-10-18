From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] transport-helper: call git fast-import properly
Date: Thu, 18 Oct 2012 09:39:35 +0200
Message-ID: <CAMP44s3FsdF7944TkO3CVCV9d80TTocE5zXyE8sh1bXL0eMu5Q@mail.gmail.com>
References: <1350462440-427-1-git-send-email-felipe.contreras@gmail.com>
	<CAGdFq_jNs_CNN8PGbbgvJbmNTSSN9TaEDxCSyDEpScZL4zyiwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 09:39:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOkhn-0003gc-G3
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 09:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab2JRHjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 03:39:36 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53571 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab2JRHjg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 03:39:36 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so8304785oag.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mZxaM6CVN/xCTVqIN3z6kfqO6hlxvDN9a1Ki7IaKfRk=;
        b=QuSJ1FGptJcwuSxC40Zwq/kLKkIy/H4pQNV269JXvFEOb4DtpbhNv2DQxIoVc36aJz
         a9qmPi4Blr3vefuTqiJmw5tM10/eX3IlaAlggdp02p0wYtxj2twkx/vQJ1Qg8y9dl2RN
         bGpehfRH9xGhcVh5H4Qxb17Q3x6HVKWDIbNV3bPBbx1+waDmTyGUvLRvKxZOYWmrbtcu
         Rjw4wBB5hh+H52PdNvoimIdxDrmKJoOSIGegqTNqCRlgHeCththNOdKWWd8KToH7SCVm
         xpgAvN2+0HvSzPcYe2RBAQyISgXH3EdFgpqZ58e1VZ5uQheZlglmS0sGan8XDRJUtl7a
         x/Yw==
Received: by 10.60.170.179 with SMTP id an19mr13112070oec.46.1350545975626;
 Thu, 18 Oct 2012 00:39:35 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Thu, 18 Oct 2012 00:39:35 -0700 (PDT)
In-Reply-To: <CAGdFq_jNs_CNN8PGbbgvJbmNTSSN9TaEDxCSyDEpScZL4zyiwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207974>

On Thu, Oct 18, 2012 at 7:13 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Wed, Oct 17, 2012 at 1:27 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> The marks options are being ignored right now.
>
> It seems unlikely to me that this never worked, surely no reviewer
> would accept a patch that doesn't actually implement the feature?
> What's the history here?

Now I see, the {import,export}-marks options are only meant for
fast-export, for fast-import one should use the 'feature' commands. It
took me a while because the git_remote_helper code for python is very
confusing: it uses testgit.marks for the marks that git generates, and
git.marks for the marks that testgit generates.

It's not very convenient for remote-helpers that can export single
branches as opposed to the whole repo:

http://github.com/felipec/git/commit/0961fdf8231a4ac057eec8a306a708e66f7b6ae9

But it works, so this patch is not needed.

-- 
Felipe Contreras
