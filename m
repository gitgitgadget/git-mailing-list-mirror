From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv4 2/4] parse-remote: support default reflist in 
	get_remote_merge_branch
Date: Fri, 12 Jun 2009 08:58:07 +0200
Message-ID: <adf1fd3d0906112358oad66387u46765919b63af816@mail.gmail.com>
References: <1244759961-4750-1-git-send-email-santi@agolina.net>
	 <1244759961-4750-3-git-send-email-santi@agolina.net>
	 <7vocsucfn7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 08:58:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF0iQ-00007H-V4
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 08:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800AbZFLG6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 02:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbZFLG6I
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 02:58:08 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:64247 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbZFLG6G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 02:58:06 -0400
Received: by bwz9 with SMTP id 9so1889575bwz.37
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 23:58:08 -0700 (PDT)
Received: by 10.204.113.12 with SMTP id y12mr3275889bkp.214.1244789887845; 
	Thu, 11 Jun 2009 23:58:07 -0700 (PDT)
In-Reply-To: <7vocsucfn7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121393>

2009/6/12 Junio C Hamano <gitster@pobox.com>:
> Santi B=E9jar <santi@agolina.net> writes:
>
>> Expand get_remote_merge_branch to compute the tracking branch to mer=
ge
>> when called without arguments (or only the remote name).
>
> I've queued this series (sans 3/4--see other message), but I am wonde=
ring
> if this has the same "only works with the defeault layout" issue and =
if so
> if it should be documented more clearly.

As it uses:

git for-each-ref --format=3D'%(upstream)' $curr_branch

it works with any layout, AFAICS.

>
> What plumbing support do you need to get the information in a more pr=
ecise
> way in the scripted Porcelain? =A0Is exposing branch_get() from remot=
e.c
> enough? =A0That is what is used by fill_tracking_info() in builtin-br=
anch.c
> and the call to format_tracking_info() remote.c made by report_tracki=
ng()
> in builtin-checkout.c --- they are used to produce the "Your branch i=
s
> ahead of that branch you are tracking" messages.

=46or the explicit case I would need something similar, given the remot=
e
name and the remote branch return the tracking branch, as is currently
done in branch_get() but with the remote.$branch.remote and
remote.$branch.merge as input.

Thanks,
Santi
