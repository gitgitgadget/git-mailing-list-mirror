From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Thu, 18 Mar 2010 13:33:18 -0400
Message-ID: <32541b131003181033p7916d92frc1269b95c292e3db@mail.gmail.com>
References: <4B67227A.7030908@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> 
	<4B8B9BF1.10408@web.de> <4b8bf32f.0706c00a.26cb.691d@mx.google.com> 
	<4BA104C7.5020207@web.de> <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com> 
	<7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA1FC39.10300@web.de> 
	<32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com> 
	<b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 18:33:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsJbL-0001c8-Rx
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 18:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120Ab0CRRdj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 13:33:39 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:35609 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab0CRRdi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 13:33:38 -0400
Received: by yxe12 with SMTP id 12so209918yxe.33
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6waIyEvubYrZWNtHT359gjd1Yu8s4j+/Oc7bo5G28xk=;
        b=LteAGCq4lkWzqrpcrmKsnvOHrHYY7aKYtSbDzT3KNDUNwDrjqFDG79v/N28VC0/sc0
         8kgzKqv/FBhC1eZTVSYfSHAVeK2rlaSNt+m0KS7rQ3EZ+gel3T1gALjenWLHXC3Tdmpt
         JLdqZzKN4qIqU/4d8UgwfB4ZJK8K02Goa7g5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wGGcH4BGI39iydS3oKAUvRMhUqi+hPIxK+Di6/Gl0p3P7lgk+xyrIvVLKsUHPcvO0G
         detGywQyw2GftoaIlnXV10p4dayPkZIn/VBnq+XDU9z0P2jTiB/AyZpBM0QHzOV4BKKY
         dJv8DMPYqA2nBr5xvuDeinSd9/hqylVps/cgI=
Received: by 10.151.86.14 with SMTP id o14mr1855847ybl.43.1268933618090; Thu, 
	18 Mar 2010 10:33:38 -0700 (PDT)
In-Reply-To: <b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142484>

On Thu, Mar 18, 2010 at 1:19 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> On Thu, Mar 18, 2010 at 11:36, Avery Pennarun <apenwarr@gmail.com> wr=
ote
>> stashing isn't really something you'd want to do on a per-branch
>> basis. =A0Most of the point is that you stash away your changes, the=
n
>> switch to another branch, then restore your stash to your *current*
>> working state sometime later.
>
> As you may know, "git checkout" carries local modifications to the ne=
w
> working tree if there are no conflicts, so no explicit stash usage is
> necessary in many cases.

I'm almost never lucky enough that switching branches won't touch the
same files as the ones I've been editing (especially Makefile).  I
imagine this works better with larger repositories like the Linux
kernel.  But my fingers have learned that if I do 'git stash' it
always works, while if I don't it doesn't always work, so I stash
without thinking nowadays.

The other big advantage of using stash is that your half-done files
end up in the repo, so if you later screw up by doing something
idiotic like 'git reset --hard' at the wrong time, you can still get
it back.  I love that feeling of safety.

> Anyway, I think it would be useful to be able to manage multiple
> stashes rather than having to rely on just one global stash. However,
> I imagine than explicit Work In Progress (WIP) commits as sketched
> above would go a long way in keeping histories and workflows clean an=
d
> organized.

The stash can contain multiple entries.  They're stored in a stack,
but you can pull prior entries out of the stack if you want.
Personally, I don't need anything more.

Have fun,

Avery
