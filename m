From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH re-roll] Do not display 'Switched to a new branch' when
 the branch existed
Date: Wed, 18 Aug 2010 21:39:20 +0800
Message-ID: <AANLkTikHbj4zA6Kj0wUp6uQUY3w6cM_z0=Pes1jLLTky@mail.gmail.com>
References: <AANLkTimaZF1Q6BPB7CN0Wa5-Ov2ejVfPsmL34vps2VqK@mail.gmail.com>
	<AANLkTi=3z9gJdT8LL3NANFyppUjvOVcrszjf5J5zAKPe@mail.gmail.com>
	<20100818091603.GA6263@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Knittl <knittl89@googlemail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 15:39:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olira-0008C6-UJ
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab0HRNjY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 09:39:24 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55005 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab0HRNjV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 09:39:21 -0400
Received: by eyg5 with SMTP id 5so314300eyg.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+Fv6mdSoaf4g2Vhghm5eH2CSTnwojCQAbfRsB+9lE88=;
        b=IJhZznZdKtBRo0G52sPRAq0cos8L2MWnjc+47/VCjVHOiwrA6sc2xqjTIb+ChnTpSY
         znIhe5Y9yKJ7MlX1Os9P0jw9HUhyIIy2ilui1s0oVJ++4vJ6dEP+CC0x1za0AuES9Kj0
         uLih0e9dW8Qd+ojYhrHVuQHSUPoerFzADaop0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AAk5ze8jXDxNmXmt2YBCcYaSM6UWVEU72oMbVrFbF6ew7A6xKUWUoFL5hvPeBPizuQ
         VRMTcRB2lFGhlrH5IiRJwanSr6hO4nPxNw9/aRZJ3AW2dQ1d5l610v1TnxT4ImhbBs+0
         q12vq/WBZ8L6UF0GToa7R91S0sx+h3OeQXjBE=
Received: by 10.213.7.12 with SMTP id b12mr2098194ebb.76.1282138760249; Wed,
 18 Aug 2010 06:39:20 -0700 (PDT)
Received: by 10.213.22.134 with HTTP; Wed, 18 Aug 2010 06:39:20 -0700 (PDT)
In-Reply-To: <20100818091603.GA6263@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153847>

Hi,

On Wed, Aug 18, 2010 at 5:16 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,

Johnathan, thanks for the heads up.

> [snip]
>
> The "From " line and so on output by "git format-patch" are for your
> mailer. =A0Clarifying From:, Date:, and Subject: lines at the start o=
f
> your message are allowed, though, and can be useful when forwarding
> patches from someone else.

Knittl, I wonder how you generated this patch? Were you working on top
of the "bad" commit?

>> +++ b/builtin/checkout.c
>> @@ -536,7 +536,9 @@ static void update_refs_for_switch(struct
>> checkout_opts *opts,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 new->name);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(=
stderr, "Switched to%s branch '%s'\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 opts->branch_exists ? " and reset" : " a new",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 opts->branch_exists
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 ? " and reset"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 : opts->new_branch ? " a new" : "",

Strange - I thought I had this sorted out. Thanks for spotting this.

> Maybe it would be clearer to write
>
> =A0 =A0 =A0 =A0opts->new_branch ? " a new"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: opts->branch_exists ? " and reset"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: "",
>
> to emphasize that this is a list of condition/result pairs?

We could do with some parentheses - here's my take:

	fprintf(stderr, "Switched to%s branch '%s'\n",
		(opts->branch_exists ? " and reset" :
			(opts->new_branch ? " a new" : "")),
		new->name);

--=20
Cheers,
Ray Chuan
