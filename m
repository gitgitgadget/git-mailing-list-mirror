From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] pull/fetch rename
Date: Tue, 20 Oct 2009 23:33:40 -0700
Message-ID: <7v3a5db6ij.fsf@alter.siamese.dyndns.org>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
 <20091021063008.GA3349@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 08:34:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Ulj-00027r-QB
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 08:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbZJUGdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 02:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbZJUGdt
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 02:33:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZJUGdt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 02:33:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B33B7F4E6;
	Wed, 21 Oct 2009 02:33:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YsVi6jSjt3r4XJJNdtxYx4Czoyk=; b=NdUH0P
	tJ8t5IB8p5I+iTeKnoXZRBe546CR2JCusKSg58Mn0S1Z85cEpfwMo+ANFFy6cI/A
	yFE0HsaTMPGZClE48t+P3OnbwfN6sjxMoDrthhuFD5R/i9i603Z+l2DWnJqxYZZp
	awVx5sucZvo7Mkzd+wquetDzkhCoxIABouJ1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MgXrik68f0k454H1et8lWqgdWYAzLERH
	nwFJuX4R3gZO/PbYIltlBvUBMqRoI/evlmt/exGW7Om1HS7JsNoCstYx+jPbY32A
	hMW1Wu2zNWUsFGkK0x+F/ESJyV2V1U0w4KOafJd5yF7cJl1aOxr0bkytI10ROpCu
	nnxqzSCC6vc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36B597F4E0;
	Wed, 21 Oct 2009 02:33:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 806567F4DE; Wed, 21 Oct 2009
 02:33:41 -0400 (EDT)
In-Reply-To: <20091021063008.GA3349@glandium.org> (Mike Hommey's message of
 "Wed\, 21 Oct 2009 08\:30\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B07138C4-BE0B-11DE-8716-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130889>

Mike Hommey <mh@glandium.org> writes:

> BTW, shouldn't fetch be deprecated in favour of git remote update ?

Why?  People will then be confused because half of them would expect
"remote update" to somehow affect their working tree, and some others
would expect their working tree reset to one of the branches from the
remote, and it won't solve anything.  Oh, and it will irritate people who
are used to type "git fetch", too.
