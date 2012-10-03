From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fixing the p4merge launch shell script
Date: Tue, 02 Oct 2012 17:44:45 -0700
Message-ID: <7vipas5qpu.fsf@alter.siamese.dyndns.org>
References: <506B7AFB.1070700@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 02:45:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJD59-0004NC-JB
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 02:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab2JCAot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 20:44:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191Ab2JCAos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 20:44:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4F379B8F;
	Tue,  2 Oct 2012 20:44:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IA1sWj5nEa4aJZLcEmsROPq7FEc=; b=KFyptS
	JscOmBIFfqpCy/iySsQbT74/UX7gNz5pNACTiacDMPEGTLysdDPf8QJAQj8qWOun
	+Cc2DuPkE2ZhMg9gPmz2LnN/QbMEvzm31bWxi8VLTr6siOmCFSKmGDvpKqjxMMNq
	8vHduAqOJe5QPnO/SNQeVE4zI2QjlQVptUFmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dq7+Kh7r/2dhTLxkJ7AZMIAEaNupaaJi
	Fq5GEDo1tcF1nzXVuqHqYvEqJdG9FRv3Z7/+JcHvbQA9Go5MZCSePiIasDSktHGI
	/lqvEvF7hIgpFtGt+oL2fw75cbug2FoYCPcLQT1etl3qKXIWrqhjAwGNBrG+v+tF
	1AgVvUF1rQU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1FB89B8E;
	Tue,  2 Oct 2012 20:44:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 156319B8C; Tue,  2 Oct 2012
 20:44:46 -0400 (EDT)
In-Reply-To: <506B7AFB.1070700@game-point.net> (Jeremy Morton's message of
 "Wed, 03 Oct 2012 00:38:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87E36316-0CF3-11E2-8281-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206855>

Jeremy Morton <admin@game-point.net> writes:

> I've noticed that the p4merge shell script could do with some
> improvement when it comes to merging.  Because p4merge throws up an
> error when one of the files it's given to diff is "/dev/null", git
> needs to create a temporary empty file and pass that to p4merge when
> diffing a file that has been created/deleted (eg. create file, git add
> ., git diff --cached).
> ...
> Thoughts?  Is there an easier way to do this?

Which version of git?  Perhaps you do not have ec245ba (mergetool:
Provide an empty file when needed, 2012-01-19) yet?
