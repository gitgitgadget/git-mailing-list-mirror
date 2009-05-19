From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log 
	--graph
Date: Tue, 19 May 2009 16:14:25 +0200
Message-ID: <36ca99e90905190714l15a13483p2a76ab7f630bd8bb@mail.gmail.com>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090519102742.GA28702@noris.de>
	 <36ca99e90905190337y63aeb98ag59ff37688f75ba96@mail.gmail.com>
	 <20090519110800.GB28702@noris.de>
	 <36ca99e90905190448k64ee18afw8abc49bd90ecb58f@mail.gmail.com>
	 <20090519131044.GD28702@noris.de>
	 <36ca99e90905190632q656a5855qe7624902ef82a3da@mail.gmail.com>
	 <20090519133947.GE28702@noris.de>
	 <36ca99e90905190651tfed03f9ha87ca32b3aee2599@mail.gmail.com>
	 <20090519140920.GF28702@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Michael Radziej <mir@noris.de>
X-From: git-owner@vger.kernel.org Tue May 19 16:14:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Q5U-0001DJ-OP
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 16:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbZESOO1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 10:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbZESOO1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 10:14:27 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:44197 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZESOO0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 10:14:26 -0400
Received: by bwz22 with SMTP id 22so3854480bwz.37
        for <git@vger.kernel.org>; Tue, 19 May 2009 07:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Wps8i8HHIAhustBtMt2Z/CEKPHjx6tlMN68Nek4KAck=;
        b=aLJTwKSpYe/OUdGKNBKNPSE4NWd16tJSFo7gcIAjcmSaBoujTPvns0htH4ZCINET2g
         VcvcEl37wn1hCU00ga8x3WEb3CLYnDAB5TKMO7eUg23Nwh7I9sHnhyK6E1nuTSrqH7QZ
         7BvhXWygyDr+9YUzkmTbGKSjq5BCoMN9qp09M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CJKvvMdId3yMakLZmuXQN6bsmTJ1BYaU7a3yRJ1d4ugWVIbuiMvX+9pOdAmk/siTcW
         Xe7L64+m2EPsEUyvcJM/DK6iuCh7ppdad0HMGQkbH2szrJcaWJVnaSwWEPKJ/8XBIBKe
         bi5f/A7W40btXLGbPBvD413halK4YQqGv2owY=
Received: by 10.204.98.141 with SMTP id q13mr70676bkn.188.1242742465952; Tue, 
	19 May 2009 07:14:25 -0700 (PDT)
In-Reply-To: <20090519140920.GF28702@noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119533>

On Tue, May 19, 2009 at 16:09, Michael Radziej <mir@noris.de> wrote:
> On Tue, May 19, Bert Wesarg wrote:
>
>> No its just a formating tab to make the output of summary --graphviz=
 nicer ;-)
>>
>> As martin suggests, you can remove any "\t" from the 'echo' lines in
>> tg-summary or add a '-e' option to it.
>>
>> I will probably post tomorrow an updated patch.
>
> Cool. If I had any knowledge of graphviz I'd really like to help out =
:-(
>
> I see another issue. On a quite complicated repository, I did the "tg
> summary --graphviz ... edit ... =C2=A0graphviz ..." dance, and there =
I get the
> following output:
>
> mir@mir:otrs-git$ cat /tmp/graph | gvpr -f ~/src/topgit/share/graph.g=
vpr
> gvpr: "/home/mir/src/topgit/share/graph.gvpr", line 936: gg_nl_ret +=3D
> graph_output_commit_line();<<<
> =C2=A0-- cannot convert node_t to string
Ok, still two unrelated problems.

>
> I have attached /tmp/graph (the output of tg summary --graphviz), I c=
an't
> find anything that would stick out. I have to prepare this particular
> project a bit before I could push it out to git hub (removing configu=
ration
> part with not-so-public content), do you need it at all?
I think the graphviz output should suffice. thanks.

>
> I'm going to be away from mail for a few hours.
>
>
> Thanks for your efforts!
>
> Michael
