From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Do check_repository_format() early
Date: Sat, 1 Dec 2007 13:50:36 +0700
Message-ID: <fcaeb9bf0711302250ldfb543evd6d5f70d95ae51f7@mail.gmail.com>
References: <20071128165837.GA5903@laptop>
	 <Pine.LNX.4.64.0711281703470.27959@racer.site>
	 <fcaeb9bf0711280910x40fecdd5mf6d86e4a9b656d01@mail.gmail.com>
	 <Pine.LNX.4.64.0711281717460.27959@racer.site>
	 <fcaeb9bf0711280924v34160eddsf8a75f8f8cee389c@mail.gmail.com>
	 <Pine.LNX.4.64.0711281810410.27959@racer.site>
	 <7v3aunb0q4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 07:51:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyMBn-0000ra-I7
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 07:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbXLAGuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 01:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbXLAGuj
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 01:50:39 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:61884 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbXLAGuj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 01:50:39 -0500
Received: by mu-out-0910.google.com with SMTP id i10so712194mue
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 22:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=k3gg8wZ83Q9LfCXMAzEcu+HU9TRX7ajQAjGukiT2BmQ=;
        b=CtrU2IhjTf8Y07Je1SMeSxTdyuKfjwh+KwITge85tVWk7WkU0OYcDlQ+BVtWX4AxAY0Zjfo9bGFIUZWnzuJrTuf6sdeA9D/YRfjnqFhnGScsOFYiKI1L9DjJuMB+mUC9P+mFbHd6Zu9WUvDlxzZKCpiHv9n4VQKEHgppA2uNQjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BxgUTmaaOgzNHTM9bG5sXVRysHAh/BYS472adUOpckBa1ZcOxb32Js4LyuQpSuWULKfPKe9QO80m3Q5KPW0J50cy9DN5QpJfGkGjTDu+PrFHSW5A1T7H6nXuEwOJWa5AULBAajEw7ig+K0vSgFk/J4lp6aDX0e0Z3rjIrul0L28=
Received: by 10.86.25.17 with SMTP id 17mr8096412fgy.1196491836572;
        Fri, 30 Nov 2007 22:50:36 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Fri, 30 Nov 2007 22:50:36 -0800 (PST)
In-Reply-To: <7v3aunb0q4.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66704>

On Dec 1, 2007 9:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Thu, 29 Nov 2007, Nguyen Thai Ngoc Duy wrote:
> >
> >> The comment is clearly not clear enough. Maybe this?
> >>
> >> +                     if (!work_tree_env) {
> >> +                             retval = set_work_tree(gitdirenv);
> >> +                             /* config may override worktree (see
> >> set_work_tree comment) */
> >> +                             check_repository_format();
> >> +                             return retval;
> >> +                     }
> >
> > Perfect.  Please make it so, and add my ACK.
>
> Looks sensible, but can this be accompanied with a trivial test to
> demonstrate the existing breakage?
>

How can I reliably check setup_git_directory_gently()? I can pick one
command that uses setup_git_directory_gently(). But commands change.
Once they turn to setup_git_directory(), the test will no longer be
valid.

-- 
Duy
