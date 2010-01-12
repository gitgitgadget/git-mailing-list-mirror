From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Interest in locking mechanism?
Date: Tue, 12 Jan 2010 20:33:18 +0100
Message-ID: <46a038f91001121133r62b3d748n38ca27234f18e960@mail.gmail.com>
References: <1263319565-sup-1767@ezyang>
	 <32541b131001121101i76ad8062p3a7f3571ad86b0ce@mail.gmail.com>
	 <1263323292-sup-4182@ezyang>
	 <32541b131001121124u541de280na9184183d8704dc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Edward Z. Yang" <ezyang@mit.edu>, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 20:33:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUmUc-0007tF-18
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 20:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768Ab0ALTdX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jan 2010 14:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754572Ab0ALTdX
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 14:33:23 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:45510 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab0ALTdW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2010 14:33:22 -0500
Received: by ewy1 with SMTP id 1so5074798ewy.28
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 11:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=go1J/WLW/6+SF6F0LGQCtKVshqwZyDUcA4XqnAG+3ps=;
        b=rJimrNtstgpKbCgOZ35jUwZ0jcd4PVwnjFp+BfihaZpwdHAEoVd8SyKisFesw0CiQr
         9wfvfrj+PtwN2pjYyXknhYcW2AVyCeHYr6PpgAGf7jgBk20ahvnxUqILnQr1AmDJfCIq
         Y4z+0JR/t2lSFM0YAbKiKJe+CmsPPSS+uTLq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rhPDuGmNMwYAomzrD3mOiZZBtOii57Lmfyl6/XcrzzWIgHcxP4+x9G829Cl1Gc6iD2
         yS7UzF5GvuEpFEkgBzBSph9tabkRS65b0+hWw1q6Rp7IQg6rpD7qI6tpO4+8o97JDXwp
         QGeF9XhVkel2wzD+qaRoUjP5lW/gDCLLb7ey0=
Received: by 10.213.100.145 with SMTP id y17mr24353ebn.27.1263324798400; Tue, 
	12 Jan 2010 11:33:18 -0800 (PST)
In-Reply-To: <32541b131001121124u541de280na9184183d8704dc8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136754>

On Tue, Jan 12, 2010 at 8:24 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> really). =A0Just make a 'co' command that writes your username to
> .filename.lock and chmods the file; then write a ci command that
> checks the lockfile to make sure it's yours, deletes the lock file,
> git commits it, and chmods the file back again.

Actually -- on the same track but even better: if you are using a
unixy system, you are likely to have all the users belong to a group,
and the files are editable by the group because they are rwx by group
members.

So write your own "git-lock" command that does "chmod g-w $@";
git-unlock reenables the group-writable bit. Done.

=46or more arcane things, use ACLs. On Windows I am sure there is a
commandline tool to touch ACL bits.

hth,



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
