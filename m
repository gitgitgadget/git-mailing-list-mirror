From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v4] git remote: Separate usage strings for subcommands
Date: Thu, 19 Nov 2009 13:58:57 -0500
Message-ID: <32c343770911191058x7be7d34ascc3564064b880213@mail.gmail.com>
References: <4B04B4A2.8090001@gmail.com>
	 <20091119124040.6117@nanako3.lavabit.com>
	 <32c343770911190651w3f1ac9b6i2d3b1a62a032489f@mail.gmail.com>
	 <7vlji2bd23.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, jrnieder@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 19:59:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBCDm-0008JR-SC
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 19:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbZKSS66 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Nov 2009 13:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753964AbZKSS65
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 13:58:57 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:45191 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbZKSS65 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2009 13:58:57 -0500
Received: by fxm21 with SMTP id 21so2753207fxm.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 10:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uDvgLB8t+AnmRvKPcyT35Y3wbgnJ62v3VdIy2WeGTH4=;
        b=JP+VnBPJG59j4G56+vRNQDUc96huVR65CyEAHPgeEEc6ye6WLteLTQJBKA7uxzxvbH
         JjLE9equQH4ZZcgyPUQmhRHvbgeG+iC8LEXGUK7QybzR3k1dSoesLfo4gjNZ64prNBH4
         SpkvnzCTwRjXGUrn9ta1edIBWoMLkYytWTGrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=c0pCbyDGiQboyn6yC9uP0jEfxZ6x77U9Dzrt9/XInn92TH5ny+/l69cKt4+KxAeUrs
         +zXGw8jydeIHe2NyADAs49g+ixImOMm6FJfnjsiMSCL9mDoykGy1ilgRZPcrZDbRgZya
         Qfn46so3BVd3i02q+PpLqcspWPofBz7XfRUn0=
Received: by 10.216.91.12 with SMTP id g12mr114540wef.33.1258657141949; Thu, 
	19 Nov 2009 10:59:01 -0800 (PST)
In-Reply-To: <7vlji2bd23.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133243>

On Thu, Nov 19, 2009 at 1:10 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> The original version of this patch [1] left the contents of the usag=
e
>> strings intact. =C2=A0However, Junio expressed a preference to chang=
e
>> them to use the generic <options>. =C2=A0See this thread for the
>> discussion [2].
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/133048/
>> [2] http://thread.gmane.org/gmane.comp.version-control.git/132968/fo=
cus=3D133050
>
> Sorry, but I think you misunderstood what I meant, then. =C2=A0in [2]=
, I said...

=2E.. snip ...

>    ... the options list is used to reproduce the information in a maj=
or part
>    of that string already.  So I would prefer builtin_remote_add_usag=
e[] to
>    be something like:
>
>        "git remote add [<options>...] <name> <url>"
>
> I meant that we want to change "remote add -h" to show this here; and=
 the
> reason why I doubted "the value of reusing option string" was because=
 I
> wanted to do so without touching the concise list of the subcommands =
and
> their options given by "remote -h".  Otherwise, it would have made pe=
rfect
> sense to use preprocessor macros to share the two identical strings.

Okay, I believe I understand now, but let's test that theory ;)

Using the 'add' subcommand as an example, the desired output is:

Output of 'git remote -h':
    "git remote [-v | --verbose]"
    "git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> =
<url>"
    etc.

Output of 'git remote add -h':
    "git remote add [<options>...] <name> <url>"
    followed by the detailed description given by 'parse_options()'.

Text in 'man git-remote':
    "git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> =
<url>"
    with the options explained in detail later in the file.

Thanks for your patience,
Tim
