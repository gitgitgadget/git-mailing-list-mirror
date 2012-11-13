From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Test failures in contrib/remote-helpers
Date: Tue, 13 Nov 2012 10:59:32 +0530
Message-ID: <CALkWK0=+HGzLpFNPn_mo2_zt+pqYs230ZK4x3SweiFcXCD5zHQ@mail.gmail.com>
References: <CALkWK0mU5O3Rqznkx-qn8VLFEgsMzOba1i8onSvf8X3FBeTs6g@mail.gmail.com>
 <CAMP44s1TLyKoHVouwgCFqi-vwA6rUBYJZXTA7JDFX6bfyQ7_tw@mail.gmail.com>
 <CALkWK0k9trxx8NC1GWw-yYzBKhFchrvg2JLeBtyoAkokmv9A0w@mail.gmail.com> <CAMP44s1E7qKCPTH1MMuOwJkW8opmD+Q6bzD6j1-KM039g-Uq2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 06:30:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY94Z-0000GJ-2b
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 06:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123Ab2KMF3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 00:29:53 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39047 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab2KMF3x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 00:29:53 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so7049961obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 21:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+wt2v+cMmqHpjy0/CGpy5thsOpx46f8ANl8wTdSxAXM=;
        b=hMqa0p6b7I6vLlJr1NlcZ7hcw9JvWYdxEjYNeQ2tJMNEDKaEH4ox4FtNTYSmzDStji
         bIA4N2Sn8vRwBbLJu1yRoZA9Fp0BLyjtLGX86MA7QMJGTddZy/ai94IMLCn5ZblVwFxP
         g38plVKcs+fW9TbMEfviGQOopAWJwpU29mt/1R0zX1qS+whzBgReWFwAt2KCKlD0RxsW
         g4D+b4KYIq2ykb5LXgYgQe6wYb9MHpXvKIBJxWfFMFHsyRuoTDiYkqezpSr4fk0IyXgG
         cGyAGQBQHsOhpQLshWm3waXZGlZ857z6RJTmri39LNGbu0AH2D52zzbH5LGUuz85ssHy
         C99Q==
Received: by 10.60.28.36 with SMTP id y4mr16133479oeg.13.1352784592407; Mon,
 12 Nov 2012 21:29:52 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Mon, 12 Nov 2012 21:29:32 -0800 (PST)
In-Reply-To: <CAMP44s1E7qKCPTH1MMuOwJkW8opmD+Q6bzD6j1-KM039g-Uq2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209575>

Felipe Contreras wrote:
> And here's the one for bzr:
>
> --- a/contrib/remote-helpers/git-remote-bzr
> +++ b/contrib/remote-helpers/git-remote-bzr
> @@ -646,12 +646,12 @@ def get_repo(url, alias):
>      global dirname, peer
>
>      clone_path = os.path.join(dirname, 'clone')
> -    origin = bzrlib.controldir.ControlDir.open(url)
> +    origin = bzrlib.bzrdir.BzrDir.open(url)
>      remote_branch = origin.open_branch()
>
>      if os.path.exists(clone_path):
>          # pull
> -        d = bzrlib.controldir.ControlDir.open(clone_path)
> +        d = bzrlib.bzrdir.BzrDir.open(clone_path)
>          branch = d.open_branch()
>          result = branch.pull(remote_branch, [], None, False)
>      else:
>
> I have other fixes to run up to 2.0.

Works for me.  All four tests pass now.
Reported-by: Ramkumar Ramachandra <artagnon@gmail.com>
Tested-by: Ramkumar Ramachandra <artagnon@gmail.com>

Ram
