From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git-archive and tar options
Date: Mon, 18 Jul 2011 19:12:45 -0500
Message-ID: <4E24CBFD.9090909@gmail.com>
References: <ivla29$liu$1@dough.gmane.org> <20110714015656.GA20136@sigill.intra.peff.net> <4E1F2468.6080409@lsrfire.ath.cx> <20110714172718.GA21341@sigill.intra.peff.net> <4E2477E1.5090406@gmail.com> <4E249C94.3040002@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Neal Kreitzinger <neal@rsss.com>,
	git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jul 19 02:12:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qixvj-0005EF-4u
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 02:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab1GSAMu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 20:12:50 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38509 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab1GSAMu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 20:12:50 -0400
Received: by gxk21 with SMTP id 21so1551886gxk.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 17:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iOdQgbGKdhYT6X9LXAWnrL6iILm7VPz8BaUVqRaoEYM=;
        b=N4JrGxT6YEMA1pe7lJezKlBV/kshr5yKC71uZcNLR3rVk5LLPq1jwA9JJaXY35dZ3S
         d2WdWvi/n++4Z0nC2sOKpsmsUtgpQyJBAI60dRXMeq+47WuN8eqf6ytMkdxau4gNEC+b
         YMoNVfUKhW+3RMJdK7eCorPRdEoLoHCjj1+VM=
Received: by 10.150.169.21 with SMTP id r21mr6038921ybe.60.1311034369383;
        Mon, 18 Jul 2011 17:12:49 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id y9sm2087279ybf.3.2011.07.18.17.12.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 17:12:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4E249C94.3040002@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177432>

On 7/18/2011 3:50 PM, Ren=C3=A9 Scharfe wrote:
> Am 18.07.2011 20:13, schrieb Neal Kreitzinger:
>> HEAD:$subdir worked on my bare repo.  I ran it for each transformant
>> pathspec and then combined the archives with tar --catenate:
>>
>> # git archive --format=3Dtar --prefix=3DmyWeb/myRoot/myAPP/Templates=
/
>> HEAD:WebPortal/Templates/>myAPP.myTag.tar
>> # git archive --format=3Dtar --prefix=3Dopt/mySTUFF/v01/SCRIPTS/
>> HEAD:SCRIPTS/>SCRIPTS.tar
>> # tar --file=3DmyAPP.myTag.tar -A SCRIPTS.tar
>>
>> However, the permissions also need to change to 777 and tar --mode w=
ould
>> not effect this in combination with --catenation or -x.  Is there a =
way
>> I can change the permissions without having to untar->chmod->retar, =
and
>> without having to use a non-bare repo as an intermediary?
>
> You can use the configuration setting tar.umask to affect the
> permissions of the archive entries.  Set it to 0 to pass the permissi=
on
> bits from the repo unchanged.
>
The permissions in my repo are 775 and 664 and I want to change them to=
 777.

-neal
