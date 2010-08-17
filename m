From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] updating examples/git-merge (plus a builtin/merge
 fix)
Date: Tue, 17 Aug 2010 03:10:33 -0500
Message-ID: <20100817081033.GB28476@burratino>
References: <20100817065147.GA18293@burratino>
 <AANLkTikf-do4nyQO=W93BxKxDekQJpExLtop__tz1n8o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 10:12:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlHHM-0006Vp-Jn
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 10:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088Ab0HQIMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 04:12:13 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35067 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab0HQIMJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 04:12:09 -0400
Received: by yxg6 with SMTP id 6so2313037yxg.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PRU43BZZ0xVNOSePnQ/3+NCm3fGQqwrEyEPuVOBvJNs=;
        b=OdWyTp8rRBliuK7l7l/nJ9NgNbS/qwdf1ZRCMTCEvL56xobCzooTkOsV9G4hXj43i6
         6+Yl2EsJDV7GL7QHl8E72WTWB6j313Emy3jbZevLgbH2/O4l7JD/hiODQTtXBengIEko
         r2eF89nbzm39nN6wMhsvqfy41/+b/9h+ff34Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XPot0BK0SSmlicJ62Mvu90TM87bKSbh/OZolpGyRedxNPbz7dWzPls/4Xtwsw+Anxv
         RJZJyerlm4nF3jUwd60XZuuvIGt1dvodMx4g3H2xtOIQDY3KWbi3AkX1bKMc8lC/2MRL
         S+5hHQv7sEcpMpjl8hRd/jGl8aAMO7kNkEvFs=
Received: by 10.100.53.30 with SMTP id b30mr7160539ana.43.1282032728969;
        Tue, 17 Aug 2010 01:12:08 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c25sm668229ana.39.2010.08.17.01.12.07
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 01:12:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikf-do4nyQO=W93BxKxDekQJpExLtop__tz1n8o@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153733>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Aug 17, 2010 at 06:51, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> Patches 8-10 expose functionality used by merge when handling octopu=
s
>> merges.
>
> You mean 9-10, 8 looks good. I don't have the familiarity to comment
> on 9-10.

I would be especially interested in feedback on the interface from
those two. ;-)

Is merge-base the right command to learn --independent?

Is --independent the right name for "reduced parent list"?

Is merge-base --octopus generally useful at all, or should we change
the API for custom octopus strategies (maybe at the same time as
teaching them to declare NO_TRIVIAL and NO_FAST_FORWARD preferences)
to leave the list of merge bases out?

>> Patches 12 and later are ports of various patches to builtin/merge.c=
=2E
>> I did the bare minimum to make tests pass. :)
>
> Those also look good to my untrained eye.

Thanks for looking them over.

> How do you run the tests against git-merge.sh? Is there some make
> target to use it instead of git-merge.c, or do you manually move it i=
n
> place?

Ah, yes, I should have made that information more prominent.

To test: remove cmd_merge from the builtins list in git.c,
build git, and then run:

 cp contrib/examples/git-merge.sh .
 make SCRIPT_SH=3Dgit-merge.sh git-merge
 cd t && make

> If it's the latter a switch somewhere to run the test suite against
> these .sh alternatives might compliment this series nicely.

Yes, that sounds like an good idea.  Of course most of the retired
scripts are bitrotted by now.
