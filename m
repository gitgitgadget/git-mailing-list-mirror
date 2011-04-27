From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Tue, 26 Apr 2011 22:58:25 -0500
Message-ID: <20110427035825.GA4546@elie>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 06:07:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEw2P-0008AX-8s
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 06:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234Ab1D0D6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 23:58:32 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63152 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab1D0D6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 23:58:32 -0400
Received: by ywj3 with SMTP id 3so487039ywj.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 20:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=CQKUUGW5s/8Iyo2IPUvNeKS0P81Chs4ACz7e/n4N4/E=;
        b=ERizlqp+wlNH/M9GvriLT8K2YQNyYaRHGhf8YIvsQergSX50UOdN2/1JjmOai6JAAk
         L5888AC6dx2UnPT0V3TC2gobEJfS9JX4YM3q8Cs1GKSxb3UguJUx6Eolnr4D6BQDPOv8
         5yYQPCOFJdb1aQ+ykNOs0MqY3yO/y3YPKwt3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uRSzUOvlGRHSZvDtfHzkHQSOoDewXaRm9rmD+kKMHHWr3T0DDJSq7PQB4QBQRjqEi8
         Hnq+TY8w8E9Wt4fnMLKO8i0hpNq5DcrsjNUpg7wJ8BAy9Ct3CCt/nyQ3cjiy0ofgO6Or
         ami0Y0AtmOjVRjkvX+9RxvKMOsHJKmIJ5cHmc=
Received: by 10.91.68.35 with SMTP id v35mr1436021agk.98.1303876711201;
        Tue, 26 Apr 2011 20:58:31 -0700 (PDT)
Received: from elie ([68.255.96.190])
        by mx.google.com with ESMTPS id e9sm414873ann.50.2011.04.26.20.58.29
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 20:58:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172162>

Hi Jon,

Jon Seymour wrote:

> Has anyone ever given consideration to git supporting a plugin
> architecture for git extensions?
>
> The idea would be to provide a consistent way to install, and address
> extensions to the core git functionality in a manner that does not
> require the extension to actually be integrated into the git core.

I haven't looked into 'git work' yet, but for my own private tweaks,
two mechanisms have sufficed:

 * adding a program named git-foo to the $PATH introduces a
   'git foo' command.  For the git command look and feel, scripts
   tend to start with

	. "$(git --exec-path)"/git-sh-setup

   (see git-sh-setup(1) for details).

 * various existing git commands can have their behavior modified
   through configuration and hooks.

Does 'git work' require changing the behavior of existing commands,
and if so, are there hooks that could be introduced to help in doing
that?
