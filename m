From: =?ISO-8859-1?Q?Florian_K=F6berle?= <florian@fkoeberle.de>
Subject: Re: gitignore bug: including files in an excluded directoy does not
        work.
Date: Fri, 29 May 2009 23:25:41 +0200
Message-ID: <4A2052D5.80604@fkoeberle.de>
References: <809f58722b8bdb916fa7816cd80d3833-EhVcXl1BQAtYRw8cBxcBWQEwfgFLV15YQUBGAEFbXkI3XV8WXlhwH1RQWEFeRENtXlhdQ1hSWAtfWg==-webmailer2@server05.webmailer.hosteurope.de> <4A1DA8A7.9030606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 29 23:48:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA9wL-0003zC-B1
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 23:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbZE2Vs2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 17:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbZE2Vs1
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 17:48:27 -0400
Received: from wp165.webpack.hosteurope.de ([80.237.132.172]:60199 "EHLO
	wp165.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750811AbZE2Vs1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 17:48:27 -0400
X-Greylist: delayed 1362 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2009 17:48:26 EDT
Received: from p54964e1a.dip.t-dialin.net ([84.150.78.26] helo=[192.168.1.50]); authenticated
	by wp165.webpack.hosteurope.de running ExIM with esmtpsa (TLSv1:RC4-MD5:128)
	id 1MA9aC-000093-R4; Fri, 29 May 2009 23:25:44 +0200
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <4A1DA8A7.9030606@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.7
X-bounce-key: webpack.hosteurope.de;florian@fkoeberle.de;1243633709;96a66925;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120320>

Michael J Gruber wrote:
> Florian K=F6berle venit, vidit, dixit 23.05.2009 11:18:
>  =20
>> steps to reproduce:
>>
>> git init
>> echo /src/config > .gitignore
>> echo \!/src/config/readme.txt >> .gitignore
>> mkdir -p src/config
>> touch src/config/readme.txt
>> git add src
>>
>> expected results:
>> git should add the readme.txt file
>>
>> actual result:
>> git doesn't add the readme.txt file
>>
>>
>> additional comments:
>>
>> pre to the commit d6b8fc303b it was possible to archive the wished e=
ffect
>> with this .gitignore file:
>> ------------------
>> /src/config/
>> !/src/config/readme.txt
>> ------------------
>> The pre d6b8fc303b git fails to detect that it can exclude src/confi=
g.
>> Thus it checks the directory content and finds out that the readme.t=
xt
>> matches both - the exclude and the include pattern.
>>    =20
>
> The change in behaviour was intentional. You get the desired effect u=
sing:
>
> /src/config/*
> !/src/config/readme.txt
>
> Cheers,
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>  =20
Hello Michael,

thanks for the explanation.

Best regards,
=46lorian
