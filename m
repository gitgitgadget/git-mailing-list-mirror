From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 22:31:49 +0100
Message-ID: <40aa078e1001161331o115065dax98642ed2054f9b9d@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <201001161138.36535.j6t@kdbg.org>
	 <40aa078e1001160305y17b46a6dtc4959e5255c7acae@mail.gmail.com>
	 <201001161336.20703.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 22:31:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWGFP-0004AD-Vp
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 22:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426Ab0APVbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 16:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289Ab0APVbv
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 16:31:51 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:39314 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab0APVbv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 16:31:51 -0500
Received: by ewy19 with SMTP id 19so2030783ewy.21
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 13:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=DUrD1B6UUDVoGxkLEaiCy1XDpzPaNvfi7rgKLz5VUEE=;
        b=Ncq0fU7W7R/5x0z/ATDQ0R7mI0sVRf4OxTtfWQYuafUVBFtoikBunSGU5nbEZPsr8j
         3twreC7wjiOzIu7lQyhlDo0JGdklP7RsZ2DXp+hbqmMdVelA2h8AmVSpfbj4I7G5sPT9
         f7DJ1NUzhEMLoEJMy2/NDFLcZOCr6fcE/8G7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=Hw+qxhZ5yz/xCSvYXPmTFxtOIry3oRoeLycOju5JYV02EJmAPFAbikKIVZ49eGHXwP
         2ayplF7J/pPZyO5B/+iJui8sk9RdgB4Z12VmdqqmYX/8CYE6/I3iO25PtL7wlh6wOV/g
         9dyzVDIROnF9gfHdD3qjppuA7q4y4yVcfzgp4=
Received: by 10.216.89.138 with SMTP id c10mr1367831wef.47.1263677509649; Sat, 
	16 Jan 2010 13:31:49 -0800 (PST)
In-Reply-To: <201001161336.20703.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137261>

On Sat, Jan 16, 2010 at 1:36 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Samstag, 16. Januar 2010, Erik Faye-Lund wrote:
>> ...but __WSAFDIsSet() seems to be every bit as official on Windows as
>> FD_ISSET() (documented in msdn, without any notes not to use it), so I
>> still don't really see the point.
>
> I didn't know nor check whether it is documented, but assumed from the '__'
> that it must be internal. Being documented makes a big difference. I'm fine
> with either solution.
>

OK, in that case, I'll leave it as it is. The current code is slightly
more tested (I've been using it for some weeks), and I'm slightly lazy
;)

But I'll update FD_SET...

-- 
Erik "kusma" Faye-Lund
