From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Interest in locking mechanism?
Date: Tue, 12 Jan 2010 15:25:18 -0500
Message-ID: <32541b131001121225y3929d6cao437297f4f233f4e@mail.gmail.com>
References: <1263319565-sup-1767@ezyang> <32541b131001121101i76ad8062p3a7f3571ad86b0ce@mail.gmail.com> 
	<1263323292-sup-4182@ezyang> <32541b131001121124u541de280na9184183d8704dc8@mail.gmail.com> 
	<46a038f91001121133r62b3d748n38ca27234f18e960@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Edward Z. Yang" <ezyang@mit.edu>, git <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 21:25:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUnJ9-0007VK-Qz
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 21:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab0ALUZj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jan 2010 15:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754630Ab0ALUZj
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 15:25:39 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:35390 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab0ALUZi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2010 15:25:38 -0500
Received: by ywh6 with SMTP id 6so22822959ywh.4
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 12:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jnz3rfmZG6R5vCbg/wLbCGoo+tuIKeR9fEFhd+zejJQ=;
        b=frlPvpvNLMM0Suw2aoZcnb4ClZ07m8YtXpB8PZ7s3YHzp7VZ3i6zDfAp25rLa2bK2q
         4ZW8mrkxtE23hDrQXSoz4DcFMP7XCZSPNc+UXXH3rybq5JYvPT41bvnfrtBYUZQKGjdu
         Eph8zXVyKQdNl/HvwpCm5tmFNW2eDXff1/Hzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ae501bpt0wew7g/GAXVqukfQGG42y2tSwh8rQIxwpKBawxGmK16GmzHOPZBxlpoQE7
         IqDh8VtYl8aiAAojqnUFzmi0W0Cdn74AZIjegmnE2EVa6pTZA8H36jKpxG7AiE32J3fK
         QbFnBv/xWk5F1EXvFxZ5K6UatYpa7yFdiJ09s=
Received: by 10.150.174.36 with SMTP id w36mr6820214ybe.144.1263327938238; 
	Tue, 12 Jan 2010 12:25:38 -0800 (PST)
In-Reply-To: <46a038f91001121133r62b3d748n38ca27234f18e960@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136757>

On Tue, Jan 12, 2010 at 2:33 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Tue, Jan 12, 2010 at 8:24 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> really). =A0Just make a 'co' command that writes your username to
>> .filename.lock and chmods the file; then write a ci command that
>> checks the lockfile to make sure it's yours, deletes the lock file,
>> git commits it, and chmods the file back again.
>
> Actually -- on the same track but even better: if you are using a
> unixy system, you are likely to have all the users belong to a group,
> and the files are editable by the group because they are rwx by group
> members.
>
> So write your own "git-lock" command that does "chmod g-w $@";
> git-unlock reenables the group-writable bit. Done.

The trick is to track which user has the file checked out; you don't
want some random person to (accidentally) check in someone else's
file.  That's the whole point.  Of course, you can arrange for this
with some simple shell scripting.

I doubt ACLs are needed really.  RCS certainly works(1) fine without th=
em.

Have fun,

Avery

(1) depending on your definition of "works"
