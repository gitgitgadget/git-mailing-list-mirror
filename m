From: Junio C Hamano <gitster@pobox.com>
Subject: Re: About refs refs/heads/+...
Date: Sun, 21 Dec 2014 10:40:28 -0800
Message-ID: <xmqqy4q0c0df.fsf@gitster.dls.corp.google.com>
References: <CACsJy8B8wVKAoqaKJxuyWbyDbFEofwctyfQoU=A0S_yUMc8bgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 19:40:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2lQm-0000AY-DJ
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 19:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbaLUSke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 13:40:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751540AbaLUSkb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 13:40:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 06F5226335;
	Sun, 21 Dec 2014 13:40:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=krRl9q+4IE9xTG95U499QcP+vKQ=; b=ZWhiAL
	fFC+bzH6T82hA034GhEFBDq3oA3as4n9xYesEBVBSb4LX18VWtn1rq49u7K+Sctk
	qZJVgvKOKOccVyy0T8xqiz8Ogwx/wOKWQj2xdrSBcgm19QuAKc14l0wysIXvnHdW
	Qx3u8FSs9ir1OqjtL3u1Q2GbFYLtfwToMIHDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M6vn4bfRlZ74WsyTQCpsVH/TycVYrOJr
	blDQ1wQd0tvdC6KAIXW5y1naE0CUEmR5/1myL5r/RKB6T+Hy7woKVcYQuH5M8yvW
	WzmBMDvHEz0zXljGUe2FOg1ZiD4moamsc/+Wz5ycFcFAu25tTUg9UYKjVoJtY4E9
	BdWIEgI8680=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F06BB26334;
	Sun, 21 Dec 2014 13:40:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57B7326333;
	Sun, 21 Dec 2014 13:40:29 -0500 (EST)
In-Reply-To: <CACsJy8B8wVKAoqaKJxuyWbyDbFEofwctyfQoU=A0S_yUMc8bgA@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 21 Dec 2014 17:58:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D6447466-8940-11E4-B371-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261617>

Duy Nguyen <pclouds@gmail.com> writes:

> I accidentally created a branch whose name starts with  "+".
> Everything went ok until I pushed it  because "+" is interpreted as
> forced refspec (e.g. "git push somewhere +wip"). Using full ref names
> would avoid ambiguity. The corner case of this is where the branch
> name is simply "+". Then refspec "+:" will be interpreted completely
> different from what the user wants.

Using full ref names does not avoid ambiguity in that case?  What
is a push refspec with an empty right-hand-side supposed to do in
the first place anyway?
