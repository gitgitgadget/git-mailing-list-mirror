From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/21] refs: always handle non-normal refs in files backend
Date: Tue, 12 Jan 2016 16:19:26 -0800
Message-ID: <xmqqfuy2qqk1.fsf@gitster.mtv.corp.google.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
	<1452561740-8668-15-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 01:19:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ9A1-0004f8-2Z
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 01:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309AbcAMATc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 19:19:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63996 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754264AbcAMAT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 19:19:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD31D3BF36;
	Tue, 12 Jan 2016 19:19:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=IXWTaZAw+Psy5mdz8t2g/61c+iI=; b=fusoUHNGLZ9nQJfLxzY/
	+BUj6H2FsfYlE2AViSh6W0YPaqYFxAgsfiY5Q9vh+w8R2GFU1fOi0R2aCeZ+ff2x
	Z8YyS1s86PLIfUh9kTxMZ3EnOBhNKZ6+20OtiKr1wBofJhvlMrewWL/DW9PKoM1j
	fcYpw4cwPnRzrgc6aAUCuzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Ra5GmdGZ3KkxNr9SpzxEYD+QWWi1XvjwhRkzwgs1oDSnEk
	3gUzZ5WTM4/ACTW7Ph9V8vEl1S/KfB8wyPFrkUUpcT8k8aDfQD4cF/TV/ZSxDyR/
	aSp/cbtAFqB37MgmLauB4mNwPjfrE61glJ9Pt/EVLveuU2a/e2lpPpAjBTB8s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A55C23BF35;
	Tue, 12 Jan 2016 19:19:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 281303BF34;
	Tue, 12 Jan 2016 19:19:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4E695594-B98B-11E5-9E15-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283861>

David Turner <dturner@twopensource.com> writes:

>  int ref_transaction_commit(struct ref_transaction *transaction,
>  			   struct strbuf *err)
>  {
>  	int ret = -1;
>  	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
> +	struct string_list files_affected_refnames = STRING_LIST_INIT_NODUP;
> +	struct string_list_item *item;

This variable is never used (at least at the end of the series after
applying up to 21/21).
