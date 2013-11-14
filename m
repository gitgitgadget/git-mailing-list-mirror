From: Luca Milanesio <luca.milanesio@gmail.com>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Thu, 14 Nov 2013 11:17:31 +0000
Message-ID: <66513F31-CF2E-4327-AEA3-20176C14EEE1@gmail.com>
References: <20130601050355.GA23408@sigill.intra.peff.net> <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com> <20130601090934.GA13904@sigill.intra.peff.net> <CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com> <CAMK1S_hPups3SCwxhHRYWBJzpPreNVUfNdx1+_Hjy2_d0MMpaA@mail.gmail.com> <CALkWK0=SqCh-82F4ud+AxuzzEezyMWqMvc6HAPoxOk32vUND7A@mail.gmail.com> <528416EA.1070307@gmail.com> <87bo1nmn6w.fsf@linux-k42r.v.cablecom.net> <20131114080735.GB16327@sigill.intra.peff.net> <5284AC6E.4030208@gmail.com> <20131114110937.GA11597@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 14 12:17:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vguve-000782-T4
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 12:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab3KNLRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 06:17:37 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63626 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608Ab3KNLRe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Nov 2013 06:17:34 -0500
Received: by mail-wi0-f178.google.com with SMTP id hn6so2282711wib.17
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 03:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uoH2J/A0sZAVni5BdurPldvS+iMPhdRmftkwpkgcR2w=;
        b=kRjyr50oD0Hb34OMA2pqb4MTgFEoF1nDzuMmCdKOJ6Jvqg0GXIlxUuV4d9AHlXvd+h
         4CTqJjJ4kqy9NNJGuG6PqUhS+nSNEUhILdb0ZHZztehrqfZfk2qmbu3AoroLSqHrO/JI
         wYFMy5ByUZ76W/rFX49AD/IDUxTb4wI+s1Ul58l0DpbHeiMpqGcd7YqUBoC+G3QCPslz
         OJtMpJLcKhH25b8vqtB2zoqS9DnOZ+7Y813fU9uH0XzFEAru3vNoHCrDLp9M9VyCR095
         Cnd4gg4vMztS0232ESd8Ki65lW6xEnwSHx71Fxvnzy51mw5VjtBkmUvvQv3hNZcT27+P
         fkIw==
X-Received: by 10.180.102.97 with SMTP id fn1mr1893225wib.32.1384427853338;
        Thu, 14 Nov 2013 03:17:33 -0800 (PST)
Received: from [127.0.0.1] (dns2.lmitsoftware.com. [178.32.227.121])
        by mx.google.com with ESMTPSA id gg20sm3949882wic.1.2013.11.14.03.17.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 03:17:32 -0800 (PST)
In-Reply-To: <20131114110937.GA11597@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1816)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237823>

Would be really useful anyway to have the ability to create a server-side reference based on a SHA-1, using the Git protocol.
Alternatively, just fetching a remote repo based on a SHA-1 (not referenced by any ref-spec but still existent) so that you can create a new reference locally and push.

Luca.

On 14 Nov 2013, at 11:09, Jeff King <peff@peff.net> wrote:

> On Thu, Nov 14, 2013 at 04:26:46PM +0530, Sitaram Chamarty wrote:
> 
>>> I do not know about any particular debate in git circles, but I assume
>>> Sitaram is referring to this incident:
>>> 
>>>  https://groups.google.com/d/msg/jenkinsci-dev/-myjRIPcVwU/t4nkXONp8qgJ
>>> 
>>> in which a Jenkins dev force-pushed and rewound history on 150 different
>>> repos. In this case the reflog made rollback easy, but if he had pushed
>>> a deletion, it would be harder.
>> 
>> I don't know if they had a reflog on the server side; they used
>> client-side reflogs if I understood correctly.
>> 
>> I'm talking about server side (bare repo), assuming the site has
>> core.logAllRefUpdates set.
> 
> Yes, they did have server-side reflogs (the pushes were to GitHub, and
> we reflog everything). Client-side reflogs would not be sufficient, as
> the client who pushed does not record the history he just rewound (he
> _might_ have it at refs/remotes/origin/master@{1}, but if somebody
> pushed since his last fetch, then he doesn't).
> 
> The "simplest" way to recover is to just have everyone push again
> (without --force). The history will just silently fast-forward to
> whoever has the most recent tip. The downside is that you have to wait
> for that person to actually push. :)
> 
> I think they started with that, and then eventually GitHub support got
> wind of it and pulled the last value for each repo out of the
> server-side reflog for them.
> 
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
