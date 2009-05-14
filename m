From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: check-ref-format question
Date: Thu, 14 May 2009 09:56:39 +0930
Message-ID: <93c3eada0905131726p3afe8e68j160bd3931886093d@mail.gmail.com>
References: <93c3eada0905121709k73a47bddu60def6b5fbc1b15e@mail.gmail.com>
	 <4A0AD5A2.2090103@drmicha.warpmail.net>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 14 02:26:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Omf-0000iq-2W
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 02:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbZENA0k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 20:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbZENA0k
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 20:26:40 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:58324 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbZENA0j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 20:26:39 -0400
Received: by qw-out-2122.google.com with SMTP id 5so770167qwd.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 17:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vI+M/1OLSO05Kg6z1opdQi1oovCIpjoY1H51DaK3MCg=;
        b=TW3CdGIUKLXN++YtS6D8+Z4zgsHmEuMPY3Hs2vviueNNF4lCwurartr2a6GTenrn7F
         I1ygPs0EZ6b//5hkQZlRNtj4DutauD+YCJibIv9Zv4jmjFE92fbq8OFUawAW14fz00w3
         Naooi2/5+hegL4iYC8lHjdau3kQmEVQMB/q0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=IbdcEH1dB24VijLa8xpfZTzXFO+vsMqbEexQlwCS6Ywrior8VJbRNyhCXsln6mP26a
         A7YvGjXeWxe0mLGLOEwCi6RBbDBXKWhucB81TGIg9kt9XFHVf20Jda1d7rFwy04sL0W7
         rMubnUMHGYSo3u4/x38TBDf7qd/QqIrbAWGDA=
Received: by 10.220.75.5 with SMTP id w5mr2218598vcj.6.1242260799758; Wed, 13 
	May 2009 17:26:39 -0700 (PDT)
In-Reply-To: <4A0AD5A2.2090103@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119120>

On Wed, May 13, 2009 at 11:43 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Geoff Russell venit, vidit, dixit 13.05.2009 02:09:
>> 1 $ git --version
>> git version 1.6.2.3
>> 2 $ git check-ref-format xxxx && echo OK
>> 3 $ git-check-ref-format --branch xxxx && echo OK
>> xxxx
>> OK
>> 4 $ git check-ref-format --branch xxxx && echo OK
>> usage: git check-ref-format refname
>>
>>
>> 2 seems wrong,
>> I tried 3 after looking at =A0builtin-check-ref-format.c
>> I couldn't find any test cases in the git/t directory
>>
>> From the documenation, I expect "git check-ref-format xxx" to return=
 0 if xxx is
>> a valid branch or ref name. =A0git version 1.6.3 gives the same resu=
lts.
>
> There are several things going on:
>
> A) In 3 you use a different git than in 1,2,4. You told us the latter=
 is
> 1.6.2.3, and I'm telling you the former contains v1.6.2.1-310-ga31dca=
0
> (which has the new --branch option).
> This simply checks whether refs/heads/xxxx is sane. (It also resolves
> @{-1} and such, which is what makes it useful at all.)

Sorry, my mistake I was running in 2 windows on 2 machine and got
confused. Ignore
line 3 in my example.

>
> B) "master" certainly looks like a valid refname, the doc seems to im=
ply
> that it should pass the check.

$ git --version
git version 1.6.2.3
$ git check-ref-format xxxx && echo OK
$ git check-ref-format master && echo OK
$ git check-ref-format master/xxxx && echo OK
OK

I'm confused.

Geoff.


>
> C) Looking at the code, check-ref-format checks explicitly for the
> presence of at least 2 levels: foo/bar is good, foo is bad. So, maste=
r
> always had been bad, as well (or bad) as full sha1s!
>
> The code has always behaved like C since its inception but I don't kn=
ow
> the rationale behind the 2 level requirement. Daniel, Junio?
>
> Michael
>
