From: Eugene Sajine <euguess@gmail.com>
Subject: Re: help understanding git diff output
Date: Thu, 27 Jan 2011 18:23:22 -0500
Message-ID: <AANLkTimtHvn3uO2pf8+VWz_1VYediChRx9fdmVw_vVtU@mail.gmail.com>
References: <AANLkTi=H1LuGfQC8+u83So+6XyOqJxHJ3zsdgs4JTdkc@mail.gmail.com>
	<7vk4hqgd71.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 00:24:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PibC6-00085j-Vg
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 00:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834Ab1A0XX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jan 2011 18:23:56 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42827 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab1A0XXz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jan 2011 18:23:55 -0500
Received: by ywe10 with SMTP id 10so835824ywe.19
        for <git@vger.kernel.org>; Thu, 27 Jan 2011 15:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BycrRLxEGibbSa40vbzZJt62RZMd3OBajxxdv/HWKrg=;
        b=DQa8JCBEnNoC/8F4N8iFKFQcf62hMMEBOAfvm0387WeRtyewfTGkYl7oFZaln5/0Uu
         m2fDhPOz1Bp6ix5MwYTECFeJzwZfYqHbREcXKcaXfjQa2MEOlvDclJEq9dIZzaoDwhpb
         XUF0pi2bwwxSMB0/opYDIUJv8895E4jTVwF1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M6iyIvfwFPQvDnoIbdA2fbPMU/rN0d+sg7p7lDXRxMmAHaMStLM5DvPvwoME2yIZv4
         L1i0KLC5CUfsw+Fd1zUwvzmVzDU7oFU4C4gLBiQXhZCvs2Nvv9ApoKzGNIQfyiMZOGsb
         aRVYQJpHQ2li0azp9ptM7xV865nIKaV0khdX0=
Received: by 10.236.95.141 with SMTP id p13mr3436617yhf.98.1296170602633; Thu,
 27 Jan 2011 15:23:22 -0800 (PST)
Received: by 10.146.168.5 with HTTP; Thu, 27 Jan 2011 15:23:22 -0800 (PST)
In-Reply-To: <7vk4hqgd71.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165595>

On Thu, Jan 27, 2011 at 6:05 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> I get empty diff when i execute:
>>
>> $git diff branch1..branch2
>>
>> and i also get empty diff when running
>>
>> $git diff branch2..branch1
>
> The thing is, "diff" is about comparing "two endpoints".
>
> We still do support, as a backward compatibility measure, the A..B
> notation to help people who learned "git diff" from ancient documents=
, and
> we don't plan to deprecate the notation in any way, but don't be fool=
ed by
> the notation which usually means "the range from A to B". =C2=A0In th=
e context
> of diff, it does not mean a range, as diff is about two "endpoints".
>
>> What i cannot wrap my mind around is why the command below with
>> symmetric difference range gives me non-empty diff
>>
>> $git diff branch1...branch2
>
> "git diff A...B" is a short-hand for "git diff $(git merge-base A B) =
B",
> naming the fork point between branches A and B as one end, and B as t=
he
> other end, of the diff. =C2=A0Again, diff is about two "endpoints", a=
nd the
> notation does not mean a symmetric difference range.
>
>
>

Thanks a lot, Junio. I was looking at the wrong place in the
documentation. Skipped the part in diff doc explaining that range
notations are not exactly ranges for diff.

Thanks,
Eugene
