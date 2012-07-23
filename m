From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: support --tool-help option like difftool does
Date: Mon, 23 Jul 2012 15:31:04 -0700
Message-ID: <7vy5mahzyv.fsf@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFAE1.3070304@gmail.com> <7vr4s2mnir.fsf@alter.siamese.dyndns.org>
 <7vipdemm0a.fsf_-_@alter.siamese.dyndns.org> <500D9E5A.2000204@gmail.com>
 <500D9EDB.90603@gmail.com> <7vhasyl0gc.fsf@alter.siamese.dyndns.org>
 <CAHGBnuMCsxmVN8fCSgazqKUwtJzJJxtrVxjKwCEEhZJ_U0cW9w@mail.gmail.com>
 <CAJDDKr4TyDp5vxqqHGkBBSiMJXJHW528+nqrag9Rgz+vksqjhg@mail.gmail.com>
 <7vmx2qji03.fsf@alter.siamese.dyndns.org>
 <CAHGBnuNvzoSkrujoxLt-M5VS2Pm=e6CL_P39pyRAv-NEi1y6QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Tim Henigan <tim.henigan@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 00:31:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StR9m-0005Jn-BL
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 00:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab2GWWbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 18:31:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754822Ab2GWWbG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 18:31:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3758363AC;
	Mon, 23 Jul 2012 18:31:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4uIb8kmX15PdwQWIdVP+Tdv9pKc=; b=cBueMm
	Z+XNNivqKOJKU/k36rT5+jkmckFcfPHCniMbtykNubUYTXOKvXiWYjZxiXnAGIhx
	neVrm6+qSkTirDrvwG50Jpgw6M9UnaQxzcg5pfLl3XTB9Zpo3DlYqEKa+WQzXia6
	0C/QSUnr1OVtqIXwqEl1DaXsLgC5gUghFeAyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gLrRbbaTgAn6enJw3LNJeUC9N4vEz9uP
	bJQh0gs5IjkvJIZ5oY739ZaJzRTy7vPATEhbIe/b+bhm0TVm3OKtr3czKPDI6+aJ
	Lw3h3MkIu08aRt/vtQZG6eV3NUIngTYaBFZSW/VNyjC/nA9cQ+ERyWqpNWN0cwhN
	h4UEiuJrkuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 232DA63AB;
	Mon, 23 Jul 2012 18:31:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7481D63AA; Mon, 23 Jul 2012
 18:31:05 -0400 (EDT)
In-Reply-To: <CAHGBnuNvzoSkrujoxLt-M5VS2Pm=e6CL_P39pyRAv-NEi1y6QA@mail.gmail.com>
 (Sebastian Schuberth's message of "Mon, 23 Jul 2012 23:27:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 174EB0B6-D516-11E1-971C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201997>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Mon, Jul 23, 2012 at 11:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> There are only five or six classes of environment that matter in the
>> real world for the purpose of giving "well known" examples: Windows,
>> MacOS X, Gnome, KDE and Linux terminal.  By picking a representative
>> one from each and listing them, the end result would have at least
>> one that people from various platforms have _heard of_ and can guess
>> what they do.  The "most common" is secondary, and "well known" is
>
> I completely agree with this. So we should take the chance and add a
> Windows representative to the list of difftools, no?

I do not care very deeply either way.  I am more interested in
seeing --tool-list options supported by both so that we can get rid
of hardcoded list from the completion script.

> This drops the explicit mention of --tool-help as an option in the
> documentation compared to my patch. Do you want to keep --tool-help
> being mentioned inline as part of the --tool option documentation
> only?

While I do not think having one would hurt that much, I do not think
a separate entry would add much value either, so I chose not to
clutter the documentation further.  The "--tool=<tool>" entry is
enough hint to draw eyes of readers who want to find out what kind
of backends are supported, and --tool-help is mentioned there quite
prominently.
