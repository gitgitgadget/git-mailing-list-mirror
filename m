From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] cvsimport: partial whitespace cleanup
Date: Fri, 26 Nov 2010 22:33:15 -0800
Message-ID: <7v8w0fp978.fsf@alter.siamese.dyndns.org>
References: <939dff25f5a58b6f37cf21bf490b2782f6e96f39.1290697830.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Nov 27 07:33:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMELl-0004Pb-0r
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 07:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147Ab0K0Gd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 01:33:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab0K0Gd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 01:33:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F10F376E;
	Sat, 27 Nov 2010 01:33:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Zk5ZdZPLp2ZVn2VxMGPN/nhElM=; b=SrKOhk
	hKpCDMTCibCOwkxqVGLCpg1WjwS7eHJ86ljPd6+DRLidpCvxTV8b07YDm76O+lFl
	eGdC1s5jVWPMTEv6cqp7Ryynnm6Vh3En2IsUFf9qVLml54lfLpiEQJfaYRgZpVH5
	Kx6VqlexFe6KMuKaLgmy+6GG4VqUjC2DrIyoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hB+1X4e1xMMHIcyx5v5288Wr5kNWbX/o
	9sy/cVbMt3XrUPYiJYZLVw80gHBnNVJCPKKzYdv0+1BeSYXeyYhoI7VE2kwPHqXs
	DV9czt8Tr62uNMUNOnsj2rhYL5/SPSuYMWFD7564naJwSsjZZi+Si8SHdDZ7ghf7
	IYJ38Sp5WVk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F02A9376D;
	Sat, 27 Nov 2010 01:33:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 21B27376C; Sat, 27 Nov 2010
 01:33:33 -0500 (EST)
In-Reply-To: <939dff25f5a58b6f37cf21bf490b2782f6e96f39.1290697830.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu\, 25 Nov 2010 16\:10\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 43CDEB96-F9F0-11DF-8F72-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162301>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> @@ -100,13 +100,13 @@ sub read_repo_config {
>  		my $arg = 'git config';
>  		$arg .= ' --bool' if ($o !~ /:$/);
>  
> -        chomp(my $tmp = `$arg --get cvsimport.$key`);
> +		chomp(my $tmp = `$arg --get cvsimport.$ckey`);

At this point in the series you haven't introduced $ckey yet, hence this
will break, no?
