From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc git: multivar configuration parameters append to existing values
Date: Mon, 16 Jun 2014 14:10:50 -0700
Message-ID: <xmqqfvj4pnl1.fsf@gitster.dls.corp.google.com>
References: <1402922952-172-1-git-send-email-philipoakley@iee.org>
	<xmqqd2e8r8yz.fsf@gitster.dls.corp.google.com>
	<708AD97F308249A1B61D9348AFE59182@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "GitList" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"Robert Clausecker" <fuz@fuz.su>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Tanay Abhra" <tanayabh@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 23:11:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WweBF-0004KM-5W
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 23:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038AbaFPVK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 17:10:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52911 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582AbaFPVK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 17:10:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 16A5B216C3;
	Mon, 16 Jun 2014 17:10:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3pf7mcouijr2zw7ZCv+GIzR19uI=; b=vtuO3+
	BsdCIYrhIhjAWPxJDOeB7tcMUbKiGSR8UJxmMlPiNCDraDRxFvEJuPt3NjF1AUPx
	LlEPKBNZu45ayNEPBfwTYpJlrAQDoBaN8+8/lsomPMij7sLCOA+DkiUI3DzUkLvw
	QJB68o9FaKdAUosyIA36FjLUas8JEE4hWP9Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J+F+YoC44rFSVgdI+b6Cxxq+TkKyYrM+
	OxudkgNx5nuyuyCYa61buoBUACwTYCG7c7APuHBoKdy0KJZOyNb85iEtKpxdWojK
	AicCUnyKE8iAmIbqToR6h65Ud4NtpyhDP9iISjwGO0aTuo6EtLjSNJO46GPgh/Gu
	f//Neou322E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 096DB216C2;
	Mon, 16 Jun 2014 17:10:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 38F77216B2;
	Mon, 16 Jun 2014 17:10:50 -0400 (EDT)
In-Reply-To: <708AD97F308249A1B61D9348AFE59182@PhilipOakley> (Philip Oakley's
	message of "Mon, 16 Jun 2014 20:38:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B182C892-F59A-11E3-82C8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251824>

"Philip Oakley" <philipoakley@iee.org> writes:

>>                                                                   ---once 
>> the reader
>>   understands that Git reads all configuration varilables of the
>>   same name and the code paths that *use* one of them pick the one
>>   defined the last,
> It's this step that's a concern. We shouldn't be forcing the reader to 
> implicitly grok that, especially as we don't actually say it elsewhere 
> (in the regular documentation).

I think that is what I was driving at.  If we do not tell the reader
that, perhaps we should and everything else will fall as natural
consequence of that understanding.

>> * The last sentence added, i.e. "insteadof"-style, will not be
>>   understood by any reader other than those who tried to use "-c"
>>   on remote.*.url variables and does not belong here.  A better
>>   way/place to give that information is needed.
>
> I just wanted to indicate that some multivars do have get-out [override] 
> config parameters, though we aren't consistent about their names yet, 
> while giving a clue as to a typical name style.

I think those who tried "-c remote.*.url" would be helped better by
having a see-also in the documentation on "remote.*.url" that refers
them to "insteadOf" noting that "remote.*.url" is a multi-value
variable and appending different definition will not make "the last
one wins".  After all "-c" is merely *one* way to append.

The next person who gets confused may say "I added remote.origin.url
at the end of my $repo/.git/config expecting that the value to be
used"; the answer would be the same "the variable is multi-valued;
adding a new value is not the right way to futz with it.  You either
need to replace, or if you do not want to replace, use insteadOf".

That is the second reason why the mention of insteadOf does not
belong to the description of "-c var=value".

Perhaps something like this as a starting point?

 Documentation/config.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1d718bd..357cc02 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2108,6 +2108,13 @@ remote.pushdefault::
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
++
+Note that this variable is multi-valued (e.g. "git push there" with
+multiple `remote.there.url` will push to all the named repositories),
+and does not follow the "last-one-survives" rule.  When you want to
+temporarily redirect a push to somewhere else, see `url.<base>.insteadOf`;
+you cannot use "git -c remote.<name>.url=<temporary URL> push", because
+you will be pushing to both the configured place and the temporary place.
 
 remote.<name>.pushurl::
 	The push URL of a remote repository.  See linkgit:git-push[1].
@@ -2419,6 +2426,10 @@ url.<base>.insteadOf::
 	the best alternative for the particular user, even for a
 	never-before-seen repository on the site.  When more than one
 	insteadOf strings match a given URL, the longest match is used.
++
+When you want to redirect a push to `$URL` (e.g. `site.xz:myrepo`) 
+temporarily to somewhere else (e.g. `othersite.xz:myrepo`), you can
+use "git -c url.othersite.xz:myrepo.insteadOf=site.xz:myrepo push ..."
 
 url.<base>.pushInsteadOf::
 	Any URL that starts with this value will not be pushed to;
