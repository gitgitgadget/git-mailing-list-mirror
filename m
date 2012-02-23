From: Luke Diamand <luke@diamand.org>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Thu, 23 Feb 2012 10:02:31 +0000
Message-ID: <4F460EB7.3030503@diamand.org>
References: <4F46036F.3040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nikolaj Shurkaev <snnicky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 11:02:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0VVA-00068l-TR
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 11:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab2BWKCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 05:02:12 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52515 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2BWKCL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 05:02:11 -0500
Received: by wgbdt10 with SMTP id dt10so906898wgb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 02:02:09 -0800 (PST)
Received-SPF: pass (google.com: domain of luke@diamand.org designates 10.180.101.228 as permitted sender) client-ip=10.180.101.228;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of luke@diamand.org designates 10.180.101.228 as permitted sender) smtp.mail=luke@diamand.org
Received: from mr.google.com ([10.180.101.228])
        by 10.180.101.228 with SMTP id fj4mr1463652wib.4.1329991329986 (num_hops = 1);
        Thu, 23 Feb 2012 02:02:09 -0800 (PST)
Received: by 10.180.101.228 with SMTP id fj4mr1203556wib.4.1329991329924;
        Thu, 23 Feb 2012 02:02:09 -0800 (PST)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id er8sm4455311wib.1.2012.02.23.02.02.08
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 02:02:09 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Iceowl/1.0b2 Icedove/3.1.13
In-Reply-To: <4F46036F.3040406@gmail.com>
X-Gm-Message-State: ALoCoQkYo99j06TYG2VGcRSM8vXOZvO4YnN3JN+VZAWe6DkPGF1JDG+M96izvehurho4QF0i+GJ3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191344>

On 23/02/12 09:14, Nikolaj Shurkaev wrote:
> Hello all.
>
> I wanted to generate several files with some statistics using "git log
> -z" command.
> I did something like this:
> git log -z --patch HEAD~10..HEAD -- SomePathHere | xargs -0
> --max-chars=1000000 ~/1.sh
>
> If I put
> echo "started"
> into the file ~/1.sh I see that the file is called only once instead of
> multiple times.
>
> I'm newbie to xargs, thus I tested with and that worked as I expected.
> find . -type f -print0 | xargs -0 ./1.sh
> That produced a lost of "started" lines.
>
> Thus I suspect there is a but in git log -z command and that doesn't
> "Separate the commits with NULs instead of with new newlines." as
> promised in the documents.
> Is my understanding correct or I don't understand the documentation or
> somehow pass wrong parameters into git log?

Just a guess, but doesn't the "--patch" option to git log ask it to 
produce a patch output? Surely that will override the -z: patch will not 
be expecting NULs.

>
> Thank you.
> Best regards,
> Nikolaj
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
