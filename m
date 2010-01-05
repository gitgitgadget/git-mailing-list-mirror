From: Russell Steicke <russellsteicke@gmail.com>
Subject: Re: A question about changing remote repo name
Date: Tue, 5 Jan 2010 10:52:46 +0800
Message-ID: <c1b8b6671001041852w4740b7d6g4b8db1221c5dc744@mail.gmail.com>
References: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Dongas <dongas86@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 04:00:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRzf7-00075b-HX
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 04:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab0AEDAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 22:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754390Ab0AEDAp
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 22:00:45 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:55325 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab0AEDAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 22:00:44 -0500
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jan 2010 22:00:44 EST
Received: by iwn32 with SMTP id 32so542864iwn.33
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 19:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=a49mT8055ymFRDXnFliV10sJLiVUHsetC9bEt1W3tvE=;
        b=vP/wXuIdHIJn96zCxxboCSa1InqqWA8T5S8CTix87uf8XTzbY/Tgga3FPwQcujc1k1
         Icc187lnsvpvMIdVWkiWcMpUYwR09SBea42ZCB9QtGFt5QsqTODrAbJ7dPDUgVILqEr5
         x0blBeEBlqX5oNh8oPJLEHWlyYw5V4SZzv4Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eCKCLTorR7Tcz/H8+GMeZTvnYs+w+GvlT9Aiisn9EmnpFExlD9D0OV+V+ksE5I4iUt
         jUsXK416R8lAHOPCAVP3Hn2nIR8L6QtHL4yBbuz2U3sgD5ZBrqR/DRkn2WhgiJQR4nwN
         KiB9w69PKjkuhuxgYM0DoxsOR4ejJkAjCkjzY=
Received: by 10.231.48.210 with SMTP id s18mr1423549ibf.3.1262659986395; Mon, 
	04 Jan 2010 18:53:06 -0800 (PST)
In-Reply-To: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136156>

On Mon, Jan 4, 2010 at 2:45 PM, Dongas <dongas86@gmail.com> wrote:
> So i need to change the remote name manually.
>
> I tried modifying the .git/config file locally but it didn't work.
>
> Could someone help tell how to do it?

After editing .git/config, do this:

$ mv .git/refs/remotes/OLDNAME .git/refs/remotes/NEWNAME

and optionally:

$ mv .git/logs/refs/remotes/OLDNAME .git/logs/refs/remotes/NEWNAME

Remember to rename the remote in any tracking branches in .git/config,
as well as the name in the [remote "OLDNAME"] section, and the name in
any fetch and push lines.  ie

[remote "OLDNAME"]
	url = something
	fetch = +refs/heads/*:refs/remotes/OLDNAME/*
[branch "master"]
	remote = OLDNAME
	merge = refs/heads/master

Becomes

[remote "NEWNAME"]
	url = something
	fetch = +refs/heads/*:refs/remotes/NEWNAME/*
[branch "master"]
	remote = NEWNAME
	merge = refs/heads/master





-- 
Virus found in this message.
