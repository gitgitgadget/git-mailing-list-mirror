From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git for local web development
Date: Fri, 17 Apr 2009 20:48:13 +0200
Message-ID: <46a038f90904171148xefb2085yc47e58c62cd3bbaf@mail.gmail.com>
References: <135754252540163221910297561025355826788-Webmail@me.com>
	 <20090417115925.GB29121@coredump.intra.peff.net>
	 <loom.20090417T153819-898@post.gmane.org>
	 <20090417183046.GB30240@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: William DiNoia <william.dinoia@mac.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:55:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LutDL-0005U6-5n
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 20:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756052AbZDQSx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 14:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754685AbZDQSx3
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 14:53:29 -0400
Received: from mail-bw0-f211.google.com ([209.85.218.211]:33132 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbZDQSx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 14:53:28 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2009 14:53:27 EDT
Received: by bwz7 with SMTP id 7so288693bwz.37
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wgbETmrvwPaYrzP65sbHn6kq0sDWGAZUPsGMUBKri2Q=;
        b=USmrzXmOWH6LVoaKbUjAG7Jsw9e5Zz1f7D+NgDVNZXFSbBq9OeAblrDNuMCm12dBPZ
         734ebwa/p1K9xUXsW5GDrhj/PL8jj6citjNxuiWMce4QFdbFsJRTxSj1cLsDXGcMesrG
         0UbfTDl8zGuj+h43PlNcaOZUsrjtk9UPEBUQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SXYEsAeNuUuewBoLgBTwXQB7S8cDRd/x4uhSA4ReBXeVMwapfwa9jjkNZdb3s7z3q6
         BTvR+TQ0e3m6CMkEUxKhq+TuobHJvCt9ocQvSsGTZGugQb+duWXjEqojKg0fOTixoWlv
         UTkmW/dr6ZFhgRg9bwYl4gIYw77K48cmh52LE=
Received: by 10.223.116.77 with SMTP id l13mr869863faq.106.1239994093603; Fri, 
	17 Apr 2009 11:48:13 -0700 (PDT)
In-Reply-To: <20090417183046.GB30240@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116776>

On Fri, Apr 17, 2009 at 8:30 PM, Jeff King <peff@peff.net> wrote:
> repo and working tree are not owned by "william"? As long as www-data,
> presumably the webserver could still serve it.

Also, as long as they are owned by www-data, the setup is more
vulnerable to security problems.

Files served by Apache (or any other webserver) should _not_ be owned
by the same user that the webserver runs under. The www-data ownership
is exclusively for files that you expect the webserver to be able to
_modify_: files uploaded by users, session data files, sqlite
databases and such.

You don't really want your webserver changing executable files such as PHP.

It is a valid thing to create a user to own those files, and in
servers where a team was maintaining the code, we have often used
'www-code'.

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
