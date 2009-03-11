From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: setting up tracking on push
Date: Tue, 10 Mar 2009 21:52:44 -0400
Message-ID: <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
	 <76718490903052049k217e9c12gb7881f8904fdd9d@mail.gmail.com>
	 <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de>
	 <buoy6vi297q.fsf@dhlpc061.dev.necel.com>
	 <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
	 <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com>
	 <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com>
	 <20090310230939.GB14083@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 02:54:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhDeB-0006zz-PK
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 02:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbZCKBws convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 21:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753610AbZCKBwr
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 21:52:47 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:59371 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbZCKBwq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 21:52:46 -0400
Received: by rv-out-0506.google.com with SMTP id g37so2496779rvb.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 18:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ySTV7mZ/4OZItTC5jDbaWyc3yB85SNEUZVykBjrUygY=;
        b=PanJ+pZ2vrEg/kqzIcU83fogSV9/6WwH3yDfSp7jgLhNCkF35wAaAHw4Y4xIwpCOyk
         Y2/gWb9fb7tjOV45rW8d4jAVN48+qXzcRuu9/1o65a6PY7pg/2eDbAFWWbbDPYPaTep3
         RvWX8XnyeN3QmF11+nCzEzK5kgaS6hpP9w0U8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kPFArt01X0D0zQ0Xd2Lyo1QA2YU+B+oyVUs1FL4gCOhn5LeTdTi3Auy4hdEujCk1QP
         GtpKjXBQaALpXgT7BG/8+sLq1GkCW3oE/RnQzazPYYwxMGPjko7IqvVgshpww6vEdWPU
         2h6GWShVYNBPeos8Z3/b+scZ6eTEMb3Xfb78Q=
Received: by 10.141.88.3 with SMTP id q3mr4071882rvl.125.1236736364571; Tue, 
	10 Mar 2009 18:52:44 -0700 (PDT)
In-Reply-To: <20090310230939.GB14083@sigio.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112866>

On Tue, Mar 10, 2009 at 7:09 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 10, 2009 at 04:26:03PM -0400, Marc Branchaud wrote:
>
>> It would be good if the branch command allowed modification of a
>> branch's properties. =C2=A0At the very least, branch-creation comman=
ds like
>> "git branch --track foobranch origin/master" could offer to modify i=
f
>> the branch already exists, instead of just quitting.
>
> I agree that it would be nice if an interface could be made around
> "branch --track". However, the problem with
>
> =C2=A0git branch --track foobranch origin/master
>
> is that it does two things: it sets up tracking, and it resets the
> foobranch ref. Right now we complain if foobranch already exists. We
> have a "-f" to override. But what you want to say is "set foobranch t=
o
> track origin/master, but _don't_ actually reset where it points". And=
 I
> don't see an intuitive way of doing that with that syntax. If you don=
't
> require "-f", then you are silently ignoring half of what the user as=
ked
> you to do.

Maybe a new switch, say -u for update:

-u --track [<branch>] <upstream>

Update tracking information for an existing branch. <branch> is
optional and defaults to the current branch. <upstream> is the branch
you wish to track, e.g. origin/master; normally <upstream> is a remote
tracking branch, but specifying a local branch is valid as well.

-u --no-track [<branch>]

Remove tracking information for an existing branch. <branch> is
optional and defaults to the current branch.

j.
