From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: why is my repo size ten times bigger than what I expected?
Date: Tue, 8 Mar 2011 22:44:00 +0100
Message-ID: <AANLkTikuuzHZ897kOY2u0Sv=0JTDffo0UhcxkyynVQAZ@mail.gmail.com>
References: <AANLkTimi+OnpdX+Y7jx1JaOmGbZc_XEgJFeK0PKLpu2o@mail.gmail.com>
	<AANLkTi=V3nEamocowbHovvV0U69nZgD70fysu1CQOwrR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ruben Laguna <ruben.laguna@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 22:45:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px4ij-0001M1-Nc
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371Ab1CHVp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 16:45:28 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38945 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512Ab1CHVp1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 16:45:27 -0500
Received: by fxm17 with SMTP id 17so5565553fxm.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 13:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eRVTZqFi9WgrIZ5GoQbDGi7zzarthv8uhgC9UacUCGY=;
        b=SStqqgfW3mBSGNo6XKdaRk5V62X+xaIZ7qVwo6NRzWlmq2ktbxckSJ/FVsDTHb4Gpe
         l22/uaSOlPH359nOEOz00wJWhL+eKreI7f91LQGfmx4s0QOhRbuDFz77YiQRi5Uj1Ujl
         8ZpdhEqpsPS6+6UruJMPnYc9hRFuAFm5qmPas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p6uUfr7nmeblVYWZft5a1D0y8TjTFrnNJN9VaVsn4/OyXFTSP9s5vdSqntToyowypu
         19GBj/Nn8oZ5dctmJDyUsnYSKXoYsQ1utj/0TCHDTLhZNqKxb4a3aIoHNgd0PJJfLMAW
         8s9/xkZF1duQ9GygkysP+MC0alpAqy8LQoIBg=
Received: by 10.223.85.196 with SMTP id p4mr5202950fal.5.1299620640779; Tue,
 08 Mar 2011 13:44:00 -0800 (PST)
Received: by 10.223.151.16 with HTTP; Tue, 8 Mar 2011 13:44:00 -0800 (PST)
In-Reply-To: <AANLkTi=V3nEamocowbHovvV0U69nZgD70fysu1CQOwrR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168704>

On Sat, Mar 5, 2011 at 11:05 AM, Ruben Laguna <ruben.laguna@gmail.com> =
wrote:
> Hi,
>
> I had a repo which was big 143MB because it contained a bunch of jar
> files. So I decided to remove those completely from the history.
>
> In short I used the git-large-blob [1] to find all the jars and used
> the git-remove-history script [2] which does the filter-branch thing,
> prune, etc.
>
> I did this on all branches (that I know of) and now I can see that th=
e
> jars are gone because I can't find them with git-large-blob. =C2=A0an=
d the
> repo size has dropped from 143Mb to 87Mb.

I just thought I'd mention that the git-remove-history script that you
mention does filter-branch on HEAD, and not using the --all parameter.
I thought --all was the best way to "catch all" branches in one go...

    -- Tor Arvid

> My concern is that 87Mb is still really big taking into account he
> size of the project. =C2=A0in fact if I run "git diff-tree -r -p $com=
mit
> |wc -c" for each commit and sum all I get 5.5Mb.
>
>
> I also ran the git-rev-size [3] script that I found in this mailing
> list and I only see that the size grows steadly from commit to commit
> up to 1482731 bytes. So again how come the .git directory is 87MB?
>
>
> So, Can anybody tell me if this repository size is "normal" for a
> project with 1.4MB source and 352 commits?
> Is there a better way to calculate the size (in bytes) of each commit=
?
>
> Is there any other thing I could do to reduce and audit =C2=A0the rep=
ository size?
>
>
> Thanks in advance!
> Rub=C3=A9n
>
> ---
> [1]=C2=A0http://stackoverflow.com/questions/298314/find-files-in-git-=
repo-over-x-megabytes-that-dont-exist-in-head
> [2]=C2=A0http://dound.com/2009/04/git-forever-remove-files-or-folders=
-from-history/
> [3] http://markmail.org/message/762zzg5zckbiq2i7
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
