From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Add "raw" output option to blobs in "tree" view format
Date: Fri, 7 Jul 2006 09:41:52 -0700 (PDT)
Message-ID: <20060707164152.86022.qmail@web31805.mail.mud.yahoo.com>
References: <7vmzbl3nqj.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 18:41:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FytOu-0003XG-DT
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 18:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWGGQly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 12:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWGGQlx
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 12:41:53 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:34950 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932222AbWGGQlx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 12:41:53 -0400
Received: (qmail 86024 invoked by uid 60001); 7 Jul 2006 16:41:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=lUFBk+l4GvOk7KjjPQ9lr/PMw/zpMln7nQoGQwI5YjC4ZLeLx9aFStz3FXFQuCzWJ/gE01B6zAhigarN/MRCMoc9IIcyRb/TQ0HLZrbuot7yGnaEc/v8Wx8uw+YucBm+z5Y1W7U6I9YqWosxb5aHRL8/ruOcFFaQ/v0velOgor8=  ;
Received: from [68.186.48.129] by web31805.mail.mud.yahoo.com via HTTP; Fri, 07 Jul 2006 09:41:52 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzbl3nqj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23449>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Add a "raw" output option to blobs in "tree" view format, so that the
> > user doesn't have to click on "blob", wait for the (binary) file to be
> > uploaded and shown in "blob" mode, and then click on "plain" to
> > download the (binary) file.
> 
> I appreciate what you are trying to achieve, but at the same
> time wonder if it would make more sense to simply teach a=blob
> action to do this automatically, perhaps using /etc/mime.types
> and/or File::MMagic.

That'd be cool for non-"text/*" files, but it would leave the user
go through the same click "tree->blob->plain" for "text/*" files,
since they are "cat -n"-able and the default action would be git_blob()
if such an algorithm is implemented.

That is, the user would still have to click through "tree->blob->plain"
to download a "text/*" file, as opposed to just "tree->raw".

What this patch allows, is that the user be able to simply download the file,
right from "tree" view, regardless of the type of file. (I.e. the type of
file as decided by the _user_, not gitweb.cgi.)

Having said that, we can still implement it, so that "raw"="blob" for
non-"text/*" files, but "raw"!="blob" for "text/*" files.  I.e. allow
the "cat -n" functionality for "text/*" files, as is currently implemented,
as well as shortcut for downloading ("raw").

> If you know your MUA will mangle whitespace to make your patch
> inapplicable, please do not add a patch to the message _and_
> attach the patch to the message.  The mail-acceptance tools know
> how to flatten MIME attachments, but if you have your log,
> three-dash and then corrupt patch in the cover-letter part, and
> then the true patch in the attachment part, the flattened result
> will have the corrupt patch first to cause the patch application
> to fail.  So please either (preferably) use a MUA that does not
> corrupt your patches, or do a log in the message part with patch
> only as attachment.

Will do.

    Luben
