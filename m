From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: help moving boost.org to git
Date: Mon, 5 Jul 2010 16:48:47 +0200
Message-ID: <AANLkTinWnyB0C7HlyLz93lszfkWd81Y7reeWRpMNwHuv@mail.gmail.com>
References: <4C31E944.30801@boostpro.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Eric Niebler <eric@boostpro.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 16:48:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVmyd-0005O4-4j
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 16:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755675Ab0GEOst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 10:48:49 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34885 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045Ab0GEOst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 10:48:49 -0400
Received: by bwz1 with SMTP id 1so2772719bwz.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=/p1yJi3UFHGtH6wZYW1jPpuohH7jaBy+EIGYe25nFig=;
        b=tPyNKj8wEIYIi6PXJypg47QErihxbDGLeX3ibSeEW/j+Qbv/phhqqjxhdkltbbfkXy
         CTUgLUk7lGtwv7tLAn0xqZfah27qzc2OdbSeCJOlXxuGXzuZHhC2LdFdgIbVnEu4oWq2
         tsKWuIFv73Td5y6P/h7lPKCl3Qx4Njd3QrxQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=KeOOW58aMhL/1X6mMZjfYjRyY2LgMroFI4czEP9leK8dEZH8Ert/1694qaFxNHOGe5
         6qqwOxICZdQFDztbpIOLWENBQ+YnuaWpUWfV1VUbcnbH76PsNxLYESdzxqA+U03KkkgD
         DbF6Af3EkoNbfaSDMGzxPtGSE6x9tsYpl+I8E=
Received: by 10.204.73.205 with SMTP id r13mr2504423bkj.35.1278341327147; Mon, 
	05 Jul 2010 07:48:47 -0700 (PDT)
Received: by 10.204.71.1 with HTTP; Mon, 5 Jul 2010 07:48:47 -0700 (PDT)
In-Reply-To: <4C31E944.30801@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150271>

On Mon, Jul 5, 2010 at 4:16 PM, Eric Niebler <eric@boostpro.com> wrote:
> I have a question about the best approach to take for refactoring a
> large svn project into git. The project, boost.org, is a collection of
> C++ libraries (>100) that are mostly independent. (There may be
> cross-library dependencies, but we plan to handle that at a higher
> level.) After the move to git, we'd like each library to be in its own
> git repository. Boost can then be a stitching-together of these, using
> submodules or something (opinions welcome). It's an old project with
> lots of history that we don't want to lose. The naive approach of simply
> forking into N repositories for the N libraries and deleting the
> unwanted files in each is unworkable because we'll end up with all the
> history duplicated everywhere ... >100 repositories, each larger than 100Mb.
>
> So, what are the options? Can I somehow delete from each repository the
> history that is irrelevant? Is these some feature of git I don't know
> about that can solve this problem for us?
>

You're probably looking for git-filter-branch. This tool can be used
with the --subdirectory-filter option to filter out a specific
subdirectory to it's own branch. Or if the project isn't split into
subdirectories, you can use the --tree-filter option to filter
specific files if you want.

See http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.html
for details

-- 
Erik "kusma" Faye-Lund
