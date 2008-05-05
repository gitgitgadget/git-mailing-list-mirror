From: "Zack Brown" <zacharyb@gmail.com>
Subject: Re: Associating tags with changelogs
Date: Mon, 5 May 2008 00:20:36 -0400
Message-ID: <218b69370805042120p533cc100r53d5d96888843273@mail.gmail.com>
References: <218b69370805042040h66d02979jac6bd64456a9d304@mail.gmail.com>
	 <436ECC5F-0664-4379-8F69-0121AE5F496E@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon May 05 06:21:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JssCg-0006sc-1S
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 06:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbYEEEUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 00:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbYEEEUk
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 00:20:40 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:33591 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbYEEEUk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 00:20:40 -0400
Received: by an-out-0708.google.com with SMTP id d40so508631and.103
        for <git@vger.kernel.org>; Sun, 04 May 2008 21:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CkkHs91WtFBugzD/LXjC66hNzQZMvOSqr4UO3zSnE6g=;
        b=QAWtXLYgCphnzSeoWvGYQwxMlgkPRf1L9/O1JxMp6JGG8rRYkIv+Og5os/RkwwlE4Ngv77QpO3WoqDTE3YntoIq+RkZ0ImFodfyzJCpdEbS+T6q8Oee6QDDPVeyEbTd+dW4hiWzqAmDtJAdZWlzUfGy1AW6TgBu7faGCWvKxDK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qhR/WlLMjv6ntyKAITR1zztD5saflUgt7x8oW3exU7kYmwhDjWcJxO2vozP432Wxf9n19oPpFYBfpf53M4AuncwHl/hkBnLVpIoK1MvVSqVeYBaoOHd90BLdWVA0fuzb4flMNMTncY8gd0r/CjA4w+Y+i+8lRulPEbEp8Wm3VJY=
Received: by 10.100.242.20 with SMTP id p20mr7058158anh.153.1209961236496;
        Sun, 04 May 2008 21:20:36 -0700 (PDT)
Received: by 10.100.172.4 with HTTP; Sun, 4 May 2008 21:20:36 -0700 (PDT)
In-Reply-To: <436ECC5F-0664-4379-8F69-0121AE5F496E@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81226>

This seems to be working for me. I just call git-describe for each log
entry before I enter it into the database.

Thanks!
Zack

On Sun, May 4, 2008 at 11:56 PM, Kevin Ballard <kevin@sb.org> wrote:
> Sounds like you want git describe --contains.
>
>  -Kevin Ballard
>
>
>
>  On May 4, 2008, at 11:40 PM, Zack Brown wrote:
>
>
> > I'm using git to extract changelog entries into a MySQL database, and
> > I want to be able to associate each changelog with the official
> > release in which it first appears. I can use "git-tag -l" to see a
> > list of the tags, and I can use "git-log tag1..tag2" to view all the
> > changelogs between two tags, but neither of these are exactly what I
> > want.
> >
> > My script keeps track of the most recent changelog entry that it has
> > processed into the MySQL database, so the next time it runs, it picks
> > up from that entry, using "`git-log sha1string.. --pretty=fuller", and
> > inserts only the changelogs since that entry into the database.
> >
> > What I'd like is to still be able to get only the entries since that
> > sha1 string, while somehow identifying the tag of the release
> > encompassing each entry listed in that set. Then when I input the
> > changelog into my database, I can associate it with the proper
> > official release (or -rc candidate).
> >
> > Is there a command to do that? I don't see anything in the man pages for
> it.
> >
>
>  --
>  Kevin Ballard
>  http://kevin.sb.org
>  kevin@sb.org
>  http://www.tildesoft.com
>
>
>



-- 
Zack Brown
