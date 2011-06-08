From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts (ad-hominem attacks)
Date: Wed, 8 Jun 2011 14:57:09 -0400
Message-ID: <BANLkTinibF0xmibeuJ6f9FUjaMmxavMJig@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<7vd3ir9btd.fsf@alter.siamese.dyndns.org>
	<4DEDC124.3060302@drmicha.warpmail.net>
	<201106081312.46377.jnareb@gmail.com>
	<BANLkTinoQCZhyhgw61u7c3eF4e5MEf+eFA@mail.gmail.com>
	<20110608150537.GC7805@sigill.intra.peff.net>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:57:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNwK-0003Jq-9j
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab1FHS5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 14:57:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64492 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab1FHS5K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 14:57:10 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so686177bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=T+pcJ7fmz+BU4qc7oAqHM0Xt/LMIWiWVDflMNDWW8VM=;
        b=BoMs+xcVCQ8wGSXKcCmufKY95RgrtYWnigiYijhac0wTUdiQbwyLX66mzGKlwFehjB
         yVa4zJbSVOqICYBLbEd0HvKhhZD5oTIQU8iCerb8MiXOwapWYb6aiSvxWAQtOgzf65P3
         dQc/Lww5pzbYYrl9neVdYtBw2VOi06zfD0h4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=J4heUVu6YRpfj5FuQINr7K9K8nSIdh9CpYGyDVp8HlArUMqrQuiGjkjFwtx4sM2Qy2
         ja9G3I5bovcx5c0PFAw3zKki125xIE5Lv+N0Gu11nrxqtlxL3t1UZpIEl1aSBprprDtb
         a3dpM7s8y+W8Hllh0HLAmHylg22cUiQVebyTo=
Received: by 10.204.62.4 with SMTP id v4mr1097875bkh.169.1307559429388; Wed,
 08 Jun 2011 11:57:09 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Wed, 8 Jun 2011 11:57:09 -0700 (PDT)
In-Reply-To: <20110608150537.GC7805@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175443>

On Wed, Jun 8, 2011 at 11:05 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 08, 2011 at 07:39:16AM -0400, Michael Nahas wrote:
>
>> On Wed, Jun 8, 2011 at 7:12 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>> > I don't quite think that we need "git diff NEXT WTREE"; the short
>> > and sweet "git diff" is short for a reason,
>>
>> To be clear, I'm not advocating and have never advocated getting rid
>> of zero-argument "git diff". =A0I've advocated that every (whole
>> project) diff command should be expressible by a "git diff TREE1
>> TREE2". =A0I'm fine with defaults if one or zero trees are specified=
=2E
>
> I agree with this, but...
>
>> So "git diff" would default to "git diff NEXT WTREE".
>
> Isn't this going to be behavior change, since your NEXT is not quite =
the
> same as the index? How do I now get an n-way combined diff of the
> unmerged files in the index?
>
> -Peff

The index is a file in .git/ that serves many purposes.  NEXT is an
image of the whole project.  NEXT can be computed from the index and
HEAD.

During a conflicted merge, stage 0 of the index holds the resolved
files.  WTREE holds all merge files: the resolved and the unresolved
(which have <<<< =3D=3D=3D=3D >>>> blocks in them).  I propose that dur=
ing a
conflicted merge, that NEXT be computed as HEAD plus the resolved
files, that is, the files in stage 0 of the index.

"git diff HEAD NEXT" would print the resolved changes.
"git diff NEXT WTREE" would print the unresolved changes
"git diff HEAD WTREE" would print all changes.

I believe that is the same behaviour as "git diff", "git diff
--cached" and "git diff HEAD" during a conflicted merge.

I do not know how "n-way" merge works.  I saw somewhere that indicated
that it was a series of N-1 two-way merges.


Mike
