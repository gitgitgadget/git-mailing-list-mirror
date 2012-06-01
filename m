From: Junio C Hamano <gitster@pobox.com>
Subject: More use of levenshtein?
Date: Fri, 01 Jun 2012 12:04:00 -0700
Message-ID: <7vzk8m26sf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 21:04:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaX8q-0003AZ-RY
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 21:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965696Ab2FATEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 15:04:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933644Ab2FATED (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 15:04:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE30480E7;
	Fri,  1 Jun 2012 15:04:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=m
	i0vj5280n0MeycQe1vkwxwqqas=; b=ecEz/4hOJLaGpsXBuKQenjF6eUfMZBQzu
	ICmlkGwCNoYebcjLqTtAjuubRpuGJgpbu9mGhMTPyZlRAeNECtr0mX6N1/lnf9tf
	Q9AJThzMoEDmqhVgE7spvP7Q21HiQj9hjpYW+N/7zqGZkpEH5c5VPIUBPmA9u1/t
	477QpuSeOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=LzQ
	j9JnZOkAvcFdZdY9ul6PJSUzesjY7rG0AK/W1+/c0aBF3yLDecuEhg+Z2Zu5pkNu
	KRt0yY76wsjkfZZydrFtL1iB2ZWOuHegpz3pG3iY8drvkd10li89vVsU1U97TJr6
	NMAeR4h9tfW985WkqgigsuEWudRXY8VHFJNB/xPQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B611780E6;
	Fri,  1 Jun 2012 15:04:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13E8B80E5; Fri,  1 Jun 2012
 15:04:01 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CE83B9E-AC1C-11E1-875C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199014>

Perhaps we could go one step further when we issue this error message?

  $ git checkout -b jc/ls-files-i-dir maitn-1.7.8
  fatal: git checkout: updating paths is incompatible with switching branches.
  Did you intend to checkout 'maitn-1.7.8' which can not be resolved as commit?

Yes, I do have maint-1.7.8 branch in my private repository.
