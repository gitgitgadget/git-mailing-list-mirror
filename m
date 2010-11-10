From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Tue, 9 Nov 2010 19:42:15 -0600
Message-ID: <20101110014215.GA1503@burratino>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org>
 <20101104112530.5c0e444a@chalon.bertin.fr>
 <4CD2E7B4.3000908@nextest.com>
 <vpq62wddmc0.fsf@bauges.imag.fr>
 <20101104181020.GB16431@burratino>
 <20101104205307.GA8911@home.lan>
 <7vd3qfr7ki.fsf@alter.siamese.dyndns.org>
 <663A3F43-5F64-41F0-B272-64EEE9775250@sb.org>
 <20101108222937.GH3167@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Yann Dirson <dirson@bertin.fr>, git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Wed Nov 10 02:42:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFziB-0004y0-UT
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 02:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab0KJBmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 20:42:40 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34122 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab0KJBmj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 20:42:39 -0500
Received: by qyk31 with SMTP id 31so126076qyk.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 17:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Drzq87DyYFnij8gJNAZaiPtqGmyODmh6KQVSmuFQwsY=;
        b=jPM1zBHD775jwbhxU7mM3PQBIIZ7OsvBx22UA/KsB++IxqTstP8I7BEv3jy0BkFXdc
         +iFOW3atRCBlcSY9RUsWVNVIEjTHfsFqm119MFwMoUNWfgNvKrv7N1XD9SkGfxgaDXmy
         /ZmNK+bEHP19UleIUQzpajLeb3kBtZRhqLpxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IyTQweyOPF4dw4IV5aFOtyqg5uLobZlTgIFOi6dglVmrkyXJH6wS0UwTs9BE5jACyK
         xR8LaG/SA5nQXptoUTLYaaj/rCyTggswWp38QtFqaahLFbMcLQIWTpi1FnOhFnZY8yRV
         qkakXiQG6Vuwmguby0cFFi1tfk6otHnpEI2cQ=
Received: by 10.229.95.11 with SMTP id b11mr6985935qcn.174.1289353358911;
        Tue, 09 Nov 2010 17:42:38 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id m7sm86541qck.37.2010.11.09.17.42.34
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 17:42:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101108222937.GH3167@home.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161117>

Yann Dirson wrote:

> |Keep in mind that any commit in the original todo list, that would
> |not be there after your edits, would not be included in the resulting
> |rebased branch.  In case you realize afterwards that you need such a
> |commit, you can still access it as an ancestor of @{1}, see
> |git-reflog(1) for details.

Do you mean @{-1}?

> Maybe we could list a copy of the todo list in the comments, as a
> reference for double-checking.  Such a list could even be used for a
> final check before applying, that would ask confirmation if the set of
> patches has changed, and offer to edit again.  The same config item
> (eg. advice.interactiveRebase ?) could be used to hide the note and
> the check.

Mm, but intentionally dropping commits is common, no?

What would be nice is to be able to do

	git rebase --change-of-plans

and somehow get my editor of choice to open with the original todo
list (read-only) and the current todo list (read/write).

Well, a person can dream. :)
