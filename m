From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Stack overflow at write_one()
Date: Sat, 19 Nov 2011 18:00:31 -0800
Message-ID: <CAJo=hJtBKmf_yuJDXoKPA7OXrXhaZtm+P6rQx1376dngAmQNiA@mail.gmail.com>
References: <4EC81131.2010704@cesarb.net> <7vty5zizwn.fsf@alter.siamese.dyndns.org>
 <4EC823A0.3010603@cesarb.net> <CAJo=hJv2aGEFcMjTPxJsyLerqUn3w3hc3hWnc1ScaDrSGihzyQ@mail.gmail.com>
 <4EC8437C.6000808@cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Cesar Eduardo Barros <cesarb@cesarb.net>
X-From: git-owner@vger.kernel.org Sun Nov 20 03:01:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRwiK-0007jr-4q
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 03:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab1KTCAy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Nov 2011 21:00:54 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39212 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab1KTCAx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2011 21:00:53 -0500
Received: by ggnr5 with SMTP id r5so1314907ggn.19
        for <git@vger.kernel.org>; Sat, 19 Nov 2011 18:00:53 -0800 (PST)
Received: by 10.236.128.226 with SMTP id f62mr12590350yhi.104.1321754453130;
 Sat, 19 Nov 2011 18:00:53 -0800 (PST)
Received: by 10.147.167.10 with HTTP; Sat, 19 Nov 2011 18:00:31 -0800 (PST)
In-Reply-To: <4EC8437C.6000808@cesarb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185714>

On Sat, Nov 19, 2011 at 16:02, Cesar Eduardo Barros <cesarb@cesarb.net>=
 wrote:
> Em 19-11-2011 21:30, Shawn Pearce escreveu:
>>
>> On Sat, Nov 19, 2011 at 13:46, Cesar Eduardo Barros<cesarb@cesarb.ne=
t>
>> =A0wrote:
>>>
>>> Em 19-11-2011 19:08, Junio C Hamano escreveu:
>>>>
>>>> Already found the real cause (jGit bug) and workaround posted, I t=
hink.
>>>
>>> I presume the cause then is what was fixed by
>>>
>>> http://egit.eclipse.org/w/?p=3Djgit.git;a=3Dcommit;h=3D2fbf296fda20=
5446eac11a13abd4fcdb182f28d9
>>> ?
>>
>> Yes. The AOSP servers were all updated with the above JGit patch, so
>> the servers are no longer sending duplicate objects. But yes, for a
>> period of time there were duplicates in the kernel repositories,
>> particularly kernal/omap.
>
> So, would an alternative workaround in my situation be to delete
> kernel/omap.git and let repo sync recreate it? It seems repo does not=
 have
> extra metadata anywhere else, so just removing the directory should b=
e
> enough for it to clone again from scratch, hopefully getting a correc=
ted
> pack from the server.

Yes. repo does not have extra state, so just removing the directory
and running `repo sync` again to clone the repository would correct
the local repository.
