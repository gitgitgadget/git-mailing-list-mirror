From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git-mergetool: wrap tools with 3 files only to use the BASE file
 instead of MERGED
Date: Wed, 10 Aug 2011 21:23:43 +0200
Message-ID: <CAHGBnuP5hZ_GJ-ZCwDUVttXvZqsrTh7yXjJCZUoMgVEwVrYjjw@mail.gmail.com>
References: <20110810160356.GA32126@ortolo.eu>
	<20110810161211.GC4076@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tanguy Ortolo <tanguy+debian@ortolo.eu>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 10 21:23:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrENa-0001pO-NL
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 21:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845Ab1HJTXp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Aug 2011 15:23:45 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59137 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730Ab1HJTXo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2011 15:23:44 -0400
Received: by qyk34 with SMTP id 34so812665qyk.19
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Jds2sdz0bPGQGYbfxlP/+5MwJTc0gb0kSdJWEL6s5hc=;
        b=PdDQtRzOpfm9ladxoAawGK2wHKMEjsq0sRNYDRrpVKZOtymT5GU1VJ8nJkjiaZIqHm
         aG77614p9GKe1kJ9j2CI+QqrarsAUXRWBKV3TwB7PhvEKZhV4Ksqoq95qYUWbF3YMWv0
         7afwtKFCOazfG+3ZzwMaFf0WeltCTRrvzASyc=
Received: by 10.229.241.7 with SMTP id lc7mr6598773qcb.129.1313004223966; Wed,
 10 Aug 2011 12:23:43 -0700 (PDT)
Received: by 10.229.182.11 with HTTP; Wed, 10 Aug 2011 12:23:43 -0700 (PDT)
In-Reply-To: <20110810161211.GC4076@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179075>

On Wed, Aug 10, 2011 at 18:12, Jonathan Nieder <jrnieder@gmail.com> wro=
te:

>> I think it would be better to wrap such merge tools by:
>> 1. passing them BASE LOCAL REMOTE;
>> 2. checking whether or not BASE hase been modified:
>> =C2=A0 =C2=A0* if it has, then copying it to MERGED,
>> =C2=A0 =C2=A0* if it has not, exiting with return code 1 (merge fail=
ed).
>> This check can be by either saving and comparing the mdate, or perha=
ps
>> the SHA-1 hash of the BASE file.
>>
>> If this sounds good enough, I can dive into git-mergetoo--lib and
>> implement it. In the meantime, here is an example of a custom merge =
tool
>> that wraps meld for that purpose.
>
> I think you forgot to include the example. =C2=A0Anyway, at first gla=
nce it
> sounds like a sensible idea. =C2=A0David et al: thoughts?

Sounds sensible to me, too. (Although I'm not affected, as fortunately
the GUI merge tools I've been using so far, namely ECMerge and Beyond
Compare 3, both allow to specify a separate merge output.)

--=20
Sebastian Schuberth
