From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Option to omit column with time of the last
 change
Date: Wed, 04 Apr 2012 10:14:32 -0700
Message-ID: <7vlimba07b.fsf@alter.siamese.dyndns.org>
References: <20120403132735.GA12389@camk.edu.pl>
 <201204040112.02269.jnareb@gmail.com> <20120404063939.GA17024@camk.edu.pl>
 <201204041631.42905.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 19:14:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFTn5-0007Hq-B6
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 19:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757062Ab2DDROf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 13:14:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46416 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756510Ab2DDROe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 13:14:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35A0460ED;
	Wed,  4 Apr 2012 13:14:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8UoVkPPScRL9yW+Kgiu0c7w0S+w=; b=GFdFxp
	wjnqMv8Pp34OI6xbo/pVMNahxGYnhIj7fVcGC0oPGqXVD85F8TMeshzBAUXxMNov
	s9yRLjChvAt8zs957/Cb/gONk8B8Xl4f0gUSltpoVsvUygJnjY+tFCuVsWWNkIwL
	rOvKj02ylymhQ7zR0FIiVkGueaVu+AziG8YrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r3IsHZ3Vo/nw3Nh8Q0uobmxk5TQO7Gmq
	GsBGDuezaumV4cjJFawgNJ3yfAXFXUk5O6pAkORNspWShP8TL/CT1ZJXN5joW/nS
	BKCuEca3Yd4zS1b+87TlPjnRcQSZ4ItJalHuzabd+TGg9iRjvIbevOdIF8WMzEdA
	10JXjptTVUo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CE6C60EC;
	Wed,  4 Apr 2012 13:14:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ED1760EB; Wed,  4 Apr 2012
 13:14:33 -0400 (EDT)
In-Reply-To: <201204041631.42905.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 4 Apr 2012 16:31:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5D23D92-7E79-11E1-AD82-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194710>

Jakub Narebski <jnareb@gmail.com> writes:

> Perhaps instead of $no_age_column that can be single configuration
> variable like @excluded_project_list_fields instead of one variable
> per column.

True.

In general we avoid no_anything because it tends to introduce hard-to-read
double negation in the code and the documentation (e.g. "if (!$no_frotz)"),
but "next if (exists $exclude{$it})" is probably not so bad.
