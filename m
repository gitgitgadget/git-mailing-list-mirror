From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] git-branch: display "was sha1" on branch deletion rather 
	than just "sha1"
Date: Sun, 22 Mar 2009 10:11:43 -0500
Message-ID: <ee63ef30903220811m69c45e9cna0af52a3b5a851fe@mail.gmail.com>
References: <ee63ef30903211709s24f8294dq9ea52bcae72b755a@mail.gmail.com>
	 <20090322061320.GB14765@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 22 16:13:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlPMS-0007KP-0s
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 16:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbZCVPLq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 11:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbZCVPLq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 11:11:46 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:55404 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbZCVPLp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 11:11:45 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1771037yxl.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wOUPIFxKF8ffe+WHRVKEl0zRU4T4JkSN6YBMBMxWu50=;
        b=SHzbvtM1EQ9RgT+9d9IglKxmjtu/JoGb3WlsXpaGXi2R6Uu/09Z8gay1fKWfu3aiY/
         kt8yfW7F94nPhLmtWoeCfs2sYzO69uJ4WFDAQj+OL2muOGEcgQHViAznjMPQifT7flO2
         +V5YmFuJuvqViegDSKXKu6Sl/b88oZGoxhwX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hdWRCphcHTb53baVLGfHb2OfUTi4mAQWououQcWobuzJIXVtV5KH6Oh8B9N4MltA4w
         oGEg4x9LDJPHCwPg3Hoz0aq0Sf0MCssY3BlIIWg8hvk2WdoBoR7HySh2oiAKJYDgaQJP
         ZpPg3T2zxbUnMkma5Mep0qVCjbz6M8SnQ2zIY=
Received: by 10.151.108.5 with SMTP id k5mr10896684ybm.194.1237734703525; Sun, 
	22 Mar 2009 08:11:43 -0700 (PDT)
In-Reply-To: <20090322061320.GB14765@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114145>

On Sun, Mar 22, 2009 at 1:13 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 21, 2009 at 07:09:17PM -0500, Brandon Casey wrote:
>
>> Make it more pleasant to read about a branch deletion by adding "was=
".
>> Jeff King suggested this, and I ignored it. =C2=A0He was right.
>
> Heh. While I am tempted to dance in a circle shouting "I told you so"=
, I
> actually find that after getting used to it, I do not mind the curren=
t
> output. ;)
>
> Out of curiosity, what prompted your change of heart? Did you hear fr=
om
> somebody who found it confusing, or did you just change your mind?

I just changed my mind.

My original opinion was based on the output from 'git stash drop'.  It
has the full sha1 in the message and looks like:

  $git stash drop
  Dropped refs/stash@{0} (58fa28fddd951deb782e3300b2d059f95544f6f1)

I like it. I like the full sha1.

=46or some reason, the partial sha1 in the branch delete message irrita=
ted me.

  $ git branch -d mybranch
  Deleted branch mybranch (455f59b).

I don't think it was because it was a partial sha1.  Maybe it was
because the message seemed to imply that what was referenced by the
sha1 was being deleted.  The branch is just a pointer, so deleting it
does not mean that what it pointed at was lost in any way.  I think
adding "was" makes it seem more like a pointer to me.  Or maybe it has
something to do with my mother, any psychology majors in the audience?
:)

-brandon
