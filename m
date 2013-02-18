From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] contrib/subtree: Use %B for split subject/body
Date: Mon, 18 Feb 2013 14:43:25 -0800
Message-ID: <7va9r19raq.fsf@alter.siamese.dyndns.org>
References: <1361221013-12756-1-git-send-email-greened@obbligato.org>
 <1361221013-12756-2-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>,
	James Nylen <jnylen@gmail.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 23:43:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7ZR9-0006X1-T4
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 23:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486Ab3BRWn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 17:43:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757416Ab3BRWn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 17:43:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BD87B5BD;
	Mon, 18 Feb 2013 17:43:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1fVimmphfnk+/0vuiynF2MBIRfk=; b=rq56N5
	0vYC0YEx2Nebusw5rBNQRhw8p6/llJJOVWbxAznkaoFfsgK5bxHmzfCRSrPQzTe+
	QmDcU7iytJig5pwKqIEoaoeYnMKedI3PPONx6emVeOa49ueYQErF+Y2ZpA8JFEyU
	2UGpi+iBgIMMFD1KyaLsL+/lgVMHtn5ck8hUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tkNtDD+zw8TWC5lKTYVpinDsmF6FrLeS
	w+dJ40SPi9URzH8neJYH/xa/F4/lXtBD3XBEYJ88wv3c0w0IsJ89L9hE8Wed3txC
	ZyV2/qWRrG+yzxVKJoas3OUtqkYBL3KB4L/9GnLQr7f3a4VPu3rdNoQcuMsZo+Md
	0GkfRbeG0pc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CE79B5BC;
	Mon, 18 Feb 2013 17:43:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE424B5BA; Mon, 18 Feb 2013
 17:43:26 -0500 (EST)
In-Reply-To: <1361221013-12756-2-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Mon, 18 Feb 2013 14:56:46 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BDDE440-7A1C-11E2-BEED-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216542>

"David A. Greene" <greened@obbligato.org> writes:

> From: Techlive Zheng <techlivezheng@gmail.com>
>
> Use %B to format the commit message and body to avoid an extra newline
> if a commit only has a subject line.
>
> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  contrib/subtree/t/t7900-subtree.sh |   11 +++++++++++
>  1 file changed, 11 insertions(+)

Huh?

This seems to be a repeat of the test added in a5b8e28e4eb5
(contrib/subtree: use %B for split subject/body, 2013-02-04) and
nothing else, excluding the actual change to git-subtree itself.

Confused....

>
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 80d3399..8dd6a82 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -226,6 +226,17 @@ test_expect_success 'check hash of split' '
>  	check_equal ''"$new_hash"'' "$subdir_hash"
>  '
>  
> +test_expect_success 'check hash of split' '
> +        spl1=$(git subtree split --prefix subdir) &&
> +        undo &&
> +        git subtree split --prefix subdir --branch splitbr1test &&
> +        check_equal ''"$(git rev-parse splitbr1test)"'' "$spl1"
> +        git checkout splitbr1test &&
> +        new_hash=$(git rev-parse HEAD~2) &&
> +        git checkout mainline &&
> +        check_equal ''"$new_hash"'' "$subdir_hash"
> +'
> +
>  test_expect_success 'check split with --branch for an existing branch' '
>          spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
>          undo &&
