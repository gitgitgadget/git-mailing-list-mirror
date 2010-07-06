From: demerphq <demerphq@gmail.com>
Subject: Re: global hooks - once again
Date: Tue, 6 Jul 2010 17:00:36 +0200
Message-ID: <AANLkTinCFP18B8PQoGREt-izxGSlUb3IzitxK4aeiFRD@mail.gmail.com>
References: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
	<7v630x1yl8.fsf@alter.siamese.dyndns.org>
	<AANLkTikMEDUI7d5Mzwm8r43zCYTqefyI06PHOMvT1iLz@mail.gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC744940F6E57@xmail3.se.axis.com>
	<AANLkTimSvwo50Q9jsbKkzvplSPE82fNJJDSFmZVw3r5o@mail.gmail.com>
	<AANLkTilZcuYxb6ASgJq82JVdgcRcuak5PvYXZF6fcojm@mail.gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC744940F7000@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eugene Sajine <euguess@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 17:05:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW9iY-0000kq-2J
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 17:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862Ab0GFPAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 11:00:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34063 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab0GFPAk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 11:00:40 -0400
Received: by gye5 with SMTP id 5so1813513gye.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=xqTfdgAx66p5DN0CVuD7dQFMRDdGCntMojIKVY/O4QM=;
        b=Z8aglEOe1oGsFRYEL2RvgR8ETd8CVCOKToot8jh85OjjVrwvIZaBy2dentGB9W+qgp
         SS5ma96Nj2oKM0n98ceuyoHaX0XBYzhcSmcbRdcShSuIrxATESz9nqHK20BHbMcEmCA/
         BQ4YTaj2ObN/MTdzBpMLProWmqzhieX759A6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=x4Wk3LuanwEf2p2BMeeU71MtzYN8Ze2Mk83uairizL96pFSa1BncAZRBHK/gz3YimT
         rxIjNc1LMFoVnlPJ4iEBIwSA57v0Qp38UB3xIRLqAGCBgvSX298gqpWp1pfIEtcXgSp5
         wK6XGKJA2G0SXnyjCW8kRnh52ke5CGgwgPkYI=
Received: by 10.239.189.139 with SMTP id t11mr504939hbh.17.1278428436123; Tue, 
	06 Jul 2010 08:00:36 -0700 (PDT)
Received: by 10.239.183.201 with HTTP; Tue, 6 Jul 2010 08:00:36 -0700 (PDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC744940F7000@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150360>

On 6 July 2010 16:55, Peter Kjellerstedt <peter.kjellerstedt@axis.com> wrote:
>> -----Original Message-----
>> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
>> Behalf Of Eugene Sajine
>> Sent: den 6 juli 2010 14:23
>> To: Alex Riesen
>> Cc: git@vger.kernel.org
>> Subject: Re: global hooks - once again
>>
>> > How do your users disable execution of global hooks in this scheme?
>> > (to protect themselves from an evil system administrator)
>
> Yeah, I missed that case. What I have is another configuration
> variable (e.g., core.hooksActiveLevels) which is set to a string of
> different configuration levels (defaulting to 'system global local').
> Only the hook directories specified on an active level are
> scanned for hooks. So by setting it to just 'local' any system
> and global hook directories are ignored.
>
> This is not optimal, but was the best I could come up with.
> I really do not want to force the users to explicitly specify
> the hook directories for each repository, but rather be able
> to set it on a global level, and then use exceptions for the
> few cases where the global hooks should not be active.
>
>> In a corporate environment it is not the case, i believe. If sysadmin
>> made a mistake a with hooks, he will have to fix it, but there is no
>> point in overriding on user level as hooks in this case will be
>> something about company policy, aren't they?
>
> Well, actually it is needed there too. Even though the vast
> majority of repositories the user clones are company repositories
> that should use the company's rules, he may clone some occasional
> repositories from the outside (e.g., Linux or git) in which case
> he probably wants to disable the global company hooks.

Id have guessed that users would be discouraged from having their own
repositories on a central version control server in most larger
environments.

For instance i can imagine that boxes that devs actively work on would
have no global setting, and central version control boxes would have
it.

cheers,
Yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
