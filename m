From: =?ISO-8859-1?Q?Dirk_H=F6rner?= <dirker@gmail.com>
Subject: Re: [PATCH v2] git-cvsimport: add support for cvs pserver password 
	scrambling.
Date: Fri, 14 Aug 2009 11:46:19 +0200
Message-ID: <4da546dc0908140246i35b28052wd7b7790d191a9984@mail.gmail.com>
References: <1250233111-19188-1-git-send-email-dirker@gmail.com> 
	<7vskfusvpq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 11:46:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbtN2-0003qh-HS
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 11:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbZHNJqk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 05:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbZHNJqj
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 05:46:39 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:59955 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbZHNJqj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 05:46:39 -0400
Received: by ewy10 with SMTP id 10so1379425ewy.37
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zecbgXv2VR8b5mlcNFAchpor2D3D5wp9lTG9WzOsRKQ=;
        b=gLPQqF/Q3KguSRt1wOg6T1SjcSBsmM2zCJUP+B1PRr+Q4vutRW/sJmVkqwQUYSzUj2
         GS45oN5ih7G9mS21yuIO7NgMxIEKWI70PUi1JUnd5WCBqdf7yYZiTwS0q+FZNGgJljsu
         qSqD98AVTy1AEjPhMeydiz6mg74PAKBzj4hW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=szasQDybJ6Ei5E6AAK1wj9oaqpH6Bt4mby8Y/AJLwdYqNdnDOg6dPqU5uyjXAUGXKC
         +D+JIceb4yRaGuQehth0dgpPhSCGBo7mNRstiLpyEQHi70ejLhKahdC3fVO9Gh7oJJ0/
         eOvKlm+jpu+9PVFbOpPMJ69ZMdAGNA7y4KqdE=
Received: by 10.210.70.8 with SMTP id s8mr604943eba.69.1250243199093; Fri, 14 
	Aug 2009 02:46:39 -0700 (PDT)
In-Reply-To: <7vskfusvpq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125922>

Hi Junio,

On Fri, Aug 14, 2009 at 9:25 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Thanks.
>
> While I appreciate your effort to add a test, I'd rather not apply th=
e
> test part of your patch for two reasons:
>
> =A0- It is not a test against a real cvs pserver but is a whitebox te=
st to
> =A0 verify that the program says what the program is supposed to spit=
 out
> =A0 to the network; and
>
> =A0- It still is a network test that will fail if the TCP port is occ=
upied
> =A0 for whatever reason when the test is run, which will make automat=
ed
> =A0 build and test cycle unreliable.
>
> Unfortunately, I do not see an easy way to run a real cvs pserver
> listening to a local unix domain socket under $TRASH_DIRECTORY, which
> would solve both of the above issues.
>

I agree with you, the tests are not the best. As Dscho stated in one
of the replies to the last version of this patch, the cvs pserver is
quite good to test with because it uses stdin/stdout for
communication. The main problem is git-cvsimport, which right now only
supports tcp sockets.

Ciao,
Dirk
