From: Russ Dill <russ.dill@gmail.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Sun, 29 Mar 2009 23:18:54 -0700
Message-ID: <f9d2a5e10903292318w6108bc50u2ddc830a6d9d85df@mail.gmail.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	 <20090327090554.5d6160f2@pc09.procura.nl>
	 <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 08:20:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoArK-0000g9-Es
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 08:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbZC3GS5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 02:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204AbZC3GS4
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 02:18:56 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:61784 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZC3GS4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 02:18:56 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2286388rvb.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 23:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1hZTnIt1zX00Bdhf8tUECxvasHRrSEinPdKeTVzAOz4=;
        b=SQ3+lBYPOzBKEZmf0UQ1+/AE9UcwStgX/fIbABbNZxpJJ3LV+QwXek1r+2mFxafkpz
         Rzu+WZwhmsVuXUCVAfibYKThb6rGgfno+Ag51UwUDTTOT+FyRviwheslxMNm2TSS4zie
         FnYDazsdXs/XbqjSQzCCCnzwMRFBdqLTgqZN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m9QlLwhoO7QMild0AXYtET5J1xvpian1Nu1rKtx3OGiULJ8jMFcsUuNFfTT1yWdHY4
         UrxhI+meS92Fz0uJn7YTPuvopaY2AdlSp2dB9Z1Yeo1Io8n+Fo7LPXOMfv6gzFCUDDXm
         z4wZvRjYtxWA8hdzlviZEtiKDZWvybsjUfI6M=
Received: by 10.141.113.3 with SMTP id q3mr2655823rvm.12.1238393934086; Sun, 
	29 Mar 2009 23:18:54 -0700 (PDT)
In-Reply-To: <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115083>

On Fri, Mar 27, 2009 at 2:50 AM, Ulrich Windl
<ulrich.windl@rz.uni-regensburg.de> wrote:
> On 27 Mar 2009 at 9:05, H.Merijn Brand wrote:
>
>> On Fri, 27 Mar 2009 08:21:36 +0100, "Ulrich Windl"
>> <ulrich.windl@rz.uni-regensburg.de> wrote:
>>
>> > What I'd like to see in git (My apologies if some were already dis=
cussed to
>> > death):
>> >
>> > 1) The ability to use the file's time at the time of add/commit in=
stead of
>> > =C2=A0 =C2=A0the current time, and the ability tho check outfiles =
with the times stored
>> > =C2=A0 =C2=A0in the repository.
>> >
>> > 2) Keyword substitution. I know it's controverse (dealing with bin=
ary files),
>> > =C2=A0 =C2=A0but I'd like to have some automatic version numbering=
 keyword at least:
>> > =C2=A0 =C2=A0Initial idea is that every commit with a change incre=
ments the number by
>> > =C2=A0 =C2=A0one, and when merging numbers a and b, the resulting =
number is max(a, b) + 1.
>>
>> impossible. Even with checkin- and checkout hooks, you won't get tha=
t
>> SCCS behaviour. They have to be better in something too :)
>> /me still misses that but got used to it
>
> Hi,
>
> what made me wonder is this (about item 1): I thought I've read that =
blobs store
> content and attributes, so very obviously I wondered why not store th=
r "right
> attributes" (i.e. the time of the file). My reasoning: You make some =
changes, then
> test them (which might last several hours or days). The if I'm happy =
I'll
> "commit". Naturally I want to see the time of change for each file wh=
en the change
> had been actually made, not when the change was committed. Likewise w=
hen checking
> out, I want to be able to see the time of modification, not the time =
of commit.
> I'm aware that many people don't care about such differences...
>

Ok, so if Nancy did some work on the part number form 6 months ago,
but it got merged into master yesterday. What date should the file
have? This kind of incremental version number, and trusting of file
dates really only matters on a centralized system with a single
branch.

Not only that, but modification times are much more useful with make.
Merging or pulling small changes into a tree shouldn't require a full
rebuild of the entire tree which in some cases could take hours.
Especially since 'git log <file>', 'gitk <file>', or 'git blame
<file>' give much more information anyway.

I know some people sort their directory by date to see what kind of
stuff happened since they last worked on the repository, but it
doesn't scale to a project with many directories and the log is much
more useful anyway.
