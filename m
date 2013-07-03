From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change "remote tracking" to "remote-tracking"
Date: Wed, 03 Jul 2013 13:33:19 -0700
Message-ID: <7vy59ncrjk.fsf@alter.siamese.dyndns.org>
References: <1372842754-13366-1-git-send-email-mschub@elegosoft.com>
	<20130703183851.GR408@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Schubert <mschub@elegosoft.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Pete Wyckoff <pw@padd.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 22:33:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuTk1-0005Y6-0w
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 22:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229Ab3GCUdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 16:33:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756179Ab3GCUdX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 16:33:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B1B52D571;
	Wed,  3 Jul 2013 20:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dt9TB/gmfKG4m6+qg0zGK2hdtis=; b=xaAxpG
	m1A0EBYTBTfDlta0b3KfSAWbLMKzvvSAiXv2ehFFxWaSXRFaCWx3Gjfdmf3AFq6e
	xhsKBTbR0ffh5AZ+PqSr/FwqO1E4fkHiVCtjLXPO2HT6ckni9T/FkeLRwkj0b21q
	JpY1X7xXd13rEeV+nBH4QOEGZIgSgdlBmdsj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g/06fiecVDdrPT+K+LjnwkJzYT5w7pIY
	76UEKa63ggn7fIctyB8Y/Kra+T7jiYiTWvaP6LSyfIw3cjWf0cU//yBFUUEWCbPj
	xZ+ywF1EHMsb6gHG3TBxDANfz9797UAs9dMckpLyp42VYBIqhrg85r4cSOM9hNsh
	5IThFCc7cp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AAE92D570;
	Wed,  3 Jul 2013 20:33:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB6B62D56C;
	Wed,  3 Jul 2013 20:33:20 +0000 (UTC)
In-Reply-To: <20130703183851.GR408@google.com> (Jonathan Nieder's message of
	"Wed, 3 Jul 2013 11:38:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCFB2B6A-E41F-11E2-B1FE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229526>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Michael Schubert wrote:
>
>> --- a/Documentation/git-p4.txt
>> +++ b/Documentation/git-p4.txt
>> @@ -180,7 +180,7 @@ subsequent 'sync' operations.
>>  	Import changes into given branch.  If the branch starts with
>>  	'refs/', it will be used as is.  Otherwise if it does not start
>>  	with 'p4/', that prefix is added.  The branch is assumed to
>> -	name a remote tracking, but this can be modified using
>> +	name a remote-tracking, but this can be modified using
>>  	'--import-local', or by giving a full ref name.  The default
>>  	branch is 'master'.
>
> This is confusing both before and after the patch.  What is "a remote
> tracking"?
>
> Perhaps:
>
> 	--branch <ref>::
> 		Import changes into <ref> instead of refs/remotes/p4/master.
> 		If <ref> starts with refs/, it is used as is.  Otherwise, if
> 		it does not start with p4/, that prefix is added.
> 	+
> 	By default a <ref> not starting with refs/ is treated as the
> 	name of a remote-tracking branch (under refs/remotes/).  This
> 	behavior can be modified using the --import-local option.
> 	+
> 	The default <ref> is "master".
>
> The rest of the patch looks good.

Myy reading did hiccup at the same "remote-tracking" used as if it
were a noun, and your rewritten version reads much better.

Thanks.
