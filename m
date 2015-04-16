From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib-functions.sh: fix the second argument to some helper functions
Date: Thu, 16 Apr 2015 13:31:31 -0700
Message-ID: <xmqq8udrizmk.fsf@gitster.dls.corp.google.com>
References: <1429193527-1528-1-git-send-email-gitter.spiros@gmail.com>
	<vpqoamop28y.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 16 22:32:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiqSE-0005we-QM
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 22:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbbDPUbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 16:31:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753503AbbDPUbf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 16:31:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 855414AF9B;
	Thu, 16 Apr 2015 16:31:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bLj7Hj77Q5biIlSBx5DVPmUDSYQ=; b=nL9QwT
	OHjyCSddZy0Y4jLtbudsnTxH3jhFn1LAQUEscYtJMPu4Qn+XZ6zPU88jPRN/TcdM
	ZQVb0qHXDIt/GDih3j46OFtjp1E8oWDQcQtPnhmThZl7w9y6cFch2XIPf4uD+0TW
	HDJM3v68ee2iEmdHZcEelbvf3KLg7fhVWkH/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gLv3bTRI6MfA8thD5X/s6uK4OroD+n3N
	ReDRFk7+md4d7SlWi2RmFD6cmrJT/871O8nAwGgYjtNb5AtE8QC4AL+x2mUGS7xS
	B7WMe7YZFO/33vpsupRuNNVuKqQ9fOKeaAZXbCJGC6L7tFeJli7XTe5cTqU/UgU+
	h9SqbOVVwgQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D9B94AF9A;
	Thu, 16 Apr 2015 16:31:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 083CC4AF99;
	Thu, 16 Apr 2015 16:31:32 -0400 (EDT)
In-Reply-To: <vpqoamop28y.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	16 Apr 2015 16:38:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 920C4D86-E477-11E4-A533-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267332>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -478,7 +478,7 @@ test_external_without_stderr () {
>>  test_path_is_file () {
>>  	if ! test -f "$1"
>>  	then
>> -		echo "File $1 doesn't exist. $*"
>> +		echo "File $1 doesn't exist. $2"
>>  		false
>>  	fi
>>  }
>> @@ -486,7 +486,7 @@ test_path_is_file () {
>>  test_path_is_dir () {
>>  	if ! test -d "$1"
>>  	then
>> -		echo "Directory $1 doesn't exist. $*"
>> +		echo "Directory $1 doesn't exist. $2"
>>  		false
>>  	fi
>>  }
>
> Sounds straightforwardly correct to me.

Thanks.  This however makes me wonder why you were nominated for
reviewing this patch, though...
