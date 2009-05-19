From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log 
	--graph
Date: Tue, 19 May 2009 18:45:10 +0200
Message-ID: <36ca99e90905190945m1ecea6bka99946783ea1d22a@mail.gmail.com>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090519110800.GB28702@noris.de>
	 <36ca99e90905190448k64ee18afw8abc49bd90ecb58f@mail.gmail.com>
	 <20090519131044.GD28702@noris.de>
	 <36ca99e90905190632q656a5855qe7624902ef82a3da@mail.gmail.com>
	 <20090519133947.GE28702@noris.de>
	 <36ca99e90905190651tfed03f9ha87ca32b3aee2599@mail.gmail.com>
	 <20090519140920.GF28702@noris.de>
	 <36ca99e90905190714l15a13483p2a76ab7f630bd8bb@mail.gmail.com>
	 <36ca99e90905190732g53599cb8y142a137bc79ad655@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Michael Radziej <mir@noris.de>
X-From: git-owner@vger.kernel.org Tue May 19 18:45:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6SRP-0004uA-KO
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 18:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbZESQpN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 12:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752952AbZESQpN
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 12:45:13 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:31293 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbZESQpM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 12:45:12 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1912132fkq.5
        for <git@vger.kernel.org>; Tue, 19 May 2009 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YZ8wPCBffGZq1E6qYIdtW+GETufwvXvpje1RiqgFSQ8=;
        b=i2QW8CfKbz9gsU3yaJsrJpFi3KVvzIacru+RjSnjH5mIy276MyeRDhUhwbTPvd/8sR
         dFOgpd781w89ZEU5M5Cap1/1DquXe1d82tKb1XfoMWWEWOn6nkhYwxuEKe+xwmq7yLT/
         ddAOYuno6H2QnWd8VVgPm+J8g95eiKZWCzV9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cq4yb2Cu/DTiGZ393cCTtt4L2Ppo4Ee3oXFvs+mPwaun2o+uUBLl3B7SizoxpzNGM/
         5DNR7umE2cEwCFq+HxWMMLiogRs9meiP8L1VatFbOCSlUEZ5uXnUUc4pbTrALHbJxLm5
         9zuIhx/OzpbCbuqI86B0Nn696T8XjuQsrd36E=
Received: by 10.223.114.207 with SMTP id f15mr221016faq.90.1242751510823; Tue, 
	19 May 2009 09:45:10 -0700 (PDT)
In-Reply-To: <36ca99e90905190732g53599cb8y142a137bc79ad655@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119548>

On Tue, May 19, 2009 at 16:32, Bert Wesarg <bert.wesarg@googlemail.com>=
 wrote:
> On Tue, May 19, 2009 at 16:14, Bert Wesarg <bert.wesarg@googlemail.co=
m> wrote:
>> On Tue, May 19, 2009 at 16:09, Michael Radziej <mir@noris.de> wrote:
>>> I see another issue. On a quite complicated repository, I did the "=
tg
>>> summary --graphviz ... edit ... =C2=A0graphviz ..." dance, and ther=
e I get the
>>> following output:
>>>
>>> mir@mir:otrs-git$ cat /tmp/graph | gvpr -f ~/src/topgit/share/graph=
=2Egvpr
>>> gvpr: "/home/mir/src/topgit/share/graph.gvpr", line 936: gg_nl_ret =
+=3D
>>> graph_output_commit_line();<<<
>>> =C2=A0-- cannot convert node_t to string
>> Ok, still two unrelated problems.
> And still I can't reproduce it here :(
I found a missing rename which causes random segfaults.

Here the diff:

--- a/share/graph.gvpr
+++ b/share/graph.gvpr
@@ -523,7 +523,7 @@ BEGIN {
                  * print the branch lines as "|".
                  */
                 if (gg_prev_state =3D=3D GRAPH_POST_MERGE &&
-                    gg_prev_commit_index < gg_opcl_i)
+                    gg_prev_n_index < gg_opcl_i)
                     gg_opcl_sb +=3D gg_write_column(gg_columns[gg_opcl=
_i], "\\");
                 else
                     gg_opcl_sb +=3D gg_write_column(gg_columns[gg_opcl=
_i], "|");

patch tomorrow

Bert
