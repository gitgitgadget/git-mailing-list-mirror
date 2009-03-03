From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH] doc: clarify how -S works
Date: Tue, 3 Mar 2009 17:39:38 +0000
Message-ID: <43d8ce650903030939u73f09171uf4041b6d9824b698@mail.gmail.com>
References: <49AD3E78.1050706@sneakemail.com>
	 <20090303152333.GB24593@coredump.intra.peff.net>
	 <20090303154041.GA31265@coredump.intra.peff.net>
	 <7v1vted0d7.fsf@gitster.siamese.dyndns.org>
	 <20090303171138.GA454@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 18:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeYc8-0003AW-PA
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 18:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbZCCRjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 12:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbZCCRjk
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 12:39:40 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:52361 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbZCCRjk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 12:39:40 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3414019wfa.4
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 09:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4ViXsUP5yr6P1YO8taAHi5pUVRVwUw+blEtKPEHDMMk=;
        b=IHnI97Fle3w022EDA8hKvWXXoe4n7HkkAH+sl6i2D8fh+gscna2SFdSfLGwjfq5S+U
         /tjV67To5VKwve+Zy/mnZBYfWOqZJfmg2a3JHdhV1G0O1iYaIO1KE9EwBC4Dp5wU4hHE
         ti3IKwCxBJkPvvQhVRBaX8GMZtodDb22Tgh2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=igZUrCeJDf8DFqBBINYjHGY5BaGacMbYUdmvO6EKYzKvHML1kfwwdsbwAr+e5wgp8j
         MSvpvEO1bIdK9gxEbXEHimIVFs1NDU7XA6Umo4wjOLqgTqlnfqOXUrwpOZuoeJNh+WCM
         QxbaCh5y1sXy4ZCWnXqivppwsmyCA/YNhXHpg=
Received: by 10.142.238.4 with SMTP id l4mr3715971wfh.98.1236101978161; Tue, 
	03 Mar 2009 09:39:38 -0800 (PST)
In-Reply-To: <20090303171138.GA454@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112133>

2009/3/3 Jeff King <peff@peff.net>:
> On Tue, Mar 03, 2009 at 08:42:12AM -0800, Junio C Hamano wrote:
>
>> In retrospect, because --pickaxe was designed primarily for Porcelai=
n use,
>> it was a mistake for it to have taken a short-and-sweet -S synonym.
>
> Hmm. I actually like the pickaxe behavior and find it useful for
> searching. IOW, I consider it a porcelain feature, just perhaps not t=
he
> one that some people are expecting.
>
>> > =C2=A0-S<string>::
>> > - =C2=A0 Look for differences that contain the change in <string>.
>> > + =C2=A0 Look for differences that introduce or remove an instance=
 of
>> > + =C2=A0 <string>. Note that this is different than the string sim=
ply
>> > + =C2=A0 appearing in diff output; see the 'pickaxe' entry in
>> > + =C2=A0 linkgit:gitdiffcore[7] for more details.
>>
>> Look for differences that change the number of occurrences of <strin=
g>?
>
> Yes, that is technically correct. I was trying to find a wording that
> was a little less "this is literally what it does" and more "this is
> what you might find it useful for".

Is there any way to have an option to also match any line containing
the string?  That might be the best way to document it, as well as
being very useful:

-s<string>
   Look for any additions, removals or changes in any line containing <=
string>
-S<string>
   Look only for any additions or removals of the <string> in any line

John
