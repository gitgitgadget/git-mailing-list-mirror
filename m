From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] graph API: fix bug in graph_is_interesting()
Date: Fri, 21 Aug 2009 17:39:16 +0200
Message-ID: <adf1fd3d0908210839s35da944co4ba4079f6216b44c@mail.gmail.com>
References: <1250628954.114121983@192.168.1.201>
	 <20090818211812.GL8147@facebook.com>
	 <7vk5103chi.fsf@alter.siamese.dyndns.org>
	 <20090819022918.GO8147@facebook.com>
	 <20090819023433.GP8147@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Adam Simpkins <simpkins@facebook.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 17:39:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeWDA-0007pI-8A
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 17:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbZHUPjR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2009 11:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbZHUPjQ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 11:39:16 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:45983 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932440AbZHUPjQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 11:39:16 -0400
Received: by ewy3 with SMTP id 3so736855ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 08:39:17 -0700 (PDT)
Received: by 10.216.87.133 with SMTP id y5mr224599wee.88.1250869156129; Fri, 
	21 Aug 2009 08:39:16 -0700 (PDT)
In-Reply-To: <20090819023433.GP8147@facebook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126734>

On Wed, Aug 19, 2009 at 4:34 AM, Adam Simpkins<simpkins@facebook.com> w=
rote:
> Previously, graph_is_interesting() did not behave quite the same way =
as
> the code in get_revision(). =A0As a result, it would sometimes think
> commits were uninteresting, even though get_revision() would return
> them. =A0This resulted in incorrect lines in the graph output.
>
> This change creates a get_commit_action() function, which
> graph_is_interesting() and simplify_commit() both now use to determin=
e
> if a commit will be shown. =A0It is identical to the old simplify_com=
mit()
> behavior, except that it never calls rewrite_parents().
>
> This problem was reported by Santi B=E9jar. =A0The following command
> would exhibit the problem before, but now works correctly:
>
> =A0git log --graph --simplify-by-decoration --oneline v1.6.3.3
>
> Previously git graph did not display the output for this command
> correctly between f29ac4f and 66996ec, among other places.

Thanks, the fix works (no comments about the code, only the behavior).

One more thing Junio. In 99af022 (graph API: fix bug in
graph_is_interesting(), 2009-08-18) in 'pu' my name is mispelled, it
seems it was interpreted as latin1, then recoded as UTF8, interpreted
as latin and recoded to latin1, or in other words the =E9 is 4 bytes
instead of two. I've checked this mail and it is latin1, correctly
specified in the headers.

Thanks,
Santi
