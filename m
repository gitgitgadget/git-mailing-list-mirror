From: "Spencer E. Olson" <olsonse@umich.edu>
Subject: Re: Git submodule update and the --merge flag when submodule is yet to be checked out
Date: Fri, 18 Mar 2011 14:24:40 -0700
Message-ID: <201103181524.40521.olsonse@umich.edu>
References: <AANLkTikJo_pjSAmVV3wjWi04io4zWb-_P5p81TYj9tq6@mail.gmail.com> <7vipvgw3c1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carl =?utf-8?q?F=C3=BCrstenberg?= <azatoth@gmail.com>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:24:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0hAE-0004V9-L0
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 22:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503Ab1CRVYu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 17:24:50 -0400
Received: from smtp.mail.umich.edu ([141.211.12.86]:39484 "EHLO
	tombraider.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757428Ab1CRVYt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 17:24:49 -0400
Received: FROM localhost (cadash.gpcc.itd.umich.edu [141.211.2.218])
	By tombraider.mr.itd.umich.edu ID 4D83CD9D.6C7F7.28704 ;
	Authuser olsonse;
	18 Mar 2011 17:24:45 EDT
User-Agent: KMail/1.9.4
In-Reply-To: <7vipvgw3c1.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169364>

Yes, this was the intent of this fix last month

On Friday 18 March 2011 15:01, Junio C Hamano wrote:
> Carl F=C3=BCrstenberg <azatoth@gmail.com> writes:
> > Sorry for re-posting the question but I though I should explain the
> > issue better and to fix the subject line.
> > sub
> > When you are cloning repository containing submodules, and you are
> > using the --merge flag to "git submodule update" the first time, th=
en
> > the submodule instance in question will assume you want to delete a=
ll
> > files present in the module.
>
> Is this something we fixed last month?
>
> commit 1b4735d9f3e0b7ea62c7c22f0afcb45e10c46c7e
> Author: Spencer E. Olson <olsonse@umich.edu>
> Date:   Thu Feb 17 09:18:45 2011 -0700
>
>     submodule: no [--merge|--rebase] when newly cloned
>
>     "git submodule update" can be run with either the "--merge" or
> "--rebase" option, or submodule.<name>.update configuration variable =
can be
> set to "merge" or "rebase, to cause local work to get integrated when
> updating the submodule.
>
>     When a submodule is newly cloned, however, it does not have a che=
ck out
>     when a rebase or merge is attempted, leading to a failure.  For n=
ewly
>     cloned submodules, simply check out the appropriate revision.  Th=
ere is
> no local work to integrate with for them.
>
>     Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
>     Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
