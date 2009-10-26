From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git push interface inconsistency
Date: Mon, 26 Oct 2009 18:31:44 -0400
Message-ID: <32541b130910261531o36b8ce7eh6bddf26a2ae15663@mail.gmail.com>
References: <76c5b8580910261525y5397b54eyf9c3d58c0fe19fce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 23:33:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Y6l-0002Dk-A7
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 23:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbZJZWcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 18:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbZJZWcA
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 18:32:00 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:44062 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbZJZWb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 18:31:59 -0400
Received: by yxe17 with SMTP id 17so10240499yxe.33
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 15:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=lyuZKCUiysF1HlatjoU0AR0OiYSYrg5kS4K+AfJGZwM=;
        b=r3Hhjl0K1kvMwob4NO0eqGSS/rG5dO9Afxm+G2YNfR6CJfV90qNJLPzNDyV4OVbsRD
         CDB67o9dYdLnoHBhGbtrm7Y26om14nsQAIPVkg/BDBjtWh5nCQyKPqvdGsIkmdA5R8kh
         WihLeMUjNGMo7RBnvNpldNlwn90wWd2QUD1bM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hUP+vF/fD57UhUuSNwSTI6qhFvrvpWAHuUhPkHBOGT0UoODWcrb7EJrpuDZjxqmQ2S
         SBPl2xiBI+HVeEUKPmi6Ez993hzHidTCXmeOFqcP5KLS3JZnw0qYhc+zb/NwGFdtrINY
         cZojvipFaUZT+oKCpTE7w+v9nLUC8BDxvqS1s=
Received: by 10.151.5.21 with SMTP id h21mr24999630ybi.26.1256596324079; Mon, 
	26 Oct 2009 15:32:04 -0700 (PDT)
In-Reply-To: <76c5b8580910261525y5397b54eyf9c3d58c0fe19fce@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131282>

On Mon, Oct 26, 2009 at 6:25 PM, Eugene Sajine <euguess@gmail.com> wrote:
> I have a question:
>
> Why I can't do
>
> $ git push my_tag
>
> It will fail because the remote is not specified, even if there is
> only one origin remote
>
> but can do
>
> $ git push --tags
>
> and it will push tags to origin...

Because 'my_tag' is interpreted as the name or URL of the remote, not
as a branch name.  You can do "git push origin" and it will guess the
branch name(s) to push, but because of that, the one-parameter push
can't *also* be used to guess the remote name.

In contrast, --tags is a flag, so it's actually the zero-parameter
version of push, which assumes 'origin' and then guesses the branch
name (and --tags changes the guessed result).

Hope that helps.

Have fun,

Avery
