From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Millisecond precision in timestamps?
Date: Wed, 28 Nov 2012 09:57:43 -0800
Message-ID: <7vobihvcdk.fsf@alter.siamese.dyndns.org>
References: <20121127204828.577264065F@snark.thyrsus.com>
 <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
 <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com>
 <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net>
 <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
 <CABYiQpmEpdf3L56NYSvPWovNOs_ifqj5QctuPSMoygHyMrz8+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Eric Raymond <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 18:58:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdlta-0003a5-IH
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 18:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040Ab2K1R5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 12:57:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754443Ab2K1R5q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 12:57:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DBA9955E;
	Wed, 28 Nov 2012 12:57:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rDSiTuoxX2xAZePX1lCzsrgAf+g=; b=GxhRrO
	PJj4XAF6Om3S/zj8hRIAaGq3tYHgy3Hn3AAU2kSdzFJm7rlaOrGQSbcJ3cII6GJW
	X/A0dxUnwrmfLCxgjQ7NGHt9FM/z3eTYLIorPrFbm5arlDXqeR0CR9WfiSb80o2F
	UbnyGj2GHoCwaK6L2WOVBTcU+fs8v000R8mNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FCjmo0vEKUNzb5iug8xPyrZMQV1ctqra
	EFcwmSDGbwxQiiMN5jy8FW/xc7Fz2PCcQl/mdKeDnufm/bUD1raGUftt3s5C9A+U
	+EtWtnY3yEQk4L+e23oV485F/BvMHkL894JIHACfQxUNx3eRjOjo1VYf49ta47bE
	YPjdXDUcyOw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE05C955D;
	Wed, 28 Nov 2012 12:57:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50F30955C; Wed, 28 Nov 2012
 12:57:45 -0500 (EST)
In-Reply-To: <CABYiQpmEpdf3L56NYSvPWovNOs_ifqj5QctuPSMoygHyMrz8+g@mail.gmail.com> (Thomas
 Berg's message of "Wed, 28 Nov 2012 09:19:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CEF180C-3985-11E2-B387-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210746>

Thomas Berg <merlin66b@gmail.com> writes:

> If roundtripping to other version control systems is an argument,
> adding sub-second timestamps could potentially create as many problems
> as it solves. For example, I've been using the hg-git bridge, and it
> supports roundtripping between git and mercurial today (for most repos
> I've tried anyway). I may have missed something,...

What I left unsaid was that the use of extra subsecond resolution is
optional.  I do not see any reason for *us* to create commits with
subsecond resolution when we are writing native commits.  Only when
the end users and/or import tools tell us to.  If you assume all
foreign SCM you care about have at least one second resolution, you
would be fine.

Having said all that, given that this, if implemented, would not be
used by us but only for recording other people's times, and that the
set of meta information we record in our history will never be
superset of everybody else's anyway, I do not see much point in
supporting subsecond timestamps in the first place.
