From: "Ron Eggler" <ron.eggler@gmail.com>
Subject: RE: Copy branch into master
Date: Mon, 28 Nov 2011 11:08:33 -0800
Message-ID: <3655DADD9B52450B81B0CD34F1B0FAB6@bny.us.bosch.com>
References: <CAHxBh_T-f7O4r0zn=NtLTYtdbNqd3qSo2tW84aYRJp7ugDSMpw@mail.gmail.com> <20111128183616.GB29503@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Andrew Eikum'" <aeikum@codeweavers.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 20:08:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV6ZM-0002EK-Cf
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 20:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702Ab1K1TIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 14:08:42 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57452 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211Ab1K1TIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 14:08:41 -0500
Received: by qyk4 with SMTP id 4so1150931qyk.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 11:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:references:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding:x-mailer:in-reply-to
         :thread-index:x-mimeole;
        bh=iX7tOTqge0o7FzU4oeOR2c26LTOIVfhhoUIk5EGAatA=;
        b=hqH7Qqe030TDMkvb0AgZE5A/Wh7B4Dn6X+xPBwhDyhu+92nBUR3uhL6NHXYBcRUAhS
         zIBRdmrtFJyM+n2Bh8GP7FBjjX+gsDyN6misHeC/+H1+AIw2OY9AY4vL2ndzrjG3BEcS
         b67j/XmmCjQb3IGZsZdcHqpYFZAL4XvL8yOBI=
Received: by 10.229.217.85 with SMTP id hl21mr1228111qcb.20.1322507320847;
        Mon, 28 Nov 2011 11:08:40 -0800 (PST)
Received: from BNY2F87AE (exchange.extremecctv.com. [208.181.49.113])
        by mx.google.com with ESMTPS id bw9sm34856306qab.18.2011.11.28.11.08.35
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Nov 2011 11:08:38 -0800 (PST)
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20111128183616.GB29503@foghorn.codeweavers.com>
Thread-Index: Acyt/KBShYuoOr+jSpeBWrXfMVxfQQAA/WiQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186027>

Thanks for that,

I guess I'd go for renaming DVT to master.

However, I also played around with merge a little, started a merge (in
Windows GUI) and aborted it but the icon of my directory keeps showing the
ywellow exclemation mark, signing that a merge is going on right now but
going into the directory, all the files are with a geen check mark. What's
going on here? How do I resolve this - I don't wanna mess things up so I
might rather resolve this before moving DVT to master.

Thanks,
Ron

-----Original Message-----
From: Andrew Eikum [mailto:aeikum@codeweavers.com] 
Sent: Monday, November 28, 2011 10:36 AM
To: Ron Eggler
Cc: git@vger.kernel.org
Subject: Re: Copy branch into master

On Mon, Nov 28, 2011 at 10:25:33AM -0800, Ron Eggler wrote:
> Some time ago I created a DVT branch in my project and I have almost been
> exclusively working in it. Now the time for some test deployment came and
I
> didn't have time to merge it all back into the master thus I gave out the
> DVT branch version. Now I would like to copy exactly what I have in that
> branch back into my master to have an exact copy in my master of what got
> deployed with out any changes.
> How can I do this?

Couple options, depending on what you want:

Rename DVT to master (similar to 'mv DVT master', including
losing the contents of 'master'):
$ git checkout --detach HEAD
$ git branch -M DVT master
$ git checkout master

Retain old master (like 'mv master old_master; mv DVT master'):
$ git checkout --detach HEAD
$ git branch -m master old_master
$ git branch -m DVT master
$ git checkout master

The "checkout --detach" is just so Git doesn't complain about
moving/deleting the currently checked out branch.

If you haven't yet, be sure to read ProGit, which should make
questions like this trivial for you to answer yourself in the future:
<http://progit.org/book/>

Hope this helps,
Andrew
