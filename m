From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv3 1/4] parse-remote: function to get the tracking branch 
	to be merge
Date: Tue, 9 Jun 2009 09:29:28 +0200
Message-ID: <adf1fd3d0906090029s2aa7fe19j7b1005997d70b92c@mail.gmail.com>
References: <1244451651-22651-2-git-send-email-santi@agolina.net>
	 <7v8wk2wbfs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 09:29:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDvm4-0005CZ-9Z
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 09:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757177AbZFIH32 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 03:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756820AbZFIH31
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 03:29:27 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:54427 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756697AbZFIH31 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 03:29:27 -0400
Received: by bwz9 with SMTP id 9so3593868bwz.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 00:29:28 -0700 (PDT)
Received: by 10.204.63.208 with SMTP id c16mr7105367bki.131.1244532568205; 
	Tue, 09 Jun 2009 00:29:28 -0700 (PDT)
In-Reply-To: <7v8wk2wbfs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121149>

2009/6/9 Junio C Hamano <gitster@pobox.com>:
> Santi B=E9jar <santi@agolina.net> writes:
>
>> The only user of get_remote_refs_for_fetch was "git pull --rebase" a=
nd
>> it only wanted the tracking branch to be merge. So, add a simple
>> function with this new meaning.
>>
>> No behavior changes.
>
> I am all for code reduction, but after following the original logic t=
hat
> uses remote_refs_for_fetch (which knows about things like "git pull t=
here
> +refs/heads/master:refs/heads/origin tag v1.6.0" from the command lin=
e)
> that in turn calls canon_refs_list_for_fetch (which returns a list e.=
g.
> +refs/heads/master:refs/heads/origin refs/tags/v1.6.0:refs/tags/v1.6.=
0),
> and do not quite see how you can casually say "No behaviour changes."

Ups, you are right. But even in you case the only important branch is
the first, so the only possible change in behavior is:

git pull --rebase tags v1.6.0

I'll see what I can do.

Thanks for the review,
Santi
