From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 10/18] revert: Save data for continuing after conflict resolution
Date: Fri, 29 Jul 2011 01:48:51 +0530
Message-ID: <CALkWK0=GY_MqbA6vofGJDkpG1YFs41mzqpB-8jitkt3gZjb4wg@mail.gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
 <1311871951-3497-11-git-send-email-artagnon@gmail.com> <20110728174519.GB29866@elie.dc0b.debconf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 22:19:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmX38-0005FE-5V
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 22:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953Ab1G1UTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 16:19:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52146 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797Ab1G1UTM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 16:19:12 -0400
Received: by wyg8 with SMTP id 8so414319wyg.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 13:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2TeTgGLACad9yXqgk8UKLjOMZAElmqEQfvxGE7R7g7c=;
        b=i5fgPiE6/biyGsuzoAuTeVMM8Hbi/dDA60j30453ggzzrnclDK4AeMCMILI8yEVmAY
         yyvZgRR1Wk1rIYy2fRFkQl9dlMN0hGzizMyAu/yIizAB/KszsF6dDcsm1WR0L9d0HQMR
         mw9zZ70ERhenEhqildNJLj3UUld4C4ysD9/xY=
Received: by 10.227.5.199 with SMTP id 7mr518643wbw.64.1311884351107; Thu, 28
 Jul 2011 13:19:11 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 28 Jul 2011 13:18:51 -0700 (PDT)
In-Reply-To: <20110728174519.GB29866@elie.dc0b.debconf.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178114>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> That these two files alone are not enough to implement a "--continue=
"
>> that remembers the command-line options specified; later patches in
>> the series save them too.
>
> Micronit: I think this sentence has an extra "That".

Ugh.  Fixed.

>> +pristine_detach () {
>> + =C2=A0 =C2=A0 git checkout -f "$1^0" &&
>> + =C2=A0 =C2=A0 git read-tree -u --reset HEAD &&
>> + =C2=A0 =C2=A0 git clean -d -f -f -q -x
>> +}
>
> Nit: probably best to include the "rm -rf .git/sequencer" in this
> function. =C2=A0But I don't think that should hold up the patch.

Ah, good idea.  Fixed.

Thanks.

-- Ram
