From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sun, 13 Jan 2008 22:23:12 -0500
Message-ID: <478AD5A0.50900@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org> <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <alpine.LSU.1.00.0801122123430.8333@wbgn129.biozentrum.uni-wuerzburg.de> <47893F53.2070908@gmail.com> <alpine.LSU.1.00.0801132220200.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 04:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEFvc-0004bp-Un
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 04:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbYANDXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 22:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753640AbYANDXS
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 22:23:18 -0500
Received: from ag-out-0708.google.com ([72.14.246.250]:25973 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbYANDXR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 22:23:17 -0500
Received: by ag-out-0708.google.com with SMTP id 23so1352549agd.10
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 19:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=S1NWCCRXlL6htGieGby7e8NZewnSu6N5krmXi1A0GMk=;
        b=iwPc7fUjy1ACSjpV68gYEpCmHCC4KR1r33KeBMi2r/SAhaVJrdoFhNnF+ScHJ1SAZa/ftdj58V2qc3vwh+AMbxUUuu4rN8w/o83XhtamCrlovvfw2TwvYds1quKNYiFWOXzaZCeHbtJ+kV2FkH6fv54eO/8HJK0XdGc8MaczFRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=oXO1KTBOtI9iETmjIeMdvvd9mbCmFNwvHNVYKXgMJA45maoD/0pg0F8B5iilGq5el7hkXNpUIKMWxR6y8o8r+aJfHmSvsuX52dJwcETgnWMUSUhKbA+LyrbM0FvUvlC8h3xjjpFU02Hssgfhh96CHnCx0OfY2tXZ+ZCK7mN5AU0=
Received: by 10.100.107.7 with SMTP id f7mr12968494anc.108.1200280995948;
        Sun, 13 Jan 2008 19:23:15 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.17.196])
        by mx.google.com with ESMTPS id b12sm7918817ana.1.2008.01.13.19.23.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jan 2008 19:23:14 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0801132220200.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70436>

Johannes Schindelin wrote:
> Unfortunately, you _still_ fail to even ackonwledge that you still need a 
> lookup, and that I have a point when saying "your patch does not help, 
> since you still have a lookup".
>   
I don't acknowledge this point as it is not true.

I will try to explain one more time.

1 - "origin" is fine as an abstraction IFF everyone on the project can 
reasonably expect that "git fetch origin" will yield the same results 
for anyone who executes that command. As I have tried (and apparently 
failed) to explain, for numerous complex and unchangeable reasons, "git 
fetch origin" is *NOT* expected to give the same results around this 
project and therefore, "origin" is not a useful abstraction.

2 - Until we used submodules, we never defined "origin", but instead 
explicitly named the server using standard nicknames (e.g., "git fetch 
frotz", not "git fetch"). Everyone who can access frotz gets the same 
result. Those who can't, and have to use server "zorft", get a different 
result but it is obvious to all they didn't go to frotz.

3 - As the servers are different and have different content, it is just 
part of the workflow to know the server names and use them. We have 
agreed upon a common set of server nicknames. There is no lookup, we 
just know them. Maybe you call this a lookup step, but frankly this is 
part of *required* job knowledge (which server has what and which to use 
for which purpose).

4 - The problem came with submodules. Now, the recipe of "git clone -o 
frotz" no longer really works, as all of the submodules now have remote 
origin = frotz, and remote frotz is undefined while the master-project 
is the other way around. This is confusing to say the least. As 
submodules forced origin in, the path of least resistance  was just 
giving in and using origin. Now we have to be very aware not only of 
what server to use, but now also what origin is so that we can know how 
to reach the server we wanted. (i.e., Do I use "origin" or "frotz" to 
reach frotz?) This *IS* an extra lookup step required because of origin 
being defined.

Now, we can recusively use "git remote add" to just go ahead and add all 
remotes needed regardless of what origin says, and *partly* get back to 
where we were. Only partly, because git submodule update will still use 
origin, and *only* origin for fetching. So we still have to know what 
origin is (problem #1, fixed by my patches 1-4), and if what we need to 
fetch from is in fact not origin (even though the master project knows 
what server to access), submodule update in fact doesn't even work 
(fixed by the fifth patch that flows the remote down from the master).

So no, I do not acknowledge that we have an extra lookup step and that 
just using origin is the same or simpler or whatever. It absolutely is 
not. Quite the opposite, for us using "origin" forces an unnecessary 
extra lookup and translation step and complicates, not simplifies, use 
of submodules.

Mark
