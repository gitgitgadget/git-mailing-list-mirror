From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Display the date of a tag in a human friendly way.
Date: Fri, 04 Jan 2013 15:50:35 -0800
Message-ID: <7vhamwse2c.fsf@alter.siamese.dyndns.org>
References: <1357314431-32710-1-git-send-email-wildfire@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anand Kumria <wildfire@progsoc.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 00:50:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrH2Q-0006vB-1t
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 00:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344Ab3ADXuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 18:50:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749Ab3ADXui (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 18:50:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 102DCB87A;
	Fri,  4 Jan 2013 18:50:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kcm0fHqKBiJOa4AA4NSEoUHOp6Y=; b=dne/mD
	Vli9Widp0yByHKiiHpXH/dOWSvDnNuiGIdxmubhI3cq2+fdM6qibmgSpARMbrOeD
	BSpEyyEM8Fhjc9YMf1MxofZ7o3ZpTbXaftYJXPPq4Y4s9vGYCodJV11TnJemeBMg
	2gBgdjk6psU2s9iLJh5nDW/hSNpYazRC3Ul3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ax3q1/Y8Y/RIMbXgbe7LgRl33N+dfUtB
	ZgqB9r+O8xdia87QS6q553Kn9cJ0ZaxCrZvX+lm+ZqrYNG+QTJyMYBm3gjD2Bws1
	W/Sjd8n3x56RnNHG0ttEnxd5+HiULm1leNpakc8mwJ6rM0vJVyOfABQsydIto4rg
	/K3ffYXoq5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01A72B879;
	Fri,  4 Jan 2013 18:50:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A622B878; Fri,  4 Jan 2013
 18:50:37 -0500 (EST)
In-Reply-To: <1357314431-32710-1-git-send-email-wildfire@progsoc.org> (Anand
 Kumria's message of "Fri, 4 Jan 2013 15:47:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89BC6DE8-56C9-11E2-9CC5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212656>

Anand Kumria <wildfire@progsoc.org> writes:

> By selecting a tag within gitk you can display information about it.
> This information is output by using the command
>
>  'git cat-file tag <tagid>'
>
> This outputs the *raw* information from the tag, amongst which is the
> time - in seconds since the epoch. As useful as that value is, I find it
> a lot easier to read and process time which it is something like:
>
>  "Mon Dec 31 14:26:11 2012 -0800"
>
> This change will modify the display of tags in gitk like so:
>
>   @@ -1,7 +1,7 @@
>    object 5d417842efeafb6e109db7574196901c4e95d273
>    type commit
>    tag v1.8.1
>   -tagger Junio C Hamano <gitster@pobox.com> 1356992771 -0800
>   +tagger Junio C Hamano <gitster@pobox.com> Mon Dec 31 14:26:11 2012 -0800
>
>    Git 1.8.1
>    -----BEGIN PGP SIGNATURE-----
>
> Signed-off-by: Anand Kumria <wildfire@progsoc.org>
> ---

Sounds like a sensible thing to do but I didn't check how else
(other than purely for displaying) this string is used.

Paul, the patch is not made against your tree, so if you choose to
take it you would need to strip the leading directory at the top.

Thanks.

PS. I haven't received a pull request from you for a while; are
there accumulated changes I should be pulling in before -rc0 of the
next release we are working on?

>  gitk-git/gitk |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index d93bd99..aae1c58 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -10675,7 +10675,7 @@ proc showtag {tag isnew} {
>      set linknum 0
>      if {![info exists cached_tagcontent($tag)]} {
>  	catch {
> -           set cached_tagcontent($tag) [exec git cat-file tag $tag]
> +           set cached_tagcontent($tag) [exec git cat-file -p $tag]
>  	}
>      }
>      if {[info exists cached_tagcontent($tag)]} {
