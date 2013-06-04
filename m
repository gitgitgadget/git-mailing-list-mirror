From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/README: test_must_fail is for testing Git
Date: Tue, 04 Jun 2013 13:49:15 -0700
Message-ID: <7v1u8h7gac.fsf@alter.siamese.dyndns.org>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com>
	<CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com>
	<CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com>
	<51A62A96.6040009@gmail.com> <51A665E4.9080307@gmail.com>
	<CACsJy8D4wmhGkEsn8r5OEQv_hX=OFD5W8abnBnYFcFCQZfLOoQ@mail.gmail.com>
	<7vk3mcnwlj.fsf@alter.siamese.dyndns.org>
	<7vppw195x7.fsf_-_@alter.siamese.dyndns.org>
	<AAD729AEE8D044B89388799A7CC7552A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Karsten Blees" <karsten.blees@gmail.com>,
	"Duy Nguyen" <pclouds@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 22:49:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjyAW-0000Vi-33
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 22:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387Ab3FDUtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 16:49:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279Ab3FDUtT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 16:49:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E67D0257EF;
	Tue,  4 Jun 2013 20:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+YQndOcPqmM1FcoG0NASaKEZl8U=; b=xAHOc/
	5W28UVdC5YEtny8lLeHPyvpEp+rCOiKSjhuqMeQyQlGk0F8y1rwyQRUkO4yEE1gy
	ci8Re3Os4TQQ1ftPWq3jE4hpIZlGmQwOBX0Vxc3wO5AR8BNNIKa9OPJpeezTfvfu
	2H7fzpvWpKbmmmb0VTppmSMpWSUtAloLXd8bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a6SnVDkDQks/YyDgu5rHMc4F4IPNT46V
	jGdkvbhBwLj3vL8fYybhrNFsxdrs21E/clBX0422pRQ0R5Pl0R7DDsyw2KXFwX15
	Njy5KKqK2k25BuzV6csvt3y4ph++bBvbHefYqJEdshXFU31ybgTe8twXG3qq/D7j
	HylKsoZRIEM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92E2B257EE;
	Tue,  4 Jun 2013 20:49:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A9BE257E6;
	Tue,  4 Jun 2013 20:49:17 +0000 (UTC)
In-Reply-To: <AAD729AEE8D044B89388799A7CC7552A@PhilipOakley> (Philip Oakley's
	message of "Tue, 4 Jun 2013 21:16:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 392EBF10-CD58-11E2-9B46-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226400>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Tuesday, June 04, 2013 5:50 PM
>> When a test wants to make sure there is no <string> in an output
>> file, we should just say "! grep string output";
>
> Small nit: It took me two readings of the commit message to correctly
> parse this break point. The flowing together of the two parts with the
> semicolon fooled me. Separate them?
>
>>      "test_must_fail"
>> is there only to test Git command and catch unusual deaths we know
>> about (e.g. segv) as an error, not as an expected failure.

Thanks.  Does this read better?

    t/README: test_must_fail is for testing Git
    
    When a test wants to make sure there is no <string> in an output
    file, we should just say "! grep string output".
    
    "test_must_fail" is there only to test Git command and catch unusual
    deaths we know about (e.g. segv) as an error, not as an expected
    failure.  "test_must_fail grep string output" is unnecessary, as
    we are not making sure the system binaries do not dump core or
    anything like that.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
