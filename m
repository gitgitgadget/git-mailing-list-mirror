From: Frank Li <lznuaa@gmail.com>
Subject: Re: http getpass function in msysgit
Date: Thu, 4 Feb 2010 09:56:57 +0800
Message-ID: <1976ea661002031756j2c2699b0hf7deb8febdce841b@mail.gmail.com>
References: <1976ea661002021918m19d9b37fx1872557d3c810e3a@mail.gmail.com>
	 <7vpr4mrijt.fsf@alter.siamese.dyndns.org>
	 <1976ea661002022148s544be10bie912295e04189864@mail.gmail.com>
	 <7vaavp3i2n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 02:57:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncqxr-0003YQ-Kp
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 02:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283Ab0BDB47 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 20:56:59 -0500
Received: from mail-gx0-f228.google.com ([209.85.217.228]:42681 "EHLO
	mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532Ab0BDB46 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 20:56:58 -0500
Received: by gxk28 with SMTP id 28so1922380gxk.9
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 17:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eTP+de5Bag7F8OMPzTlx1M6FneDKLuh7EGu1MYdRGVs=;
        b=QhDlllsMXhNu6dnlkhy7+28M/L+kBL8qIFgEFKQqMhKNAAusLqXi8Z2mbWUdokJnRo
         1Egki+4tirm8mO8XRJODNZS/5bp2YUw9yyHnLIT1QXjnJVQ2TECBwJ1A1dZbItKe+dWV
         VCs5jXf9mV++4PCTsiAcLswkx8mqdlO/xiN98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r2zpHlRyU2lChfatl/DUbVG0QK3+p6x75c1fPDuYHv8vpv2htN1MQbUy8Y1gBFH19d
         jsDSSSEnRHOPxwmPDpPIPpAXgFk2kGUMQ3Sjrkje50dhimm2PpNTF1RVyym9np1C5Obp
         QJW5MweRk6VpVK1QZqypTL1+rKKLsSSYEUy34=
Received: by 10.150.118.11 with SMTP id q11mr1082756ybc.40.1265248617606; Wed, 
	03 Feb 2010 17:56:57 -0800 (PST)
In-Reply-To: <7vaavp3i2n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138930>

>
> =A0- If GIT_ASKPASS is not set:
>
> =A0 - If SSH_ASKPASS is present, then use that from getpass() for any=
 and
> =A0 =A0 all places that would want to get "password" like things;
>
> =A0 - Otherwise consult the terminal as before;
>
> =A0- If GIT_ASKPASS is set:
>
> =A0 - If SSH_ASKPASS is not set, then export the value of GIT_ASKPASS=
 as
> =A0 =A0 such as well, so that whenever we spawn "ssh", the same GIT_A=
SKPASS
> =A0 =A0 program will be used as a fallback.
>
> That way, if the user already has set up SSH_ASKPASS, we will use the=
 same
> familiar dialog without forcing the user do anything extra. =A0If the=
 user
> only sets GIT_ASKPASS without doing SSH_ASKPASS, we would also use it=
 to
> drive the ssh session. =A0In either case, the user doesn't need to wo=
rry
> about multiple configuration or dialog interface.
>
>> It is nice to use one dialog for all cases. git-svn also have the sa=
me problem.
>

Can we direct use SSH_ASKPASS for all getpass and don't use GIT_ASKPASS=
 at all?
The logic will be come simple.
