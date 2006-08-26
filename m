From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: Problem with pack
Date: Sat, 26 Aug 2006 20:53:52 +0200
Organization: ARCES - =?ISO-8859-15?Q?Universit=E0_di_Bologna?=
Message-ID: <44F098C0.8000202@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 26 20:54:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH3IE-0001JC-8X
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 20:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWHZSyB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 14:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWHZSyB
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 14:54:01 -0400
Received: from arces.unibo.it ([137.204.143.6]:31468 "EHLO arces.unibo.it")
	by vger.kernel.org with ESMTP id S1751565AbWHZSx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 14:53:56 -0400
Received: from [192.168.143.223] (mars-fw.arces.unibo.it [137.204.143.2])
	(authenticated bits=0)
	by arces.unibo.it (8.13.7/8.13.7) with ESMTP id k7QJ6tXk019408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 26 Aug 2006 21:06:56 +0200
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
To: git@vger.kernel.org
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_50,USER_IN_WHITELIST 
	autolearn=unavailable version=3.1.3-gr0
X-Spam-Checker-Version: SpamAssassin 3.1.3-gr0 (2006-06-01) on 
	mail.arces.unibo.it
X-Virus-Scanned: ClamAV 0.88.4/1733/Sat Aug 26 15:08:57 2006 on arces.unibo.it
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26063>

> Earlier you said that the mothership has 1.4.2, and the note has
> 1.4.0.  The sequence of events as I understand are:
>
> 	- repack -a -d on the mothership with 1.4.2; no problems
>           observed.
>
>         - transfer the results to note; this was done behind git so
>           no problems observed.
>
>         - tried to repack on note with 1.4.0; got "failed to
>           read delta-pack base object" error.
>   
Yes... only before that I had a few more iterations PC<->notebook always
syncing with unison.
> Can you make the pack/idx available to the public for
> postmortem?
>   
Yes... I can make them available... the pack/idx actually do not contain
anything extremely confidential (just a bunch of LaTeX files).
Only, being that there is conference data and stuff by people who
professionally organize conferences, I'd prefer to make it available
directly to some specific people that I can trust not re-distributing it
rather than putting it in the general public.
> Also I wonder if the pack can be read by 1.4.2.
>   
No it cannot.
> Earlier you said "unpack-objects <$that-pack.pack" fails with
> "error code -3 in inflate..."  What exact error do you get?
> I am guessing that it is get_data() which says:
>
> 	"inflate returned %d\n"
>   
This is right...
>   
Just a question...
Might the problem have come out of a scenario like the following...

1) I use unison to sync my documents (rather than using the git tools...
silly me!)
2) I get things wrong in controlling unison (without realizing that I
do) and the result is that I lose some blobs.
3) I repack an unclean tree (missing some objects)

Can this be the case?

Thanks

Sergio
