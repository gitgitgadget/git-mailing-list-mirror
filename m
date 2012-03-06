From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Fix a warning about conversion to float
Date: Tue, 06 Mar 2012 10:58:22 -0800
Message-ID: <7v62ehtv3l.fsf@alter.siamese.dyndns.org>
References: <1331024077-5736-1-git-send-email-user@vincent-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 19:58:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4zai-0004w8-EJ
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 19:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756413Ab2CFS60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 13:58:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755247Ab2CFS6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 13:58:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D4BF5786;
	Tue,  6 Mar 2012 13:58:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iHLMvIf5M4SP1g/iao8mQqSgq9c=; b=qMz2pP
	iegqsiDV9LSTzA85YMW8awhsoO4nvYRbzmvlGN01NidrxnjUh0ZmN/VOybMSHFMS
	1RavMX80wriXCfto0WNYUEjmt9OForfbzm5ReWzIZ0a1F+1kGQuzFcV2033sW3mi
	ZOyQjnscN3DchQ+pbLvfurdcZqXfquNteYeIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mrLQrIGV7njmc3uUT+9HOylB2xAhOush
	2Tvf2rhZ1HclZDBiozDM2KGMSzP1v0+6n3+YPpfe611aOKIc1s5d+rN9V/TOawwp
	/IAVeyk3f1kWagYAJXGEM0uzRQaFyVKHL/+iPthVOjyaYHWfHdJP3+hQaZw53kmt
	6bOvc2vIjtY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 144375785;
	Tue,  6 Mar 2012 13:58:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E4065783; Tue,  6 Mar 2012
 13:58:23 -0500 (EST)
In-Reply-To: <1331024077-5736-1-git-send-email-user@vincent-VirtualBox>
 (Vincent van Ravesteijn's message of "Tue, 6 Mar 2012 09:54:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 593F2E30-67BE-11E1-94D0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192375>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> From: Vincent van Ravesteijn <vfr@lyx.org>
>
> Below in the same function, val is correctly casted to a float. Do this also
> for the initialization of x.

Hrm, is it correctly casted or needlessly casted?

It is unclear what problem you are trying to solve here.

> @@ -550,6 +550,7 @@ static int sqrti(int val)
>  	return (int)x;
>  }
>  
> +
>  static struct commit_list *skip_away(struct commit_list *list, int count)

Huh?
