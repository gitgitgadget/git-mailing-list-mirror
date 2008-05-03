From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/5] diff.c: Remove code redundancy in diff_words_show
Date: Sat, 03 May 2008 11:20:54 -0700
Message-ID: <7vr6cjtfjt.fsf@gitster.siamese.dyndns.org>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
 <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 20:22:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsMMx-0000l1-AF
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 20:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbYECSVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 14:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbYECSVJ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 14:21:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbYECSVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 14:21:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 52196280F;
	Sat,  3 May 2008 14:21:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 89F4F280D; Sat,  3 May 2008 14:21:01 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B221D210-193D-11DD-A240-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81111>

Ping Yin <pkufranky@gmail.com> writes:

> +static mmfile_copy_set_boundary(mmfile_t *dest, mmfile_t *src) {

cc1: warnings being treated as errors
diff.c:464: warning: return type defaults int

> +	int i;
> +
> +	dest->size = src->size;
> +	dest->ptr = xmalloc(dest->size);
> +	memcpy(dest->ptr, src->ptr, dest->size);
> +	for (i = 0; i < dest->size; i++)
> +		if (isspace(dest->ptr[i]))
> +			dest->ptr[i] = '\n';
> +}
> +
>  /* this executes the word diff on the accumulated buffers */
>  static void diff_words_show(struct diff_words_data *diff_words)
>  {
> @@ -444,20 +455,9 @@ static void diff_words_show(struct diff_words_data *diff_words)
>  	int i;

diff.c:482: warning: unused variable 'i'
