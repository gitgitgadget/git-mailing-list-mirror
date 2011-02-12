From: Julian Ibarz <julian.ibarz@gmail.com>
Subject: Re: Re: Re: Updating a submodule with a compatible version from
 another submodule version using the parent meta-repository
Date: Sat, 12 Feb 2011 15:32:43 -0500
Message-ID: <AANLkTimist_GXgRGdUW1PpxpRO=poYgD4HkDC5CsyLra@mail.gmail.com>
References: <4D407099.4010805@web.de>
	<AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com>
	<4D407875.7080607@web.de>
	<AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com>
	<7v7hdrl7nw.fsf@alter.siamese.dyndns.org>
	<AANLkTik8VrhbBSLwRq9gd39hofnmifk15zSqXVTsSzAp@mail.gmail.com>
	<7v1v3zjp6w.fsf@alter.siamese.dyndns.org>
	<20110129110807.GA21864@book.hvoigt.net>
	<AANLkTimBCeSnR270eWMcrgCVj6rmiRkJizOxQPAPOAnn@mail.gmail.com>
	<AANLkTim2G0kF+omPZ1_fk0P6oGDaKDWd79XNR5GXUkWG@mail.gmail.com>
	<20110209193610.GA67890@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Feb 12 21:32:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoM9C-0002fF-7b
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 21:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642Ab1BLUcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 15:32:45 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61633 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab1BLUco (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 15:32:44 -0500
Received: by iyj8 with SMTP id 8so3547587iyj.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 12:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wzviqwZrk7Fla8oqkPnc4Pgv4NIE3tnECGr23qk3N7Y=;
        b=I3ezznEDONtfNzXlPeR6NZej9RI8m7A9DhxsofHqElQWjiWoQAP+PQGpd4qjs79QB5
         ep2iXYtWkk3nBrF2c/W1fiWot1ERvAlzpa1zobPZS6rUGgd5sSPyMNJMOxPx4Wup6M/B
         GqrQPeFpQwetqrIHlsWIowTJ4SEWqmK7ARD1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FTumql6JKlXhuVOmbeW6IDUqhj1CBSeBN2KcIiDJoorBQTKqihpb2lMHaW+uKcHPb3
         BlOzonWUv1on1scNzUkdZ8HxCd7GtOUrwjfA/bUmLBQy74+uBdNj9O2pnVrmrFsOu39g
         5XdDH63HNJ7ZJdZ44wrc2ird9ZfoCh3iSD0lY=
Received: by 10.42.1.199 with SMTP id 7mr2534511ich.490.1297542763281; Sat, 12
 Feb 2011 12:32:43 -0800 (PST)
Received: by 10.42.222.10 with HTTP; Sat, 12 Feb 2011 12:32:43 -0800 (PST)
In-Reply-To: <20110209193610.GA67890@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166621>

Hi Heiko,

Thanks for all your feedbacks. Before your first mail I had already
implemented command 1 you are talking about and almost finished
command 2. Today I could spend some time again on this side project
and I have finished command 2. Here is what you do:

git submodulecheckout --find-versions <submodule> > <some_temp_file>
cd <submodule>
git submodulecheckout --find-closest < <some_temp_file>

This will output the version you need to checkout in the meta
repository. I don't handle the case where there is multiple solutions
but it is a good start I think. I think with this you can already
start the integration in the submodule bash script to make it
recursive and be more user-friendly? Are you still interested Heiko?

I have pushed this to my repository so you can check it out if you want.

Both commands have a suboptimal implementation but it can be improved
without changing the current API so I think it is a minor issue. I
will probably try this at work today on msysgit. Currently I am  doing
this at home on my linux using some open source meta-repository, if
you have a big one to try this feature let me know (I am currently
using git://git.assembla.com/luadocsuperforest.git and it is not that
big).

Best regards,

Julian Ibarz

On Wed, Feb 9, 2011 at 2:36 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Hi Julian,
>
> On Wed, Feb 02, 2011 at 11:31:40PM -0500, Julian Ibarz wrote:
>> So now my two questions that could save me some time are:
>> - is there a function that gives the distance between two commits? I'm
>> sure there is something like this coded somewhere but I didn't find it
>> yet
>
> One thing which now came to my mind is that you might be interested in
> is to use merge bases to find the earliest commit that contains a
> certain revision.
>
> Have a look at how I implemented the submodule merge strategy that might
> help you. You can find it in commit 68d03e4a. I basically do a search
> for the earliest commit that contains the commits from both sides. You
> could use a similar strategy but limit the possible candidates to a
> restricted list of commits which are contained in the supermodule.
>
> Cheers Heiko
>
